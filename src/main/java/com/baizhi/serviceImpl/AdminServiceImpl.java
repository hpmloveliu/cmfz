package com.baizhi.serviceImpl;

import com.baizhi.entity.Admin;
import com.baizhi.mapper.AdminMapper;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;

    public Admin queryAdminByName(String name, String password) {
        if (name.length() == 0) throw new RuntimeException("用户名为空");
        Admin ad = new Admin();
        ad.setName(name);
        Admin admin = adminMapper.selectOne(ad);
        if (admin == null) throw new RuntimeException("用户不存在");
        if (!admin.getPassword().equals(password)) throw new RuntimeException("密码不正确");

        return admin;
    }
}
