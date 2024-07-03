package com.nc13.ecommerce.repository;

import com.nc13.ecommerce.dto.ProductDTO;
import com.nc13.ecommerce.provider.ProductProvider;
import org.apache.ibatis.annotations.*;
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

    @SelectProvider(type = ProductProvider.class, method = "findAll")
    List<ProductDTO> findAllByPageAndSearch(@Param("page") Pageable page, String search);

    @Select("select count(*) from product")
    int count();

    @SelectProvider(type = ProductProvider.class, method = "countBySearch")
    int countBySearch(String search);

    @Select("select *, c.name as category_name from product p, category c " +
            "where p.category_id = c.id and p.id = #{id} order by p.id desc")
    @Result(property = "categoryName", column = "category_name")
    ProductDTO findById(int id);

    @Insert("insert into product(name, price, info, stock, category_id) " +
            "values(#{product.name}, #{product.price}, #{product.info}, #{product.stock}, #{product.categoryId})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(@Param("product") ProductDTO product);
}
