package com.spring.groovy.attendance.controller;

import java.util.*;

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

import com.spring.groovy.attendance.model.AttandanceRequestVO;
import com.spring.groovy.attendance.model.AttendanceVO;
import com.spring.groovy.attendance.service.InterAttendanceService;
import com.spring.groovy.management.model.MemberVO;


@Controller
public class AttendanceController {

	
	@Autowired
	private InterAttendanceService service;
	
	
	@RequestMapping(value = "/attend/myAttend.on")
	public String myAttendStatus(HttpServletRequest request) {
		request.setAttribute("submenuId", "my1");
		return "attendance/my/my_attend_status.tiles";
		
	}
	
	@RequestMapping(value = "/attend/myManage.on")
	public String myAttendManage(HttpServletRequest request) {
		request.setAttribute("submenuId", "my2");
		return "attendance/my/my_attend_manage.tiles";
		
	}
		
	@RequestMapping(value = "/attend/teamStatus.on")
	public String teamAttendStatusWeekly(HttpServletRequest request) {
		request.setAttribute("submenuId", "team1");
		return "attendance/team/team_attend_status.tiles";
		
	}	
	
	@RequestMapping(value = "/attend/teamManagePopup.on")
	public String teamAttendManagePopup(HttpServletRequest request) {
		request.setAttribute("userid", "userid");
		return "tiles/attendance/content/team/team_manage_popup";
		
	}
	
	@RequestMapping(value = "/attend/teamManage.on")
	public String teamAttendManage(HttpServletRequest request) {
		request.setAttribute("submenuId", "team2");
		return "attendance/team/team_attend_manage.tiles";
		
	}
	
	@RequestMapping(value = "/attend/allStatus.on")
	public String allAttendStatus(HttpServletRequest request) {
		
		List<Map<String, String>> departList = service.getDepartments();
		
		request.setAttribute("departList", departList);
		request.setAttribute("submenuId", "all1");
		return "attendance/admin/admin_attend_status.tiles";
		
	}
	
	@RequestMapping(value = "/attend/allManage.on")
	public String allAttendManage(HttpServletRequest request) {
		
		List<Map<String, String>> departList = service.getDepartments();
		
		request.setAttribute("departList", departList);
		
		request.setAttribute("submenuId", "all2");
		return "attendance/admin/admin_attend_manage.tiles";
		
	}
	
	
	// 출근하기
	@ResponseBody
	@RequestMapping(value = "/attend/goStartWork.on", method={RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String goStartWork(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");		
		// System.out.println("empno: " + empno);
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		
		int n = service.goStartWork(paraMap);
		// System.out.println("workStartTime : "+ workStartTime);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	
	
	// 퇴근하기
	@ResponseBody
	@RequestMapping(value = "/attend/goEndWork.on", method={RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String goEndWork(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");		
		// System.out.println("empno: " + empno);
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		
		int n = service.goEndWork(paraMap);
		// System.out.println("workStartTime : "+ workStartTime);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	
	
	// 사이드바에 출근시간 퇴근시간 얻어오기
	@ResponseBody
	@RequestMapping(value = "/attend/getWorkTimes.on", produces="text/plain;charset=UTF-8")
	public String getWorkTimes(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");		
		// System.out.println("empno: " + empno);
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		
		Map<String, String> workTimeMap = service.getWorkTimes(paraMap);
				
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("workTimeMap", workTimeMap);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	
	
	// 사이드바에 주간 근무시간 얻어오기
	@ResponseBody
	@RequestMapping(value = "/attend/getSideWeeklyWorkTimes.on", produces="text/plain;charset=UTF-8")
	public String getSideWeeklyWorkTimes(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		
		
		Map<String, String> weeklyworkTimesMap = service.getWeeklyWorkTimes(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("weeklyworkTimesMap", weeklyworkTimesMap);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	
	// 사이드바에 부서 얻어오기 
	@ResponseBody
	@RequestMapping(value = "/attend/getDepartment.on", produces="text/plain;charset=UTF-8")
	public String getDepartment(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");		
		// System.out.println("empno: " + empno);
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		
		Map<String, String> partMap = service.getDepartment(paraMap);
				
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("partMap", partMap);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	
	
	// 근태 신청하기	
	@ResponseBody
	@RequestMapping(value="/requestAttendance.on", method= {RequestMethod.POST})
	public ModelAndView requestAttendance(HttpServletRequest request, ModelAndView mav) {
		
		String empno = request.getParameter("empno");
		String attend_index = request.getParameter("attend_index");
		String usedate = request.getParameter("usedate");
		String startTime1 = request.getParameter("startTime1");
		String startTime2 = request.getParameter("startTime2");
		String endTime1 = request.getParameter("endTime1");
		String endTime2 = request.getParameter("endTime2");
		String place = request.getParameter("place");
		String reason = request.getParameter("reason");
		
		if(place == null || "".equals(place)) {	place = " ";	}
		if(reason == null || "".equals(reason)) {	reason = " ";	}
		
		/*
		System.out.println("empno : " + empno);
		System.out.println("attend_index : " + attend_index);
		System.out.println("usedate : " + usedate);
		System.out.println("startTime1 : " + startTime1);
		System.out.println("startTime2 : " + startTime2);
		System.out.println("endTime1: " + endTime1);
		System.out.println("endTime2 : " + endTime2);
		System.out.println("place : [" + place + "]");
		System.out.println("reason : " + reason);
		*/
		String starttime = usedate + " " + startTime1 + ":" + startTime2;
		String endtime = usedate + " " + endTime1 + ":" + endTime2;
		/*
		System.out.println("starttime : " + starttime);
		System.out.println("endtime : " + endtime);
		*/
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("attend_index", attend_index);
		paraMap.put("usedate", usedate);
		paraMap.put("starttime", starttime);
		paraMap.put("endtime", endtime);
		paraMap.put("place", place);
		paraMap.put("reason", reason);
						
		
		int n = service.requestAttendance(paraMap);
		
		if(n == 1) {
			mav.addObject("submenuId", "my2");
			mav.setViewName("attendance/my/my_attend_manage.tiles");
		}
		
				
		return mav;
	}
	
	
	
	// my attend status
	@ResponseBody
	@RequestMapping(value = "/attend/myAttendStatusList.on", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String myAttendStatusList(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");
		String calMonthVal = request.getParameter("calMonthVal");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("calMonthVal", calMonthVal);
		
		List<AttendanceVO> myAttendStatusList = service.myAttendStatusList(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(myAttendStatusList != null && myAttendStatusList.size() != 0) { 
			for(AttendanceVO avo : myAttendStatusList) {
				
				JSONObject jsonObj= new JSONObject();
				
				jsonObj.put("workdate", avo.getWorkdate());
				jsonObj.put("workstart", avo.getWorkstart());
				jsonObj.put("workend", avo.getWorkend());
				jsonObj.put("trip", avo.getTrip());
				jsonObj.put("tripstart", avo.getTripstart());
				jsonObj.put("tripend", avo.getTripend());
				jsonObj.put("dayoff", avo.getDayoff());
				jsonObj.put("extendstart", avo.getExtendstart());
				jsonObj.put("triptime", avo.getTriptime());
				jsonObj.put("worktime", avo.getWorktime());
				
				jsonArr.put(jsonObj);
				
			} // end of for -------------------------
		}
		
		// System.out.println(jsonArr);
		
		return jsonArr.toString(); // 
		
	}
	
	
	
	// 내 근태조회 상단 박스에 이번주 근무시간 얻어오기
	@ResponseBody
	@RequestMapping(value = "/attend/getWeeklyWorkTimes.on", produces="text/plain;charset=UTF-8")
	public String getWeeklyWorkTimes(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");		
		// System.out.println("empno: " + empno);
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		
		Map<String, String> weeklyworkTimesMap = service.getWeeklyWorkTimes(paraMap);				
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("weeklyworkTimesMap", weeklyworkTimesMap);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}

	
	
	// 내 근태조회 상단 박스에 이번달 근무시간 얻어오기
	@ResponseBody
	@RequestMapping(value = "/attend/getMonthlyWorkTimes.on", produces="text/plain;charset=UTF-8")
	public String getMonthlyWorkTimes(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");		
		// System.out.println("empno: " + empno);
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		
		Map<String, String> monthlyworkTimesMap = service.getMonthlyWorkTimes(paraMap);				
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("monthlyworkTimesMap", monthlyworkTimesMap);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	
	
	// 근태 신청내역 조회
	@ResponseBody
	@RequestMapping(value = "/attend/getRequestList.on", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String getRequestList(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");
		
		dateStart += " 00:00:01";
		dateEnd += " 23:59:59";
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("dateStart", dateStart);
		paraMap.put("dateEnd", dateEnd);
		
		List<AttandanceRequestVO> getRequestList = service.getRequestList(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(getRequestList != null) { // mymvc 에서는 new arrayList를 썼느데 지금은 안씀. 그래서 댓글이 없는 글은 null 로 나옴
			for(AttandanceRequestVO arvo : getRequestList) {
				
				JSONObject jsonObj= new JSONObject();
				
				jsonObj.put("requestid", arvo.getRequestid());
				jsonObj.put("attend_index", arvo.getAttend_index());
				jsonObj.put("starttime", arvo.getStarttime());
				jsonObj.put("endtime", arvo.getEndtime());
				jsonObj.put("registerdate", arvo.getRegisterdate());
				jsonObj.put("place", arvo.getPlace());
				jsonObj.put("reason", arvo.getReason());
				
				jsonArr.put(jsonObj);
				
			} // end of for -------------------------
		}
		
		// System.out.println(jsonArr);
		
		return jsonArr.toString(); // 
		
	}
	
	
	// 근태 신청내역 삭제 
	@ResponseBody
	@RequestMapping(value="/attend/deleteRequest.on", method= {RequestMethod.GET})
	public int deleteRequest(HttpServletRequest request) {
		
		String requestid = request.getParameter("requestid");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("requestid", requestid);
				
		int n = service.deleteRequest(paraMap);
								
		return n;
	}
	
	
	// 근태 사용내역 조회
	@ResponseBody
	@RequestMapping(value = "/attend/getUsedAttendList.on", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String getUsedAttendList(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("dateStart", dateStart);
		paraMap.put("dateEnd", dateEnd);
		
		List<AttandanceRequestVO> getUsedAttendList = service.getUsedAttendList(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(getUsedAttendList != null) { 
			for(AttandanceRequestVO arvo : getUsedAttendList) {
				
				JSONObject jsonObj= new JSONObject();
				
				jsonObj.put("requestid", arvo.getRequestid());
				jsonObj.put("attend_index", arvo.getAttend_index());
				jsonObj.put("starttime", arvo.getStarttime());
				jsonObj.put("endtime", arvo.getEndtime());
				jsonObj.put("registerdate", arvo.getRegisterdate());
				jsonObj.put("place", arvo.getPlace());
				jsonObj.put("reason", arvo.getReason());
				
				jsonArr.put(jsonObj);
				
			} // end of for -------------------------
		}
		
		// System.out.println(jsonArr);
		
		return jsonArr.toString(); // 
		
	}
	
	
	// 내 근태관리 상단 박스에 기간별 근태상태 얻어오기
	@ResponseBody
	@RequestMapping(value = "/attend/getBoxAttend.on", produces="text/plain;charset=UTF-8")
	public String getBoxAttend(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");		
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("dateStart", dateStart);
		paraMap.put("dateEnd", dateEnd);
		
		Map<String, String> boxAttendMap = service.getBoxAttend(paraMap);				
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("boxAttendMap", boxAttendMap);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}

	
	// 부서별 근태조회에서 부서정보박스 정보 얻어오기
	@ResponseBody
	@RequestMapping(value = "/attend/getTeamInfoBox.on", produces="text/plain;charset=UTF-8")
	public String getTeamInfoBox(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");		
		String department = request.getParameter("department");	
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("department", department);
		
		List<MemberVO> teamInfoList = service.getTeamInfoBox(paraMap);
				
		JSONArray jsonArr = new JSONArray(); // []
		
		if(teamInfoList != null && teamInfoList.size() != 0) { 
			for(MemberVO mvo : teamInfoList) {
				
				JSONObject jsonObj= new JSONObject();
				
				jsonObj.put("empno", mvo.getEmpno());
				jsonObj.put("department", mvo.getDepartment());
				jsonObj.put("name", mvo.getName());
				jsonObj.put("position", mvo.getPosition());
				jsonObj.put("bumun", mvo.getBumun());
				
				jsonArr.put(jsonObj);
				
			} // end of for -------------------------
		}
		
		return jsonArr.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
		
		
	
	// 부서별 근태조회에서 개인정보박스 정보 얻어오기
	@ResponseBody
	@RequestMapping(value = "/attend/getPersonalInfoBox.on", produces="text/plain;charset=UTF-8")
	public String getPersonalInfoBox(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");	
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("dateStart", dateStart);
		paraMap.put("dateEnd", dateEnd);
		
		Map<String, String> PersonalInfoMap = service.getPersonalInfoBox(paraMap);
				
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("PersonalInfoMap", PersonalInfoMap);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	
	
	
	// 부서별 근태조회에서 회원 근태 정보 얻어오기
	@ResponseBody
	@RequestMapping(value = "/attend/getWeeklyWorkList.on", produces="text/plain;charset=UTF-8")
	public String getWeeklyWorkList(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");
		
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("dateStart", dateStart);
		paraMap.put("dateEnd", dateEnd);
				
		List<Map<String, String>> weeklyWorkList = service.getWeeklyWorkList(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(weeklyWorkList != null && weeklyWorkList.size() != 0) { 
			for(Map<String, String> map : weeklyWorkList) {
				
				JSONObject jsonObj= new JSONObject();
				
				jsonObj.put("workstart", map.get("workstart"));
				jsonObj.put("workend", map.get("workend"));
				jsonObj.put("extendtime", map.get("extendtime"));
				jsonObj.put("worksum", map.get("worksum"));
				jsonObj.put("dayoff", map.get("dayoff"));
				jsonObj.put("trip", map.get("trip"));
				jsonObj.put("tripstart", map.get("tripstart"));
				jsonObj.put("tripend", map.get("tripend"));
				
				jsonArr.put(jsonObj);
				
			} // end of for -------------------------
		}
		
		return jsonArr.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	
	
	
	
	// 일일 부서별 근태조회에서 회원 근태 정보 얻어오기
	@ResponseBody
	@RequestMapping(value = "/attend/getDailyWorkList.on", produces="text/plain;charset=UTF-8")
	public String getDailyWorkList(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");
		String datepick = request.getParameter("datepick");
		
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("datepick", datepick);
		
		List<Map<String, String>> dailyWorkList = service.getDailyWorkList(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(dailyWorkList != null && dailyWorkList.size() != 0) { 
			for(Map<String, String> map : dailyWorkList) {
				
				JSONObject jsonObj= new JSONObject();
				
				jsonObj.put("name", map.get("name"));
				jsonObj.put("empimg", map.get("empimg"));
				jsonObj.put("workstarttime", map.get("workstarttime"));
				jsonObj.put("workendtime", map.get("workendtime"));
				jsonObj.put("worktime", map.get("worktime"));
				jsonObj.put("worktimecom", map.get("worktimecom"));
				jsonObj.put("triptime", map.get("triptime"));
				jsonObj.put("worktimeback", map.get("worktimeback"));
				jsonObj.put("extendstart", map.get("extendstart"));
				jsonObj.put("extendtime", map.get("extendtime"));
				jsonObj.put("dayoff", map.get("dayoff"));
								
				jsonArr.put(jsonObj);
				
			} // end of for -------------------------
		}
		
		return jsonArr.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	
	
	// 부서 근태 관리 - 박스 정보 얻어오기 
	@ResponseBody
	@RequestMapping(value = "/attend/getBoxInfo.on", produces="text/plain;charset=UTF-8")
	public String getStartNoCheck(HttpServletRequest request) {
				
		String department = request.getParameter("department");	
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("department", department);
		paraMap.put("dateStart", dateStart);
		paraMap.put("dateEnd", dateEnd);
		
		Map<String, String> boxInfoMap = new HashMap<String, String>();
		
		String cntstartnochk = service.getCntstartnochk(paraMap);	
		String cntendnochk = service.getCntendnochk(paraMap);
		String cntabsent = service.getCntabsent(paraMap);
		String cntdayoff = service.getCntdayoff(paraMap);
		String sumextend = service.getSumextend(paraMap);
				
		boxInfoMap.put("cntstartnochk", cntstartnochk);
		boxInfoMap.put("cntendnochk", cntendnochk);
		boxInfoMap.put("cntabsent", cntabsent);
		boxInfoMap.put("cntdayoff", cntdayoff);
		boxInfoMap.put("sumextend", sumextend);
				
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("boxInfoMap", boxInfoMap);
		
		return jsonObj.toString(); // "{"workStartTime":"15:00:00"}"
		
	}
	/*
	@RequestMapping(value="/attend/getTeamSearchList.on")
	public ModelAndView getTeamSearchList(ModelAndView mav, HttpServletRequest request) {
				
		List<Map<String, String>> teamSearchList = null;
				
		Map<String, Object> filterMap = new HashMap<String, Object>();
		String[] filters = request.getParameterValues("filter");
		
		String filterwhere = "";
		if(filters != null) {
			for(String str : filters) {
				if("trip".equals(str)) {
					filterwhere += "or "+str+" like '%외근%' ";
				}
				else if("noStartCheck".equals(str)) {
					filterwhere += "or workstart like '출근미등록' ";
				}
				else if("noEndCheck".equals(str)) {
					filterwhere += "or workend like '퇴근미등록' ";
				}
				else if("dayoff".equals(str)) {
					filterwhere += "or "+str+" like '연차' ";
				}
				else if("extend".equals(str)) {
					filterwhere += "or "+str+" like '%연장%' ";
				}
			}
		}
		
		filterwhere = filterwhere.substring(2);
		
		filterMap.put("filterwhere", filterwhere);
		
		String startTime = request.getParameter("filterStartTime");
		String endTime = request.getParameter("filterEndTime");
		String department = request.getParameter("filterDepartment");
		String fname = request.getParameter("filterName");
				
		
		if(fname == null || "".equals(fname.trim())) {
			fname = "";
		}
		
		// filterMap.put("filterDetailMap", filterDetailMap);
		filterMap.put("startTime", startTime);
		filterMap.put("endTime", endTime);
		filterMap.put("department", department);
		filterMap.put("fname", fname);
				
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		int totalCount = 0;        // 총 게시물 건수
	    int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
	    int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
	    int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
	      
	    int startRno = 0; // 시작 행번호
	    int endRno = 0;   // 끝 행번호
		
		// 부서관리 총 게시물 건수(totalCount)
	    totalCount = service.getTotalCnt(filterMap);
	    
	    totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
	    
	    if(str_currentShowPageNo == null) {
	    	// 게시판에 보여지는 초기화면
	    	currentShowPageNo = 1;
	    }
	    else {
	    	
	    	try {
	    		currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
	    		if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
	    			currentShowPageNo = 1;
	    		}
	    	} catch(NumberFormatException e) {
	    		currentShowPageNo = 1;
	    	}
	    	
	    }
	    
		
	    startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
	    
	    
	    filterMap.put("startRno", String.valueOf(startRno));
	    filterMap.put("endRno", String.valueOf(endRno));
	    
	    teamSearchList = service.getTeamSearchList(filterMap);
		// 페이징처리한 글목록 가져오기(검색까지 포함)
		
		// === #121. 페이지바 만들기   === // 
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	    
		String pageBar = "<ul style='list-style: none;'>";
		String url = "/groovy/attend/getTeamSearchList.on?filterStartTime="+startTime+"&filterEndTime="+endTime+"&filterDepartment="+department+"&filterName="+fname;
		
		for(String str : filters) {
			url += "&filter="+str;				
		}
		
		
		// === [맨처음][이전] 만들기  === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; text-decoration: underline; color:red; width:30px; font-size:12pt;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
			
		} // end of while -----------------------
		
		// === [다음][마지막] 만들기  === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		pageBar += "</ul>"; 
				
		mav.addObject("pageBar", pageBar);
		mav.addObject("totalCount", totalCount);
			
		// System.out.println("pageBar: "+ pageBar);
		
		
		
		mav.addObject("teamSearchList", teamSearchList);
		mav.addObject("submenuId", "team2");
		mav.setViewName("attendance/team/team_attend_manage.tiles");
		
		
		
				
		return mav;
	}
	*/
	
	@ResponseBody
	@RequestMapping(value="/attend/getTeamSearchList.on", produces="text/plain;charset=UTF-8")
	public String getTeamSearchList(HttpServletRequest request) {
				
		List<Map<String, String>> teamSearchList = null;
				
		Map<String, Object> filterMap = new HashMap<String, Object>();
		String filter = request.getParameter("filter");
		
		String[] filters = filter.split("_");
				
		String filterwhere = "";
		if(filters != null) {
			for(String str : filters) {
				if("trip".equals(str)) {
					filterwhere += "or "+str+" like '%외근%' ";
				}
				else if("noStartCheck".equals(str)) {
					filterwhere += "or workstart like '출근미등록' ";
				}
				else if("noEndCheck".equals(str)) {
					filterwhere += "or workend like '퇴근미등록' ";
				}
				else if("dayoff".equals(str)) {
					filterwhere += "or "+str+" like '연차' ";
				}
				else if("extend".equals(str)) {
					filterwhere += "or "+str+" like '%연장%' ";
				}
			}
		}
		
		filterwhere = filterwhere.substring(2);
		
		filterMap.put("filterwhere", filterwhere); 
				
		String startTime = request.getParameter("filterStartTime");
		String endTime = request.getParameter("filterEndTime");
		String department = request.getParameter("filterDepartment");
		String fname = request.getParameter("filterName");
				
		
		if(fname == null || "".equals(fname.trim())) {
			fname = "";
		}
		
		// filterMap.put("filterDetailMap", filterDetailMap);
		filterMap.put("startTime", startTime);
		filterMap.put("endTime", endTime);
		filterMap.put("department", department);
		filterMap.put("fname", fname);
				
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		// System.out.println("str_currentShowPageNo: "+str_currentShowPageNo);
		
		int totalCount = 0;        // 총 게시물 건수
	    int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
	    int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
	    int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
	      
	    int startRno = 0; // 시작 행번호
	    int endRno = 0;   // 끝 행번호
		
		// 부서관리 총 게시물 건수(totalCount)
	    totalCount = service.getTotalCnt(filterMap);
	    
	    // System.out.println("totalCount: "+totalCount);
	    
	    totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
	    
	    if(str_currentShowPageNo == null) {
	    	// 게시판에 보여지는 초기화면
	    	currentShowPageNo = 1;
	    }
	    else {
	    	
	    	try {
	    		currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
	    		if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
	    			currentShowPageNo = 1;
	    		}
	    	} catch(NumberFormatException e) {
	    		currentShowPageNo = 1;
	    	}
	    	
	    }
	    
	    // System.out.println("currentShowPageNo: "+currentShowPageNo);
		
	    startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
	    
	    // System.out.println("startRno: "+startRno + " endRno: "+endRno);
	    
	    filterMap.put("startRno", String.valueOf(startRno));
	    filterMap.put("endRno", String.valueOf(endRno));
	    
	    teamSearchList = service.getTeamSearchList(filterMap);
		// 페이징처리한 글목록 가져오기(검색까지 포함)
	    
	    // === #121. 페이지바 만들기   === // 
 		int blockSize = 10;
 		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
 		
 		int loop = 1;
 		
 		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
 	    
 		String pageBar = "<ul style='list-style: none;'>";
 		String url = "/groovy/attend/getTeamSearchList.on?filterStartTime="+startTime+"&filterEndTime="+endTime+"&filterDepartment="+department+"&filterName="+fname+"&filter="+filter;
 		
 		/*
 		for(String str : filters) {
 			url += "&filter="+str;				
 		}
 		*/
 		
 		// === [맨처음][이전] 만들기  === //
 		if(pageNo != 1) {
 			// pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"&currentShowPageNo=1'>[맨처음]</a></li>";
 			// pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
 			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='#' onclick='getFilterInfo(1)'>[맨처음]</a></li>";
 			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='#' onclick='getFilterInfo("+(pageNo-1)+")'>[이전]</a></li>";
 		}
 		
 		while( !(loop > blockSize || pageNo > totalPage) ) {
 			
 			if(pageNo == currentShowPageNo) {
 				// pageBar += "<li style='display:inline-block; text-decoration: underline; color:red; width:30px; font-size:12pt;'>"+pageNo+"</li>";
 				pageBar += "<li style='display:inline-block; text-decoration: underline; color:red; width:30px; font-size:12pt;'>"+pageNo+"</li>";
 			}
 			else {
 				// pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
 				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='#' onclick='getFilterInfo("+pageNo+")'>"+pageNo+"</a></li>";
 			}
 			
 			loop++;
 			pageNo++;
 			
 		} // end of while -----------------------
 		
 		// === [다음][마지막] 만들기  === //
 		if(pageNo <= totalPage) {
 			// pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
 			// pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
 			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='#' onclick='getFilterInfo("+pageNo+")'>[다음]</a></li>";
 			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='#' onclick='getFilterInfo("+totalPage+")'>[마지막]</a></li>";
 		}
 		pageBar += "</ul>"; 
 		
 		// System.out.println("pageBar: "+ pageBar);
 		// System.out.println("totalCount: "+ totalCount);
	    
	    JSONArray jsonArr = new JSONArray(); // []
		
	    int index = 0;
		if(teamSearchList != null && teamSearchList.size() != 0) { 
			for(Map<String, String> map : teamSearchList) {
				
				JSONObject jsonObj= new JSONObject();
				
				if(index == 0) {
					jsonObj.put("pageBar", pageBar);
					jsonObj.put("totalCount", totalCount);
				}
				jsonObj.put("fname", map.get("fname"));
				jsonObj.put("department", map.get("department"));
				jsonObj.put("workdate", map.get("workdate"));
				jsonObj.put("workstart", map.get("workstart"));
				jsonObj.put("workend", map.get("workend"));
				jsonObj.put("dayoff", map.get("dayoff"));
				jsonObj.put("trip", map.get("trip"));
				jsonObj.put("extend", map.get("extend"));
								
				jsonArr.put(jsonObj);
				
				index++;
				
			} // end of for -------------------------
		}
		
		return jsonArr.toString(); // 
		
		
		
	}
	
}
