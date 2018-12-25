package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;
import cn.afterturn.easypoi.excel.annotation.ExcelTarget;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "album")
@ExcelTarget(value = "album")
public class Album implements Serializable {
    @Id
    @KeySql(useGeneratedKeys = true)
    @Excel(name = "编号", needMerge = true) //POI注解
    private Integer id;
    @Excel(name = "题目", needMerge = true)
    private String title;
    private Integer count;//专辑包含章节数
    @Excel(name = "专辑封面", type = 2, width = 20, height = 25)
    private String coverImg;//封面图片
    private Integer score;
    private String author;
    private String broadcast;//播音员
    private String brief;//简介
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    @Excel(name = "专辑发布日期", needMerge = true, format = "yyyy-MM-dd")
    private Date pub_date;//专辑发布日期
    @ExcelCollection(name = "章节")
    private List<Chapter> children;//每个专辑所包含的章节
}
