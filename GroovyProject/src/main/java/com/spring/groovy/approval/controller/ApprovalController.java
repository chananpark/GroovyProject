package com.spring.groovy.approval.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.groovy.approval.service.ApprovalService;


@Controller
@RequestMapping(value = "/approval/*")
public class ApprovalController {
	
	private ApprovalService service;
	
	@Autowired
	public ApprovalController(ApprovalService service) {
		this.service = service;
	}

	// 전자결재 홈 페이지요청
	@RequestMapping(value = "/home.on")
	public String approvalHome(HttpServletRequest request) {

		return "approval/home.tiles";
	}
	
	// 개인문서함-상신함 페이지요청
	@RequestMapping(value = "/personal/sent.on")
	public String sentDraftList(HttpServletRequest request) {
		
		return "approval/my_draft/sent.tiles";
	}
	
	// 개인문서함-결재함 페이지요청
	@RequestMapping(value = "/personal/processed.on")
	public String processdDraftList(HttpServletRequest request) {
		
		return "approval/my_draft/processed.tiles";
	}
	
	// 개인문서함-임시저장함 페이지요청
	@RequestMapping(value = "/personal/saved.on")
	public String savedDraftList(HttpServletRequest request) {
		
		return "approval/my_draft/saved.tiles";
	}
	
	// 팀문서함 페이지요청
	@RequestMapping(value = "/team.on")
	public String teamDraftList(HttpServletRequest request) {
		
		return "approval/team_draft.tiles";
	}
	
	// 결재하기-결재대기문서 페이지요청
	@RequestMapping(value = "/requested.on")
	public String requestedDraftList(HttpServletRequest request) {
		
		return "approval/requested_draft.tiles";
	}
	
	// 업무기안 작성 페이지요청
	@RequestMapping(value = "/write/work.on")
	public String writeWorkDraft(HttpServletRequest request) {
		
		return "approval/write_form/work_form.tiles";
	}
	
	// 지출결의서 작성 페이지요청
	@RequestMapping(value = "/write/expense.on")
	public String writeExpenseReport(HttpServletRequest request) {
		
		return "approval/write_form/expense_form.tiles";
	}
	
	// 출장보고서 작성 페이지요청
	@RequestMapping(value = "/write/businessTrip.on")
	public String writeBusinessTripReport(HttpServletRequest request) {
		
		return "approval/write_form/business_trip_form.tiles";
	}
	
	// 기안조회 페이지요청
	@RequestMapping(value = "/detail.on")
	public String showDraft(HttpServletRequest request) {
		
		// if문으로 기안 종류에 따라 다른 페이지 리턴
		return "approval/draft_detail/work_detail.tiles";
	}	
	
	@RequestMapping(value = "/detail2.on")
	public String showDraft2(HttpServletRequest request) {
		
		return "approval/draft_detail/expense_detail.tiles";
	}	
	
	@RequestMapping(value = "/detail3.on")
	public String showDraft3(HttpServletRequest request) {
		
		return "approval/draft_detail/business_trip_detail.tiles";
	}	
	
	// 결재라인 선택 페이지요청
	@RequestMapping(value = "/setApprovalLine.on")
	public String setApprovalLine(HttpServletRequest request) {
		
		// 결재라인 선택 jsp
		return "approval/select_approval_member";
		
	}	
	
	// 환경설정-결재라인관리 페이지요청
	@RequestMapping(value = "/config/approvalLine.on")
	public String configApprovalLine(HttpServletRequest request) {
		
		return "approval/config/approvalLine.tiles";
	}
	
	// 환경설정-서명관리 페이지요청
	@RequestMapping(value = "/config/signature.on")
	public String configSignature(HttpServletRequest request) {
		
		return "approval/config/signature.tiles";
	}
	

}
