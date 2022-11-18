package com.spring.groovy.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.management.model.EmployeeVO;

@Controller
public class LoginController {



	// 로그인 - 처음화면
	@RequestMapping(value="/login.on", method= {RequestMethod.GET})
	public ModelAndView login(ModelAndView mav) {
		
		mav.setViewName("login/login");
		//   /WEB-INF/views/tiles/view/login/login.jsp 파일을 생성한다.
		
		return mav;
		
		// return "login/login";
	}
	
	// 로그인 - 처음화면
	@RequestMapping(value="/login2.on")
	public String login2(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("email", email);
		
	
		
		return "login/login2";
	}


	
	
}
