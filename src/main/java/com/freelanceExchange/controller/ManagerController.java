package com.freelanceExchange.controller;

import com.freelanceExchange.dao.*;
import com.freelanceExchange.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/manager")
public class ManagerController {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private ProposalDao proposalDao;

    @Autowired
    private ResultDao resultDao;

    @Autowired
    private ReportDao reportDao;

    @Autowired
    private AnswerDao answerDao;

    @GetMapping("/issue-orders")
    public String issueOrders(Model model) {
        List<Order> issueOrders = orderDao.findByIssueIsTrue();
        model.addAttribute("issueOrders", issueOrders);
        return "/order/manager/issueOrders";
    }

    @GetMapping("/issue-order{id}")
    public String issueOrder(@PathVariable Integer id, Model model) {
        Order issueOrder = orderDao.getById(id);
        Proposal acceptedProposal = proposalDao.getProposalByOrderAndDeclinedIsFalse(issueOrder);
        List<Result> results = resultDao.findResultsByOrder(issueOrder);
        List<Report> reports = reportDao.findReportsByOrder(issueOrder);
        model.addAttribute("issueOrder", issueOrder);
        model.addAttribute("acceptedProposal", acceptedProposal);
        model.addAttribute("results", results);
        model.addAttribute("reports", reports);
        model.addAttribute("answerForm", new Answer());
        return "order/manager/issueOrder";
    }

    @PostMapping("send-for-revision")
    private String sendForRevision(@RequestParam Integer orderId,
                                   @ModelAttribute("answerForm") Answer answerForm) {
        Order order = orderDao.getById(orderId);
        answerForm.setOrder(order);
        answerForm.setDateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm dd.MM.yyyy")));
        order.setReady(false);
        order.setIssue(false);
        orderDao.save(order);
        answerDao.save(answerForm);
        return "redirect:/manager/issue-orders";
    }


    @PostMapping("close-customer")
    private String closeCustomer(@RequestParam Integer orderId,
                                 @ModelAttribute("answerForm") Answer answerForm) {
        Order order = orderDao.getById(orderId);
        answerForm.setOrder(order);
        answerForm.setDateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm dd.MM.yyyy")));
        order.setClosed(true);
        order.setIssue(false);
        orderDao.save(order);
        answerDao.save(answerForm);
        return "redirect:/manager/issue-orders";
    }

    @PostMapping("close-employee")
    public String closeEmployee(@RequestParam Integer orderId,
                                @ModelAttribute("answerForm") Answer answerForm) {
        Order order = orderDao.getById(orderId);
        answerForm.setDateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm dd.MM.yyyy")));
        answerForm.setOrder(order);
        order.setClosed(true);
        order.setIssue(false);
        orderDao.save(order);
        answerDao.save(answerForm);
        return "redirect:/manager/issue-orders";
    }

    @GetMapping("/view-orders")
    public String viewOrders(Model model) {
        List<Order> orders = orderDao.findAll();
        model.addAttribute("orders", orders);
        return "order/manager/viewOrders";
    }

    @PostMapping("/lock")
    public String blockUser(@RequestParam Integer orderId) {
        Order order = orderDao.getById(orderId);
        if (order.isLocked()) {
            order.setLocked(false);
            order.setClosed(false);
            orderDao.save(order);
        } else if (!order.isLocked()) {
            if(!order.isClosed()) {
                order.setVacant(false);
                order.setLocked(true);
                order.setClosed(true);
                orderDao.save(order);
            }
        }
        return "redirect:/manager/view-orders";
    }
}