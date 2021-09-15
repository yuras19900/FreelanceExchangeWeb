package com.freelanceExchange.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GuestController {

    @GetMapping("/")
    private String main(){
        return "/general/index";
    }

    @GetMapping("/aboutUs")
    private String aboutUs(){
        return "/general/aboutUs";
    }

}
