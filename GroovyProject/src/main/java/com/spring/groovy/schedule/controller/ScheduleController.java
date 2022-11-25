package com.spring.groovy.schedule.controller;

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

import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.schedule.model.CalSmallCategoryVO;
import com.spring.groovy.schedule.service.InterScheduleService;

@Controller
public class ScheduleController {
	
	@Autowired
	private InterScheduleService service;

	// === 일정관리 시작 페이지 ===
	@RequestMapping(value="/schedule/schedule.on")
	public ModelAndView showSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/main_schedule.tiles");
		return mav;
	}
	
	
	// === 일정 등록 페이지 ===
	@RequestMapping(value="/schedule/insertSchedule.on")
	public ModelAndView insertSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		String chooseDate = request.getParameter("chooseDate");
		
		// form 에서 받아온 날짜가 있는 경우
		if(chooseDate != null) {
			mav.addObject("chooseDate", chooseDate);
		}
		
		mav.setViewName("schedule/insert_schedule.tiles2");
		return mav;
	}
	
	
	// === 일정 검색 페이지 ===
	@RequestMapping(value="/schedule/searchSchedule.on")
	public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/search_schedule.tiles");
		return mav;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	// === 전사일정 소분류 보여주기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/showCompanyCalendar.on",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String showCompanyCalendar(HttpServletRequest request) {
		
		List<CalSmallCategoryVO> calComCateList = service.showCompanyCalendar();
		
		JSONArray jsonArr = new JSONArray();
		
		if(calComCateList != null) {
			for(CalSmallCategoryVO smcatevo : calComCateList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", smcatevo.getSmcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		return jsonArr.toString();
			
	} // end of public String showCompanyCalendar(HttpServletRequest request)
	
	
	// === 전사일정 소분류 추가하기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/addComCalendar.on",method = {RequestMethod.POST})
	public String addComCalendar(HttpServletRequest request) throws Throwable {
		
		String comSmcatgoname = request.getParameter("com_smcatgoname");
		String empno = request.getParameter("cal_side_empno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("comSmcatgoname",comSmcatgoname);
		paraMap.put("empno",empno);
		
		int n = service.addComCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	} // end of public String addComCalendar(HttpServletRequest request) throws Throwable 
	///////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	// === 팀별일정 소분류 보여주기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/showTeamCalendar.on",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String showTeamCalendar(HttpServletRequest request) {
		
		String dept = request.getParameter("dept");
		
		List<CalSmallCategoryVO> calTeamCateList = service.showTeamCalendar(dept);
		
		JSONArray jsonArr = new JSONArray();
		
		if(calTeamCateList != null) {
			for(CalSmallCategoryVO smcatevo : calTeamCateList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", smcatevo.getSmcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		return jsonArr.toString();
			
	} // end of public String showMyCalendar(HttpServletRequest request)
	
	
	
	// === 팀별일정 소분류 추가하기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/addTeamCalendar.on",method = {RequestMethod.POST})
	public String addTeamCalendar(HttpServletRequest request) throws Throwable {
		
		String teamSmcatgoname = request.getParameter("team_smcatgoname");
		String empno = request.getParameter("cal_side_empno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("teamSmcatgoname",teamSmcatgoname);
		paraMap.put("empno",empno);
		
		int n = service.addTeamCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	} // end of public String addComCalendar(HttpServletRequest request) throws Throwable 
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	// === 개인일정 소분류 추가하기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/addMyCalendar.on",method = {RequestMethod.POST})
	public String addMyCalendar(HttpServletRequest request) throws Throwable {
		
		String mySmcatgoname = request.getParameter("my_smcatgoname");
		String empno = request.getParameter("cal_side_empno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("mySmcatgoname",mySmcatgoname);
		paraMap.put("empno",empno);
		
		int n = service.addMyCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	} // end of public String addMyCalendar(HttpServletRequest request) throws Throwable 
	
	
	// === 개인일정 소분류 보여주기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/showMyCalendar.on",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String showMyCalendar(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");
		
		List<CalSmallCategoryVO> calMyCateList = service.showMyCalendar(empno);
		
		JSONArray jsonArr = new JSONArray();
		
		if(calMyCateList != null) {
			for(CalSmallCategoryVO smcatevo : calMyCateList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", smcatevo.getSmcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		return jsonArr.toString();
			
	} // end of public String showMyCalendar(HttpServletRequest request)
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	// === 전사일정 및 팀별일정, 개인일정 소분류 수정하기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/editCalendar.on", method = {RequestMethod.POST})
	public String editCalCateg(HttpServletRequest request) throws Throwable {
		
		String smcatgono = request.getParameter("smcatgono");
		String smcatgoname = request.getParameter("smcatgoname");
		String empno = request.getParameter("empno");
		String caltype = request.getParameter("caltype");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("smcatgono", smcatgono);
		paraMap.put("smcatgoname", smcatgoname);
		paraMap.put("empno", empno);
		paraMap.put("caltype", caltype);
		
		int n = service.editCalCateg(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	} // end of public String editCalCateg(HttpServletRequest request) throws Throwable
	
	
	// === 전사일정 및 팀별일정, 개인일정 소분류 삭제하기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/delCalCateg.on", method = {RequestMethod.POST})
	public String delCalCateg(HttpServletRequest request) throws Throwable {
		
		String smcatgono = request.getParameter("smcatgono");
				
		int n = service.delCalCateg(smcatgono);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	} // end of public String delCalCateg(HttpServletRequest request) throws Throwable 
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	// === 일정 등록시 전사일정, 팀별일정, 개인일정 선택에 따른 서브캘린더 종류를 알아오기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/selectSmallCateg.on",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String selectSmallCateg(HttpServletRequest request) {
		
		String fk_lgcatgono = request.getParameter("fk_lgcatgono"); // 캘린더 대분류 번호
		String empno = request.getParameter("empno");       		// 사원번호
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		paraMap.put("empno", empno);
		
		List<CalSmallCategoryVO> smallCategList = service.selectSmallCateg(paraMap);
			
		JSONArray jsArr = new JSONArray();
		if(smallCategList != null) {
			for(CalSmallCategoryVO scvo : smallCategList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", scvo.getSmcatgono());
				jsObj.put("smcatgoname", scvo.getSmcatgoname());
				
				jsArr.put(jsObj);
			}
		}
		
		return jsArr.toString();
	} // end of public String selectSmallCategory(HttpServletRequest request)
	
	
	// === 참석자를 찾기 위한 특정글자가 들어간 회원명단 불러오기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/insertSchedule/searchJoinUserList.on", produces="text/plain;charset=UTF-8")
	public String searchJoinUserList(HttpServletRequest request) {
		
		String joinUserName = request.getParameter("joinUserName");
		
		// 사원 명단 불러오기
		List<MemberVO> joinUserList = service.searchJoinUserList(joinUserName);

		JSONArray jsonArr = new JSONArray();
		if(joinUserList != null && joinUserList.size() > 0) {
			for(MemberVO mvo : joinUserList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("empno", mvo.getEmpno());
				jsObj.put("name", mvo.getName());
				jsObj.put("cpemail", mvo.getCpemail());
				
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
		
	} // end of public String searchJoinUserList(HttpServletRequest request)
		
		
	// === 일정 등록하기 ===
	@RequestMapping(value="/schedule/insertScheduleEnd.on", method = {RequestMethod.POST})
	public ModelAndView insertScheduleEnd(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String startdate= request.getParameter("startdate");
	//	System.out.println("확인용 startdate => " + startdate);
	//  확인용 startdate => 20211125140000
   	    
		String enddate = request.getParameter("enddate");
		String subject = request.getParameter("subject");
		String fk_lgcatgono= request.getParameter("fk_lgcatgono");
		String fk_smcatgono = request.getParameter("fk_smcatgono");
		String color = request.getParameter("color");
		String place = request.getParameter("place");
		String joinuser = request.getParameter("joinuser");
		String content = request.getParameter("content");
		String empno = request.getParameter("empno");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("subject", subject);
		paraMap.put("fk_lgcatgono",fk_lgcatgono);
		paraMap.put("fk_smcatgono", fk_smcatgono);
		paraMap.put("color", color);
		paraMap.put("place", place);
		paraMap.put("joinuser", joinuser);
		paraMap.put("content", content);
		paraMap.put("empno", empno);
		
		int n = service.insertScheduleEnd(paraMap);

		if(n == 0) {
			mav.addObject("message", "일정 등록을 실패하였습니다. ");
		}
		else {
			mav.addObject("message", "일정이 정상적으로 등록되었습니다.");
		}
		
		mav.addObject("loc", request.getContextPath()+"/schedule/schedule.on");
		
		mav.setViewName("msg");
		
		return mav;
	} // end of public ModelAndView registerSchedule_end(ModelAndView mav, HttpServletRequest request) throws Throwable
	
		
	// === 모든 캘린더(사내캘린더, 내캘린더, 공유받은캘린더)를 불러오는것 ===
	@ResponseBody
	@RequestMapping(value="/schedule/selectSchedule.on", produces="text/plain;charset=UTF-8")
	public String selectSchedule(HttpServletRequest request) {
		
		// 등록된 일정 가져오기
		
		String empno = request.getParameter("empno");
		String cpemail = request.getParameter("cpemail");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("empno", empno);
		paraMap.put("cpemail", cpemail);
				
		List<Map<String,String>> scheduleList = service.selectSchedule(paraMap);
		
		JSONArray jsArr = new JSONArray();
		
		if(scheduleList != null && scheduleList.size() > 0) {
			
			for(Map<String,String> map : scheduleList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("scheduleno", map.get("scheduleno"));
				jsObj.put("startdate", map.get("startdate"));
				jsObj.put("enddate", map.get("enddate"));
				jsObj.put("subject", map.get("subject"));
				jsObj.put("color", map.get("color"));
				jsObj.put("place", map.get("place"));
				jsObj.put("joinuser", map.get("joinuser"));
				jsObj.put("content", map.get("content"));
				jsObj.put("fk_smcatgono", map.get("fk_smcatgono"));
				jsObj.put("fk_lgcatgono", map.get("fk_lgcatgono"));
				jsObj.put("empno", map.get("fk_empno"));
				jsObj.put("department", map.get("department"));
				
				jsArr.put(jsObj);
			}// end of for-------------------------------------
		
		}
		
		return jsArr.toString();
	} // end of public String selectSchedule(HttpServletRequest request)
		
		
		
	// === 일정 상세보기 ===
	@RequestMapping(value="/schedule/viewSchedule.on")
	public ModelAndView viewSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno = request.getParameter("scheduleno");
		
		/*
		// 검색하고 나서 취소 버튼 클릭했을 때 필요함
		String listgobackURL_schedule = request.getParameter("listgobackURL_schedule");
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);

		
		// 일정상세보기에서 일정수정하기로 넘어갔을 때 필요함
		String gobackURL_detailSchedule = Myutil.getCurrentURL(request);
		mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
		
		try {
			Integer.parseInt(scheduleno);
			Map<String,String> map = service.detailSchedule(scheduleno);
			mav.addObject("map", map);
			mav.setViewName("schedule/detailSchedule.tiles1");
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/scheduleManagement.action");
		}
		*/
		
		Map<String,String> map = service.viewSchedule(scheduleno);
		mav.addObject("map", map);
		
		mav.setViewName("schedule/view_schedule.tiles");
		return mav;
	} // end of public ModelAndView viewSchedule(ModelAndView mav, HttpServletRequest request)
	

	// === 일정 수정하기 ===
	@RequestMapping(value="/schedule/editSchedule.on", method = {RequestMethod.POST})
	public ModelAndView editSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno= request.getParameter("scheduleno");
   		
		try {
			Integer.parseInt(scheduleno);
			
			String gobackURL_viewSchedule = request.getParameter("gobackURL_viewSchedule");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			Map<String,String> map = service.viewSchedule(scheduleno);
			
			if( !loginuser.getEmpno().equals( map.get("FK_EMPNO") ) ) {
				String message = "다른 사용자가 작성한 일정은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			else {
				mav.addObject("map", map);
				mav.addObject("gobackURL_viewSchedule", gobackURL_viewSchedule);
				
				mav.setViewName("schedule/edit_schedule.tiles2");
			}
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/schedule.on");
		}
		
		return mav;
		
	} // end of public ModelAndView editSchedule(ModelAndView mav, HttpServletRequest request)
		
		
	// === 일정 수정하기 마무리 ===
	@RequestMapping(value="/schedule/editScheduleEnd.on", method = {RequestMethod.POST})
	public ModelAndView editScheduleEnd(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String startdate= request.getParameter("startdate");
	//	System.out.println("확인용 startdate => " + startdate);
	//  확인용 startdate => 20211125140000
   	    
		String enddate = request.getParameter("enddate");
		String subject = request.getParameter("subject");
		String fk_lgcatgono= request.getParameter("fk_lgcatgono");
		String fk_smcatgono = request.getParameter("fk_smcatgono");
		String color = request.getParameter("color");
		String place = request.getParameter("place");
		String joinuser = request.getParameter("joinuser");
		String content = request.getParameter("content");
		String empno = request.getParameter("empno");
		String scheduleno = request.getParameter("scheduleno");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("subject", subject);
		paraMap.put("fk_lgcatgono",fk_lgcatgono);
		paraMap.put("fk_smcatgono", fk_smcatgono);
		paraMap.put("color", color);
		paraMap.put("place", place);
		paraMap.put("joinuser", joinuser);
		paraMap.put("content", content);
		paraMap.put("empno", empno);
		paraMap.put("scheduleno", scheduleno);
		
		int n = service.updateScheduleEnd(paraMap);

		if(n == 0) {
			mav.addObject("message", "일정 수정을 실패하였습니다. ");
		}
		else {
			mav.addObject("message", "일정이 정상적으로 수정되었습니다.");
		}
		
		mav.addObject("loc", request.getContextPath()+"/schedule/viewSchedule.on?scheduleno="+scheduleno);
		
		mav.setViewName("msg");
		
		return mav;
	} // end of public ModelAndView editScheduleEnd(ModelAndView mav, HttpServletRequest request) throws Throwable	
		
		
	
	// === 일정 삭제하기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/deleteSchedule.on", method = {RequestMethod.POST})
	public String deleteSchedule(HttpServletRequest request) throws Throwable {
		
		String scheduleno = request.getParameter("scheduleno");
				
		int n = service.deleteSchedule(scheduleno);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	} // end of public String deleteSchedule(HttpServletRequest request) throws Throwable
	
	
	
	
	
	
	
	
}
