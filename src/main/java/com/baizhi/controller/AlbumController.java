package com.baizhi.controller;

import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.baizhi.dto.AlbumDto;
import com.baizhi.entity.Album;
import com.baizhi.entity.Chapter;
import com.baizhi.service.AlbumService;
import com.baizhi.service.ChapterService;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.jaudiotagger.audio.AudioFileIO;
import org.jaudiotagger.audio.exceptions.CannotReadException;
import org.jaudiotagger.audio.exceptions.InvalidAudioFrameException;
import org.jaudiotagger.audio.exceptions.ReadOnlyFileException;
import org.jaudiotagger.audio.mp3.MP3AudioHeader;
import org.jaudiotagger.audio.mp3.MP3File;
import org.jaudiotagger.tag.TagException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.List;

import static cn.afterturn.easypoi.excel.ExcelExportUtil.exportExcel;

@RestController
@RequestMapping("album")
public class AlbumController {
    @Autowired
    private AlbumService albumService;
    @Autowired
    private ChapterService chapterService;

    //根据专辑的id值查询专辑
    @RequestMapping("queryAlbumById")
    public Album queryAlbumById(int parentId) {
        Album album = albumService.queryAlbumById(parentId);
        return album;
    }

    //分页查询所有专辑
    @RequestMapping("queryAlbumByPage")
    public AlbumDto queryAlbumByPage(int page, int rows) {
        System.out.println("页码：" + page + "：条数：：" + rows);
        AlbumDto dto = albumService.queryAlbumByPage(page, rows);
        /*for (Album album : albums) {
            System.out.println(album);
        }*/
        return dto;
    }


    //查询所有专辑
    @RequestMapping("queryAlbum")
    public List<Album> queryAlbum() {
        List<Album> albums = albumService.queryAlbum();
        /*for (Album album : albums) {
            System.out.println(album);
        }*/
        return albums;
    }

    //添加专辑
    @RequestMapping("insertAlbum")
    public void insertAlbum(Album album, MultipartFile imgFile, HttpSession session) throws IOException {
       /*
       上传文件时，需要为文件进行重命名，格式为：用户名+UUID+文件名+后缀，此处为了简便，使用原来的名字
        */
        //1.获取上传文件的名称
        String filename = imgFile.getOriginalFilename();

        //2.将文件名放置在专辑类对象中
        album.setCoverImg("/images/" + filename);
        //3.获取上传文件的真实路径
        String realPath = session.getServletContext().getRealPath("/images");
        //4.根据文件路径创建一个文件对象
        File file = new File(realPath + "/" + filename);
        //5.使用MultipartFile类的transferTo方法上传文件
        imgFile.transferTo(file);

        //6.执行数据库的添加功能,添加专辑
        albumService.insertAlbum(album);
    }

    //添加章节
    @RequestMapping("insertChapter")
    public void insertChapter(Chapter chapter, MultipartFile mp3File, HttpSession session) throws IOException, TagException, ReadOnlyFileException, CannotReadException, InvalidAudioFrameException {
        //1.获取=上传文件的真实路径
        String filename = mp3File.getOriginalFilename();
        //2.将文件名设置给对象
        chapter.setUrl("/mp3File/" + filename);
        //3.获取上传文件的真实路径
        String realPath = session.getServletContext().getRealPath("/mp3File");
        //4.根据文件路径创建一个文件对象
        File file = new File(realPath + "/" + filename);
        //5.使用MultipartFile类的transferTo方法上传文件
        mp3File.transferTo(file);

        //获取MP3文件时长(秒)
        MP3File f = (MP3File) AudioFileIO.read(file);
        MP3AudioHeader audioHeader = (MP3AudioHeader) f.getAudioHeader();
        int b = audioHeader.getTrackLength();
        chapter.setDuration(b);//设置chapter对象

        //获取MultipartFile类型的MP3文件大小
        long size = mp3File.getSize();//获取大小
        Double dou = Double.valueOf(Long.toString(size));
        DecimalFormat format = new DecimalFormat("#0.00");
        String s = format.format(dou / 1024 / 1024);
        //System.out.println("文件大小：："+s);
        Double aDouble = Double.valueOf(s);
        chapter.setSize(aDouble);

        //6.执行数据库的添加功能,添加专辑
        chapterService.insertChapter(chapter);
        System.out.println(chapter);
    }

    //下载章节音频
    @RequestMapping("downloadChapter")
    public void downloadChapter(String mp3Url, HttpSession session, HttpServletResponse response) throws IOException {
        //获取要下载的文件真实路径
        String realPath = session.getServletContext().getRealPath(mp3Url);

        //读取文件
        byte[] bytes = FileUtils.readFileToByteArray(new File(realPath));
        // byte[] bytes = FileCopyUtils.copyToByteArray(new File(realPath));

        String[] str = mp3Url.split("/"); //分隔文件名

        //设置响应头，以附件的形式下载
        response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(str[2], "UTF-8"));
        // 设置下载的类型
        response.setContentType("audio/mpeg");


        // 获取输出流输出附件内容
        ServletOutputStream outputStream = response.getOutputStream();
        outputStream.write(bytes);
        //清空缓存，关闭文件流
        if (outputStream != null) outputStream.flush();
        if (outputStream != null) outputStream.close();
        // System.out.println("真实路径：：" + realPath);
    }


    //专辑导出,使用POI导出为数据表格
    @RequestMapping("albumExport")
    public void albumExport(HttpServletResponse response, HttpSession session) {
        List<Album> albums = albumService.queryAlbum();
        //获取当前类的跟路径
        String realPath = session.getServletContext().getRealPath("/");
        System.out.println("realPath:" + realPath);
        //遍历album集合，重新为coverImg字段赋值（封面图片全路径realPath + coverImg）
        for (Album album : albums) {
            String coverImg = album.getCoverImg();
            String newCoverImg = realPath + coverImg;
            album.setCoverImg(newCoverImg);
        }

        Workbook workbook = exportExcel(new ExportParams("专辑信息", "章节", "album"),
                Album.class, albums);
        try {
            //设置响应类型
            response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode("album.xls", "UTF-8"));
            response.setContentType("application/vnd.ms-excel"); //设置导出类型为xls格式
            workbook.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    //专辑导入,没有完成
    @RequestMapping("albumImport")
    public void albumImport(MultipartFile importFile, HttpSession session) {
        //获取文件的真实名称
        String filename = importFile.getOriginalFilename();
        //获取文件的真实路径
        String realPath = session.getServletContext().getRealPath(filename);
        System.out.println("路径：：" + realPath);//不对   路径：：F:\ideaSource\springboot-empty\cmfz\src\main\webapp\album.xls
        try {
            Workbook workbook = new HSSFWorkbook(importFile.getInputStream());
            //获取Sheet
            Sheet sheet = workbook.getSheet("album");
            //获取表中的总行数
            int rowNum = sheet.getLastRowNum();
            //前四行为标题行，不读取
            for (int i = 4; i <= rowNum; i++) {
                Row row = sheet.getRow(i);
                System.out.println("row::" + row);

            }


        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
