package com.example.blog.Entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class User {
    private Integer userid;       // 用户ID
    private String username;      // 用户名
    private String password;      // 密码
    private Integer roleid;       // 用户角色ID
    private String fullname;      // 用户全名
    private LocalDateTime registerTime; // 注册时间
}
