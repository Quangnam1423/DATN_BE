package com.DATN.Bej.repository.product;

import com.DATN.Bej.entity.product.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository <Product, String> {
    boolean existsByName(String name);
    List<Product> findAllByOrderByCreateDateDesc();
    List<Product> findByStatusOrderByCreateDateDesc(int status);

    Optional<Product> findByName(String productName);
    
    @Query("SELECT p FROM Product p " +
           "LEFT JOIN FETCH p.variants v " +
           "LEFT JOIN FETCH v.attributes " +
           "LEFT JOIN FETCH v.detailImages " +
           "LEFT JOIN FETCH p.introImages " +
           "WHERE p.id = :id")
    Optional<Product> findByIdWithDetails(@Param("id") String id);
}
