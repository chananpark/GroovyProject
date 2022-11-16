package com.spring.groovy.attendance.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AttendanceController {

	
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
	public String teamAttendStatus(HttpServletRequest request) {
		request.setAttribute("submenuId", "team1");
		return "attendance/team/team_attend_status.tiles";
		
	}
	
	@RequestMapping(value = "/attend/teamStatusWeekly.on")
	public String teamAttendStatusWeek(HttpServletRequest request) {
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
	
	
}
