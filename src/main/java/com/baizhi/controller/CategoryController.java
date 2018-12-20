package com.baizhi.controller;

import com.baizhi.entity.Menu;
import com.baizhi.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("category")
public class CategoryController {
    @Autowired
    private MenuService menuService;

  /*  //查询子标签
    @RequestMapping("queryChildenCategory")
    public List<Menu> queryChildenCategory(int parent_id){

        return null;
    }*/

    //查询父标签
    @RequestMapping("queryParentCategory")
    public List<Menu> queryParentCategory(int parent_id) {
        List<Menu> menus = menuService.queryCategory(parent_id);

        return menus;

    }

}
