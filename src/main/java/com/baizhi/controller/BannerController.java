package com.baizhi.controller;

import com.baizhi.dto.BannerDto;
import com.baizhi.entity.Banner;
import com.baizhi.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@RestController
@RequestMapping("/banner")
public class BannerController {
    @Autowired
    private BannerService bannerService;

    @RequestMapping("/queryByStatusBanner")
    public BannerDto queryByStatusBanner(int page, int rows) {
        System.out.println("page::" + page + ",rows::" + rows);
        BannerDto bannerDto = bannerService.queryByPageBanner(page, rows);
        System.out.println(bannerDto);

        return bannerDto;
    }

    //删除
    @RequestMapping("delete")
    public void deleteByIdBanner(int id) {
        bannerService.deleteByIdBanner(id);

    }

    //更新
    @RequestMapping("updateStatusBanner")
    public void updateStatusBanner(Banner banner) {
        bannerService.updateBanner(banner);
        System.out.println("更新成功");
    }

    //插入
    @RequestMapping("insertBanner")
    public void insertBanner(Banner banner, MultipartFile file1, HttpSession session) throws IOException {
        System.out.println("banner::" + banner);

        //1.获取文件的名称
        String filename = file1.getOriginalFilename();
        //2.将文件名放在对象中
        banner.setImg_path("/img/" + filename);
        //3.获取上传文件的真实路径
        ServletContext ctx = session.getServletContext();
        String realPath = ctx.getRealPath("/img");
        //4.使用长传文件全名创建一个文件对象
        File file = new File(realPath + "/" + filename);
        //5.上传文件
        file1.transferTo(file);

        //6.执行数据库的添加功能
        bannerService.insertBanner(banner);


    }

}
