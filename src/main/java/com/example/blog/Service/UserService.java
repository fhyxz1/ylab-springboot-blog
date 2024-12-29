package com.example.blog.Service;

import cn.dev33.satoken.stp.StpUtil;
import com.example.blog.Entity.User;
import com.example.blog.Mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    // 查询单个用户
    public User getUserById(Integer id) {
        System.out.println(id);
        if (id == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        return userMapper.getUserById(id);
    }

    // 查询所有用户
    public List<User> getAllUsers() {
        return userMapper.getAllUsers();
    }

    // 注册用户
    public String registerUser(User user) {
        if (user == null || user.getUsername() == null) {
            throw new IllegalArgumentException("用户信息或用户名不能为空");
        }

        // 检查用户名是否存在
        User existingUser = userMapper.getUserByUsername(user.getUsername());
        if (existingUser != null) {
            return "exists"; // 用户名已存在
        }

        userMapper.insertUser(user);
        return "success";
    }

    // 根据用户名查询用户
    public User getUserByUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("用户名不能为空");
        }
        System.out.println(userMapper.getUserByUsername(username));
        return userMapper.getUserByUsername(username);
    }
    public String getRole(Integer roleid) {
        return userMapper.getRole(roleid);
    }
    // 用户登录
    public boolean loginUser(String username, String password) {
        if (username == null || password == null) {
            throw new IllegalArgumentException("用户名和密码不能为空");
        }

        // 验证用户
        User user = userMapper.getUserByUsername(username);
        if (user == null) {
            throw new IllegalArgumentException("用户不存在");
        }

        if (!user.getPassword().equals(password)) {
            throw new IllegalArgumentException("密码错误");
        }

        // 使用 Sa-Token 登录
        try {
            StpUtil.login(user.getUserid()); // 确保 user.getId() 不为空
            return true;
        } catch (Exception e) {
            throw new RuntimeException("登录失败: " + e.getMessage(), e);
        }
    }
}
