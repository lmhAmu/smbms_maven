package com.bdqn.service.impl;

import com.bdqn.entity.User;
import com.bdqn.mapper.UserMapper;
import com.bdqn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Override
    public List<User> getList(String userName, Integer userRole,Integer id) {
        return userMapper.getList(userName,userRole,id);
    }

    @Override
    public int add(User user) {
        return userMapper.add(user);
    }

    @Override
    public User get(String userCode, String userPassword) {

        return userMapper.get(userCode,userPassword);
    }

    @Override
    public int update(User user) {
        return userMapper.update(user);
    }
}
