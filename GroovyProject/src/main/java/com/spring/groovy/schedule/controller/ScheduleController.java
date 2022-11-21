package com.spring.groovy.schedule.controller;

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
		
		mav.setViewName("schedule/insert_schedule.tiles2");
		return mav;
	}
	
	
	// === 일정 검색 페이지 ===
	@RequestMapping(value="/schedule/searchSchedule.on")
	public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/search_schedule.tiles");
		return mav;
	}
	
	
	// === 일정 상세 보기 ===
	@RequestMapping(value="/schedule/viewSchedule.on")
	public ModelAndView viewSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/view_schedule.tiles");
		return mav;
	}
	
	
	// === 일정 수정 하기 ===
	@RequestMapping(value="/schedule/editSchedule.on")
	public ModelAndView editSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		mav.setViewName("schedule/edit_schedule.tiles2");
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
