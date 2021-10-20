package com.freelanceExchange.controller;

import com.freelanceExchange.model.Role;
import com.freelanceExchange.model.User;
import com.freelanceExchange.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;

@Controller
public class RegistrationController {

    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
        return "authorization/registration";
    }

    @PostMapping("/registration")
    public String addUser(@ModelAttribute("userForm") User userForm, Model model,
                          @RequestParam("role") String role){

        if (!userForm.getPassword().equals(userForm.getPasswordConfirm())){
            model.addAttribute("passwordError", "Пароли не совпадают");
            return "authorization/registration";
        }
        if(role.equals("ROLE_USER")){
            userForm.setRoles(Collections.singleton(new Role(1, "ROLE_USER")));
        } else if(role.equals("ROLE_EMPLOYEE")){
            userForm.setRoles(Collections.singleton(new Role(2, "ROLE_EMPLOYEE")));
        } else {
            model.addAttribute("roleError", "Выберите роль");
            return "authorization/registration";
        }
        if (!userService.saveUser(userForm)){
            model.addAttribute("usernameError", "Пользователь с таким именем уже существует");
            return "authorization/registration";
        }
        return "redirect:/";
    }

}
