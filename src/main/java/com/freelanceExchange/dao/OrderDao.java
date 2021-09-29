package com.freelanceExchange.dao;

import com.freelanceExchange.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderDao extends JpaRepository<Order, Integer> {
    List<Order> findAllByUserId(Integer userId);
}
