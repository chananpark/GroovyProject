package com.spring.groovy.reservation.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.reservation.model.ReservSmallCategoryVO;
import com.spring.groovy.reservation.model.ReservationVO;

public interface InterReservationService {

	// 자원 항목 불러오기
	List<ReservSmallCategoryVO> selectSmallCategory(Map<String, String> paraMap);

	// === 자원 예약하기 === 
	int addReservation(Map<String, String> paraMap);

	// 선택한 날짜에 따른 예약된 시간 가져오기
	List<ReservationVO> reservTime(Map<String, String> paraMap);

	
	
	
	
	
	
	
	
	
	
}
