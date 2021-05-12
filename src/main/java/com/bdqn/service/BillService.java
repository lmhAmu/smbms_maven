package com.bdqn.service;

import com.bdqn.entity.Bill;

import java.util.List;

public interface BillService {
    List<Bill> inquire(String productName,
                       Integer providerId,
                       Integer isPayment,Integer id);
    //修改
    int update(Bill bill);
    //添加
    int add(Bill bill);
    //删除
    int delete(int id);
}
