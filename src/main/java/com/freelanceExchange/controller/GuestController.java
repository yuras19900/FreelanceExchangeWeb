package com.freelanceExchange.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GuestController {

    @GetMapping("/")
    private String main(){
        return "/general/index";
    }

    @GetMapping("/about-us")
    private String aboutUs(){
        return "/general/aboutUs";
    }

    @GetMapping("/login")
    private String login(Model model){
        return "/authorization/login";
    }
}
