package com.baizhi.service;

import com.baizhi.dto.BannerDto;
import com.baizhi.entity.Banner;

import javax.servlet.http.HttpSession;


public interface BannerService {
    public BannerDto queryByPageBanner(int courPage, int page);

    public void updateBanner(Banner banner);

    public void deleteByIdBanner(int id, HttpSession session);

    public void insertBanner(Banner banner);
}
