package com.freelanceExchange.controller;

import com.freelanceExchange.dao.AnswerDao;
import com.freelanceExchange.dao.OrderDao;
import com.freelanceExchange.dao.ProposalDao;
import com.freelanceExchange.dao.ResultDao;
import com.freelanceExchange.model.*;
import com.freelanceExchange.service.ProposalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private ProposalDao proposalDao;

    @Autowired
    private ProposalService proposalService;

    @Autowired
    private ResultDao resultDao;

    @Autowired
    private AnswerDao answerDao;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/vacant-orders")
    public String vacantOrders(Model model) {
        List<Order> vacantOrders = orderDao.findByVacantIsTrue();
        model.addAttribute("vacantOrders", vacantOrders);
        return "/order/employee/vacantOrders";
    }

    @PostMapping("filter")
    public String filter(Model model, @RequestParam String filter) {
        Iterable<Order> ordersByTag;
        if (!filter.isEmpty()) {
            ordersByTag = orderDao.findOrdersByTagAndVacantIsTrue(filter);
        } else {
            ordersByTag = orderDao.findByVacantIsTrue();
        }
        model.addAttribute("vacantOrders", ordersByTag);
        return "/order/employee/vacantOrders";
    }


    @GetMapping("/new-proposal{id}")
    public String newProposal(@PathVariable Integer id, Model model, @AuthenticationPrincipal User authUser) {
        Order order = orderDao.getById(id);
        List<Proposal> myProposals = proposalDao.findProposalsByOrderAndUser(order, authUser);
        model.addAttribute("order", order);
        model.addAttribute("myProposals", myProposals);
        model.addAttribute("proposalForm", new Proposal());

        return "/order/employee/newProposal";
    }

    @PostMapping("new-proposal")
    public String newProposal(@ModelAttribute("proposalForm") Proposal proposalForm, @AuthenticationPrincipal User user, @RequestParam Integer orderId) {
        Order order = orderDao.getById(orderId);
        proposalForm.setOrder(order);
        proposalService.saveProposal(proposalForm, user);
        return "redirect:/employee/vacant-orders";
    }

    @GetMapping("/my-active-orders")
    public String myActiveOrders(@AuthenticationPrincipal User user, Model model) {
        List<Order> activeOrders = orderDao.findAllByEmployeeAndClosedIsFalse(user);
        List<Order> closedOrders = orderDao.findAllByEmployeeAndClosedIsTrue(user);
        model.addAttribute("activeOrders", activeOrders);
        model.addAttribute("closedOrders", closedOrders);
        return "/order/employee/myActiveOrders";
    }

    @GetMapping("/active-order{id}")
    public String activeOrder(@PathVariable Integer id, Model model, @AuthenticationPrincipal User authUser) {
        Order order = orderDao.getById(id);
        if (!order.getEmployee().getId().equals(authUser.getId())) {
            return "redirect:/forbidden";
        }
        model.addAttribute("order", order);
        Proposal proposal = proposalDao.getProposalByOrderAndDeclinedIsFalse(order);
        model.addAttribute("proposal", proposal);
        model.addAttribute("resultForm", new Result());
        List<Result> results = resultDao.findResultsByOrder(order);
        model.addAttribute("results", results);
        List<Answer> answers = answerDao.findAnswersByOrder(order);
        model.addAttribute("answers", answers);
        return "/order/employee/activeOrder";
    }

    @PostMapping("add-result")
    public String addResult(@RequestParam Integer orderId, @ModelAttribute("resultForm") Result resultForm,
                            @RequestParam("file") MultipartFile file, Model model) throws IOException {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        String uuidFile = UUID.randomUUID().toString();
        String resultFileName = uuidFile + "." + file.getOriginalFilename();
        resultForm.setFilename(resultFileName);
        file.transferTo(new File(uploadPath + "/" + resultFileName));
        Order order = orderDao.getById(orderId);
        resultForm.setOrder(order);
        resultForm.setDateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm dd.MM.yyyy")));
        order.setReady(true);
        orderDao.save(order);
        resultDao.save(resultForm);
        return "redirect:/employee/my-active-orders";
    }
}
