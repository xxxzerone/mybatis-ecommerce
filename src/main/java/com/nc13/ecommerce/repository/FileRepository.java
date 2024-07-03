package com.nc13.ecommerce.repository;

import com.nc13.ecommerce.dto.FileDTO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface FileRepository {

    @Insert("insert into files(file_name, file_origin_name, file_ext, file_size, product_id) " +
            "values(#{file.fileName}, #{file.fileOriginName}, #{file.fileExt}, #{file.fileSize}, #{file.productId})")
    int insert(@Param("file") FileDTO file);

    @Select("select * from files where product_id = #{productId}")
    List<FileDTO> findByProductId(int productId);
}
