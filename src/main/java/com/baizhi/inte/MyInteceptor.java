package com.baizhi.inte;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//拦截器不拦截jsp请求，之拦截action请求
//需要写一个配置类，
public class MyInteceptor implements HandlerInterceptor {
    //在控制器执行之前执行
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //获取请求中的验证码
        String code = (String) httpServletRequest.getParameter("code");
        //获取session中的code
        HttpSession session = httpServletRequest.getSession();
        String code2 = (String) session.getAttribute("code");
        if (code2.equals(code)) {
            return true;
        } else {
            System.out.println("验证码错误");
            //将错误信息存入session
            session.setAttribute("error", "验证码错误");
            //重定向到登录页面
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login.jsp");
            return false;
        }

    }

    //在控制器执行返回View之前执行
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle");
    }

    //在控制器执行之后执行
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        System.out.println("afterCompletion");
    }
}
