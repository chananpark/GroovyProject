package com.spring.groovy.reservation.model;

import java.util.List;
import java.util.Map;

public interface InterReservationDAO {

	// 자원 항목 불러오기
	List<ReservSmallCategoryVO> selectSmallCategory(Map<String, String> paraMap);

	// === 자원 예약하기 === 
	int addReservation(Map<String, String> paraMap);

	// 선택한 날짜에 따른 예약된 시간 가져오기
	List<ReservationVO> reservTime(Map<String, String> paraMap);

	// 예약일자에 예약이 존재하는지 여부 확인
	int existReservation(Map<String, String> paraMap);

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
