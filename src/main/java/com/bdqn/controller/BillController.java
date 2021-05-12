package com.bdqn.controller;

import com.bdqn.entity.Bill;
import com.bdqn.entity.Provider;
import com.bdqn.service.BillService;
import com.bdqn.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@Controller
public class BillController {
    @Autowired
    BillService billService;
    @Autowired
    ProviderService providerService;

    @RequestMapping("/billList.do")
    public String inquire(String queryProductName,
                          Integer queryProviderId,
                          Integer queryIsPayment,
                          Model model) {
        model.addAttribute("queryProductName",queryProductName);
        model.addAttribute("queryProviderId",queryProviderId);
        model.addAttribute("queryIsPayment",queryIsPayment);
        List<Bill> list = billService.inquire(queryProductName, queryProviderId, queryIsPayment,null);
        model.addAttribute("list", list);
        List<Provider> providerList = providerService.getList(null, null,null);
        model.addAttribute("providerList", providerList);
        return "jsp/billlist";
    }

    @RequestMapping("/billview.do")
    public String billview(int billid,Model model){
        List<Bill> list = billService.inquire(null, null, null, billid);
        model.addAttribute("list", list);
        return "jsp/billview";
    }

    @RequestMapping("/billmodify.do")
    public String billmodify(int billid,Model model){
        List<Provider> providerList = providerService.getList(null, null,null);
        model.addAttribute("providerList", providerList);
        List<Bill> list = billService.inquire(null, null, null, billid);
        model.addAttribute("list", list);
        Integer queryProviderId=null;
        for (Bill bill : list) {
            queryProviderId = bill.getProviderId();
        }
        model.addAttribute("queryProviderId",queryProviderId);
        return "jsp/billmodify";
    }

    @RequestMapping("/billupdate.do")
    @ResponseBody
    public String billupdate(Bill bill){
        int i = billService.update(bill);
        if(i>0){
            return "true";
        }else {
            return "false";
        }
    }

    @RequestMapping("/billadd.do")
    @ResponseBody
    public String billadd(Bill bill){
        bill.setCreationDate(new Date());
        int i = billService.add(bill);
        if(i>0){
            return "true";
        }else {
            return "false";
        }
    }

    @RequestMapping("/billdelete.do")
    @ResponseBody
    public String billdelete(int id){
        int i = billService.delete(id);
        if(i>0){
            return "true";
        }else {
            return "false";
        }
    }
}
