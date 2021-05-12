package com.bdqn.controller;

import com.alibaba.fastjson.JSON;
import com.bdqn.entity.Provider;
import com.bdqn.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class ProviderController {
    @Autowired
    ProviderService providerService;


    @RequestMapping(value = "/providerList.do",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String providerList(Model model) {
        List<Provider> list = providerService.getList(null, null,null);
        return JSON.toJSONString(list);
    }

    @RequestMapping("/provider.do")
    public String Inquire(String queryProCode,String queryProName,Model model) {
        List<Provider> list = providerService.getList(null, queryProCode,queryProName);
        model.addAttribute("queryProCode", queryProCode);
        model.addAttribute("queryProName", queryProName);
        model.addAttribute("providerList", list);
        return "jsp/providerlist";
    }
    @RequestMapping("/providerview.do")
    public String providerview(int proid,Model model) {
        List<Provider> list = providerService.getList(proid, null,null);
        model.addAttribute("list", list);
        return "jsp/providerview";
    }
    @RequestMapping("/providermodify.do")
    public String providermodify(int proid,Model model) {
        List<Provider> list = providerService.getList(proid, null,null);
        model.addAttribute("list", list);
        return "jsp/providermodify";
    }








    @RequestMapping("/add.do")
    public String add() {
        return "jsp/provider-add";
    }

    @RequestMapping("/provideradd.do")
    public String provideradd(Provider provider) {
        int add = providerService.add(provider);
            return "redirect:provider.do";
    }


    @RequestMapping("/provideraddverify.do")
    @ResponseBody
    public String provideraddverify(String proCode) {
        List<Provider> list = providerService.getList(null, proCode,null);
        if (list.size()<=0) {
            return "true";
        }else {
            return "false";
        }
    }
}
