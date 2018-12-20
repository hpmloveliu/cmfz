package com.baizhi.controller;

import com.baizhi.util.CreateValidateCode;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@RestController
@RequestMapping("code")
public class CreateCodeController {
    /*
    生成验证码
     */

    @RequestMapping("createCode")
    public void createCode(HttpSession session, HttpServletResponse response) {
        //1.画一张随机图片 --- 使用工具类的write方法画图片
        CreateValidateCode cvc = new CreateValidateCode();
        //2.获取图片上的随机数  --- 存档  --- session
        String code = cvc.getCode();
        //3.将获取到的验证码存入session
        session.setAttribute("code", code);
        //4.在输出图片
        //声明一个输出流
        ServletOutputStream out = null;

        try {
            //根据响应获取输出流
            out = response.getOutputStream();
            cvc.write(out);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (out != null)
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }

        }

        System.out.println("验证码为：：" + code);
    }




 /*   public void  createCode(HttpSession session, HttpServletResponse response){
        //1.使用工具类，获取验证码
        String code = ValidateImageCodeUtils.getSecurityCode();
        //2.将获取的验证码放入session
        session.setAttribute("code",code);

        //3.将获取的验证码放入验证码图片中，并创建一个图片输出流，在页面绘制验证码图片
        BufferedImage image = ValidateImageCodeUtils.createImage(code);
        //声明一个输出流
        ServletOutputStream out = null;

        try {
            //根据响应获取输出流
            out = response.getOutputStream();
            //使用图片输出流将流输出到页面
            ImageIO.write(image,"png",out);
        }catch (Exception e){
            e.printStackTrace();
        }finally{
            if(out!=null)
                try {out.close();} catch (IOException e) {e.printStackTrace();}

        }

        System.out.println("验证码为::"+code);

    }*/

}
