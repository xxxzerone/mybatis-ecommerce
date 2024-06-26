package com.nc13.ecommerce.controller;

import com.nc13.ecommerce.dto.UserDTO;
import com.nc13.ecommerce.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/auth")
    public String auth(UserDTO userDTO, HttpSession session) {
        UserDTO user = userService.auth(userDTO);
        if (user != null) {
            session.setAttribute("logIn", user);
        }

        return "redirect:/products";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "user/register";
    }

    @GetMapping("/seller/register")
    public String sellerRegisterPage() {
        return "user/sellerRegister";
    }

    @ResponseBody
    @PostMapping("/validateUser")
    public Map<String, Object> validateUser(String email) {
        Map<String, Object> result = new HashMap<>();

        UserDTO user = userService.findByEmail(email);
        if (user != null) {
            result.put("result", "fail");
        } else {
            result.put("result", "success");
        }

        return result;
    }

    @PostMapping("/register")
    public String register(UserDTO userDTO, RedirectAttributes redirectAttributes) {
        int result = userService.insertBuyer(userDTO);
        if (result != 1) {
            redirectAttributes.addAttribute("message", "회원가입에 실패했습니다.");
            return "redirect:/error-page";
        }

        return "redirect:/";
    }

    @PostMapping("/seller/register")
    public String sellerRegister(UserDTO userDTO, RedirectAttributes redirectAttributes) {
        int result = userService.insertSeller(userDTO);
        if (result != 1) {
            redirectAttributes.addAttribute("message", "회원가입에 실패했습니다.");
            return "redirect:/error-page";
        }

        return "redirect:/";
    }
}
