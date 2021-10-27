package com.freelanceExchange.controller;

import com.freelanceExchange.dao.*;
import com.freelanceExchange.model.*;
import com.freelanceExchange.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class OrderController {

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private OrderService orderService;

    @Autowired
    private ProposalDao proposalDao;

    @Autowired
    private ResultDao resultDao;

    @Autowired
    private ReportDao reportDao;

    @Autowired
    private AnswerDao answerDao;

    @GetMapping("/my-orders")
    public String myOrders(Model model, @AuthenticationPrincipal User user) {
        List<Order> closedOrders = orderDao.findOrdersByUserAndClosedIsTrue(user);
        List<Order> activeOrders = orderDao.findOrdersByUserAndClosedIsFalse(user);
        model.addAttribute("activeOrders", activeOrders);
        model.addAttribute("closedOrders", closedOrders);
        return "order/myOrders";
    }

    @GetMapping("/new-order")
    public String newOrder(Model model) {
        model.addAttribute("orderForm", new Order());
        return "order/newOrder";
    }

    @PostMapping("/new-order")
    public String addOrder(@ModelAttribute("orderForm") Order orderForm, @AuthenticationPrincipal User user) {
        orderService.saveOrder(orderForm, user);
        return "redirect:/my-orders";
    }

    @GetMapping("/order{id}")
    public String orderById(@PathVariable Integer id, Model model, @AuthenticationPrincipal User authUser) {
        Order order = orderDao.getById(id);
        if(!order.getUser().getId().equals(authUser.getId())){
            return "redirect:/forbidden";
        }
        model.addAttribute("order", order);
        model.addAttribute("reportForm", new Report());
        List<Answer> answers = answerDao.findAnswersByOrder(order);
        model.addAttribute("answers", answers);
        if (order.isVacant()) {
            List<Proposal> proposals = proposalDao.findProposalByOrder(order);
            model.addAttribute("proposals", proposals);
        }
        if (!order.isVacant()) {
            Proposal acceptedProposal = proposalDao.getProposalByOrderAndDeclinedIsFalse(order);
            model.addAttribute("acceptedProposal", acceptedProposal);
        }
        if (order.isPaid()) {
            List<Result> results = resultDao.findResultsByOrder(order);
            model.addAttribute("results", results);
        }
        return "order/order";
    }

    @PostMapping("accept-proposal")
    public String acceptProposal(@RequestParam Integer orderId, @RequestParam Integer proposalId) {

        Order order = orderDao.getById(orderId);
        List<Proposal> declinedProposals = proposalDao.findProposalByOrder(order);
        for (Proposal proposals : declinedProposals) {
            proposals.setDeclined(true);
            proposalDao.save(proposals);
        }
        Proposal proposal = proposalDao.getById(proposalId);
        proposal.setDeclined(false);
        order.setEmployee(proposal.getUser());
        order.setVacant(false);
        orderDao.save(order);
        return "redirect:/my-orders";
    }

    @PostMapping("payOrder")
    public String payOrder(@RequestParam Integer orderId) {
        Order order = orderDao.getById(orderId);
        order.setPaid(true);
        orderDao.save(order);
        return "redirect:/my-orders";
    }

    @GetMapping("/download/{fileName}")
    public String downloadFile(@PathVariable String fileName, HttpServletResponse response){
        Path file = Paths.get(uploadPath + "/" + fileName);
        if(Files.exists(file)){
            response.setHeader("Content-disposition", "attachment;filename=" + fileName + "/");
            response.setContentType("application/octet-stream");
            try {
                Files.copy(file, response.getOutputStream());
                response.getOutputStream().flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "order/myOrders";
    }

    @PostMapping("new-report")
    public String newReport(@RequestParam Integer orderId, @ModelAttribute ("reportForm") Report reportForm){
        Order order = orderDao.getById(orderId);
        reportForm.setOrder(order);
        reportForm.setClosed(false);
        reportForm.setDateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm dd.MM.yyyy")));;
        order.setIssue(true);
        orderDao.save(order);
        reportDao.save(reportForm);
        return "redirect:/my-orders";
    }

    @PostMapping("close-order")
    public String closeOrder(@RequestParam Integer orderId){
        Order order =orderDao.getById(orderId);
        order.setClosed(true);
        orderDao.save(order);
        return "redirect:/my-orders";
    }
}
