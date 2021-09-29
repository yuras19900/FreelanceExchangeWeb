package com.freelanceExchange.service;

import com.freelanceExchange.dao.OrderDao;
import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderDao orderDao;

    public List<Order> findAllByUserId(@AuthenticationPrincipal User user) {
        return orderDao.findAllByUserId(user.getId());
    }

    public void saveOrder(Order order, @AuthenticationPrincipal User user) {
        order.setUser(user);
        order.setVacant(true);
        order.setReady(false);
        order.setPaid(false);
        order.setClosed(false);
        orderDao.save(order);
    }
}
