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

//    @Select("select c.*, u.*, p.name as product_name, p.price from cart c, user u, product p where c.user_id = u.id and c.product_id = p.id and c.user_id = #{userId} order by c.updated_at desc")
    @Select("select c.id, c.user_id, c.product_id, c.quantity, c.updated_at, p.name as product_name, p.price, p.stock" +
            " , (c.quantity * p.price) as total_price, sum(c.quantity * p.price) over() as cart_total_price" +
            " from cart c, user u, product p where c.user_id = u.id and c.product_id = p.id and c.user_id = #{userId} order by c.updated_at desc")
    @Results(id = "carts", value = {
            @Result(property = "productName", column = "product_name"),
            @Result(property = "totalPrice", column = "total_price"),
            @Result(property = "cartTotalPrice", column = "cart_total_price"),
    })
    List<CartDTO> findAllByUserId(String userId);

    @Select("select * from cart where user_id = #{userId} and product_id = #{productId}")
    CartDTO findByUserIdAndProductId(String userId, Long productId);

    @Update("update cart set quantity = quantity + ${cart.quantity} where user_id = #{userId} and product_id = #{cart.productId}")
    int update(String userId, @Param("cart") CartDTO cart);

    @Update("update cart set quantity = quantity + 1 where id = #{id}")
    int plusQuantityById(int id);

    @Update("update cart set quantity = quantity - 1 where id = #{id}")
    int minusQuantityById(int id);
}
