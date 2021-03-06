package com.baizhi.serviceImpl;

import com.baizhi.dto.AlbumDto;
import com.baizhi.entity.Album;
import com.baizhi.mapper.AlbumMapper;
import com.baizhi.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class AlbumServiceImpl implements AlbumService {
    //注入dao
    @Autowired
    private AlbumMapper albumMapper;

    @Override
    public List<Album> queryAlbum() {

        List<Album> albums = albumMapper.queryAlbum();

        return albums;
    }

    //添加
    @Override
    public void insertAlbum(Album album) {
        //为专辑设置上传时间
        album.setPub_date(new Date());

        albumMapper.insert(album);

        System.out.println("添加成功");

    }

    //根据Id查询专辑
    @Override
    public Album queryAlbumById(int id) {

        Album album = albumMapper.selectByPrimaryKey(id);
        return album;
    }

    //分页查询
    @Override
    public AlbumDto queryAlbumByPage(int page, int rows) {
        //创建DTO对象
        AlbumDto albumDto = new AlbumDto();
        List<Album> albums = albumMapper.queryAlbumByPage(page, rows);
        //查存总条数
        int selectCount = albumMapper.selectCount(new Album());
        //为dto属性赋值
        albumDto.setRows(albums);
        albumDto.setTotal(selectCount);
        return albumDto;
    }


}
