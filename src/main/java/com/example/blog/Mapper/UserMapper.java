package com.example.blog.Mapper;

import com.example.blog.Entity.User;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface UserMapper {
    // 保留原有方法
    List<User> getAllUsers();

    User getUserByUsername(@Param("username") String username);

    String getRole(@Param("roleid") Integer roleid);

    User getUserById(@Param("userid") Integer userid);

    User login(@Param("username") String username, @Param("password") String password);

    int insertUser(User user);

    // 新增用户管理相关方法
    // 分页查询用户列表
    List<User> getUserList(@Param("username") String username,
                           @Param("roleid") Integer roleid,
                           @Param("offset") Integer offset,
                           @Param("pageSize") Integer pageSize);

    // 获取用户总数
    int getUserCount(@Param("username") String username,
                     @Param("roleid") Integer roleid);

    // 更新用户信息
    int updateUser(User user);

    // 删除用户
    int deleteUser(@Param("userid") Integer userid);

    // 重置密码
    int resetPassword(@Param("userid") Integer userid,
                      @Param("newPassword") String newPassword);
}