package com.baizhi.controller;

import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/adminLogin")
public class AdminLoginController {
    @Autowired
    private AdminService adminService;

    @RequestMapping("/login")
    public String login(String name, String password, String code, HttpSession session) {
      /*  //从session中获取存入的验证码
        String str = (String) session.getAttribute("code");
        if(!str.equals(code)) return "false";*/
        Admin admin = null;
        try {
            admin = adminService.queryAdminByName(name, password);
            if (admin == null) return "false";
            //用户验证成功后，将用户存入session
            session.setAttribute("admin", admin);
            //存放用户登陆成功的标识
            session.setAttribute("login", "ok");
            //System.out.println(admin);
            System.out.println("我是控制台::" + name + "," + password);
            return "ok";
        } catch (Exception e) {
            e.printStackTrace();
            return "false";
        }

    }

}
