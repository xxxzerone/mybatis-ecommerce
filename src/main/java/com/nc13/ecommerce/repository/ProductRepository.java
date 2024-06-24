package com.nc13.ecommerce.repository;

import com.nc13.ecommerce.dto.ProductDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Select;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ProductRepository {

    @Select("select *, c.name as category_name from product p, category c " +
            "where p.category_id = c.id order by p.id desc limit ${page.offset}, ${page.pageSize}")
    @Result(property = "categoryName", column = "category_name")
    List<ProductDTO> findAll(@Param("page") Pageable page);

    @Select("select count(*) from product")
    int count();

    @Select("select *, c.name as category_name from product p, category c " +
            "where p.category_id = c.id and p.id = #{id} order by p.id desc")
    @Result(property = "categoryName", column = "category_name")
    ProductDTO findById(int id);
}
