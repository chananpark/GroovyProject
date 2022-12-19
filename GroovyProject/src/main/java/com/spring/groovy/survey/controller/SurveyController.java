package com.spring.groovy.survey.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.spring.groovy.approval.model.ExpenseListVO;
import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.survey.model.AskVO;
import com.spring.groovy.survey.model.JoinSurveyVO;
import com.spring.groovy.survey.model.SurveyVO;
import com.spring.groovy.survey.model.TargetVO;
import com.spring.groovy.survey.service.InterSurveyService;

@Controller
public class SurveyController {

	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterSurveyService service;
	
	
	// 설문리스트 목록
	@RequestMapping(value="/survey/surveyList.on")
	public ModelAndView surveyList(ModelAndView mav, HttpServletRequest request,SurveyVO svo,Pagination pagination) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String empno = loginuser.getEmpno();
		
		 // 설문리스트 목록 - 전체 글 개수 구하기(페이징) 
		int listCnt = service.getcountSurveyList(pagination);
		
		// 페이지수 알아오기
		Map<String, Object> paraMap = pagination.getPageRange(listCnt);// startRno, endRno
		paraMap.put("svo",svo);
		paraMap.put("empno",empno);
		
		mav.addObject("listCnt", listCnt);
		
		// 설문리스트 목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
		mav.addObject("pageCnt", service.getSurveyCnt(paraMap));
		
		 // 페이지바
		mav.addObject("pagebar",pagination.getPagebar(request.getContextPath()+"/survey/surveyList.on"));
		
		mav.setViewName("survey/public/surveyList.tiles");
		return mav;
	}
	
	// 설문리스트 - 설문참여
	@RequestMapping(value="/survey/surveyJoin.on")
	public ModelAndView surveyJoin(ModelAndView mav,HttpServletRequest request,AskVO avo) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		mav.addObject("loginuser",loginuser);
		
		String surno = request.getParameter("surno");
		
		System.out.println(surno);
		
		mav.addObject("surno", surno);
		
	
		Map<String,Object> paramap = new HashMap<>();
		paramap.put("avo", avo);
		paramap.put("surno", surno);
	
		List<AskVO> surveyAskList = service.surveyJoin(paramap);
		mav.addObject("surveyAskList", surveyAskList);
		mav.setViewName("survey/public/surveyJoin.tiles");
		
		System.out.println(surveyAskList);
		
		return mav;
	}
	
	
	// 답변한 설문지 insert
	@ResponseBody
	@RequestMapping(value="/survey/surveyJoinEnd.on")
	public String surveyJoinEnd( HttpServletRequest request,JoinSurveyVO jvo) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String empno = loginuser.getEmpno();
		
		String jvoListsurtitle = request.getParameter("jvoList[1].surtitle");
		String answer = request.getParameter("jvoList[1].answer");
		System.out.println(jvoListsurtitle+"1");
		System.out.println(answer+"1 ekq");
		
		ArrayList<JoinSurveyVO> getJvoList = new ArrayList<>(jvo.getJvoList());
		
		// 관리자 - 설문작성(설문조사 번호 insert하기)
		Map<String, Object>paramap = new HashMap<>();
		paramap.put("getJvoList", getJvoList);
		paramap.put("empno", empno);
		
		//  답변한 설문지 insert
		int n = service.surveyJoinEnd(paramap);
		
		JSONObject json = new JSONObject();
		json.put("n", n);
		System.out.println(n+"controller");
		
		return json.toString();
	}
	
	// 관리자 - 설문작성1
	@RequestMapping(value="/survey/surveyWriting.on")
	public ModelAndView surveyWriting(ModelAndView mav, HttpServletRequest request,MemberVO mvo) {
		mav.setViewName("survey/admin/surveyWriting.tiles");
		return mav;
	}
	
	// 관리자 - 설문작성2
	@RequestMapping(value="/survey/surveyWritingEnd.on")
	public ModelAndView surveyWritingEnd(ModelAndView mav, HttpServletRequest request,SurveyVO svo, MemberVO mvo) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String empno = loginuser.getEmpno();
		
		String surtitle = request.getParameter("surtitle");
		String surexplain = request.getParameter("surexplain");
		String surstart = request.getParameter("surstart");
		String surend = request.getParameter("surend");
		String surtarget = request.getParameter("surtarget");
		String suropenstatus = request.getParameter("suropenstatus");
		String fk_department_no = request.getParameter("fk_department_no");
	
		Map<String,Object> paramap = new HashMap<>();
		paramap.put("empno", empno);
		paramap.put("surtitle", surtitle);
		paramap.put("surexplain", surexplain);
		paramap.put("surstart", surstart);
		paramap.put("surend", surend);
		paramap.put("surtarget", surtarget);
		paramap.put("suropenstatus", suropenstatus);
		paramap.put("fk_department_no", fk_department_no);
		
		mav.addObject("paramap", paramap);
		mav.setViewName("survey/admin/surveyWritingEnd.tiles");
		
		return mav;
	}
	
	// 관리자 - 설문작성(설문번호)
	@ResponseBody
	@RequestMapping(value="/survey/surveyWritingNo.on")
	public String surveyWritingNo( HttpServletRequest request,SurveyVO svo, MemberVO mvo) {

		// 관리자 - 설문작성(설문조사 번호 insert하기)
		Map<String, Object>paramap = new HashMap<>();
		paramap.put("svo", svo);
		
		// 관리자 - 설문작성(설문번호) 이곳에서 결과값이 true인지 아닌지 설정
		String fk_surno = service.addSurvey(paramap);
		
		JSONObject json = new JSONObject();
		json.put("fk_surno", fk_surno);
		
		return json.toString();
	}
		

	// 관리자 - 설문작성(질문번호)
	@ResponseBody
	@RequestMapping(value="/survey/surveyWritingFinish.on")
	public String surveyWritingFinish( HttpServletRequest request, AskVO avo) {
		
		String ajax_fk_surno = request.getParameter("ajax_fk_surno");
	
		System.out.println(ajax_fk_surno);
		
		// 관리자 - 설문작성(한 문항씩 insert하기)
		Map<String,Object> paramap = new HashMap<>();
		paramap.put("avo", avo);
		paramap.put("ajax_fk_surno", ajax_fk_surno);
				
		// 관리자 - 설문작성(한 문항씩 insert하기)
		int p = service.getAskList(paramap);
		
		JSONObject json = new JSONObject();
		json.put("p", p);
	
		return json.toString();
	}
	
	
	
	// 관리자 - 설문관리
	@RequestMapping(value="/survey/surveyManage.on")
	public ModelAndView surveyManage(ModelAndView mav, HttpServletRequest request,SurveyVO svo,TargetVO tvo,MemberVO mvo,JoinSurveyVO jvo ,Pagination pagination) {
	
		 // 설문리스트 목록 - 전체 글 개수 구하기(페이징) 
		int listCnt = service.getcountSurveyList(pagination);
		
		//  설문리스트 목록  -설문 참여자 수 구하기(페이징) 
		mav.addObject("joinempcnt",service.getJoinEmpCnt(jvo));
		//  설문리스트 목록  -설문 참여자 수 구하기(페이징) 
		mav.addObject("empCnt",service.getEmpCnt(mvo));
		
		// 페이지수 알아오기
		Map<String, Object> paraMap = pagination.getPageRange(listCnt);// startRno, endRno
		paraMap.put("svo",svo);
		
		mav.addObject("listCnt", listCnt);
		
		paraMap.put("tvo",tvo);
		
		// 관리자 설문리스트 목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
		mav.addObject("surveyManageList", service.surveyManage(paraMap));
		
		 // 페이지바
		mav.addObject("pagebar",pagination.getPagebar(request.getContextPath()+"/survey/surveyManage.on"));
		
		mav.setViewName("survey/admin/surveyManage.tiles");
		return mav;
	}
	
	// 관리자 - 설문관리(결과)
	@RequestMapping(value="/survey/surveyManageView.on")
	public ModelAndView surveyManageView(ModelAndView mav,HttpServletRequest request,SurveyVO svo,MemberVO mvo,JoinSurveyVO jvo,AskVO avo) {
		
		String surno = request.getParameter("surno");
		System.out.println(surno);
		mav.addObject("surno",surno);
		
		Map<String,Object> paraMap = new HashMap<>();
		paraMap.put("svo", svo);
		paraMap.put("surno",surno);
		
		// 설문내용 조회하는 select
		List<SurveyVO> resultViewList = service.resultView(paraMap);
		mav.addObject("resultViewList", resultViewList);
		
		// 설문 참여자 수 구하기
		mav.addObject("joinempcnt",service.getJoinEmpCnt(jvo));
		// 설문 참여자 수 구하기 
		mav.addObject("empCnt",service.getEmpCnt(mvo));
		
		// 설문지의 질문내용을 조회하는 select
		List<AskVO> surveyAskList = service.surveyJoin(paraMap);
		mav.addObject("surveyAskList", surveyAskList);
		
		
		mav.setViewName("survey/admin/surveyManageView.tiles");
		
		return mav;
	}
	
	
	// 관리자 - 설문삭제하기 
	@ResponseBody
	@RequestMapping(value="/survey/surveyDelete.on")
	public String surveyDelete(HttpServletRequest request,SurveyVO svo) {
		
		String surno = request.getParameter("surno");
		System.out.println(surno);
		//mav.addObject("surno",surno);
		
		Map<String,Object> paraMap = new HashMap<>();
		paraMap.put("svo", svo);
		paraMap.put("surno",surno);
		
		// 설문지를 삭제 delete
		int n = service.surveyDelete(paraMap);
		
		JSONObject json = new JSONObject();
		json.put("n", n);
	
		return json.toString();
	}
	
	
	
	
	
	
	
	// ================================================================================= //

	
	@ExceptionHandler(org.springframework.validation.BindException.class)
	public String error(Exception e) {
		e.printStackTrace();
		return "error";
	}


	
}
