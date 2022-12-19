package com.spring.groovy.attendance.model;

import java.util.*;

import com.spring.groovy.management.model.MemberVO;

public interface InterAttendanceDAO {

	// 출근하기
	int goStartWork(Map<String, String> paraMap);
	// 퇴근하기
	int goEndWork(Map<String, String> paraMap);
	
	// 사이드바에 출근시간 퇴근시간 얻어오기
	Map<String, String> getWorkTimes(Map<String, String> paraMap);

	// 사이드바에 부서 얻어오기
	Map<String, String> getDepartment(Map<String, String> paraMap);
	
	// 근태 신청하기 
	int requestAttendance(Map<String, String> paraMap);	
	
	// my attend status
	List<AttendanceVO> myAttendStatusList(Map<String, String> paraMap);
	
	// 내 근태조회 상단 박스에 이번주 근무시간 얻어오기
	Map<String, String> getWeeklyWorkTimes(Map<String, String> paraMap);
	
	// 내 근태조회 상단 박스에 이번달 근무시간 얻어오기
	Map<String, String> getMonthlyWorkTimes(Map<String, String> paraMap);
	
	// 근태 신청내역 조회
	List<AttandanceRequestVO> getRequestList(Map<String, String> paraMap);
	
	// 근태 사용내역 조회
	List<AttandanceRequestVO> getUsedAttendList(Map<String, String> paraMap);
	
	// 내 근태관리 상단 박스에 기간별 근태상태 얻어오기
	Map<String, String> getBoxAttend(Map<String, String> paraMap);
	
	// 부서별 근태조회에서 부서정보박스 정보 얻어오기
	List<MemberVO> getTeamInfoBox(Map<String, String> paraMap);
	
	// 부서별 근태조회에서 개인정보박스 정보 얻어오기
	Map<String, String> getPersonalInfoBox(Map<String, String> paraMap);
	
	// 부서별 근태조회에서 회원 근태 정보 얻어오기
	List<Map<String, String>> getWeeklyWorkList(Map<String, String> paraMap);
	
	// [일별] 부서별 근태조회에서 회원 근태 정보 얻어오기
	List<Map<String, String>> getDailyWorkList(Map<String, String> paraMap);
	
	// 근태 신청내역 삭제
	int deleteRequest(Map<String, String> paraMap);
	
	// 부서 근태 관리 - 박스 정보 얻어오기 (출근 미체크)
	String getCntstartnochk(Map<String, String> paraMap);
	// 부서 근태 관리 - 박스 정보 얻어오기 (퇴근 미체크)
	String getCntendnochk(Map<String, String> paraMap);
	// 부서 근태 관리 - 박스 정보 얻어오기 (무단결근)
	String getCntabsent(Map<String, String> paraMap);
	// 부서 근태 관리 - 박스 정보 얻어오기 (연차)
	String getCntdayoff(Map<String, String> paraMap);
	// 부서 근태 관리 - 박스 정보 얻어오기 (연장근무)
	String getSumextend(Map<String, String> paraMap);
	
	// 부서관리 총 게시물 건수(totalCount)
	int getTotalCnt(Map<String, Object> filterMap);
	
	// 페이징처리한 글목록 가져오기(검색까지 포함)
	List<Map<String, String>> getTeamSearchList(Map<String, Object> filterMap);
	
	// 전사 근태 관리 - 부서 리스트 얻어오기
	List<Map<String, String>> getDepartments();
	
	String getSideWeeklyWorkTime(Map<String, String> paraMap);
	

	
		
		
		
		
	

	
	
	

}
