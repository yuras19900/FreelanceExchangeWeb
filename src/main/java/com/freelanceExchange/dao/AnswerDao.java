package com.freelanceExchange.dao;

import com.freelanceExchange.model.Answer;
import com.freelanceExchange.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AnswerDao extends JpaRepository<Answer, Integer> {
    List<Answer> findAnswersByOrder(Order order);
}
