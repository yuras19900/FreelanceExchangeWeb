package com.freelanceExchange.controller;

import com.freelanceExchange.dao.OrderDao;
import com.freelanceExchange.dao.ProposalDao;
import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.Proposal;
import com.freelanceExchange.model.User;
import com.freelanceExchange.service.ProposalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private ProposalDao proposalDao;

    @Autowired
    private ProposalService proposalService;

    @GetMapping("/vacantOrders")
    public String vacantOrders(Model model){
        List<Order> vacantOrders =orderDao.findByVacantTrue();
        model.addAttribute("vacantOrders", vacantOrders);
        return "/order/employee/vacantOrders";
    }

    @GetMapping("/newProposal{id}")
    public String newProposal(@PathVariable Integer id, Model model){
        Order order = orderDao.getById(id);
        model.addAttribute("order", order);
        model.addAttribute("proposalForm", new Proposal());

        return "/order/employee/newProposal";
    }

    @PostMapping("/newProposal{id}")
    public String newProposal(@PathVariable Integer id, @ModelAttribute("proposalForm") Proposal proposalForm, @AuthenticationPrincipal User user){
        Order order = orderDao.findById(id).orElse(new Order());
        proposalForm.setOrder(order);
        proposalService.saveProposal(proposalForm, user);
        return "redirect:/employee/vacantOrders";
    }

    @GetMapping("/myActiveOrders")
    public String myActiveOrders(@AuthenticationPrincipal User user, Model model){
        List<Order> orders = orderDao.findAllByEmployeeId(user.getId());
        model.addAttribute("orders", orders);
        return "/order/employee/myActiveOrders";
    }

    @GetMapping("/activeOrder{id}")
    public String activeOrder(@PathVariable Integer id, Model model){
        Order order = orderDao.getById(id);
        model.addAttribute("order", order);
        Proposal proposal = proposalDao.getProposalByOrder(order);
        model.addAttribute("proposal", proposal);
        return "/order/employee/activeOrder";
    }
}
