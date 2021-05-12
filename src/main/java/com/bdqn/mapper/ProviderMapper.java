package com.bdqn.mapper;

import com.bdqn.entity.Provider;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProviderMapper {
    List<Provider> getList(@Param("id") Integer id,@Param("proCode") String proCode,@Param("proName") String proName);
    int add(Provider provider);
    int delete(@Param("id") int id);
}
