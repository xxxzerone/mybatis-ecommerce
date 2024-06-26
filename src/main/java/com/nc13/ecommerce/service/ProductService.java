package com.nc13.ecommerce.service;

import com.nc13.ecommerce.dto.ProductDTO;
import com.nc13.ecommerce.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    public Page<ProductDTO> findAll(Pageable pageable) {
        Sort sort = Sort.by("b.id").descending();
        pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        List<ProductDTO> productsPageable = productRepository.findAll(pageable);
        int totalCount = productRepository.count();

        return new PageImpl<>(productsPageable, pageable, totalCount);
    }

    public ProductDTO findById(int id) {
        return productRepository.findById(id);
    }
}
