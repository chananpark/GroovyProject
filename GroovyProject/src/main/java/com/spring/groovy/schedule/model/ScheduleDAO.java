package com.spring.groovy.schedule.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groovy.management.model.MemberVO;

@Repository
public class ScheduleDAO implements InterScheduleDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	////////////////////////////////////////////////////////
	
	
	// === 전사일정 소분류 보여주기 ===
	@Override
	public List<CalSmallCategoryVO> showCompanyCalendar() {
		List<CalSmallCategoryVO> calComCateList = sqlsession.selectList("yeojin.showCompanyCalendar");  
		return calComCateList;
	} // end of public List<Calendar_small_category_VO> showCompanyCalendar()

	
	// 전사일정 소분류명 존재여부 확인
	@Override
	public int existComCalendar(String comSmcatgoname) {
		int n = sqlsession.selectOne("yeojin.existComCalendar", comSmcatgoname);
		return n;
	}

	// 전사일정 소분류 추가
	@Override
	public int addComCalendar(Map<String, String> paraMap) {
		int n = sqlsession.insert("yeojin.addComCalendar", paraMap);
		return n;
	}

	
	// 수정하려는 전사일정 및 팀별일정, 개인일정 소분류명이 이미 해당 사용자가 만든 소분류 카테고리명으로 존재하는지 유무 알아오기
	@Override
	public int existsCalCateg(Map<String, String> paraMap) {
		int m = sqlsession.selectOne("yeojin.existsCalCateg", paraMap);
		return m;
	}


	// 전사일정 및 팀별일정, 개인일정 소분류명 수정하기 
	@Override
	public int editCalCateg(Map<String, String> paraMap) {
		int n = sqlsession.update("yeojin.editCalCateg", paraMap);
		return n;
	}

	
	// === 전사일정 및 팀별일정, 개인일정 소분류 삭제하기 ===
	@Override
	public int delCalCateg(String smcatgono) {
		int n = sqlsession.delete("yeojin.delCalCateg", smcatgono);
		return n;
	}


	// === 팀별일정 소분류 보여주기 ===
	@Override
	public List<CalSmallCategoryVO> showTeamCalendar(String dept) {
		List<CalSmallCategoryVO> calTeamCateList = sqlsession.selectList("yeojin.showTeamCalendar", dept);  
		return calTeamCateList;
	}


	// 팀별일정 소분류명 존재여부 확인
	@Override
	public int existTeamCalendar(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("yeojin.existTeamCalendar", paraMap);
		return n;
	}

	// 팀별일정 소분류 추가
	@Override
	public int addTeamCalendar(Map<String, String> paraMap) {
		int n = sqlsession.insert("yeojin.addTeamCalendar", paraMap);
		return n;
	}


	// 개인일정 소분류명 존재여부 확인
	@Override
	public int existMyCalendar(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("yeojin.existMyCalendar", paraMap);
		return n;
	}

	// 개인일정 소분류 추가
	@Override
	public int addMyCalendar(Map<String, String> paraMap) {
		int n = sqlsession.insert("yeojin.addMyCalendar", paraMap);
		return n;
	}


	// === 개인일정 소분류 보여주기 ===
	@Override
	public List<CalSmallCategoryVO> showMyCalendar(String empno) {
		List<CalSmallCategoryVO> calMyCateList = sqlsession.selectList("yeojin.showMyCalendar", empno);  
		return calMyCateList;
	}


	// === 일정 등록시 전사일정, 팀별일정, 개인일정 선택에 따른 서브캘린더 종류를 알아오기 ===
	@Override
	public List<CalSmallCategoryVO> selectSmallCateg(Map<String, String> paraMap) {
		List<CalSmallCategoryVO> smallCategList = sqlsession.selectList("yeojin.selectSmallCateg", paraMap);  
		return smallCategList;
	}


	// === 참석자를 찾기 위한 특정글자가 들어간 회원명단 불러오기 ===
	@Override
	public List<MemberVO> searchJoinUserList(String joinUserName) {
		List<MemberVO> joinUserList = sqlsession.selectList("yeojin.searchJoinUserList", joinUserName);
		return joinUserList;
	}


	// === 일정 등록하기 ===
	@Override
	public int insertScheduleEnd(Map<String, String> paraMap) {
		int n = sqlsession.insert("yeojin.insertScheduleEnd", paraMap);
		return n;
	}


	// === 모든 캘린더(사내캘린더, 내캘린더, 공유받은캘린더)를 불러오는것 ===
	@Override
	public List<Map<String,String>> selectSchedule(Map<String,String> paraMap) {
		List<Map<String,String>> selectSchedule = sqlsession.selectList("yeojin.selectSchedule", paraMap);
		return selectSchedule;
	}


	// === 일정 상세보기 ===
	@Override
	public Map<String, String> viewSchedule(String scheduleno) {
		Map<String,String> map = sqlsession.selectOne("yeojin.viewSchedule", scheduleno);
		return map;
	}


	// === 일정 수정하기 마무리 ===
	@Override
	public int updateScheduleEnd(Map<String, String> paraMap) {
		int n = sqlsession.update("yeojin.updateScheduleEnd", paraMap);
		return n;
	}


	// === 일정 삭제하기 ===
	@Override
	public int deleteSchedule(String scheduleno) {
		int n = sqlsession.delete("yeojin.deleteSchedule", scheduleno);
		return n;
	} 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
