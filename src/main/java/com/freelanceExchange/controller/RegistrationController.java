package com.freelanceExchange.controller;

import com.freelanceExchange.model.Role;
import com.freelanceExchange.model.User;
import com.freelanceExchange.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Collections;

@Controller
public class RegistrationController {

    @Autowired
    private UserRepo userRepo;

    @GetMapping("/registration")
    public String registration() {
        return "/authorization/registration";
    }

    @PostMapping("/registration")
    public String addUser(User user, Model model) {

        /*User userFromDb = userRepo.findByLogin(user.getLogin());
        if (userFromDb != null) {
            model.addAttribute("message", "User is already exists");
            return "/authorization/registration";
        }*/
        model.addAttribute("login", user.getLogin());
        model.addAttribute("password", user.getPassword());
        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        userRepo.save(user);

        return "redirect:/authorization/login";
    }

}
