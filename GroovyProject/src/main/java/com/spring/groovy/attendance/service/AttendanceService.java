package com.spring.groovy.attendance.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.attendance.model.AttandanceRequestVO;
import com.spring.groovy.attendance.model.AttendanceVO;
import com.spring.groovy.attendance.model.InterAttendanceDAO;
import com.spring.groovy.management.model.MemberVO;

@Service
public class AttendanceService implements InterAttendanceService {

	@Autowired
	private InterAttendanceDAO adao;
	
	
	// 출근하기
	@Override
	public int goStartWork(Map<String, String> paraMap) {
		int n = adao.goStartWork(paraMap);
		return n;
	}
	
	// 퇴근하기
	@Override
	public int goEndWork(Map<String, String> paraMap) {
		int n = adao.goEndWork(paraMap);
		return n;
	}

	// 사이드바에 출근시간 퇴근시간 얻어오기
	@Override
	public Map<String, String> getWorkTimes(Map<String, String> paraMap) {
		Map<String, String> workTimeMap = adao.getWorkTimes(paraMap);
		return workTimeMap;
	}
	
	// 사이드바에 부서 얻어오기 
	@Override
	public Map<String, String> getDepartment(Map<String, String> paraMap) {
		Map<String, String> partMap = adao.getDepartment(paraMap);
		return partMap;
	}

	// 근태 신청하기 
	@Override
	public int requestAttendance(Map<String, String> paraMap) {
		int n = adao.requestAttendance(paraMap);
		return n;
	}
	
	
	
	// my attend status
	@Override
	public List<AttendanceVO> myAttendStatusList(Map<String, String> paraMap) {
		List<AttendanceVO> myAttendStatusList = adao.myAttendStatusList(paraMap);
		return myAttendStatusList;
	}

	
	// 내 근태조회 상단 박스에 이번주 근무시간 얻어오기
	@Override
	public Map<String, String> getWeeklyWorkTimes(Map<String, String> paraMap) {
		Map<String, String> weeklyWorkTimesMap = adao.getWeeklyWorkTimes(paraMap);
		return weeklyWorkTimesMap;
	}

	// 내 근태조회 상단 박스에 이번달 근무시간 얻어오기
	@Override
	public Map<String, String> getMonthlyWorkTimes(Map<String, String> paraMap) {
		Map<String, String> monthlyworkTimesMap = adao.getMonthlyWorkTimes(paraMap);
		return monthlyworkTimesMap;
	}

	
	// 근태 신청내역 조회
	@Override
	public List<AttandanceRequestVO> getRequestList(Map<String, String> paraMap) {
		List<AttandanceRequestVO> getRequestList = adao.getRequestList(paraMap);
		return getRequestList;
	}

	// 근태 사용내역 조회
	@Override
	public List<AttandanceRequestVO> getUsedAttendList(Map<String, String> paraMap) {
		List<AttandanceRequestVO> getUsedAttendList = adao.getUsedAttendList(paraMap);
		return getUsedAttendList;
	}

	// 내 근태관리 상단 박스에 기간별 근태상태 얻어오기
	@Override
	public Map<String, String> getBoxAttend(Map<String, String> paraMap) {
		Map<String, String> boxAttendMap = adao.getBoxAttend(paraMap);
		return boxAttendMap;
	}

	
	// 부서별 근태조회에서 부서정보박스 정보 얻어오기
	@Override
	public List<MemberVO> getTeamInfoBox(Map<String, String> paraMap) {
		List<MemberVO> teamInfoList = adao.getTeamInfoBox(paraMap);
		
		return teamInfoList;
	}

	// 부서별 근태조회에서 개인정보박스 정보 얻어오기
	@Override
	public Map<String, String> getPersonalInfoBox(Map<String, String> paraMap) {
		Map<String, String> PersonalInfoMap = adao.getPersonalInfoBox(paraMap);
		return PersonalInfoMap;
	}

	// 부서별 근태조회에서 회원 근태 정보 얻어오기
	@Override
	public List<Map<String, String>> getWeeklyWorkList(Map<String, String> paraMap) {
		List<Map<String, String>> weeklyWorkList = adao.getWeeklyWorkList(paraMap);
		return weeklyWorkList;
	}

	
	// [일별] 부서별 근태조회에서 회원 근태 정보 얻어오기
	@Override
	public List<Map<String, String>> getDailyWorkList(Map<String, String> paraMap) {
		List<Map<String, String>> dailyWorkList = adao.getDailyWorkList(paraMap);
		return dailyWorkList;
	}

	// 근태 신청내역 삭제
	@Override
	public int deleteRequest(Map<String, String> paraMap) {
		int n = adao.deleteRequest(paraMap);
		return n;
	}

	// 부서 근태 관리 - 박스 정보 얻어오기 (출근 미체크)
	@Override
	public String getCntstartnochk(Map<String, String> paraMap) {
		String cntstartnochk = adao.getCntstartnochk(paraMap);
		return cntstartnochk;
	}
	// 부서 근태 관리 - 박스 정보 얻어오기 (퇴근 미체크)
	@Override
	public String getCntendnochk(Map<String, String> paraMap) {
		String cntendnochk = adao.getCntendnochk(paraMap);
		return cntendnochk;
	}
	// 부서 근태 관리 - 박스 정보 얻어오기 (무단결근)
	@Override
	public String getCntabsent(Map<String, String> paraMap) {
		String cntabsent = adao.getCntabsent(paraMap);
		return cntabsent;
	}
	// 부서 근태 관리 - 박스 정보 얻어오기 (연차)
	@Override
	public String getCntdayoff(Map<String, String> paraMap) {
		String cntdayoff = adao.getCntdayoff(paraMap);
		return cntdayoff;
	}
	// 부서 근태 관리 - 박스 정보 얻어오기 (연장근무)
	@Override
	public String getSumextend(Map<String, String> paraMap) {
		String sumextend = adao.getSumextend(paraMap);
		return sumextend;
	}

	// 부서관리 총 게시물 건수(totalCount)
	@Override
	public int getTotalCnt(Map<String, Object> filterMap) {
		int totalCnt = adao.getTotalCnt(filterMap);
		return totalCnt;
	}

	// 페이징처리한 글목록 가져오기(검색까지 포함)
	@Override
	public List<Map<String, String>> getTeamSearchList(Map<String, Object> filterMap) {
		List<Map<String, String>> teamSearchList = adao.getTeamSearchList(filterMap);
		return teamSearchList;
	}

	
	
		
		
		
		

	
	


}
