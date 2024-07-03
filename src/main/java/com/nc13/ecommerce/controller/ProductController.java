package com.nc13.ecommerce.controller;

import com.nc13.ecommerce.dto.FileDTO;
import com.nc13.ecommerce.dto.PageableDTO;
import com.nc13.ecommerce.dto.ProductDTO;
import com.nc13.ecommerce.service.FileService;
import com.nc13.ecommerce.service.ProductService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/products")
@RequiredArgsConstructor
public class ProductController {

    private static final Logger log = LoggerFactory.getLogger(ProductController.class);

    private final ProductService productService;
    private final FileService fileService;

    @GetMapping
    public String productsPage(
            Model model,
            @PageableDefault(size = 5) Pageable pageable,
            @RequestParam(value = "search", defaultValue = "") String search
    ) {
        Page<ProductDTO> result = productService.findAll(pageable, search);

        List<ProductDTO> products = result.toList();
        PageableDTO page = PageableDTO.builder()
                .totalPages(result.getTotalPages())
                .totalElements(result.getTotalElements())
                .number(result.getNumber())
                .size(result.getSize())
                .build();

        model.addAttribute("page", page);
        model.addAttribute("products", products);

        return "product/productList";
    }

    @GetMapping("/{id}")
    public String product(@PathVariable int id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        ProductDTO product = productService.findById(id);
        if (product == null) {
            redirectAttributes.addAttribute("message", "없는 상품입니다.");
            return "redirect:/error-page";
        }

        List<FileDTO> files = fileService.findByProductId(id);


        model.addAttribute("product", product);
        model.addAttribute("files", files);

        return "product/productDetail";
    }

    @GetMapping("/create")
    public String createPage() {
        return "product/create";
    }

    @PostMapping("/create")
    @ResponseBody
    public Map<String, Object> create(
            @RequestPart ProductDTO productDTO,
            @RequestPart(required = false) List<MultipartFile> files
    ) {
        Map<String, Object> data = new HashMap<>();

        int result = productService.insert(productDTO);
        if (result != 1) {
            data.put("result", "fail");
            return data;
        }

        result = fileService.uploads(productDTO.getId(), files);
        if (result != 1) {
            data.put("result", "fail");
            return data;
        }

        data.put("result", "success");
        return data;
    }
}
