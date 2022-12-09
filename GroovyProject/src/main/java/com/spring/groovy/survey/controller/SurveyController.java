package com.spring.groovy.survey.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.survey.model.AskVO;
import com.spring.groovy.survey.model.SurveyVO;
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
	
	
	// 관리자 - 설문작성1
	@RequestMapping(value="/survey/surveyWriting.on")
	public String surveyWriting(HttpServletRequest request,SurveyVO svo) {
		return "survey/admin/surveyWriting.tiles";
	}
	
	// 관리자 - 설문작성2
	@RequestMapping(value="/survey/surveyWritingEnd.on")
	public ModelAndView surveyWritingEnd(ModelAndView mav, HttpServletRequest request,SurveyVO svo, MemberVO mvo) {
		
		String surtitle = request.getParameter("surtitle");
		String surexplain = request.getParameter("surexplain");
		String surstart = request.getParameter("surstart");
		String surend = request.getParameter("surend");
		String surtarget = request.getParameter("surtarget");
		String suropenstatus = request.getParameter("suropenstatus");
		
		String fk_department_no = request.getParameter("fk_department_no");
		
		
		System.out.println(surtitle);
		System.out.println(surexplain);
		System.out.println(surstart);
		System.out.println(surend);
		System.out.println(surtarget);
		System.out.println(fk_department_no);
		System.out.println(suropenstatus);
		System.out.println("*******************************************************************");
		
		Map<String,Object> paramap = new HashMap<>();
		paramap.put("svo", svo);
		paramap.put("mvo", mvo);
		
		mav.addObject("paramap", paramap);
		
		mav.setViewName("survey/admin/surveyWritingEnd.tiles");
		
		return mav;
	}
	
	// 관리자 - 설문작성(설문번호)
		@ResponseBody
		@RequestMapping(value="/survey/surveyWritingNo.on")
		public String surveyWritingNo( HttpServletRequest request,SurveyVO svo, AskVO avo, MemberVO mvo) {
		
			
			String surtitle = request.getParameter("surtitle");
			String surexplain = request.getParameter("surexplain");
			String surstart = request.getParameter("surstart");
			String surend = request.getParameter("surend");
			String surtarget = request.getParameter("surtarget");
			String suropenstatus = request.getParameter("suropenstatus");
			String fk_department_no = request.getParameter("fk_department_no");
		
			System.out.println("=============================================================================");
			
			System.out.println(surtitle);
			System.out.println(surexplain);
			System.out.println(surstart);
			System.out.println(surend);
			System.out.println(surtarget);
			System.out.println(fk_department_no);
			System.out.println(suropenstatus);
		
			// 관리자 - 설문작성(설문조사 번호 insert하기)
			int n = service.getsurveyList(svo);
		
			JSONObject json = new JSONObject();
			json.put("n", n);
			
			return json.toString();
		}
		

	// 관리자 - 설문작성(질문)
	@ResponseBody
	@RequestMapping(value="/survey/surveyWritingFinish.on")
	public String surveyWritingFinish( HttpServletRequest request,SurveyVO svo, AskVO avo, MemberVO mvo) {
		
		String questno = request.getParameter("questno");
		String fk_surno = request.getParameter("fk_surno");
		String question = request.getParameter("question");
		String option1 = request.getParameter("option1");
		String option2 = request.getParameter("option2");
		String option3 = request.getParameter("option3");
		String option4 = request.getParameter("option4");
		String option5 = request.getParameter("option5");
		System.out.println("------------------------------------------------------------------------");
	
		System.out.println(questno);
		System.out.println(fk_surno);
		System.out.println(question);
		System.out.println(option1);
		System.out.println(option2);
		System.out.println(option3);
		System.out.println(option4);
		System.out.println(option5);
		
		// 관리자 - 설문작성(설문번호 알아오기)
		Map<String,Object> cur_surno = service.getsurveyNO(svo);
		
		// 관리자 - 설문작성(한 문항씩 insert하기)
		Map<String,Object> paramap = new HashMap<>();
		paramap.put("avo", avo);
		paramap.put("cur_surno", cur_surno);
		
		int p = service.getAskList(paramap);
		
		JSONObject json = new JSONObject();
		json.put("p", p);
		
		return json.toString();
	}
	
	
	
	
	
	
	// 관리자 - 설문관리
	@RequestMapping(value="/survey/surveyManage.on")
	public ModelAndView surveyManage(ModelAndView mav, HttpServletRequest request,SurveyVO svo) {
		
		
		mav.setViewName("survey/admin/surveyManage.tiles");
		return mav;
	}
	
	// 관리자 - 설문관리
	@RequestMapping(value="/survey/surveyManageView.on")
	public String surveyManageView(HttpServletRequest request) {
		
		return "survey/admin/surveyManageView.tiles";
	}
	
	
	// ================================================================================= //

	
	@ExceptionHandler(org.springframework.validation.BindException.class)
	public String error(Exception e) {
		e.printStackTrace();
		return "error";
	}

	
	
	
	
}
