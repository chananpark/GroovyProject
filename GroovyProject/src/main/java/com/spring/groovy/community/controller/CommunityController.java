package com.spring.groovy.community.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/community/*")
public class CommunityController {

	//@Autowired
	public CommunityController() {
	}

	// 커뮤니티 목록 페이지요청
	@RequestMapping(value = "/list.on")
	public ModelAndView getCommunityList(ModelAndView mav, HttpServletRequest request) {

		mav.setViewName("community/list.tiles2");
		return mav;
		
	}
}
