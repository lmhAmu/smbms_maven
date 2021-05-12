package com.bdqn.service.impl;


import com.bdqn.entity.Provider;
import com.bdqn.mapper.ProviderMapper;
import com.bdqn.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ProviderServiceImpl implements ProviderService {
    @Autowired
    ProviderMapper providerMapper;

    @Override
    public List<Provider> getList(Integer id,String proCode,String proName) {
        return providerMapper.getList(id,proCode,proName);
    }

    @Override
    public int add(Provider provider) {
        return providerMapper.add(provider);
    }

    @Override
    public int delete(int id) {
        return providerMapper.delete(id);
    }
}
