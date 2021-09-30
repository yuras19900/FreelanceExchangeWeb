package com.freelanceExchange.controller;

import com.freelanceExchange.dao.OrderDao;
import com.freelanceExchange.dao.ProposalDao;
import com.freelanceExchange.dao.ResultDao;
import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.Proposal;
import com.freelanceExchange.model.Result;
import com.freelanceExchange.model.User;
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

    @Value("${upload.path}")
    private String uploadPath;

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
        Proposal proposal = proposalDao.getProposalByOrderAndDeclinedIsFalse(order);
        model.addAttribute("proposal", proposal);
        model.addAttribute("resultForm", new Result());
        if(order.isReady()){
            List<Result> results = resultDao.findResultByOrder(order);
            model.addAttribute("results", results);
        }
        return "/order/employee/activeOrder";
    }

    @PostMapping("/addResult{id}")
    public String addResult(@PathVariable Integer id, @ModelAttribute("resultForm") Result resultForm,
                            @RequestParam("file")MultipartFile file, Model model) throws IOException {
        if (file.isEmpty()){
            model.addAttribute("emptyFileError", "К отчету необходимо прикрепить файл");
            return "order/employee/activeOrder";
        } else {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()){
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();
            resultForm.setFilename(resultFileName);
            file.transferTo(new File(uploadPath+ "/" +resultFileName));
            Order order = orderDao.getById(id);
            resultForm.setOrder(order);
            order.setReady(true);
            orderDao.save(order);
            resultDao.save(resultForm);
        }
        return "/order/employee/activeOrder";
    }
}
