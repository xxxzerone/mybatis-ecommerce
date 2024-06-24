package com.nc13.ecommerce.service;

import com.nc13.ecommerce.dto.UserDTO;
import com.nc13.ecommerce.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public UserDTO auth(UserDTO userDTO) {
        return userRepository.auth(userDTO);
    }

    public UserDTO findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public int insert(UserDTO userDTO) {
        return userRepository.insert(userDTO);
    }
}
