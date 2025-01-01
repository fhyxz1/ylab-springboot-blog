package com.example.blog.Dto;

import lombok.Data;

@Data
public class LoginResponse {
    private  Integer userid;
    private String token;
    private String username;
    public LoginResponse(Integer userid, String token, String role, String fullname) {
        this.userid = userid;
        this.token = token;
        this.role = role;
        this.fullname = fullname;
    }

    private String role;
    private String fullname;

    public LoginResponse(Integer userid, String token, String username, String role, String fullname) {
        this.userid = userid;
        this.token = token;
        this.username = username;
        this.role = role;
        this.fullname = fullname;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getFullname() {
        return fullname;
    }

    public LoginResponse(String token, String role, String fullname) {
        this.token = token;
        this.role = role;
        this.fullname = fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
// 构造函数

    // getter和setter
    // ...
}
