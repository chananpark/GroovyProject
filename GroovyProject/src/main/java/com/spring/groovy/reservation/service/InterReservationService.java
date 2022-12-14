package com.spring.groovy.reservation.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.reservation.model.ReservLargeCategoryVO;
import com.spring.groovy.reservation.model.ReservSmallCategoryVO;
import com.spring.groovy.reservation.model.ReservationVO;

public interface InterReservationService {

	// 자원 항목 불러오기
	List<ReservSmallCategoryVO> selectSmallCategory(Map<String, String> paraMap);

	// === 자원 예약하기 === 
	int addReservation(Map<String, String> paraMap);

	// 선택한 날짜에 따른 예약된 시간 가져오기
	List<ReservationVO> reservTime(Map<String, String> paraMap);

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

	// 이용자 예약 내역 전체 개수 구하기
	int getResrvSearchCnt(Map<String, Object> paraMap);

	// 한 페이지에 표시할 이용자 예약 내역 글 목록
	List<Map<String, String>> getResrvList(Map<String, Object> paraMap);

	// 자원 목록
	List<Map<String, String>> managementResource();

	// 자원명 수정 메소드
	int editSmcatgoname(Map<String, String> paraMap);

	// 자원 추가 메소드
	int addSmcatgo(Map<String, String> paraMap);

	// 자원 상태 변경 메소드
	int changeStatus(Map<String, String> paraMap);

	// 버튼 클릭 시 자원 항목 리스트 변경 메소드
	List<Map<String, String>> resourceFilter(Map<String, String> paraMap);

	// 예약 안내 페이지 수정
	ReservLargeCategoryVO editResourceContent(Map<String, String> paraMap);

	// 자원 안내 수정 최종
	int endEditResourceContent(Map<String, String> paraMap);

	// 자원 안내 내용 보여주기
	ReservLargeCategoryVO mainLgcategContent(String lgcatgono);

	
	
	
	
	
	
	
	
	
	
}
