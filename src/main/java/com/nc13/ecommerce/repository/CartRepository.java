package com.nc13.ecommerce.repository;

import com.nc13.ecommerce.dto.CartDTO;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CartRepository {

    @Insert("insert into cart(user_id, product_id, quantity) values(#{userId}, #{cart.productId}, #{cart.quantity})")
    int insert(String userId, @Param("cart") CartDTO cart);

    @Select("select c.*, u.*, p.name as product_name, p.price from cart c, user u, product p where c.user_id = u.id and c.product_id = p.id and c.user_id = #{userId} order by c.updated_at desc")
    @Result(property = "productName", column = "product_name")
    List<CartDTO> findAllByUserId(String userId);

    @Select("select * from cart where user_id = #{userId} and product_id = #{productId}")
    CartDTO findByUserIdAndProductId(String userId, Long productId);

    @Update("update cart set quantity = quantity + ${cart.quantity} where user_id = #{userId} and product_id = #{cart.productId}")
    int update(String userId, @Param("cart") CartDTO cart);
}
