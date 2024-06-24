package com.nc13.ecommerce.controller;

import com.nc13.ecommerce.dto.PageableDTO;
import com.nc13.ecommerce.dto.ProductDTO;
import com.nc13.ecommerce.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {

    private static final Logger log = LoggerFactory.getLogger(ProductController.class);

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public String productsPage(Model model, @PageableDefault(size = 5) Pageable pageable) {
        Page<ProductDTO> result = productService.findAll(pageable);
        List<ProductDTO> products = new ArrayList<>();
        for (ProductDTO product : result) {
            products.add(ProductDTO.builder()
                    .id(product.getId())
                    .name(product.getName())
                    .price(product.getPrice())
                    .info(product.getInfo())
                    .stock(product.getStock())
                    .categoryId(product.getCategoryId())
                    .createdAt(product.getCreatedAt())
                    .updatedAt(product.getUpdatedAt())
                    .categoryName(product.getCategoryName())
                    .build());
        }
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

        model.addAttribute("product", product);

        return "product/productDetail";
    }
}
