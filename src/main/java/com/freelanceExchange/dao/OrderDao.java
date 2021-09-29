package com.freelanceExchange.dao;

import com.freelanceExchange.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderDao extends JpaRepository<Order, Integer> {
    List<Order> findAllByUserId(Integer userId);
    Optional<Order> findById(Integer id);
    List<Order> findByVacantTrue();
    List<Order> findAllByEmployeeId(Integer employeeId);
}
