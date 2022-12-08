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
		
	@RequestMapping(value = "/attend/teamStatusWeekly.on")
	public String teamAttendStatusWeekly(HttpServletRequest request) {
		request.setAttribute("submenuId", "team1");
		return "attendance/team/team_attend_status_weekly.tiles";
		
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
		request.setAttribute("submenuId", "all1");
		return "attendance/admin/all_attend_status.tiles";
		
	}
	
	@RequestMapping(value = "/attend/allManage.on")
	public String allAttendManage(HttpServletRequest request) {
		request.setAttribute("submenuId", "all2");
		return "attendance/admin/all_attend_manage.tiles";
		
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
		
		System.out.println("empno : " + empno);
		System.out.println("attend_index : " + attend_index);
		System.out.println("usedate : " + usedate);
		System.out.println("startTime1 : " + startTime1);
		System.out.println("startTime2 : " + startTime2);
		System.out.println("endTime1: " + endTime1);
		System.out.println("endTime2 : " + endTime2);
		System.out.println("place : [" + place + "]");
		System.out.println("reason : " + reason);
		
		String starttime = usedate + " " + startTime1 + ":" + startTime2;
		String endtime = usedate + " " + endTime1 + ":" + endTime2;
		
		System.out.println("starttime : " + starttime);
		System.out.println("endtime : " + endtime);
		
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
			mav.setViewName("redirect:/attend/myAttendStatusList.on");
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
		// System.out.println("empno: " + empno);
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		
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
	
	
	@RequestMapping(value="/attend/getTeamSearchList.on")
	public ModelAndView getTeamSearchList(ModelAndView mav, HttpServletRequest request) {
				
		List<Map<String, String>> teamSearchList = null;
		
		////////////////////////////////////////////////////////////////////
		// === #69. 글조회수(readCount)증가 (DML문 update)는
		//          반드시 목록보기에 와서 해당 글제목을 클릭했을 경우에만 증가되고,
		//          웹브라우저에서 새로고침(F5)을 했을 경우에는 증가가 되지 않도록 해야 한다.
		//          이것을 하기 위해서는 session 을 사용하여 처리하면 된다.
		
		HttpSession session = request.getSession();
		
		// === #114. 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 시작 === //
		/*
			페이징 처리를 통한 글목록 보여주기는
			
			예를들어 2페이지의 내용을 보고자 한다면 검색을 할 경우는 아래와 같이 
			list.action?searchType=subject&searchWord=java&currentShowPageNo=2 와 같이 해주어야 한다.
			
			또는 검색이 없는 전체를 볼 때는 아래와 같이
			list.action 또는
			list.action?searchType=subject&searchWord=&currentShowPageNo=2 또는
			list.action?searchType=name&searchWord=&currentShowPageNo=2 와 같이 해주어야 한다.
			
		*/
		
		Map<String, Object> filterMap = new HashMap<String, Object>();
		String[] filters = request.getParameterValues("filter");
		
		List<String> filterList = new ArrayList<String>();
		if(filters != null) {
			for(String str : filters) {
				filterList.add(str);				
			}
		}
		else {
			filterList.add("none");
		}
		
		String startTime = request.getParameter("filterStartTime");
		String endTime = request.getParameter("filterEndTime");
		String department = request.getParameter("filterDepartment");
		String name = request.getParameter("filterName");
				
		
		if(name == null || "".equals(name.trim())) {
			name = "";
		}
		
		System.out.println("startTime: "+startTime);
		System.out.println("endTime: "+endTime);
		System.out.println("department: "+department);
		System.out.println("name: "+name);
		
		for(String str : filterList){
		    System.out.println(str);
		}
		
		filterMap.put("filterList", filterList);
		filterMap.put("startTime", startTime);
		filterMap.put("endTime", endTime);
		filterMap.put("department", department);
		filterMap.put("name", name);
				
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을 때로 나뉘어진다.
		int totalCount = 0;        // 총 게시물 건수
	    int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
	    int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
	    int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
	      
	    int startRno = 0; // 시작 행번호
	    int endRno = 0;   // 끝 행번호
		
		// 부서관리 총 게시물 건수(totalCount)
	    totalCount = service.getTotalCnt(filterMap);
	    // System.out.println("~~~~  totalCount: "+ totalCount);
	    
	    // 만약 총 게시물건수(totalCount) 가 22개라면
	    // 총 페이지수 totalPage 는 3개가 되어야 한다.
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
	    
	    // **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
	    /*
	           currentShowPageNo      startRno     endRno
	          --------------------------------------------
	               1 page        ===>    1           10
	               2 page        ===>    11          20
	               3 page        ===>    21          30
	               4 page        ===>    31          40
	               ......                ...         ...
	    */
		
	    startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
	    
	    filterMap.put("startRno", String.valueOf(startRno));
	    filterMap.put("endRno", String.valueOf(endRno));
	    
	    teamSearchList = service.getTeamSearchList(filterMap);
		// 페이징처리한 글목록 가져오기(검색까지 포함)
		
		// 아래의 것은 검색대상 컬럼과 검색어를 뷰단페이지에서 유지시키기 위한 것이다.
		/*
		if() {
			mav.addObject("paraMap", paraMap);
		}
		*/
		
		// === #121. 페이지바 만들기   === // 
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	    
		String pageBar = "<ul style='list-style: none;'>";
		String url = "/attend/getTeamSearchList.on";
		
		// === [맨처음][이전] 만들기  === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; text-decoration: underline; color:red; width:30px; font-size:12pt;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
			
		} // end of while -----------------------
		
		// === [다음][마지막] 만들기  === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		pageBar += "</ul>"; 
				
		mav.addObject("pageBar", pageBar);
			
		
		
		// === #114. 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝   === //
		///////////////////////////////////////////////////////
		
		mav.addObject("teamSearchList", teamSearchList);
		
		mav.setViewName("attendance/team/team_attend_manage.tiles");
		
		return mav;
	}
	
}
