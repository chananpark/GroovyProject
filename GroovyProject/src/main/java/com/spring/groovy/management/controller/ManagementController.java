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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.management.model.ProofVO;
import com.spring.groovy.management.service.InterManagementService;

@Controller
public class ManagementController {
	

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
	
	
	
	//재직증명서 - 증명서신청
	@RequestMapping(value="/manage/proof/proofEmployment.on")
	public ModelAndView proofEmployment(ModelAndView mav, HttpServletRequest request, ProofVO pvo) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String method= request.getMethod();
		
		if("POST".equals(method)) {
			
			/*	
			String issueuse = request.getParameter("issueuse");
			
			Map<String,Object> paraMap = new HashMap<>();
			paraMap.put("issueuse", issueuse);
			paraMap.put("loginuser", loginuser);*/
			
			int n = service.proofEmployment(pvo);
			
			if(n != 1) {
				String message = "신청이 취소되었습니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("loginuser", loginuser);
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				return mav;
			}
			/*
			 * // 재직증명서 신청내역을 가져오기 List<ProofVO> proofList = service.getProofList();
			 * 
			 * mav.addObject("proofList", proofList);
			 */
			mav.addObject("loginuser", loginuser);
			mav.setViewName( "redirect:/manage/proof/proofList.on");
			return mav;
		}
		
		mav.setViewName( "manage/each/proof/proofEmployment.tiles");
		return mav;
	}
	
	
	
	//재직증명서 - 증명서목록
	@RequestMapping(value="/manage/proof/proofList.on")
	public ModelAndView proofList(ModelAndView mav, Pagination pagination, HttpServletRequest request, ProofVO pvo) {
	
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String empno = loginuser.getEmpno();
		
		// 재직증명서 신청내역을 가져오기
		List<ProofVO> proofList = service.getProofList(empno);
		
		/*
		 * // 전체 글 개수 구하기 int listCnt = service.getcountList(pagination);
		 * 
		 * // 페이지수 알아오기 Map<String, Object> paraMap = pagination.getPageRange(listCnt);
		 * // startRno, endRno
		 * 
		 * // 한 페이지에 표시할 글 목록 mav.addObject("pageCnt", service.getOnePageCnt(paraMap));
		 * 
		 * // 페이지바 mav.addObject("pagebar",
		 * pagination.getPagebar(request.getContextPath()+"/manage/proof/proofList.on"))
		 * ; mav.addObject("paraMap", paraMap);
		 */
		mav.addObject("proofList", proofList);
		mav.addObject("empno", empno);
		
		mav.setViewName("manage/each/proof/proofList.tiles");
		return mav;
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
	@RequestMapping(value="/manage/admin/searchInfoAdmin.on")
	public ModelAndView searchInfoAdmin(ModelAndView mav, Pagination pagination, HttpServletRequest request) {

		// 전체 글 개수 구하기
		int listCnt = service.getcountList(pagination);
		
		// 페이지수 알아오기
		Map<String, Object> paraMap = pagination.getPageRange(listCnt); // startRno, endRno
		
		// 한 페이지에 표시할 글 목록
		mav.addObject("empList", service.getOnePageCnt(paraMap));
		
		// 페이지바
		mav.addObject("pagebar", pagination.getPagebar(request.getContextPath()+"/manage/admin/searchInfoAdmin.on"));
		mav.addObject("paraMap", paraMap);
		
		mav.setViewName("manage/admin/info/searchInfoAdmin.tiles");
			
		return mav;
		
	}
	
	
	//관리자 사원관리 - 사원등록
	@RequestMapping(value="/manage/admin/registerInfo.on")
	public ModelAndView registerInfo(ModelAndView mav, HttpServletRequest request) {

		String method = request.getMethod();
		
		if("POST".equals(method)) {
			
		}
		
		mav.setViewName("manage/admin/info/registerInfo.tiles");
		return mav; 
	}
	
	
	//관리자 사원관리 - 사원등록(이메일중복확인 Ajax)
	@ResponseBody
	@RequestMapping(value="/manage/admin/checkCpEmail.on", produces="text/plain;charset=UTF-8")
	public String checkCpEmail(HttpServletRequest request, MemberVO mvo) {
		
		String cpemail = request.getParameter("cpemail");
		
		int n = service.checkCpEmail(cpemail);
		
		JSONObject json = new JSONObject();
		json.put("n", n);
	
		return json.toString();
	}
	
	
	//관리자 사원관리 - 사원등록
	@RequestMapping(value="/manage/admin/registerInfoEnd.on")
	public ModelAndView registerInfoEnd(ModelAndView mav, HttpServletRequest request, MemberVO mvo) {

	
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
