package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "chapter")
public class Chapter implements Serializable {
    @Id
    private String id;
    @Excel(name = "章节名称")
    private String title;
    private Double size;
    private Integer duration;//时长
    @Excel(name = "音频地址", width = 34)
    private String url;//音频对应的地址
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    @Excel(name = "上传日期", format = "yyyy-MM-dd")
    private Date upload_date;//上传日期
    private Integer album_id;//所属专辑

}
