package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user")
public class User implements Serializable {
    @Id
    @KeySql(useGeneratedKeys = true)
    @Excel(name = "编号")
    private Integer id;
    @Excel(name = "姓名")
    private String name;
    @Excel(name = "手机号")
    private String phone;
    private String password;
    private String salt;
    private String sign;
    @Excel(name = "头像")
    private String head_img;
    private String dharma;
    private String sex;
    private String province;
    private String city;
    private String status;
    @Excel(name = "注册日期", format = "yyyy-MM-dd")
    private Date reg_date;
}
