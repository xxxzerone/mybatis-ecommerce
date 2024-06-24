package com.nc13.ecommerce.service;

import com.nc13.ecommerce.dto.CartDTO;
import com.nc13.ecommerce.repository.CartRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    private static final Logger log = LoggerFactory.getLogger(CartService.class);

    private final CartRepository cartRepository;

    public CartService(CartRepository cartRepository) {
        this.cartRepository = cartRepository;
    }

    public int insert(String userId, CartDTO cartDTO) {
        return cartRepository.insert(userId, cartDTO);
    }

    public List<CartDTO> findAllByUserId(String userId) {
        return cartRepository.findAllByUserId(userId);
    }

    public CartDTO findByUserIdAndProductId(String userId, Long productId) {
        return cartRepository.findByUserIdAndProductId(userId, productId);
    }

    public int update(String userId, CartDTO cartDTO) {
        return cartRepository.update(userId, cartDTO);
    }
}
