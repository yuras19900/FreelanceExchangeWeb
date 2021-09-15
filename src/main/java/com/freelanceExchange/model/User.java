package com.freelanceExchange.model;

import javax.persistence.*;

@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "user_login")
    private String userLogin;

    @Column(name = "user_password")
    private String userPassword;
}
