package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "admin")
public class Admin implements Serializable {
    @Id
    @KeySql(useGeneratedKeys = true)//自动递增
    private Integer id;
    private String name;
    private String password;
}
