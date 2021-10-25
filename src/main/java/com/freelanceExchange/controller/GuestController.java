package com.freelanceExchange.controller;

import org.springframework.stereotype.Controller;
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
    private String login(){
        return "/authorization/login";
    }

    @GetMapping("/forbidden")
    private String forbidden(){
        return "/general/forbidden";
    }
}
