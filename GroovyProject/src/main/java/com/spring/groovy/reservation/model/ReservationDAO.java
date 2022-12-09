package com.spring.groovy.reservation.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReservationDAO implements InterReservationDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	/////////////////////////////////////////////////////////////////////////////
	
	// 자원 항목 불러오기
	@Override
	public List<ReservSmallCategoryVO> selectSmallCategory(Map<String, String> paraMap) {
		List<ReservSmallCategoryVO> smallCategList = sqlsession.selectList("yeojin.selectSmallCategory", paraMap);
		return smallCategList;
	}

	// === 자원 예약하기 === 
	@Override
	public int addReservation(Map<String, String> paraMap) {
		int n = sqlsession.insert("yeojin.addReservation", paraMap);
		return n;
	}

	// 선택한 날짜에 따른 예약된 시간 가져오기
	@Override
	public List<ReservationVO> reservTime(Map<String, String> paraMap) {
		List<ReservationVO> reservTimeList = sqlsession.selectList("yeojin.reservTime", paraMap);
		return reservTimeList;
	}

	
	// 예약일자에 예약이 존재하는지 여부 확인
	@Override
	public int existReservation(Map<String, String> paraMap) {
		int m = sqlsession.selectOne("yeojin.existReservation", paraMap);
		return m;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
