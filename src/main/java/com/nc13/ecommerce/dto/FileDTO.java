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
public class FileDTO {

    private Long id;
    private String fileName;
    private String fileOriginName;
    private String fileExt;
    private long fileSize;
    private Long productId;
    private LocalDateTime createdAt;
}
