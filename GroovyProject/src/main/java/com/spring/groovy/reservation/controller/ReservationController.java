package com.spring.groovy.reservation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.reservation.model.ReservSmallCategoryVO;
import com.spring.groovy.reservation.model.ReservationVO;
import com.spring.groovy.reservation.service.InterReservationService;


@Controller
public class ReservationController {

	@Autowired
	private InterReservationService service;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
	
	// === 자원예약 회의실 예약 페이지 === //
	@RequestMapping(value="/reservation/meetingRoom.on")
	public ModelAndView meetingRoom(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("reservation/user/meeting_room.tiles");

		return mav;
	}
	
	
	// === 자원예약 기기 예약 페이지 === //
	@RequestMapping(value="/reservation/device.on")
	public ModelAndView device(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("reservation/user/device.tiles");

		return mav;
	}

	
	// === 자원예약 차량 예약 페이지 === //
	@RequestMapping(value="/reservation/vehicle.on")
	public ModelAndView vehicle(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("reservation/user/vehicle.tiles");

		return mav;
	}
	
	
	// === 자원예약 예약하기 페이지 === //
	@RequestMapping(value="/reservation/insertReservation.on")
	public ModelAndView insertReservation(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("reservation/user/insert_reservation.tiles");

		return mav;
	}
		
	
	// === 자원예약 예약 내역 페이지 === //
	@RequestMapping(value="/reservation/confirm.on")
	public ModelAndView confirm(HttpServletRequest request, ModelAndView mav, Pagination pagination) throws Exception { 
		
		mav.setViewName("reservation/user/confirm.tiles");

		return mav;
	}
	
	
	
	// === 자원예약 관리자 예약 내역 페이지 === //
	@RequestMapping(value="/reservation/admin/adminConfirm.on")
	public ModelAndView adminConfirm(HttpServletRequest request, ModelAndView mav, Pagination pagination) throws Exception { 
		
		List<Map<String,String>> reservList = null;
		Map<String, Object> paraMap = new HashMap<String, Object>();
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
	//	String empno = request.getParameter("empno");  
	//	String cpemail = request.getParameter("cpemail");  
		
		// 로그인 정보 가져오기
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String empno = loginuser.getEmpno();
		String cpemail = loginuser.getCpemail();

		if(pagination.getSearchWord() == null || "".equals(pagination.getSearchWord()) || pagination.getSearchWord().trim().isEmpty()) {
			pagination.setSearchWord("");
		}
		
		if(startdate==null || "".equals(startdate)) {
			startdate="";
		}
		
		if(enddate==null || "".equals(enddate) || "?searchType=".equals(enddate)) {
			enddate="";
		}
		
		if(pagination.getSearchType() == null || "".equals(pagination.getSearchType()) || 
		   (!"1".equals(pagination.getSearchType()) && !"2".equals(pagination.getSearchType()) && !"3".equals(pagination.getSearchType())) ) {
			pagination.setSearchType("");
		}
		
		if(empno.equals("") || empno == null) {
			mav.addObject("message", "잘못된 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/reservation/admin/adminConfirm.on");
			
			mav.setViewName("msg.tiles");
		}

		// 문자로 장난쳤을 경우
		try {
			Integer.parseInt(empno);
		} catch (Exception e) {
			mav.addObject("message", "잘못된 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/reservation/admin/adminConfirm.on");
			
			mav.setViewName("msg.tiles");
		}
		
		paraMap.put("pagination", pagination);
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("empno", empno);
		paraMap.put("cpemail", cpemail);

		// 예약 내역 전체 개수 구하기
		int listCnt = service.getResrvAdminSearchCnt(paraMap);
	//	System.out.println(listCnt);
		
		// startRno, endRno 구하기
		// 구해 온 최대 글 개수를 파라미터로 넘긴다.
		// 파라맵에 받아온 두개의 startrno와 endrno를 담아주어야 한다
		pagination.setPageInfo(listCnt);
		paraMap.put("pagination", pagination);
		
		// 한 페이지에 표시할 관리자 예약 내역 글 목록
		reservList = service.getResrvAdminList(paraMap);
		mav.addObject("reservList", reservList);
		
		pagination.setQueryString("&startdate="+startdate+"&enddate="+enddate);
		
		// 페이지바
		mav.addObject("pagebar", pagination.getPagebar(request.getContextPath()+"/reservation/admin/adminConfirm.on"));
		mav.addObject("paraMap", paraMap);
		
		mav.setViewName("reservation/admin/admin_confirm.tiles");

		return mav;
	} // end of public ModelAndView adminConfirm(HttpServletRequest request, ModelAndView mav, Pagination pagination) throws Exception
	
	
	// === 자원예약 관리자 자원 추가 페이지 === //
	@RequestMapping(value="/reservation/admin/addResource.on")
	public ModelAndView addResource(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("reservation/admin/add_resource.tiles");

		return mav;
	}

	
	// === 자원예약 페이지에서 자원항목 불러오기
	@ResponseBody
	@RequestMapping(value="/reservation/reservationTable.on", produces="text/plain;charset=UTF-8") 
	public String reservationTable(HttpServletRequest request) {
		
		String fk_lgcatgono = request.getParameter("fk_lgcatgono"); // 자원예약 대분류 번호
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		
		List<ReservSmallCategoryVO> smallCategList = service.selectSmallCategory(paraMap);
			
		JSONArray jsArr = new JSONArray();
		if(smallCategList != null) {
			for(ReservSmallCategoryVO rcvo : smallCategList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", rcvo.getSmcatgono());
				jsObj.put("smcatgoname", rcvo.getSmcatgoname());
				
				jsArr.put(jsObj);
			}
		}
		
		return jsArr.toString();
	} // end of public String reservationTable(HttpServletRequest request) 
	
	
	// === 자원 예약하기 === 
	@RequestMapping(value="/reservation/addReservation.on", method = {RequestMethod.POST})
	public ModelAndView addReservation(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String startdate= request.getParameter("startdate");
	//	System.out.println("확인용 startdate => " + startdate);
	//  확인용 startdate => 20211125140000
		String enddate = request.getParameter("enddate");
		String fk_lgcatgono= request.getParameter("fk_lgcatgono");
		String fk_smcatgono = request.getParameter("fk_smcatgono");
		String realuser = request.getParameter("realuser");
		String empno = request.getParameter("empno");
		String returnTime = request.getParameter("return_time");
		
		if("".equals(returnTime) || returnTime == null) {
			returnTime = "";
		}
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("fk_lgcatgono",fk_lgcatgono);
		paraMap.put("fk_smcatgono", fk_smcatgono);
		paraMap.put("realuser", realuser);
		paraMap.put("empno", empno);
		paraMap.put("returnTime", returnTime);
		
		int n = service.addReservation(paraMap);

		if(n == 0) {
			mav.addObject("message", "이미 존재하는 예약 일자에는 예약이 불가능합니다.");
			mav.addObject("loc", request.getContextPath()+"/reservation/meetingRoom.on");

		}
		else {
			mav.addObject("message", "자원 예약을 완료하였습니다. 관리자 승인 이후 이용이 가능합니다.");
			mav.addObject("loc", request.getContextPath()+"/reservation/confirm.on");
		}
		
		
		mav.setViewName("msg");
		
		return mav;
	} // end of public ModelAndView registerSchedule_end(ModelAndView mav, HttpServletRequest request) throws Throwable
	
	
	// 선택한 날짜에 따른 예약된 시간 가져오기
	@ResponseBody
	@RequestMapping(value="/reservation/reservTime.on", produces="text/plain;charset=UTF-8")
	public String reservTime(HttpServletRequest request) {
		
		String fk_lgcatgono = request.getParameter("fk_lgcatgono");
		String selectDate = request.getParameter("selectDate");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		paraMap.put("selectDate", selectDate);
				
		List<ReservationVO> reservTimeList = service.reservTime(paraMap);
		
		JSONArray jsArr = new JSONArray();
		
		if(reservTimeList != null && reservTimeList.size() > 0) {
			for(ReservationVO rvo : reservTimeList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("reservationno",rvo.getReservationno());
				jsObj.put("startdate",rvo.getStartdate());
				jsObj.put("enddate", rvo.getEnddate());
				jsObj.put("fk_smcatgono", rvo.getFk_smcatgono());
				jsObj.put("fk_lgcatgono", rvo.getFk_lgcatgono());
				jsObj.put("confirm", rvo.getConfirm());
				jsObj.put("status", rvo.getStatus());
				
				jsArr.put(jsObj);
			}// end of for-------------------------------------
		}
		
		return jsArr.toString();
	} // end of public String reservTime(HttpServletRequest request)
	
	
	// 관리자 예약 내역 확인에서 예약 상태 가져오기
	@ResponseBody
	@RequestMapping(value="/reservation/statusButton.on", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public String statusButton(HttpServletRequest request) {
		
		List<ReservationVO> statusList = service.statusButton();
		
		JSONArray jsArr = new JSONArray();
		
		if(statusList != null && statusList.size() > 0) {
			for(ReservationVO rvo : statusList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("reservationno", rvo.getReservationno());
				jsObj.put("status", rvo.getStatus());
				jsObj.put("confirm", rvo.getConfirm());
				jsObj.put("startdate", rvo.getStartdate());
				jsObj.put("enddate", rvo.getEnddate());
				
				jsArr.put(jsObj);
			}// end of for-------------------------------------
		}
		
		return jsArr.toString();
	} // end of public String reservTime(HttpServletRequest request)
	
	
	// 자원 예약 승인 메소드
	@RequestMapping(value="/reservation/reservConfirm.on", method = {RequestMethod.POST})
	public ModelAndView reservConfirm(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String reservationno= request.getParameter("reservationno");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("reservationno", reservationno);

		int n = service.reservConfirm(paraMap);

		if(n == 0) {
			mav.addObject("message", "자원 예약 승인을 실패하였습니다. ");
			mav.addObject("loc", request.getContextPath()+"/reservation/admin/adminConfirm.on");

		}
		else {
			mav.addObject("message", "자원 예약을 승인하였습니다. ");
			mav.addObject("loc", request.getContextPath()+"/reservation/admin/adminConfirm.on");
		}
		
		mav.setViewName("msg");
		
		return mav;
	} // end of public ModelAndView registerSchedule_end(ModelAndView mav, HttpServletRequest request) throws Throwable
	

	// 자원 예약 취소 메소드
	@RequestMapping(value="/reservation/reservCancle.on", method = {RequestMethod.POST})
	public ModelAndView reservCancle(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String reservationno= request.getParameter("reservationno");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("reservationno", reservationno);

		int n = service.reservCancle(paraMap);

		if(n == 0) {
			mav.addObject("message", "자원 예약 취소를 실패하였습니다. ");
			mav.addObject("loc", request.getContextPath()+"/reservation/admin/adminConfirm.on");

		}
		else {
			mav.addObject("message", "자원 예약을 취소하였습니다. ");
			mav.addObject("loc", request.getContextPath()+"/reservation/admin/adminConfirm.on");
		}
		
		mav.setViewName("msg");
		
		return mav;
	} // end of public public ModelAndView reservCancle(ModelAndView mav, HttpServletRequest request) throws Throwable
	
	
	// 자원 반납 메소드
	@RequestMapping(value="/reservation/reservReturn.on", method = {RequestMethod.POST})
	public ModelAndView reservReturn(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String reservationno= request.getParameter("reservationno");
		String enddate= request.getParameter("hidden_enddate");
		
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("reservationno", reservationno);
		paraMap.put("enddate", enddate);

		int n = service.reservReturn(paraMap);

		if(n == 0) {
			mav.addObject("message", "자원 반납을 실패하셨습니다.");
			mav.addObject("loc", request.getContextPath()+"/reservation/admin/adminConfirm.on");

		}
		else {
			mav.addObject("message", "자원 반납을 완료하였습니다.");
			mav.addObject("loc", request.getContextPath()+"/reservation/admin/adminConfirm.on");
		}
		
		mav.setViewName("msg");
		
		return mav;
	} // end of public public ModelAndView reservCancle(ModelAndView mav, HttpServletRequest request) throws Throwable
	

	// 예약 내역 상세보기
	@ResponseBody
	@RequestMapping(value="/reservation/viewReservation.on", produces="text/plain;charset=UTF-8")
	public String viewReservation(HttpServletRequest request) {
		
		String reservationno = request.getParameter("reservationno");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("reservationno", reservationno);
		
		Map<String, String> map = service.viewReservation(paraMap);
		
		JSONArray jsArr = new JSONArray();
		
		if(map != null) {
			JSONObject jsObj = new JSONObject();
			jsObj.put("reservationno", map.get("reservationno"));
			jsObj.put("startdate",  map.get("startdate"));
			jsObj.put("enddate",  map.get("enddate"));
			jsObj.put("smcatgoname",  map.get("smcatgoname"));
			jsObj.put("lgcatgoname",  map.get("lgcatgoname"));
			jsObj.put("realuser",  map.get("realuser"));
			jsObj.put("empno",  map.get("empno"));
			jsObj.put("cpemail",  map.get("cpemail"));
			jsObj.put("name", map.get("name"));
			jsObj.put("status", map.get("status"));
			jsObj.put("confirm", map.get("confirm"));
			
			jsArr.put(jsObj);
		}
		
		return jsArr.toString();
	} // end of public String reservTime(HttpServletRequest request)
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
