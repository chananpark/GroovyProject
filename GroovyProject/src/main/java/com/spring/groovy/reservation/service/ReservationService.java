package com.spring.groovy.reservation.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.reservation.model.InterReservationDAO;
import com.spring.groovy.reservation.model.ReservSmallCategoryVO;
import com.spring.groovy.reservation.model.ReservationVO;

@Service
public class ReservationService implements InterReservationService {
	
	@Autowired
	private InterReservationDAO dao;

	///////////////////////////////////////////////////////////////////////////////////////////////
	
	// 자원 항목 불러오기
	@Override
	public List<ReservSmallCategoryVO> selectSmallCategory(Map<String, String> paraMap) {
		List<ReservSmallCategoryVO> smallCategList = dao.selectSmallCategory(paraMap);
		return smallCategList;
	}

	// === 자원 예약하기 === 
	@Override
	public int addReservation(Map<String, String> paraMap) {
		
		int n = 0;
		
		// 예약일자에 예약이 존재하는지 여부 확인
		int m = dao.existReservation(paraMap);
		
		if(m == 0) {
			n = dao.addReservation(paraMap);
		}
		return n;
	}

	// 선택한 날짜에 따른 예약된 시간 가져오기
	@Override
	public List<ReservationVO> reservTime(Map<String, String> paraMap) {
		List<ReservationVO> reservTimeList = dao.reservTime(paraMap);
		return reservTimeList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
