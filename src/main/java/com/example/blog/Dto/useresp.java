package com.example.blog.Dto;

import lombok.Data;

@Data
public class useresp {
    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    private Integer userid;
    private String username;
    private String role;

    public useresp(Integer userid, String username, String role, String fullname) {
        this.userid = userid;
        this.username = username;
        this.role = role;
        this.fullname = fullname;
    }

    private String fullname;
}
