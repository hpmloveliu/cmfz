package com.baizhi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@SpringBootApplication
@MapperScan("com.baizhi.mapper") //扫描dao层
public class CmfzAppLication {
    public static void main(String[] args) {

        SpringApplication.run(CmfzAppLication.class, args);

    }
}
