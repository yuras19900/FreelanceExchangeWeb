package com.freelanceExchange.controller;

import com.freelanceExchange.dao.UserDao;
import com.freelanceExchange.model.Role;
import com.freelanceExchange.model.User;
import com.freelanceExchange.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserService userService;

    @GetMapping("/all-users")
    public String allUsers(Model model) {
        List<User> users = userDao.findAll();
        model.addAttribute("users", users);
        return "admin/allUsers";
    }

    @PostMapping("/block")
    public String blockUser(@RequestParam Integer userId, Model model){
        User user = userDao.getById(userId);
        if(user.getUsername().equals("admin")){
            model.addAttribute("adminBlockError", "Не надо так делать");
            return "redirect:/admin/all-users";
        }
        if(user.isActive()) {
            user.setActive(false);
            userDao.save(user);
        } else if(!user.isActive()){
            user.setActive(true);
            userDao.save(user);
        }
        return "redirect:/admin/all-users";
    }

    @GetMapping("/add-manager")
    public String addNewManager(Model model){
        model.addAttribute("managerForm", new User());
        return "admin/addManager";
    }

    @PostMapping("/add-manager")
    public String addManager(@ModelAttribute("managerForm") User managerForm, Model model){
        if (!managerForm.getPassword().equals(managerForm.getPasswordConfirm())){
                  model.addAttribute("managerPasswordError", "Пароли не совпадают");
            return "admin/addManager";
        }
        managerForm.setRoles(Collections.singleton(new Role(3, "ROLE_MANAGER")));
        if (!userService.saveUser(managerForm)){
            model.addAttribute("managerUsernameError", "Пользователь с таким именем уже существует");
            return "admin/addManager";
        }
        return "redirect:/";
    }
}
