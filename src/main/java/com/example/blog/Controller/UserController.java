package com.example.blog.Controller;

import cn.dev33.satoken.stp.StpUtil;
import com.example.blog.Dto.LoginResponse;
import com.example.blog.Dto.useresp;
import com.example.blog.Entity.User;
import com.example.blog.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.management.relation.Role;
import java.util.List;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    // 查询单个用户
    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Integer id) {
        User user = userService.getUserById(id);
        if (user != null) {
            return ResponseEntity.ok(user); // 返回200 OK
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); // 返回404
        }
    }

    // 查询所有用户
    @GetMapping
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> users = userService.getAllUsers();
        return ResponseEntity.ok(users); // 返回200 OK
    }

    // 注册接口
    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody User user) {
        boolean success = userService.registerUser(user);
        if (success) {
            return ResponseEntity.status(HttpStatus.CREATED).body("User registered successfully!");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Username already exists!");
        }
    }

    // 登录接口
    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody User user) {
        User loginUser = userService.getUserByUsername(user.getUsername());
        if (loginUser != null && loginUser.getPassword().equals(user.getPassword())) {

            // 调用 Sa-Token 的登录方法
            StpUtil.login(loginUser.getUserid());
            String token = StpUtil.getTokenValue();
            // 创建包含token和用户信息的响应对象
            System.out.println(userService.getRole(loginUser.getRoleid()));
            LoginResponse response = new LoginResponse(loginUser.getUserid(),token,userService.getRole(loginUser.getRoleid()),loginUser.getFullname());
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("用户名或密码错误！");
        }
    }

    // 获取当前登录用户信息
    @GetMapping("/info")
    public ResponseEntity<?> getCurrentUserInfo() {
        int userid = StpUtil.getLoginIdAsInt();
        User user = userService.getUserById(userid);

        useresp rep=new useresp(userid,user.getUsername(),userService.getRole(user.getRoleid()),user.getFullname());
        if (user != null) {
            return ResponseEntity.ok(rep); // 返回200 OK
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); // 返回404
        }
    }

    // 注销接口
    @PostMapping("/logout")
    public ResponseEntity<String> logout() {
        StpUtil.logout();
        return ResponseEntity.ok("User logged out successfully!"); // 返回200 OK
    }
}
