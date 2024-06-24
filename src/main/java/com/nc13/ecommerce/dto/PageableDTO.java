package com.nc13.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PageableDTO {

    private int totalPages;
    private long totalElements;
    private int number;
    private int size;
    private int startPage;
    private int endPage;

    @Builder
    public PageableDTO(int totalPages, long totalElements, int number, int size) {
        this.totalPages = totalPages;
        this.totalElements = totalElements;
        this.number = number;
        this.size = size;
        init();
    }

    public void init() {
        if (totalPages < 5) {
            startPage = 1;
            endPage = totalPages;
        } else if (number <= 3) {
            startPage = 1;
            endPage = 5;
        } else if (number >= totalPages - 2) {
            startPage = totalPages - 4;
            endPage = totalPages;
        } else {
            startPage = number - 2;
            endPage = number + 2;
        }
    }
}
