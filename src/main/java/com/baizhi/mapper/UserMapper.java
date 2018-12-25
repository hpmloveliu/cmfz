package com.baizhi.mapper;

import com.baizhi.entity.User;
import com.baizhi.entity.UserProvince;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface UserMapper extends Mapper<User> {
    //根据省份分组查询
    public List<UserProvince> queryProvince();

    //用户活跃
    public int queryUserActive(int time);
}
