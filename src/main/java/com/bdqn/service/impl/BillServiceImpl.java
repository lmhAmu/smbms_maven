package com.bdqn.service.impl;

import com.bdqn.entity.Bill;
import com.bdqn.mapper.BillMapper;
import com.bdqn.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class BillServiceImpl implements BillService {
    @Autowired
    BillMapper billMapper;
    @Override
    public List<Bill> inquire(String productName, Integer providerId, Integer isPayment,Integer id) {
        return billMapper.inquire(productName,providerId,isPayment,id);
    }

    @Override
    public int update(Bill bill) {
        return billMapper.update(bill);
    }

    @Override
    public int add(Bill bill) {
        return billMapper.add(bill);
    }

    @Override
    public int delete(int id) {
        return billMapper.delete(id);
    }
}
