package com.spring.groovy.management.controller;


import static org.springframework.test.web.client.match.MockRestRequestMatchers.method;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.management.model.ProofVO;
import com.spring.groovy.management.service.InterManagementService;

@Controller
public class managementController {
	

	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterManagementService service;
	
	// 공용 사원관리
	@RequestMapping(value="/manage/info/viewInfo.on")
	public ModelAndView viewInfo(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("manage/each/info/viewInfo.tiles");
		return mav; 
	}
	
	@RequestMapping(value="/manage/info/viewInfoEnd.on")
	public ModelAndView viewInfoEnd(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("manage/each/info/viewInfo.tiles");
		return mav; 
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
	
	
	
	//재직증명서 - 재직증명서
	@RequestMapping(value="/manage/proof/proofEmployment.on")
	public ModelAndView proofEmployment(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		mav.addObject("loginuser", loginuser);
		mav.setViewName( "manage/each/proof/proofEmployment.tiles");
		return mav;
	}
	
	//재직증명서 - 재직증명서신청 (Ajax)
	@RequestMapping(value="/manage/proof/proofEmploymentEnd.on")
	public String proofEmploymentEnd(ProofVO pvo,  HttpServletRequest request) {
		
		int n = 0;
		// 재직증명서에 넣을 기본정보가져오기
		n  = service.getproofEmployment(pvo);
		
		JSONObject jsonObj = new JSONObject(pvo);
		jsonObj.put("n", n);
	
		return jsonObj.toString();
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

	
	
	
	// ================================================================================= //
	
	
	

	//관리자 사원관리 - 사원조회
	@RequestMapping(value="/manage/admin/searchInfoAdmin.on", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public ModelAndView searchInfoAdmin(ModelAndView mav, Pagination pagination, HttpServletRequest request) {

		// 전체 글 개수 구하기
		int listCnt = service.getsearchInfoAdmin(pagination);
		
		// 페이지수 알아오기
		Map<String, Object> paraMap = pagination.getPageRange(listCnt); // startRno, endRno
				
//		HttpSession session = request.getSession();
		
		List<MemberVO> empList = service.searchInfoAdmin();
		
		request.setAttribute("empList", empList);
		
		// 한 페이지에 표시할 글 목록
		mav.addObject("empList", service.getSearchInfoAdminList(paraMap));
		
		// 페이지바
		mav.addObject("pagebar", pagination.getPagebar(request.getContextPath()+"/manage/admin/searchInfoAdmin.on"));
		mav.addObject("paraMap", paraMap);
		
		mav.setViewName("manage/admin/info/searchInfoAdmin.tiles");
			
		return mav;
		
	}
	
	
	//관리자 사원관리 - 사원등록
	@RequestMapping(value="/manage/admin/registerInfo.on")
	public ModelAndView registerInfo(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("manage/admin/info/registerInfo.tiles");
		return mav; 
	}
		
	
	//관리자 사원관리 - 사원등록
	@RequestMapping(value="/manage/admin/registerInfoEnd.on")
	public ModelAndView registerInfoEnd(ModelAndView mav, HttpServletRequest request) {

		
		
		String empno = request.getParameter("empno");
		String cpemail = request.getParameter("cpemail");
		String name = request.getParameter("name");
		String position = request.getParameter("position"); 
	    String jubun = request.getParameter("jubun"); 
	    String postcode = request.getParameter("postcode");
	    String address = request.getParameter("address");
		String detailaddress = request.getParameter("detailaddress");
		String extraaddress = request.getParameter("extraaddress");
		String bumun = request.getParameter("bumun"); 
	    String department = request.getParameter("department"); 
	    String pvemail = request.getParameter("pvemail");
	    String depttel = request.getParameter("depttel");
	    String joindate = request.getParameter("joindate");
		String empstauts = request.getParameter("empstauts");
		String bank = request.getParameter("bank");
		String account = request.getParameter("account"); 
	    String annualcnt = request.getParameter("annualcnt"); 
	    String gender = request.getParameter("gender");
	    
		String hp1 = request.getParameter("hp1");
		String hp2 = request.getParameter("hp2");
		String hp3 = request.getParameter("hp3");
		String birthyyyy = request.getParameter("birthyyyy"); 
	    String birthmm = request.getParameter("birthmm"); 
	    String birthdd = request.getParameter("birthdd");
	     
		String mobile = hp1 + "-"+ hp2 +"-"+ hp3;
		String birthday = birthyyyy+"-"+birthmm+"-"+birthdd; 
		
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("empno", empno);
		paraMap.put("cpemail", cpemail);
		paraMap.put("name", name);
		paraMap.put("position", position);
		paraMap.put("jubun", jubun);
		paraMap.put("postcode", postcode);
		paraMap.put("address", address);
		paraMap.put("detailaddress", detailaddress);
		paraMap.put("extraaddress", extraaddress);
		paraMap.put("bumun", bumun);
		paraMap.put("department", department);
		paraMap.put("pvemail", pvemail);
		paraMap.put("depttel", depttel);
		paraMap.put("joindate", joindate);
		paraMap.put("empstauts", empstauts);
		paraMap.put("bank", bank);
		paraMap.put("account", account);
		paraMap.put("annualcnt", annualcnt);
		paraMap.put("gender", gender);
		paraMap.put("mobile", mobile);
		paraMap.put("birthday", birthday);
		
		// 사원등록
		int n = service.getRegisterInfo(paraMap);
		
		if(n==1) {
			String message="등록성공";
			mav.addObject("message", message);
			mav.addObject("n", n);
			mav.setViewName("manage/admin/info/registerInfo.tiles");
			return mav; 
		}
		
		String message = "등록실패";
		String loc = "javascript:history.back()";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		return mav;
	}
	
	
	
	
	
	
	/*
	//관리자 사원관리 - 사원등록
	@RequestMapping(value="/manage/admin/registerInfo.on")
	public ModelAndView registerInfo(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("manage/admin/info/registerInfo.tiles");
		return mav; 
	}
	*/
	
	
	/*
	//관리자 사원관리 - 사원등록
	@RequestMapping(value="/manage/admin/registerInfoEnd.on", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String registerInfoEnd(HttpServletRequest request, MemberVO mvo) {

		String hp1 = request.getParameter("hp1");
		String hp2 = request.getParameter("hp2");
		String hp3 = request.getParameter("hp3");
		String birthyyyy = request.getParameter("birthyyyy"); 
	    String birthmm = request.getParameter("birthmm"); 
	    String birthdd = request.getParameter("birthdd");
	     
		String mobile = hp1 + "-"+ hp2 +"-"+ hp3;
		String birthday = birthyyyy+"-"+birthmm+"-"+birthdd; 
		
		
		Map<String,Object> paraMap = new HashMap<>();
		paraMap.put("mvo", mvo);
		paraMap.put("mobile", mobile);
		paraMap.put("birthday", birthday);
		
		// 위에 잇는 정보를 paramap에 담아야하는데 membervo애 어떻게 넣지?

		// 사원등록
		int n = service.getRegisterInfo(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		
		return jsonObj.toString(); // "{"n":1,"name":"서영학"}" 또는 "{"n":0,"name":"서영학"}"
	}
	
	*/
	
	
	
	


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

	
	
	
	
	
	
	@ExceptionHandler(org.springframework.validation.BindException.class)
	public String error(Exception e) {
	    return "error";
	}

}
