package com.baizhi.serviceImpl;

import com.baizhi.entity.Menu;
import com.baizhi.mapper.MenuMapper;
import com.baizhi.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuMapper menuMapper;

    //根据用户的parent_id查询
    @Override
    public List<Menu> queryCategory(int parent_id) {
        Menu menu = new Menu();
        menu.setParentId(parent_id);
        List<Menu> menus = menuMapper.select(menu);
        return menus;
    }
}
