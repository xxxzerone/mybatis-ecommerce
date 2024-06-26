package com.nc13.ecommerce.repository;

import com.nc13.ecommerce.dto.CategoryDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CategoryRepository {

    @Select("select * from category")
    List<CategoryDTO> findAll();
}
