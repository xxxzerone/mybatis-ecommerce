package com.nc13.ecommerce.service;

import com.nc13.ecommerce.dto.ProductDTO;
import com.nc13.ecommerce.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private static final Logger log = LoggerFactory.getLogger(ProductService.class);

    private final ProductRepository productRepository;

    public Page<ProductDTO> findAll(Pageable pageable, String search) {
        Sort sort = Sort.by("b.id").descending();
        pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        List<ProductDTO> productsPageable = productRepository.findAllByPageAndSearch(pageable, search);
        int totalCount = productRepository.countBySearch(search);

        return new PageImpl<>(productsPageable, pageable, totalCount);
    }

    public ProductDTO findById(int id) {
        return productRepository.findById(id);
    }

    public int insert(ProductDTO productDTO) {
        return productRepository.insert(productDTO);
    }
}
