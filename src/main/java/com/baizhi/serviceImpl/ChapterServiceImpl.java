package com.baizhi.serviceImpl;

import com.baizhi.entity.Chapter;
import com.baizhi.mapper.ChapterMapper;
import com.baizhi.service.ChapterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.UUID;

@Service
@Transactional
public class ChapterServiceImpl implements ChapterService {
    @Autowired
    private ChapterMapper chapterMapper;

    @Override
    public void insertChapter(Chapter chapter) {
        //获取UUID为对象设置id值
        String id = UUID.randomUUID().toString().replace("-", "");
        //设置ID
        chapter.setId(id);
        //设置上传时间
        chapter.setUpload_date(new Date());
        chapterMapper.insert(chapter);

        System.out.println("上传成功");
    }
}
