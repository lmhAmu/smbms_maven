package com.bdqn.mapper;

import com.bdqn.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    List<User> getList(@Param("userName") String userName,@Param("userRole") Integer userRole,@Param("id") Integer id);
    int add(User user);
    User get(@Param("userCode") String userCode,@Param("userPassword") String userPassword);
    //修改密码
    int update(User user);
}
