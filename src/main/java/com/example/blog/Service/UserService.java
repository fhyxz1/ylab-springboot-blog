package com.example.blog.Service;

import cn.dev33.satoken.stp.StpUtil;
import com.example.blog.Entity.User;
import com.example.blog.Mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;
    public Map<String, Object> getUserList(String username, Integer roleid, Integer currentPage, Integer pageSize) {
        int offset = (currentPage - 1) * pageSize;
        List<User> users = userMapper.getUserList(username, roleid, offset, pageSize);
        int total = userMapper.getUserCount(username, roleid);

        Map<String, Object> result = new HashMap<>();
        result.put("list", users);
        result.put("total", total);
        return result;
    }
    public boolean updateUser(User user) {
        if (user == null || user.getUserid() == null) {
            throw new IllegalArgumentException("用户信息不能为空");
        }
        return userMapper.updateUser(user) > 0;
    }

    public boolean deleteUser(Integer userid) {
        if (userid == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        return userMapper.deleteUser(userid) > 0;
    }

    public boolean resetPassword(Integer userid, String newPassword) {
        if (userid == null || newPassword == null) {
            throw new IllegalArgumentException("用户ID和新密码不能为空");
        }
        return userMapper.resetPassword(userid, newPassword) > 0;
    }
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
