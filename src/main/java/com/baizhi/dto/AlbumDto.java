package com.baizhi.dto;

import com.baizhi.entity.Album;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

@Getter
@Setter
public class AlbumDto implements Serializable {
    // 必须 有两个属性，且名称 类型 固定'
    private List<Album> rows;
    private Integer total;
}
