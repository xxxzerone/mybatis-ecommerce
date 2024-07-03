package com.nc13.ecommerce.controller;

import com.nc13.ecommerce.dto.CartDTO;
import com.nc13.ecommerce.service.CartService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/carts")
@RequiredArgsConstructor
public class CartController {

    private static final Logger log = LoggerFactory.getLogger(CartController.class);

    private final CartService cartService;

    @ResponseBody
    @PostMapping("/{id}")
    public Map<String, Object> insert(@PathVariable("id") String userId, @RequestBody CartDTO cartDTO) {
        Map<String, Object> response = new HashMap<>();
        int result;
        CartDTO cart = cartService.findByUserIdAndProductId(userId, cartDTO.getProductId());
        if (cart != null) {
            result = cartService.update(userId, cartDTO);
        } else {
            result = cartService.insert(userId, cartDTO);
        }

        if (result == 1) {
            response.put("result", "success");
        } else {
            response.put("result", "fail");
        }

        return response;
    }

    @GetMapping("/{id}")
    public String cartPage(@PathVariable("id") String userId, Model model) {
        List<CartDTO> carts = cartService.findAllByUserId(userId);
        log.info("carts: {}", carts);

        model.addAttribute("carts", carts);

        return "cart/cartList";
    }

    @GetMapping("/plus/quantity/{id}")
    @ResponseBody
    public Map<String, Object> plusQuantity(@PathVariable int id) {
        Map<String, Object> data = new HashMap<>();
        int result = cartService.plusQuantityById(id);
        if (result == 1) {
            data.put("result", "success");
        } else {
            data.put("result", "fail");
        }

        return data;
    }

    @GetMapping("/minus/quantity/{id}")
    @ResponseBody
    public Map<String, Object> minusQuantity(@PathVariable int id) {
        Map<String, Object> data = new HashMap<>();
        int result = cartService.minusQuantityById(id);
        if (result == 1) {
            data.put("result", "success");
        } else {
            data.put("result", "fail");
        }

        return data;
    }
}
