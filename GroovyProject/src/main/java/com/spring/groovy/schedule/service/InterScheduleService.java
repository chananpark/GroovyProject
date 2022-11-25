package com.spring.groovy.schedule.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.schedule.model.CalSmallCategoryVO;
import com.spring.groovy.schedule.model.CalendarScheduleVO;

public interface InterScheduleService {

	// === 전사일정 소분류 보여주기 ===
	List<CalSmallCategoryVO> showCompanyCalendar();

	// === 전사일정 소분류 추가하기 ===
	int addComCalendar(Map<String, String> paraMap);

	// === 전사일정 및 팀별일정, 개인일정 소분류 수정하기
	int editCalCateg(Map<String, String> paraMap) throws Throwable;

	// === 전사일정 및 팀별일정, 개인일정 소분류 삭제하기 ===
	int delCalCateg(String smcatgono) throws Throwable;

	// === 팀별일정 소분류 보여주기 ===
	List<CalSmallCategoryVO> showTeamCalendar(String dept);

	// === 팀별일정 소분류 추가하기 ===
	int addTeamCalendar(Map<String, String> paraMap);

	// === 개인일정 소분류 추가하기 ===
	int addMyCalendar(Map<String, String> paraMap);

	// === 개인일정 소분류 보여주기 ===
	List<CalSmallCategoryVO> showMyCalendar(String empno);

	// === 일정 등록시 전사일정, 팀별일정, 개인일정 선택에 따른 서브캘린더 종류를 알아오기 ===
	List<CalSmallCategoryVO> selectSmallCateg(Map<String, String> paraMap);

	// === 참석자를 찾기 위한 특정글자가 들어간 회원명단 불러오기 ===
	List<MemberVO> searchJoinUserList(String joinUserName);

	// === 일정 등록하기 ===
	int insertScheduleEnd(Map<String, String> paraMap);

	// === 모든 캘린더(사내캘린더, 내캘린더, 공유받은캘린더)를 불러오는것 ===
	List<Map<String,String>> selectSchedule(Map<String,String> paraMap);

	// === 일정 상세보기 ===
	Map<String, String> viewSchedule(String scheduleno);

	// === 일정 수정하기 마무리 ===
	int updateScheduleEnd(Map<String, String> paraMap);

	// === 일정 삭제하기 ===
	int deleteSchedule(String scheduleno);

	
	
	
	
	
}
