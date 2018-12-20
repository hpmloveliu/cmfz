package com.baizhi.service;

import com.baizhi.dto.BannerDto;
import com.baizhi.entity.Banner;


public interface BannerService {
    public BannerDto queryByStatusBanner();

    public void updateBanner(Banner banner);

    public void deleteByIdBanner(int id);

    public void insertBanner(Banner banner);
}
