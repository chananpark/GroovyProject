package com.spring.groovy.attendance.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AttendanceController {

	
	@RequestMapping(value = "/attend.on")
	public String myAttendStatus(HttpServletRequest request) {
		request.setAttribute("submenuId", "my1");
		return "attendance/my/my_attend_status.tiles";
		
	}
	
	@RequestMapping(value = "/attend/my_manage.on")
	public String myAttendManage(HttpServletRequest request) {
		request.setAttribute("submenuId", "my2");
		return "attendance/my/my_attend_manage.tiles";
		
	}
	
	@RequestMapping(value = "/attend/team_status.on")
	public String teamAttendStatus(HttpServletRequest request) {
		request.setAttribute("submenuId", "team1");
		return "attendance/team/team_attend_status.tiles";
		
	}
	
	@RequestMapping(value = "/attend/team_status_weekly.on")
	public String teamAttendStatusWeek(HttpServletRequest request) {
		request.setAttribute("submenuId", "team1");
		return "attendance/team/team_attend_status_weekly.tiles";
		
	}
	
	@RequestMapping(value = "/attend/team_manage.on")
	public String teamAttendManage(HttpServletRequest request) {
		request.setAttribute("submenuId", "team2");
		return "attendance/team/team_attend_manage.tiles";
		
	}
	
	@RequestMapping(value = "/attend/all_status.on")
	public String allAttendStatus(HttpServletRequest request) {
		request.setAttribute("submenuId", "all1");
		return "attendance/admin/all_attend_status.tiles";
		
	}
	
	@RequestMapping(value = "/attend/all_manage.on")
	public String allAttendManage(HttpServletRequest request) {
		request.setAttribute("submenuId", "all2");
		return "attendance/admin/all_attend_manage.tiles";
		
	}
	
	
}
