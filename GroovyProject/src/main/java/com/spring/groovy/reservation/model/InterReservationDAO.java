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

	// 예약 내역 전체 개수 구하기
	int getResrvAdminSearchCnt(Map<String, Object> paraMap);

	// 한 페이지에 표시할 관리자 예약 내역 글 목록
	List<Map<String, String>> getResrvAdminList(Map<String, Object> paraMap);

	// 관리자 예약 내역 확인에서 예약 상태 가져오기
	List<ReservationVO> statusButton();

	// 자원 예약 승인 메소드
	int reservConfirm(Map<String, String> paraMap);

	// 자원 예약 취소 메소드
	int reservCancle(Map<String, String> paraMap);

	// 자원 반납 메소드
	int reservReturn(Map<String, String> paraMap);

	// 예약 내역 상세보기
	Map<String, String> viewReservation(Map<String, String> paraMap);

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
