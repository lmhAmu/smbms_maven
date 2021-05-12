package com.bdqn.service.impl;

import com.bdqn.entity.Role;
import com.bdqn.mapper.RoleMapper;
import com.bdqn.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    RoleMapper roleMapper;
    @Override
    public List<Role> getList() {
        return roleMapper.getList();
    }
}
