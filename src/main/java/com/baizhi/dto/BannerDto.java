package com.baizhi.dto;

import com.baizhi.entity.Banner;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

@Getter
@Setter
//数据传输对象（DTO），进行后台与前台进行数据交互
public class BannerDto implements Serializable {
    // 必须 有两个属性，且名称 类型 固定
    private List<Banner> rows;
    private Integer total;
}
