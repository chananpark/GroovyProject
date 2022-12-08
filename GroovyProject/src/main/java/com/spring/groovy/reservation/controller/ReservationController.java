package com.spring.groovy.reservation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView confirm(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("reservation/user/confirm.tiles");

		return mav;
	}
	
	
	
	// === 자원예약 관리자 예약 내역 페이지 === //
	@RequestMapping(value="/reservation/admin/adminConfirm.on")
	public ModelAndView adminConfirm(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("reservation/admin/admin_confirm.tiles");

		return mav;
	}
	
	
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
	
	
	
	
	
	
}
