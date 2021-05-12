package com.bdqn.controller;

import com.alibaba.fastjson.JSON;
import com.bdqn.entity.Provider;
import com.bdqn.entity.Role;
import com.bdqn.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class RoleController {
    @Autowired
    RoleService  roleService;
    @RequestMapping(value = "/roleList.do",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String roleList(Model model) {
        List<Role> list = roleService.getList();
        return JSON.toJSONString(list);
    }
}
