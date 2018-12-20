package com.baizhi.service;


import com.baizhi.entity.Admin;

public interface AdminService {
    public Admin queryAdminByName(String name, String password);
}
