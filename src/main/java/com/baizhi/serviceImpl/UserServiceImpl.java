package com.baizhi.serviceImpl;

import com.baizhi.entity.UserProvince;
import com.baizhi.mapper.UserMapper;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    public List<UserProvince> queryUserProvince() {
        List<UserProvince> userProvinces = userMapper.queryProvince();

        return userProvinces;
    }

    @Override
    public List<Integer> queryUserActive() {
        List<Integer> list = new ArrayList<>();
        int[] a = {7, 14, 21};
        for (int i = 0; i < a.length; i++) {
            int active = userMapper.queryUserActive(a[i]);
            list.add(active);
        }

        return list;
    }

}
