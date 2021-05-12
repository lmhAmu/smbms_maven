package com.bdqn.mapper;


import com.bdqn.entity.Bill;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BillMapper {
    // 学员操作—实现订单表的查询操作
    List<Bill> inquire(@Param("productName") String productName,
                       @Param("providerId") Integer providerId,
                       @Param("isPayment") Integer isPayment,
                       @Param("id") Integer id);
    //修改
    int update(Bill bill);
    //添加
    int add(Bill bill);
    //删除
    int delete(@Param("id") int id);
}
