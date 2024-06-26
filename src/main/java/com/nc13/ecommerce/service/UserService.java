package com.nc13.ecommerce.service;

import com.nc13.ecommerce.dto.UserDTO;
import com.nc13.ecommerce.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public UserDTO auth(UserDTO userDTO) {
        return userRepository.auth(userDTO);
    }

    public UserDTO findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public int insertBuyer(UserDTO userDTO) {
        return userRepository.insertBuyer(userDTO);
    }

    public int insertSeller(UserDTO userDTO) {
        return userRepository.insertSeller(userDTO);
    }
}
