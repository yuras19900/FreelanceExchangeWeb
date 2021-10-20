package com.freelanceExchange.controller;

import com.freelanceExchange.dao.*;
import com.freelanceExchange.model.*;
import com.freelanceExchange.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
public class OrderController {

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

    @Value("${upload.path}")
    private String uploadPath;

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
    public String addOrder(@ModelAttribute("orderForm") Order orderForm, BindingResult bindingResult, Model model, @AuthenticationPrincipal User user) {
        orderService.saveOrder(orderForm, user);
        return "redirect:/my-orders";
    }

    @GetMapping("/order{id}")
    public String orderById(@PathVariable Integer id, Model model) {
        Order order = orderDao.getById(id);
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

    @PostMapping("/accept-proposal{proposalId}for{orderId}")
    public String acceptProposal(@PathVariable Integer proposalId, @PathVariable Integer orderId) {

        Order order = orderDao.getById(orderId);
        List<Proposal> declinedProposals = proposalDao.findProposalByOrder(order);
        for (Proposal proposals : declinedProposals) { //помечаем все заявки на выполнения, как отклоненные
            proposals.setDeclined(true);
            proposalDao.save(proposals);
        }
        Proposal proposal = proposalDao.getById(proposalId);
        proposal.setDeclined(false); //помечаем выбранную пользователем заявку как не отклонённую
        order.setEmployee(proposal.getUser());
        order.setVacant(false);
        orderDao.save(order);
        return "redirect:/my-orders";
    }

    @PostMapping("payOrder{orderId}")
    public String payOrder(@PathVariable Integer orderId) {
        Order order = orderDao.getById(orderId);
        order.setPaid(true);
        orderDao.save(order);
        return "redirect:/order{orderId}";
    }

    @GetMapping("/download{fileName}")
    public String downloadFile(@PathVariable String fileName, HttpServletResponse response){
        Path file = Paths.get(uploadPath);
        if(Files.exists(file)){
            response.setHeader("Content-disposition", "attachment;filename=" + fileName);
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

    @PostMapping("/new-report{id}")
    public String newReport(@PathVariable Integer id, @ModelAttribute ("reportForm") Report reportForm){
        Order order = orderDao.getById(id);
        reportForm.setOrder(order);
        reportForm.setClosed(false);
        reportForm.setDescription(reportForm.getDescription());
        order.setIssue(true);
        orderDao.save(order);
        reportDao.save(reportForm);
        return "redirect:/order{id}";
    }

    @PostMapping("/close-order{id}")
    public String closeOrder(@PathVariable Integer id){
        Order order =orderDao.getById(id);
        order.setClosed(true);
        orderDao.save(order);
        return "redirect:/my-orders";
    }
}
