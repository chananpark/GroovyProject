package com.spring.groovy.survey.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.groovy.survey.service.InterSurveyService;

@Controller
public class SurveyController {

	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterSurveyService service;
	
	
	// 설문리스트 목록
	@RequestMapping(value="/survey/surveyList.on")
	public String surveyList(HttpServletRequest request) {
		
		return "survey/public/surveyList.tiles";
	}
	
	// 설문리스트 - 설문참여
	@RequestMapping(value="/survey/surveyJoin.on")
	public String surveyJoin(HttpServletRequest request) {
		
		return "survey/public/surveyJoin.tiles";
	}
	
	
	// 관리자 - 설문작성
	@RequestMapping(value="/survey/surveyWriting.on")
	public String surveyWriting(HttpServletRequest request) {
		
		return "survey/admin/surveyWriting.tiles";
	}
	
	// 관리자 - 설문관리
	@RequestMapping(value="/survey/surveyManage.on")
	public String payChart(HttpServletRequest request) {
		
		return "survey/admin/surveyManage.tiles";
	}
	
}
