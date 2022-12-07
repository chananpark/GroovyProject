package com.spring.groovy.community.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.FileManager;
import com.spring.groovy.community.service.InterCommunityService;

@Controller
@RequestMapping(value = "/community/*")
public class CommunityController {
	
	private InterCommunityService service;
	private FileManager fileManager;

	//@Autowired
	public CommunityController(InterCommunityService service, FileManager fileManager) {
		this.service = service;
		this.fileManager = fileManager;
	}

	// 커뮤니티 목록 페이지요청
	@RequestMapping(value = "/list.on")
	public ModelAndView getCommunityList(ModelAndView mav, HttpServletRequest request) {

		mav.setViewName("community/post_list.tiles2");
		return mav;
		
	}
	
	// 커뮤니티 글내용 조회 페이지요청
	@RequestMapping(value = "/detail.on")
	public ModelAndView getCommunityDetail(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("community/post_detail.tiles2");
		return mav;
		
	}
	
	// 커뮤니티 글 작성 페이지요청
	@RequestMapping(value = "/write.on")
	public ModelAndView getWriteForm(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("community/post_form.tiles2");
		return mav;
		
	}
	
	// 커뮤니티 글 작성하기
	@RequestMapping(value = "/addPost.on")
	public ModelAndView addPost(ModelAndView mav, HttpServletRequest request) {
		
		
		
		mav.setViewName("community/post_form.tiles2");
		return mav;
		
	}
	
}
