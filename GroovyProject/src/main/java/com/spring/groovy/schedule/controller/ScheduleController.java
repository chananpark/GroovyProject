package com.spring.groovy.schedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.Myutil;
import com.spring.groovy.common.Pagination;
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
		
		// 해당 사원이 생성한 개인일정 카테고리가 있는지 여부
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String empno = loginuser.getEmpno();
		int mySmcategCnt = service.smallCategCheck(empno);
		int teamSmcategCnt = service.teamSmallCategCheck(empno);
		int comSmcategCnt = service.comSmallCategCheck();
		
		mav.addObject("mySmcategCnt", mySmcategCnt);
		mav.addObject("teamSmcategCnt", teamSmcategCnt);
		mav.addObject("comSmcategCnt", comSmcategCnt);
		mav.setViewName("schedule/insert_schedule.tiles2");
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
		content = content.replace("\r\n","<br>");
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
		
		// 검색하고 나서 취소 버튼 클릭했을 때 필요함
		String listgobackURL_schedule = request.getParameter("listgobackURL_schedule");
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
		
		try {
			Integer.parseInt(scheduleno);
			Map<String,String> map = service.viewSchedule(scheduleno);
			mav.addObject("map", map);
			mav.setViewName("schedule/view_schedule.tiles");
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/schedule.on");
		}
		
		return mav;
	} // end of public ModelAndView viewSchedule(ModelAndView mav, HttpServletRequest request)
	

	// === 일정 수정하기 ===
	@RequestMapping(value="/schedule/editSchedule.on", method = {RequestMethod.POST})
	public ModelAndView editSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno= request.getParameter("scheduleno");
   		
		try {
			Integer.parseInt(scheduleno);
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			Map<String,String> map = service.viewSchedule(scheduleno);
			map.put("content", map.get("CONTENT").replaceAll("<br>", "\r\n"));
			
			if( !loginuser.getEmpno().equals( map.get("FK_EMPNO") ) ) {
				String message = "다른 사용자가 작성한 일정은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			else {
				mav.addObject("map", map);
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
		content = content.replace("\r\n","<br>");
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
	
	
	
	// === 일정 검색 페이지 ===
	@RequestMapping(value="/schedule/searchSchedule.on")
	public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav, Pagination pagination) throws Exception { 
		
		List<Map<String,String>> scheduleList = null;
		Map<String, Object> paraMap = new HashMap<String, Object>();
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String empno = request.getParameter("empno");  
		String cpemail = request.getParameter("cpemail");  
		String fk_lgcatgono = request.getParameter("fk_lgcatgono");

		if(pagination.getSearchWord() == null || "".equals(pagination.getSearchWord()) || pagination.getSearchWord().trim().isEmpty()) {
			pagination.setSearchWord("");
		}
		
		if(pagination.getSearchType() == null ||  "".equals(pagination.getSearchType()) ||
		   (!"subject".equals(pagination.getSearchType()) && !"content".equals(pagination.getSearchType())  && !"joinuser".equals(pagination.getSearchType()))
		  ) {  
			pagination.setSearchType("");
		}
		
		if(startdate==null || "".equals(startdate)) {
			startdate="";
		}
		
		if(enddate==null || "".equals(enddate)) {
			enddate="";
		}
		
		if(fk_lgcatgono == null || "".equals(fk_lgcatgono) || 
		   (!"1".equals(fk_lgcatgono) && !"2".equals(fk_lgcatgono) && !"3".equals(fk_lgcatgono)) ) {
			fk_lgcatgono="";
		}
		
		if(empno.equals("") || empno == null) {
			mav.addObject("message", "잘못된 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/schedule/schedule.on");
			
			mav.setViewName("msg.tiles");
		}

		// 문자로 장난쳤을 경우
		try {
			Integer.parseInt(empno);
		} catch (Exception e) {
			mav.addObject("message", "잘못된 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/schedule/schedule.on");
			
			mav.setViewName("msg.tiles");
		}
		
		paraMap.put("pagination", pagination);
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("empno", empno);
		paraMap.put("cpemail", cpemail);
		paraMap.put("fk_lgcatgono", fk_lgcatgono);

		// 일정 검색 전체 글 개수 구하기
		int listCnt = service.getScheSearchCnt(paraMap);
	//	System.out.println(listCnt);
		
		// startRno, endRno 구하기
		// 구해 온 최대 글 개수를 파라미터로 넘긴다.
		// 파라맵에 받아온 두개의 startrno와 endrno를 담아주어야 한다
		pagination.setPageInfo(listCnt);
	//	paraMap.putAll(BeanUtils.describe(pagination));
		paraMap.put("pagination", pagination);
		
		// 한 페이지에 표시할 글 목록
		scheduleList = service.getScheduleList(paraMap);
		mav.addObject("scheduleList", scheduleList);
		
		pagination.setQueryString("startdate="+startdate+"&enddate="+enddate+"&empno="+empno+"&cpemail="+cpemail+"&fk_lgcatgono="+fk_lgcatgono);
		
		// 페이지바
		// 파라미터로 페이지 url을 넘긴다.
		mav.addObject("pagebar", pagination.getPagebar(request.getContextPath()+"/schedule/searchSchedule.on"));
		mav.addObject("paraMap", paraMap);
		
		String listgobackURL_schedule = Myutil.getCurrentURL(request);
		
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
		mav.setViewName("schedule/search_schedule.tiles");
		return mav;
	} // end of public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav)
	

	// === 검색한 일정 다운로드 받기 === //
	@RequestMapping(value="/schedule/scheDownload.on", method= {RequestMethod.POST})
	public String scheDownload(HttpServletRequest request, Model model) { // model 은 값만 저장시키는 용이다
	
		List<Map<String,String>> scheduleList = null;
		Map<String, String> paraMap = new HashMap<String, String>();
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String empno = request.getParameter("empno");  
		String cpemail = request.getParameter("cpemail");  
		String fk_lgcatgono = request.getParameter("fk_lgcatgono");
		String searchWord = request.getParameter("searchWord");
		String searchType = request.getParameter("searchType");

		if(searchWord == null || "".equals(searchWord) ||searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		if(searchType == null ||  "".equals(searchType) ||
		   (!"subject".equals(searchType) && !"content".equals(searchType)  && !"joinuser".equals(searchType))
		  ) {  
			searchType = "";
		}
		
		if(startdate==null || "".equals(startdate)) {
			startdate="";
		}
		
		if(enddate==null || "".equals(enddate)) {
			enddate="";
		}
		
		if(fk_lgcatgono == null || "".equals(fk_lgcatgono) || 
		   (!"1".equals(fk_lgcatgono) && !"2".equals(fk_lgcatgono) && !"3".equals(fk_lgcatgono)) ) {
			fk_lgcatgono="";
		}

		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("empno", empno);
		paraMap.put("cpemail", cpemail);
		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		paraMap.put("searchWord", searchWord);
		paraMap.put("searchType", searchType);
		
		scheduleList = service.scheDownList(paraMap);
		
		// 일정관리 파일 다운로드 엑셀 시트 만들어주기
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		// 시트 생성
		SXSSFSheet sheet = workbook.createSheet("일정 목록");
		
		// 시트 열 너비 설정
		sheet.setColumnWidth(0, 4000); // 시작일자
		sheet.setColumnWidth(1, 4000); // 끝일자
		sheet.setColumnWidth(2, 4000); // 일정대분류
		sheet.setColumnWidth(3, 4000); // 일정소분류
		sheet.setColumnWidth(4, 4000); // 작성자
		sheet.setColumnWidth(5, 4000); // 일정명
		sheet.setColumnWidth(6, 4000); // 일정내용
		sheet.setColumnWidth(7, 4000); // 참석자
		sheet.setColumnWidth(8, 4000); // 장소
		
		// 행의 위치를 나타내는 변수
		int rowLocation = 0;
				
		////////////////////////////////////////////////////////////////////////////////////////
		// CellStyle 정렬하기(Alignment)
		// CellStyle 객체를 생성하여 Alignment 세팅하는 메소드를 호출해서 인자값을 넣어준다.
		// 아래는 HorizontalAlignment(가로)와 VerticalAlignment(세로)를 모두 가운데 정렬 시켰다.		
						
		// 파일 타이틀
		CellStyle mergeRowStyle = workbook.createCellStyle(); // workbook은 엑셀파일 // 셀스타일은 셀병합해준다
	    mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
	    mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
	    // 헤더 스타일 : 셀헤더
	    CellStyle headerStyle = workbook.createCellStyle();
	    headerStyle.setAlignment(HorizontalAlignment.CENTER);
	    headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
	    // CellStyle 배경색(ForegroundColor)만들기
        // setFillForegroundColor 메소드에 IndexedColors Enum인자를 사용한다.
        // setFillPattern은 해당 색을 어떤 패턴으로 입힐지를 정한다.
	    mergeRowStyle.setFillForegroundColor(IndexedColors.INDIGO.getIndex());  // IndexedColors.DARK_BLUE.getIndex() 는 색상(남색)의 인덱스값을 리턴시켜준다. 
	    mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); 		   // 실선
      
	    headerStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex()); // IndexedColors.LIGHT_YELLOW.getIndex() 는 연한노랑의 인덱스값을 리턴시켜준다. 
	    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    
	    // Cell 폰트(Font) 설정하기
        // 폰트 적용을 위해 POI 라이브러리의 Font 객체를 생성해준다.
        // 해당 객체의 세터를 사용해 폰트를 설정해준다. 대표적으로 글씨체, 크기, 색상, 굵기만 설정한다.
        // 이후 CellStyle의 setFont 메소드를 사용해 인자로 폰트를 넣어준다.
        // mergeRowFont 에 set 해주면 폰트스타일을 설정해 놓는 것이다.
	    Font mergeRowFont = workbook.createFont(); // import org.apache.poi.ss.usermodel.Font; 으로 한다.
	    mergeRowFont.setFontName("맑은고딕");
	    mergeRowFont.setFontHeight((short)500);
	    mergeRowFont.setColor(IndexedColors.WHITE.getIndex());
	    mergeRowFont.setBold(true);
	    
	    mergeRowStyle.setFont(mergeRowFont);
	    
	    // CellStyle 테두리 Border
        // 테두리는 각 셀마다 상하좌우 모두 설정해준다.
        // setBorderTop, Bottom, Left, Right 메소드와 인자로 POI라이브러리의 BorderStyle 인자를 넣어서 적용한다.
	    headerStyle.setBorderTop(BorderStyle.THIN);
	    headerStyle.setBorderBottom(BorderStyle.DOUBLE);
	    headerStyle.setBorderLeft(BorderStyle.THIN);
	    headerStyle.setBorderRight(BorderStyle.THIN);
	    
	    // Cell Merge 셀 병합시키기
        /* 셀병합은 시트의 addMergeRegion 메소드에 CellRangeAddress 객체를 인자로 하여 병합시킨다.
           CellRangeAddress 생성자의 인자로(시작 행, 끝 행, 시작 열, 끝 열) 순서대로 넣어서 병합시킬 범위를 정한다. 배열처럼 시작은 0부터이다.  
        */
        // 병합할 행 만들기
	    Row mergeRow = sheet.createRow(rowLocation);  // 엑셀에서 행의 시작은 0 부터 시작한다. 
	    // 첫번째 행을 의미한다. 왜냐면 rowLocation 에 값을 0을 주었음
	    
	    // 병합할 행에 "우리회사 사원정보" 로 셀을 만들어 셀에 스타일을 주기
	    for(int i=0; i<9; i++) {
	    	Cell cell = mergeRow.createCell(i);
	        cell.setCellStyle(mergeRowStyle);
	        cell.setCellValue("그루비 일정 목록");
	    }// end of for-------------------------
	    
	    // 셀 병합하기
	    sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 8)); // 시작 행, 끝 행, 시작 열, 끝 열 
		
		////////////////////////////////////////////////////////////////////////////////////////
			    
		// 헤더 행 생성
		Row headerRow = sheet.createRow(++rowLocation); // 엑셀에서 행의 시작은 0 부터 시작한다.
		// ++rowLocation는 전위연산자임. 
		
		// 해당 행의 첫번째 열 셀 생성
		Cell headerCell = headerRow.createCell(0); // 엑셀에서 열의 시작은 0 부터 시작한다.
		headerCell.setCellValue("시작일자");
		headerCell.setCellStyle(headerStyle);
		
		// 해당 행의 두번째 열 셀 생성
		headerCell = headerRow.createCell(1);
		headerCell.setCellValue("끝일자");
		headerCell.setCellStyle(headerStyle);
		
		// 해당 행의 세번째 열 셀 생성
		headerCell = headerRow.createCell(2);
		headerCell.setCellValue("일정대분류");
		headerCell.setCellStyle(headerStyle);
		
		// 해당 행의 네번째 열 셀 생성
		headerCell = headerRow.createCell(3);
		headerCell.setCellValue("일정소분류");
		headerCell.setCellStyle(headerStyle);
		
		// 해당 행의 다섯번째 열 셀 생성
		headerCell = headerRow.createCell(4);
		headerCell.setCellValue("작성자");
		headerCell.setCellStyle(headerStyle);
		
		// 해당 행의 여섯번째 열 셀 생성
		headerCell = headerRow.createCell(5);
		headerCell.setCellValue("일정명");
		headerCell.setCellStyle(headerStyle);
		
		// 해당 행의 일곱번째 열 셀 생성
		headerCell = headerRow.createCell(6);
		headerCell.setCellValue("일정내용");
		headerCell.setCellStyle(headerStyle);
		
		// 해당 행의 여덟번째 열 셀 생성
		headerCell = headerRow.createCell(7);
		headerCell.setCellValue("참석자");
		headerCell.setCellStyle(headerStyle);
		
		// 해당 행의 아홉번째 열 셀 생성
		headerCell = headerRow.createCell(8);
		headerCell.setCellValue("장소");
		headerCell.setCellStyle(headerStyle);
		
		// ==== HR사원정보 내용에 해당하는 행 및 셀 생성하기 ==== //
		Row bodyRow = null;
		Cell bodyCell = null;
		
		for(int i=0; i<scheduleList.size(); i++) {
		
			Map<String, String> scheMap = scheduleList.get(i); // 맵에 담긴 리스트를 하나하나 꺼내온다
			
			// 행생성
			bodyRow = sheet.createRow(i + (rowLocation+1)); // 기존의 rowLocation 은 1이고 여기에 1을 더하고 다시 i인 0을 더하면 총 2가 되고 첫행은 0행이기 때문에 2행(실제 시트에서 3행)이 된다.
			// 나온 데이터의 수만큼 나가게 된다.
			
			// 데이터 시작일자 표시
			bodyCell = bodyRow.createCell(0);
			bodyCell.setCellValue(scheMap.get("STARTDATE")); 
			
			// 데이터 끝일자 표시
			bodyCell = bodyRow.createCell(1);
			bodyCell.setCellValue(scheMap.get("ENDDATE")); 
			
			// 데이터 일정대분류 표시
			if("1".equals(scheMap.get("FK_LGCATGONO"))) {
				bodyCell = bodyRow.createCell(2);
				bodyCell.setCellValue("전사일정");
			} else if("2".equals(scheMap.get("FK_LGCATGONO"))) {
				bodyCell = bodyRow.createCell(2);
				bodyCell.setCellValue("팀별일정"); 
			} else if("3".equals(scheMap.get("FK_LGCATGONO"))) {
				bodyCell = bodyRow.createCell(2);
				bodyCell.setCellValue("개인일정"); 
			} 
	
			// 데이터 일정소분류 표시
			bodyCell = bodyRow.createCell(3);
			bodyCell.setCellValue(scheMap.get("SMCATGONAME")); 
			
			// 데이터 작성자 표시
			bodyCell = bodyRow.createCell(4);
			bodyCell.setCellValue(scheMap.get("NAME")); 
			
			// 데이터 일정명 표시
			bodyCell = bodyRow.createCell(5);
			bodyCell.setCellValue(scheMap.get("SUBJECT")); 
			
			// 데이터 일정내용 표시
			bodyCell = bodyRow.createCell(6);
			bodyCell.setCellValue(scheMap.get("CONTENT")); 
			
			// 데이터 참석자 표시
			bodyCell = bodyRow.createCell(7);
			bodyCell.setCellValue(scheMap.get("JOINUSER")); 
			
			// 데이터 장소 표시
			bodyCell = bodyRow.createCell(8);
			bodyCell.setCellValue(scheMap.get("PLACE")); 

		}// end of for------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////
		
		model.addAttribute("locale", Locale.KOREA);
		model.addAttribute("workbook", workbook); // 엑셀파일 여기에 다 넣어주었다
		model.addAttribute("workbookName", "그루비 일정 목록"); // 파일명
		// 이 값 3개가 excelDownloadView 여기로 넘어가게 된다. 
			    
		return "excelDownloadView";
		
	}
	
	
	
	
	
	
}
