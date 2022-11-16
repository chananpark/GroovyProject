package com.spring.groovy.index.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {

	// === 인덱스 페이지 === //
	@RequestMapping(value="/") // 여기로 오면 index.action으로 가라
	public ModelAndView home(ModelAndView mav) {
		
		mav.setViewName("redirect:/index.on");
		return mav;
	} // end of public ModelAndView home()
	
	
	// === 인덱스 페이지 === //
	@RequestMapping(value="/index.on")
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("index/index.tiles2");
		return mav;
	} // end of public ModelAndView index()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
