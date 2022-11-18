package com.spring.groovy.management.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class managementController {
	

	// 공용 사원관리
	@RequestMapping(value="/manage/info/viewInfo.on")
	public String viewInfo(HttpServletRequest request) {
		
		return "manage/each/info/viewInfo.tiles";
	}


	//공용 경조비관리 - 경조비신청
	@RequestMapping(value="/manage/celebrate/receiptCelebrate.on")
	public String receiptCelebrate(HttpServletRequest request) {
		
		return "manage/each/celebrate/receiptCelebrate.tiles";
	}

	//공용 경조비관리 - 경조비신청조회
	@RequestMapping(value="/manage/celebrate/searchReceiptCelebrate.on")
	public String searchReceiptCelebrate(HttpServletRequest request) {
		
		return "manage/each/celebrate/searchReceiptCelebrate.tiles";
	}
	
	
	
	//공용 증명서 - 재직증명서
	@RequestMapping(value="/manage/proof/proofEmployment.on")
	public String proofEmployment(HttpServletRequest request) {
		
		return "manage/each/proof/proofEmployment.tiles";
	}
	
	//공용 증명서 -  급여관리(급여조회)
	@RequestMapping(value="/manage/pay/paySearch.on")
	public String paySearch(HttpServletRequest request) {
		
		return "manage/each/pay/paySearch.tiles";
	}
	
	//공용 증명서 -  급여관리(기본외수당조회)
	@RequestMapping(value="/manage/pay/overtimepaySearch.on")
	public String overtimepaySearch(HttpServletRequest request) {
		
		return "manage/each/pay/overtimepaySearch.tiles";
	}

	
	
	
	
	
	
	

	//관리자 사원관리 - 사원조회
	@RequestMapping(value="/manage/admin/searchInfoAdmin.on")
	public String searchInfoAdmin(HttpServletRequest request) {
		
		return "manage/admin/info/searchInfoAdmin.tiles";
	}

	//관리자 사원관리 - 사원등록
	@RequestMapping(value="/manage/admin/registerInfo.on")
	public String registerInfo(HttpServletRequest request) {
		
		return "manage/admin/info/registerInfo.tiles";
	}


	//관리자 사원관리 - 경조비신청현황
	@RequestMapping(value="/manage/admin/receiptCelebrateStatus.on")
	public String receiptCelebrateStatus(HttpServletRequest request) {
		
		return "manage/admin/celebrate/receiptCelebrateStatus.tiles";
	}

	//관리자 사원관리 - 경조비지급목록
	@RequestMapping(value="/manage/admin/receiptcelebrateList.on")
	public String receiptcelebrateList(HttpServletRequest request) {
		
		return "manage/admin/celebrate/receiptcelebrateList.tiles";
	}


	// 관리자 - 재직증명서
	@RequestMapping(value="/manage/proof/proofEmploymentSearch.on")
	public String proofEmploymentSearch(HttpServletRequest request) {
		
		return "manage/admin/proof/proofEmploymentSearch.tiles";
	}

	// 관리자 - 급여관리(급여조회)
	@RequestMapping(value="/manage/pay/paySearchAdmin.on")
	public String paySearchAdmin(HttpServletRequest request) {
		
		return "manage/admin/pay/paySearchAdmin.tiles";
	}
	
	// 관리자 - 급여관리(기본외수당)
	@RequestMapping(value="/manage/pay/overtimepaySearchAdmin.on")
	public String overtimepaySearchAdmin(HttpServletRequest request) {
		
		return "manage/admin/pay/overtimepaySearchAdmin.tiles";
	}
	

	// 관리자 - 급여관리(연봉차트)
	@RequestMapping(value="/manage/pay/payChart.on")
	public String payChart(HttpServletRequest request) {
		
		return "manage/admin/pay/payChart.tiles";
	}


}
