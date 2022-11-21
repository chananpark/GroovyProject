package com.spring.groovy.schedule.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
