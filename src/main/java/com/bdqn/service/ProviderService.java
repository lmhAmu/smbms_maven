package com.bdqn.service;


import com.bdqn.entity.Provider;

import java.util.List;

public interface ProviderService {
    List<Provider> getList(Integer id,String proCode,String proName);
    int add(Provider provider);
    int delete(int id);
}
