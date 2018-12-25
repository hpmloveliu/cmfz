package com.baizhi.mapper;


import com.baizhi.entity.Album;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface AlbumMapper extends Mapper<Album> {
    //表连接查询
    public List<Album> queryAlbum();

    //分页查询
    public List<Album> queryAlbumByPage(@Param("page") int page, @Param("rows") int rows);
}
