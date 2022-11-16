package com.spring.groovy.schedule.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.schedule.service.InterScheduleService;

@Controller
public class ScheduleController {
	
	@Autowired
	private InterScheduleService service;

	// === 일정관리 시작 페이지 ===
	@RequestMapping(value="schedule/schedule.on")
	public ModelAndView showSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/main_schedule.tiles");
		return mav;
	}
	
	
	// === 일정 등록 페이지 ===
	@RequestMapping(value="schedule/insertSchedule.on")
	public ModelAndView insertSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/insert_schedule.tiles2");
		return mav;
	}
	
	
	// === 일정 검색 페이지 ===
	@RequestMapping(value="schedule/searchSchedule.on")
	public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/search_schedule.tiles");
		return mav;
	}
	
	
	// === 일정 상세 보기 ===
	@RequestMapping(value="schedule/viewSchedule.on")
	public ModelAndView viewSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/view_schedule.tiles");
		return mav;
	}
	
	
	// === 일정 수정 하기 ===
	@RequestMapping(value="schedule/editSchedule.on")
	public ModelAndView editSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/edit_schedule.tiles2");
		return mav;
	}
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
