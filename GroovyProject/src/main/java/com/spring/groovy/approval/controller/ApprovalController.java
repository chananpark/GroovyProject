package com.spring.groovy.approval.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ApprovalController {

	// 전자결재 홈 페이지요청
	@RequestMapping(value = "/approval.on")
	public String approvalHome(HttpServletRequest request) {

		return "approval/home.tiles";
	}
	
	// 개인문서함-상신함 페이지요청
	@RequestMapping(value = "/approval/personal/sent.on")
	public String sentDraftList(HttpServletRequest request) {
		
		return "approval/my_draft_sent.tiles";
	}
	
	// 개인문서함-결재함 페이지요청
	@RequestMapping(value = "/approval/personal/processed.on")
	public String processdDraftList(HttpServletRequest request) {
		
		return "approval/my_draft_processed.tiles";
	}
	
	// 팀문서함 페이지요청
	@RequestMapping(value = "/approval/team.on")
	public String teamDraftList(HttpServletRequest request) {
		
		return "approval/team_draft.tiles";
	}
	
	// 결재하기-결재대기문서 페이지요청
	@RequestMapping(value = "/approval/requested.on")
	public String requestedDraftList(HttpServletRequest request) {
		
		return "approval/requested_draft.tiles";
	}
	@RequestMapping(value = "/approval/test.on")
	public String test(HttpServletRequest request) {
		
		return "approval/test.tiles";
	}
}
