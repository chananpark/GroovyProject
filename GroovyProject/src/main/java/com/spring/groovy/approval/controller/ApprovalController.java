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

}
