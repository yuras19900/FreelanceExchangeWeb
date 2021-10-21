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
    public String issueOrder(@PathVariable Integer id, Model model){
        Order issueOrder = orderDao.getById(id);
        Proposal acceptedProposal = proposalDao.getProposalByOrderAndDeclinedIsFalse(issueOrder);
        List <Result> results = resultDao.findResultsByOrder(issueOrder);
        List<Report> reports = reportDao.findReportsByOrder(issueOrder);
        model.addAttribute("issueOrder", issueOrder);
        model.addAttribute("acceptedProposal", acceptedProposal);
        model.addAttribute("results", results);
        model.addAttribute("reports", reports);
        model.addAttribute("answerForm", new Answer());
        return "order/manager/issueOrder";
    }

    @PostMapping("send-for-revision{id}")
    private String sendForRevision( @PathVariable Integer id,
            @ModelAttribute("answerForm") Answer answerForm){
        Order order = orderDao.getById(id);
        answerForm.setOrder(order);
        answerForm.setDateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("hh:mm dd.MM.yyyy")));
        order.setReady(false);
        order.setIssue(false);
        orderDao.save(order);
        answerDao.save(answerForm);
        return "redirect:/manager/issue-orders";
    }


    @PostMapping("close-customer{id}")
    private String closeCustomer(@PathVariable Integer id,
                                 @ModelAttribute("answerForm") Answer answerForm){
        Order order = orderDao.getById(id);
        answerForm.setOrder(order);
        answerForm.setDateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("hh:mm dd.MM.yyyy")));
        order.setClosed(true);
        order.setIssue(false);
        orderDao.save(order);
        answerDao.save(answerForm);
        return "redirect:/manager/issue-orders";
    }

    @PostMapping("close-employee{id}")
    public String closeEmployee(@PathVariable Integer id,
                                @ModelAttribute("answerForm") Answer answerForm){
        Order order = orderDao.getById(id);
        answerForm.setDateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("hh:mm dd.MM.yyyy")));
        answerForm.setOrder(order);
        order.setClosed(true);
        order.setIssue(false);
        orderDao.save(order);
        answerDao.save(answerForm);
        return "redirect:/manager/issue-orders";
    }
}
