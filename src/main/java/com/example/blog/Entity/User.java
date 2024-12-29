package com.example.blog.Entity;

import lombok.Data;

@Data
public class User {
    private Integer userid;
    private String username;
    private String password;
    private Integer roleid;
    private String fullname;
}
