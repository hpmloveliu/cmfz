package com.baizhi.conf;

import com.baizhi.inte.MyInteceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class CodeInteceptor extends WebMvcConfigurerAdapter {//在程序中配置拦截器并声明拦截规则

    /*@Autowired
    private MyInteceptor myInteceptor;*/
    //注册自定义拦截器，添加拦截路径和排除拦截路径
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new MyInteceptor()).addPathPatterns("/adminLogin/login");
    }

}
