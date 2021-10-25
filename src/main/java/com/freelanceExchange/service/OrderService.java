package com.freelanceExchange.service;

import com.freelanceExchange.dao.OrderDao;
import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class OrderService {

    @Autowired
    private OrderDao orderDao;

    public void saveOrder(Order order, @AuthenticationPrincipal User user) {
        order.setUser(user);
        order.setVacant(true);
        order.setReady(false);
        order.setPaid(false);
        order.setClosed(false);
        order.setIssue(false);
        order.setLocked(false);
        order.setDateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm dd.MM.yyyy")));
        orderDao.save(order);
    }

    public void checkStatus(Order order, Model model){
        if(order.isLocked()){
            model.addAttribute("status", "Заблокирован");
        } else if(order.isClosed()){
            model.addAttribute("status", "Закрыт");
        } else if (order.isIssue()){
            model.addAttribute("status", "Жалоба");
        }
        else if(order.isPaid()){
            model.addAttribute("status", "Готов и оплачен");
        } else if (order.isReady()){
            model.addAttribute("status", "Готов");
        } else if (order.isVacant()){
            model.addAttribute("status", "Поиск исполнителей");
        }
    }
}
