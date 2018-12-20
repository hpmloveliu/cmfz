package com.baizhi.controller;

import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/adminLogin")
public class AdminLoginController {
    @Autowired
    private AdminService adminService;

    @RequestMapping("/login")
    public String login(String name, String password, HttpSession session) {
        Admin admin = adminService.queryAdminByName(name, password);
        //用户验证成功后，将用户存入session
        session.setAttribute("admin", admin);
        //存放用户登陆成功的标识
        session.setAttribute("login", "ok");
        //System.out.println(admin);
        System.out.println("我是控制台::" + name + "," + password);
        return "main/main";
    }

}
