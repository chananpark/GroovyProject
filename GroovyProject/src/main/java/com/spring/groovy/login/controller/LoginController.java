package com.spring.groovy.login.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {



	// 로그인 - 처음화면
	@RequestMapping(value="/login.on")
	public String login(HttpServletRequest request) {
		
		
		return "login/login";
	}
	
	// 로그인 - 처음화면
	@RequestMapping(value="/login2.on")
	public String login2(HttpServletRequest request) {
		
		
		return "login/login2";
	}


	
	
}
