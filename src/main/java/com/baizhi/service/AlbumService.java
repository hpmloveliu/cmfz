package com.baizhi.service;

import com.baizhi.entity.Album;

import java.util.List;

public interface AlbumService {
    public List<Album> queryAlbum();

    public void insertAlbum(Album album);

    public Album queryAlbumById(int id);
}
