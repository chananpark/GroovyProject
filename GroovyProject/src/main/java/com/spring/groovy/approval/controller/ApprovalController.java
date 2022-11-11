package com.spring.groovy.approval.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ApprovalController {

	@RequestMapping(value = "/approval.on")
	public String test(HttpServletRequest request) {

		return "approval/home/home.tiles";
	}
	
	@RequestMapping(value = "/approval/personal.on")
	public String test2(HttpServletRequest request) {
		
		return "approval/personal/personalBody.tiles";
	}
	
	@RequestMapping(value = "/approval/personal/reception.on")
	public String test3(HttpServletRequest request) {
		
		return "approval/personal/reception/receptionBody.tiles";
	}

	// 컨트롤러에 테스트 해보겟습니다. 나중에 지워주세용
	
	// 두번째 테스트입니다.. 이번에는 에러 없어야만....
}
