package com.spring.groovy.interceptor.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
// import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.groovy.management.model.MemberVO;


public class AdminCheckInterceptor implements HandlerInterceptor{
	// preHandle() 메소드는 지정된 컨트롤러의 동작 이전에 가로채는 역할을 해주는 것이다.
	// Object handler는 Dispatcher의 HandlerMapping 이 찾아준 Controller Class 객체
	
   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { 
	   		  //  pre는 ~을 다루기전에 라는 의미로 썻음(다른동작을 하기 전에 먼저 로그인 여부를 검사한다.)
	   
	   // 로그인 여부 검사
	   HttpSession session = request.getSession();
	   MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	   
       if(  loginuser == null || ( loginuser != null && !"인사총무팀".equalsIgnoreCase(loginuser.getDepartment()) ) ) {
         //로그인이 되지 않았거나 로그인한 사용자의 등급이 10미만인 경우
    	   
         String message = "인사총무팀만 접근가능 합니다.";
         String loc = request.getContextPath()+"/index.on";
         
         request.setAttribute("message", message);
         request.setAttribute("loc", loc);
         
         RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp"); // dispatcher는 msg인 alert이다.
         try {
            dispatcher.forward(request, response);
         } catch (ServletException | IOException e) {
            e.printStackTrace();
         }
         
         return false;
      }
       else {
    	   // 로그인 한 경우
    	   
    	   
    	   
    	   
    	   return true;
       }
	      
	}
}
