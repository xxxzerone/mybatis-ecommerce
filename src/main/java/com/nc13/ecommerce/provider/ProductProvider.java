package com.nc13.ecommerce.provider;

import org.apache.ibatis.jdbc.SQL;
import org.springframework.data.domain.Pageable;

public class ProductProvider {

    public String findAll(Pageable page, String search) {
        return new SQL() {{
            SELECT("*, c.name as category_name");
            FROM("product p, category c");
            WHERE("p.category_id = c.id");
            if (search != null && !search.isEmpty()) {
                WHERE("p.name LIKE concat('%', #{search}, '%')");
            }
            ORDER_BY("p.id DESC");
            LIMIT("${page.offset}, ${page.pageSize}");
        }}.toString();
    }

    public String countBySearch(String search) {
        return new SQL() {{
            SELECT("count(*)");
            FROM("product");
            if (search != null && !search.isEmpty()) {
                WHERE("name LIKE concat('%', #{search}, '%')");
            }
        }}.toString();
    }
}
