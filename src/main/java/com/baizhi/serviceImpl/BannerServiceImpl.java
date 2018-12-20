package com.baizhi.serviceImpl;

import com.baizhi.dto.BannerDto;
import com.baizhi.entity.Banner;
import com.baizhi.mapper.BannerMapper;
import com.baizhi.service.BannerService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class BannerServiceImpl implements BannerService {
    //注入dao
    @Autowired
    private BannerMapper bannerMapper;

    //查所有
    @Override
    public BannerDto queryByPageBanner(int courPage, int pageRows) {
        PageHelper.startPage(courPage, pageRows);//使用mysql分页插件

        BannerDto bannerDto = new BannerDto();
        List<Banner> list = bannerMapper.selectAll();
        int count = bannerMapper.selectCount(new Banner());
        bannerDto.setRows(list);
        bannerDto.setTotal(count);
        return bannerDto;
    }
    //修改
    @Override
    public void updateBanner(Banner banner) {
        bannerMapper.updateByPrimaryKey(banner);
    }
    //删除
    @Override
    public void deleteByIdBanner(int id) {
        bannerMapper.deleteByPrimaryKey(id);
        System.out.println("删除成功");
    }

    //添加
    @Override
    public void insertBanner(Banner banner) {
        //为banner添加上传时间
        banner.setPub_date(new Date());
        bannerMapper.insert(banner);
        System.out.println("添加成功");
    }
}
