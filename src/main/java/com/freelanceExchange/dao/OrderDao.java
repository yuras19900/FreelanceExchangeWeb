package com.freelanceExchange.dao;

import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderDao extends JpaRepository<Order, Integer> {
    List<Order> findOrdersByTagAndVacantIsTrue(String tag);
    Optional<Order> findById(Integer id);
    List<Order> findByVacantIsTrue();
    List<Order> findAllByEmployeeAndClosedIsFalse(User employee);
    List<Order> findAllByEmployeeAndClosedIsTrue(User employee);
    List<Order> findByIssueIsTrue();
    List<Order> findOrdersByUserAndClosedIsFalse(User user);
    List<Order> findOrdersByUserAndClosedIsTrue(User user);
    List<Order> findAll();
}
