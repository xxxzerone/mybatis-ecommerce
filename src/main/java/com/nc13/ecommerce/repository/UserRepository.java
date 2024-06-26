package com.nc13.ecommerce.repository;

import com.nc13.ecommerce.dto.UserDTO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserRepository {

    @Select("select * from user where email = #{user.email} and password = #{user.password}")
    UserDTO auth(@Param("user") UserDTO user);

    @Select("select * from user where email = #{user.email}")
    UserDTO findByEmail(String email);

    @Insert("insert into user(email, password, username, phone, address) " +
            "values(#{user.email}, #{user.password}, #{user.username}, #{user.phone}, #{user.address})")
    int insertBuyer(@Param("user") UserDTO user);

    @Insert("insert into user(email, password, user_type, username, phone, address) " +
            "values(#{user.email}, #{user.password}, #{user.userType}, #{user.username}, #{user.phone}, #{user.address})")
    int insertSeller(@Param("user") UserDTO user);
}
