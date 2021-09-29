package com.freelanceExchange.controller;

import com.freelanceExchange.dao.OrderDao;
import com.freelanceExchange.dao.ProposalDao;
import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.Proposal;
import com.freelanceExchange.model.User;
import com.freelanceExchange.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private OrderService orderService;

    @Autowired
    private ProposalDao proposalDao;

    @GetMapping("/myOrders")
    public String myOrders(Model model, @AuthenticationPrincipal User user) {
        List<Order> orders = orderService.findAllByUserId(user);
        model.addAttribute("orders", orders);
        return "order/myOrders";
    }

    @GetMapping("/newOrder")
    public String newOrder(Model model) {
        model.addAttribute("orderForm", new Order());
        return "order/newOrder";
    }

    @PostMapping("/newOrder")
    public String addOrder(@ModelAttribute("orderForm") Order orderForm, BindingResult bindingResult, Model model, @AuthenticationPrincipal User user) {
        if (orderForm.getName() == null || orderForm.getDescription() == null) {
            model.addAttribute("requiredFieldError", "Заполните все необходимые поля");
            return "order/newOrder";
        }
        orderService.saveOrder(orderForm, user);
        return "redirect:/myOrders";
    }

    @GetMapping("/order{id}")
    public String orderById(@PathVariable Integer id, Model model) {
        Order order = orderDao.getById(id);
        model.addAttribute("order", order);
        if(order.isVacant()){
            List<Proposal> proposals = proposalDao.findProposalByOrder(order);
            model.addAttribute("proposals", proposals);
        }
        if(!order.isVacant()){
            Proposal acceptedProposal = proposalDao.getProposalByOrderAndDeclinedIsFalse(order);
            model.addAttribute("acceptedProposal", acceptedProposal);
        }
        return "order/order";
    }

    @PostMapping("acceptProposal{proposalId}for{orderId}")
    public String acceptProposal(@PathVariable Integer proposalId, @PathVariable Integer orderId, Model model) {

        Order order = orderDao.getById(orderId);
        List<Proposal> declinedProposals = proposalDao.findProposalByOrder(order);
        for(Proposal proposals: declinedProposals){ //помечаем все заявки на выполнения, как отклоненные
            proposals.setDeclined(true);
            proposalDao.save(proposals);
        }
        Proposal proposal = proposalDao.getById(proposalId);
        proposal.setDeclined(false); //помечаем выбранную пользователем заявку как не отклонённую
        order.setEmployee(proposal.getUser());
        order.setVacant(false);
        orderDao.save(order);
        return "order/myOrders";
    }
}
