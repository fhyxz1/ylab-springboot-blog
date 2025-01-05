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
import java.util.Map;

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
    public ResponseEntity<?> registerUser(@RequestBody User user) {
        String success = userService.registerUser(user);
        if (success=="success") {
            return ResponseEntity.ok(success);
        } else if (success=="exists"){
            return ResponseEntity.status(409).body("用户已存在！");
        }
        else {
            System.out.println("参数错误！");
            return ResponseEntity.status(400).body("请求参数错误！");
    }}

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
        try {
            // 检查登录状态，抛出异常时表示 Token 无效或过期
            StpUtil.checkLogin();

            // 获取当前用户 ID
            int userid = StpUtil.getLoginIdAsInt();
            User user = userService.getUserById(userid);

            // 如果用户存在，返回用户信息
            if (user != null) {
                useresp rep = new useresp(userid, user.getUsername(), userService.getRole(user.getRoleid()), user.getFullname());
                return ResponseEntity.ok(rep); // 返回200 OK
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); // 返回404
            }
        } catch (Exception e) {
            // 捕获 Token 过期或无效异常，返回401状态码
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token已过期或无效，请重新登录");
        }
    }


    // 注销接口
    @PostMapping("/logout")
    public ResponseEntity<String> logout() {
        StpUtil.logout();
        return ResponseEntity.ok("User logged out successfully!"); // 返回200 OK
    }
    //获取用户列表
    @GetMapping("/list")
    public ResponseEntity<?> getUserList(
            @RequestParam(required = false) String username,
            @RequestParam(required = false) Integer roleid,
            @RequestParam(defaultValue = "1") Integer currentPage,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        try {
            Map<String, Object> result = userService.getUserList(username, roleid, currentPage, pageSize);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("获取用户列表失败：" + e.getMessage());
        }
    }
//更新用户数据
    @PutMapping("/{id}")
    public ResponseEntity<?> updateUser(@PathVariable Integer id, @RequestBody User user) {
        try {
            user.setUserid(id);
            boolean success = userService.updateUser(user);
            if (success) {
                return ResponseEntity.ok("用户更新成功");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("用户不存在");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("更新失败：" + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable Integer id) {
        try {
            boolean success = userService.deleteUser(id);
            if (success) {
                return ResponseEntity.ok("用户删除成功");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("用户不存在");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("删除用户失败：" + e.getMessage());
        }
    }

    @PostMapping("/{id}/reset-password")
    public ResponseEntity<?> resetPassword(@PathVariable Integer id, @RequestBody Map<String, String> body) {
        try {
            String newPassword = body.get("password");
            boolean success = userService.resetPassword(id, newPassword);
            if (success) {
                return ResponseEntity.ok("密码重置成功");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("用户不存在");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("密码重置失败：" + e.getMessage());
        }
    }
}
