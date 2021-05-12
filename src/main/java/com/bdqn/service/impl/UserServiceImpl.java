package com.bdqn.service.impl;

import com.bdqn.entity.Page;
import com.bdqn.entity.User;
import com.bdqn.mapper.UserMapper;
import com.bdqn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
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
    @Override
    public Page getPageList(Integer pageNo, Integer pageSize, String userName, Integer userRole) throws SQLException {
        Page page=new Page();
        //1，获取总条数
        int totalCount = userMapper.getTotalCount();
        //2,确定总页数
        int totalPageCount
                =totalCount%pageSize==0?totalCount/pageSize:totalCount/pageSize+1;
        //对pageNo和pageSize做合法处理
        //pageNo=pageNo<=0?1:pageNo;
        pageNo=pageNo>totalPageCount?totalPageCount:pageNo;
        pageNo=pageNo<=0?1:pageNo;

        pageSize=pageSize<=0?page.getPageSize():pageSize;
        //3，获取当前页面集合
        List<User> list = userMapper.getPageList((pageNo-1)*pageSize, pageSize,userName,userRole);
        //4，返回初始化后的Page
        page.setCurrPageNo(pageNo);
        page.setPageSize(pageSize);
        page.setTotalCount(totalCount);
        page.setTotalPageCount(totalPageCount);
        page.setUserList(list);
        return page;
    }
}
