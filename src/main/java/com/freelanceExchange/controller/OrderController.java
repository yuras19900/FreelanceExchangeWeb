package com.freelanceExchange.controller;

import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.User;
import com.freelanceExchange.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/myOrders")
    public String myOrders(Model model, @AuthenticationPrincipal User user){
        List<Order> orders = orderService.findAllByUserId(user);
        model.addAttribute("orders", orders);
        return "order/myOrders";
    }

    @GetMapping("/newOrder")
    public String newOrder(Model model){
        model.addAttribute("orderForm", new Order());
        return "order/newOrder";
    }

    @PostMapping("/newOrder")
    public String addOrder(@ModelAttribute("orderForm") Order orderForm, BindingResult bindingResult, Model model, @AuthenticationPrincipal User user){
        if(orderForm.getName()==null || orderForm.getDescription()==null){
            model.addAttribute("requiredFieldError", "Заполните все необходимые поля");
            return "order/newOrder";
        }
        orderService.saveOrder(orderForm, user);
        return "redirect:/myOrders";
    }
}
