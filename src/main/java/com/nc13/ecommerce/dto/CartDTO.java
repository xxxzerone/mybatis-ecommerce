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
public class CartDTO {

    private Long id;
    private Long userId;
    private Long productId;
    private int quantity;
    private char status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String productName;
    private String price;
}
