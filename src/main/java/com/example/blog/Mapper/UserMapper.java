package com.example.blog.Mapper;

import com.example.blog.Entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    // 查询所有用户
    List<User> getAllUsers();

    // 根据用户名查询用户
    User getUserByUsername(@Param("username") String username);
    String getRole(@Param("roleid")Integer roleid);
    // 根据 ID 查询用户
    User getUserById(@Param("userid") Integer userid);

    // 插入新用户（注册功能）
    int insertUser(User user);

    // 登录验证
    User login(@Param("username") String username, @Param("password") String password);

    // 更新用户信息
    int updateUser(User user);

    // 删除用户
    int deleteUserById(@Param("userId") Integer userId);
}
