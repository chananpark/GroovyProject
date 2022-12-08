package com.spring.groovy.schedule.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.schedule.model.CalSmallCategoryVO;
import com.spring.groovy.schedule.model.InterScheduleDAO;

@Service
public class ScheduleService implements InterScheduleService {

	@Autowired
	private InterScheduleDAO dao;

	//////////////////////////////////////////////////////////////
	
	// === 전사일정 소분류 보여주기 ===
	@Override
	public List<CalSmallCategoryVO> showCompanyCalendar() {
		List<CalSmallCategoryVO> calComCateList = dao.showCompanyCalendar(); 
		return calComCateList;
	} // end of public List<Calendar_small_category_VO> showMyCalendar(String cal_side_empno)

	
	// === 전사일정 소분류 추가하기 ===
	@Override
	public int addComCalendar(Map<String, String> paraMap) {
		int n = 0;
		
		String comSmcatgoname = paraMap.get("comSmcatgoname");
		
		// 전사일정 소분류명 존재여부 확인
		int m = dao.existComCalendar(comSmcatgoname);
		
		// 전사일정 소분류 추가
		if(m==0) { // select 결과 하나도 나오지 않을 경우
			n = dao.addComCalendar(paraMap);
		}
		
		return n;
	} // end of public int addComCalendar(Map<String, String> paraMap) 


	// === 전사일정 및 팀별일정, 개인일정 소분류 수정하기
	@Override
	public int editCalCateg(Map<String, String> paraMap) throws Throwable {
		int n = 0;
		
		// 수정하려는 전사일정 및 팀별일정, 개인일정 소분류명이 이미 해당 사용자가 만든 소분류 카테고리명으로 존재하는지 유무 알아오기  
		int m = dao.existsCalCateg(paraMap);
		
		if(m==0) {
			n = dao.editCalCateg(paraMap);	
		}
		
		return n;
	}


	// === 전사일정 및 팀별일정, 개인일정 소분류 삭제하기 ===
	@Override
	public int delCalCateg(String smcatgono) throws Throwable {
		int n = dao.delCalCateg(smcatgono);
		return n;
	}


	// === 팀별일정 소분류 보여주기 ===
	@Override
	public List<CalSmallCategoryVO> showTeamCalendar(String dept) {
		List<CalSmallCategoryVO> calTeamCateList = dao.showTeamCalendar(dept); 
		return calTeamCateList;
	}


	// === 팀별일정 소분류 추가하기 ===
	@Override
	public int addTeamCalendar(Map<String, String> paraMap) {
		int n = 0;
		
		// 팀별일정 소분류명 존재여부 확인
		int m = dao.existTeamCalendar(paraMap);
		
		// 팀별일정 소분류 추가
		if(m==0) { // select 결과 하나도 나오지 않을 경우
			n = dao.addTeamCalendar(paraMap);
		}
		
		return n;
	}


	// === 개인일정 소분류 추가하기 ===
	@Override
	public int addMyCalendar(Map<String, String> paraMap) {
		int n = 0;
		
		// 개인일정 소분류명 존재여부 확인
		int m = dao.existMyCalendar(paraMap);
		
		// 개인일정 소분류 추가
		if(m==0) { // select 결과 하나도 나오지 않을 경우
			n = dao.addMyCalendar(paraMap);
		}
		
		return n;
	}


	// === 개인일정 소분류 보여주기 ===
	@Override
	public List<CalSmallCategoryVO> showMyCalendar(String empno) {
		List<CalSmallCategoryVO> calMyCateList = dao.showMyCalendar(empno); 
		return calMyCateList;
	}


	// === 일정 등록시 전사일정, 팀별일정, 개인일정 선택에 따른 서브캘린더 종류를 알아오기 ===
	@Override
	public List<CalSmallCategoryVO> selectSmallCateg(Map<String, String> paraMap) {
		List<CalSmallCategoryVO> smallCategList = dao.selectSmallCateg(paraMap);
		return smallCategList;
	}


	// === 참석자를 찾기 위한 특정글자가 들어간 회원명단 불러오기 ===
	@Override
	public List<MemberVO> searchJoinUserList(String joinUserName) {
		List<MemberVO> joinUserList = dao.searchJoinUserList(joinUserName);
		return joinUserList;
	}

	
	// === 일정 등록하기 ===
	@Override
	public int insertScheduleEnd(Map<String, String> paraMap) {
		int n = dao.insertScheduleEnd(paraMap);
		return n;
	}


	// === 모든 캘린더(사내캘린더, 내캘린더, 공유받은캘린더)를 불러오는것 ===
	@Override
	public List<Map<String,String>> selectSchedule(Map<String,String> paraMap) {
		List<Map<String,String>> scheduleList = dao.selectSchedule(paraMap);
		return scheduleList;
	}


	// === 일정 상세보기 ===
	@Override
	public Map<String, String> viewSchedule(String scheduleno) {
		Map<String,String> map = dao.viewSchedule(scheduleno);
		return map;
	}


	// === 일정 수정하기 마무리 ===
	@Override
	public int updateScheduleEnd(Map<String, String> paraMap) {
		int n = dao.updateScheduleEnd(paraMap);
		return n;
	}


	// === 일정 삭제하기 ===
	@Override
	public int deleteSchedule(String scheduleno) {
		int n = dao.deleteSchedule(scheduleno);
		return n;
	}


	// 일정 검색 전체 글 개수 구하기
	@Override
	public int getScheSearchCnt(Map<String, Object> paraMap) {
		int n = dao.getScheSearchCnt(paraMap);
		return n;
	}

	
	// 한 페이지에 표시할 글 목록
	@Override
	public List<Map<String, String>> getScheduleList(Map<String, Object> paraMap) {
		List<Map<String,String>> scheduleList = dao.getScheduleList(paraMap);
		return scheduleList;
	}


	// === 검색한 일정 다운로드 받기
	@Override
	public List<Map<String, String>> scheDownList(Map<String, String> paraMap) {
		List<Map<String,String>> scheduleList = dao.scheDownList(paraMap);
		return scheduleList;
	}


	// 해당 사원이 생성한 개인일정 카테고리가 있는지 여부
	@Override
	public int smallCategCheck(String empno) {
		int n = dao.smallCategCheck(empno);
		return n;
	}

	
	// 해당 부서에 생성한 카테고리가 있는지 여부
	@Override
	public int teamSmallCategCheck(String empno) {
		int n = dao.teamSmallCategCheck(empno);
		return n;
	}


	// 전사 일정에 생성한 카테고리가 있는지 여부
	@Override
	public int comSmallCategCheck() {
		int n = dao.comSmallCategCheck();
		return n;
	}
	
	
	
	
	
	
	
	
}
