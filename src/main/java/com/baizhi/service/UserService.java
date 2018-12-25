package com.baizhi.service;

import com.baizhi.entity.UserProvince;

import java.util.List;

public interface UserService {
    public List<UserProvince> queryUserProvince();

    //用户活跃数
    public List<Integer> queryUserActive();
}
