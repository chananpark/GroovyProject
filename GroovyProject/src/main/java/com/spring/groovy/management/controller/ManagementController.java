package com.spring.groovy.management.controller;


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

import com.spring.groovy.common.FileManager;
import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.CelebrateVO;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.management.model.PayVO;
import com.spring.groovy.management.model.ProofVO;
import com.spring.groovy.management.service.InterManagementService;

@Controller
public class ManagementController {
	

	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterManagementService service;
	
//	파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection)
	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	
	// 사원정보 보기
	@RequestMapping(value="/manage/info/viewInfo.on")
	public ModelAndView viewInfo(ModelAndView mav, HttpServletRequest request, MemberVO mvo) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		mav.addObject("loginuser", loginuser);
		mav.setViewName("manage/each/info/viewInfo.tiles");
		return mav; 
	}

	
	
	// 사원정보 수정
	@RequestMapping(value="/manage/info/viewInfoEnd.on")
	public String viewInfoEnd(HttpServletRequest request, MemberVO mvo) {
		
		int n = service.viewInfoEnd(mvo);
		
		JSONObject json = new JSONObject();
		json.put("n", n);
	
		return json.toString();
	}
	
	
	// 사원정보 수정 - 이메일 (이메일중복확인 Ajax)
	@ResponseBody
	@RequestMapping(value="/manage/admin/checkPvEmail.on", produces="text/plain;charset=UTF-8")
	public String checkPvEmail(HttpServletRequest request, MemberVO mvo) {
		
		String pvemail = request.getParameter("pvemail");
		
		int n = service.checkPvEmail(pvemail);
		
		JSONObject json = new JSONObject();
		json.put("n", n);
	
		return json.toString();
	}
	
	//공용 경조비관리 - 경조비신청
	@RequestMapping(value="/manage/celebrate/receiptCelebrate.on")
	public ModelAndView receiptCelebrate(HttpServletRequest request, ModelAndView mav, CelebrateVO cvo) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String method= request.getMethod();
		
		if("POST".equals(method)){
			
			int n = service.receiptCelebrate(cvo);
			
			if(n != 1) {
				String message = "신청이 취소되었습니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				return mav;
			}
			
			String message = "경조비 신청이 정상적으로 신청되었습니다.";
			mav.addObject("message", message);
			mav.addObject("cvo", cvo);
			mav.setViewName("redirect:/manage/celebrate/celebrateList.on");
			return mav;
		}
		
		mav.addObject("loginuser", loginuser);
		mav.setViewName("manage/each/celebrate/receiptCelebrate.tiles");
		return mav;
	}
	
	
	

	//공용 경조비관리 - 경조비신청목록
	@RequestMapping(value="/manage/celebrate/celebrateList.on")
	public ModelAndView celebrateList(ModelAndView mav, HttpServletRequest request, CelebrateVO cvo, Pagination pagination) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String empno = loginuser.getEmpno();
		
		// 재직증명서 신청내역을 가져오기
		List<CelebrateVO> celebList = service.getCelebrateList(empno);
		
		 // 경조비 목록 - 전체 글 개수 구하기(페이징) 
		int listCnt = service.getcountCelebList(pagination);
		
		// 페이지수 알아오기
		Map<String, Object> paraMap = pagination.getPageRange(listCnt);// startRno, endRno
	
		// 경조비 목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
		mav.addObject("pageCnt", service.getCelebPageCelebCnt(paraMap));
		
		 // 페이지바
		mav.addObject("pagebar",pagination.getPagebar(request.getContextPath()+"/manage/celebrate/celebrateList.on"));
		mav.addObject("paraMap", paraMap);
		
		
		mav.addObject("celebList", celebList);
		mav.addObject("empno", empno);
		
		
		
		mav.setViewName("manage/each/celebrate/celebrateList.tiles");
		return mav;
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
		
		// 재직증명서 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
		int listCnt = service.getcountPfList(pagination);
		  
		 // 페이지수 알아오기 (페이징)
		Map<String, Object> paraMap = pagination.getPageRange(listCnt);// startRno, endRno ==> 첫페이지에 ~번부터 ~까지하 보여줄지 
		 
		// 재직증명서 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
		mav.addObject("proofList", service.getOnePagePfCnt(paraMap)); // startRno, endRno을 가지고 select문에 1번
		
		 // 페이지바
		mav.addObject("pagebar",pagination.getPagebar(request.getContextPath()+"/manage/proof/proofList.on"));
		mav.addObject("paraMap", paraMap);
		 
		mav.addObject("proofList", proofList);
		mav.addObject("empno", empno);
		
		mav.setViewName("manage/each/proof/proofList.tiles");
		return mav;
	}
	
	
	
	
	// ====== 나중에 꼭 하기!! ===== //
	//공용 증명서 - 급여관리(급여조회)
	@RequestMapping(value="/manage/pay/paySearch.on")
	public ModelAndView paySearch(ModelAndView mav, HttpServletRequest request, PayVO pvo) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		Map<String,Object> paramap = new HashMap<>();
		paramap.put("pvo", pvo);
		
		// 공용 증명서 - 월급리스트
		List<PayVO> payList = service.paySearch(paramap);
		
		mav.addObject("loginuser", loginuser);
		mav.addObject("payList", payList);
		mav.setViewName( "manage/each/pay/paySearch.tiles");
		return mav;
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

		// 관리자 사원관리 - 사원조회 한 페이지에 표시할 사원조회 전체 글 개수 구하기(페이징)
		int listCnt = service.getcountList(pagination);
		
		// 페이지수 알아오기
		Map<String, Object> paraMap = pagination.getPageRange(listCnt); // startRno, endRno
		
		// 한 페이지에 표시할 글 목록(필터 == 10개)
		mav.addObject("empList", service.getOnePageCnt(paraMap));
		
		// 페이지바
		mav.addObject("pagebar", pagination.getPagebar(request.getContextPath()+"/manage/admin/searchInfoAdmin.on"));
		mav.addObject("paraMap", paraMap);
		
		mav.setViewName("manage/admin/info/searchInfoAdmin.tiles");
			
		return mav;
		
	}
	
	
	// ============= 사원관리 다음기회에 =====================//
	
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
	@RequestMapping(value="/manage/admin/registerInfo.on")
	public ModelAndView registerInfo(ModelAndView mav, HttpServletRequest request, MemberVO  mvo) {
		
		// 사원등록 - 내선번호를 갖고오기위해 필요함
		
		 List<MemberVO> manageList = service.manageList();
		 mav.addObject("manageList", manageList);
		 
		mav.setViewName("manage/admin/info/registerInfo.tiles");
		return mav; 
	}
	
	
	//관리자 사원관리 - 사원등록
	@ResponseBody
	@RequestMapping(value="/manage/admin/registerEnd.on", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
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
		
		JSONObject json = new JSONObject();
		json.put("n", n);
		
		return json.toString(); // "{"n":1,"name":"서영학"}" 또는 "{"n":0,"name":"서영학"}"
	}
	
	
	
	
	


	//관리자 사원관리 - 경조비신청현황
	@RequestMapping(value="/manage/admin/receiptCelebrateStatus.on")
	public ModelAndView receiptCelebrateStatus(HttpServletRequest request, CelebrateVO cvo, ModelAndView mav) {
		
		List<CelebrateVO> celbStatusList = service.receiptCelebrateStatus();
		
		mav.addObject("celbStatusList", celbStatusList);
		mav.setViewName("manage/admin/celebrate/receiptCelebrateStatus.tiles");
		return mav;
	}

	//관리자 사원관리 - 경조비지급목록
	@RequestMapping(value="/manage/admin/receiptcelebrateList.on")
	public ModelAndView receiptcelebrateList(ModelAndView mav, HttpServletRequest request, CelebrateVO cvo, Pagination pagination) {

		List<CelebrateVO> celebList = service.receiptcelebrateList();
		
		// 경조비지급목록 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
		int listCnt = service.getcountClList(pagination);
		  
		 // 페이지수 알아오기 (페이징)
		Map<String, Object> paraMap = pagination.getPageRange(listCnt);// startRno, endRno ==> 첫페이지에 ~번부터 ~까지하 보여줄지 
		 
		// 경조비지급목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
		mav.addObject("celebList", service.getOnePageClCnt(paraMap)); // startRno, endRno을 가지고 select문에 1번
		
		 // 페이지바
		mav.addObject("pagebar",pagination.getPagebar(request.getContextPath()+"/manage/proof/proofList.on"));
		mav.addObject("paraMap", paraMap);

		mav.addObject("celebList", celebList);
		mav.setViewName("manage/admin/celebrate/receiptcelebrateList.tiles");
		return mav;
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

	
	// ================================================================================= //

	
	@ExceptionHandler(org.springframework.validation.BindException.class)
	public String error(Exception e) {
	    return "error";
	}

}
