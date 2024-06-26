package com.nc13.ecommerce.controller;

import com.nc13.ecommerce.dto.CategoryDTO;
import com.nc13.ecommerce.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/categories")
@RequiredArgsConstructor
public class CategoryController {

    private static final Logger log = LoggerFactory.getLogger(CategoryController.class);

    private final CategoryService categoryService;

    @GetMapping
    @ResponseBody
    public List<CategoryDTO> findAll() {
        List<CategoryDTO> categories = categoryService.findAll();

        return categories;
    }
}
