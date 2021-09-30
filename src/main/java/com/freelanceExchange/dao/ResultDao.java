package com.freelanceExchange.dao;

import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.Result;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ResultDao extends JpaRepository<Result, Integer> {
    List<Result> findResultByOrder(Order order);
}
