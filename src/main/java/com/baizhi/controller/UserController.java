package com.baizhi.controller;


import com.baizhi.entity.UserProvince;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("queryAllUser")
    public Map<String, List<UserProvince>> queryAllUser() {
        Map<String, List<UserProvince>> map = new HashMap<>();
        List<UserProvince> list = userService.queryUserProvince();
        map.put("data", list);
        System.out.println(map.toString());
        return map;
    }

    @RequestMapping("queryByDate")
    public Map<String, List<Integer>> queryByDate() {
        Map<String, List<Integer>> map = new HashMap<>();
        List<Integer> list = userService.queryUserActive();
        map.put("data", list);
        return map;
    }

}
