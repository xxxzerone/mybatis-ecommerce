package com.nc13.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTO {

    private Long id;
    private String name;
    private int price;
    private String info;
    private int stock;
    private int categoryId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String categoryName;
}
