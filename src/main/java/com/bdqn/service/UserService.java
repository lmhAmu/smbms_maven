package com.bdqn.service;

import com.bdqn.entity.Page;
import com.bdqn.entity.User;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;
import java.util.List;

public interface UserService {
    List<User> getList(String userName,Integer userRole,Integer id);
    int add(User user);
    User get(String userCode,String userPassword);
    //修改密码
    int update(User user);
    //分页
    Page getPageList(Integer pageNo, Integer pageSize, String userName, Integer userRole) throws SQLException;
}
