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

	
	// 예약 내역 전체 개수 구하기
	@Override
	public int getResrvAdminSearchCnt(Map<String, Object> paraMap) {
		int n = dao.getResrvAdminSearchCnt(paraMap);
		return n;
	}


	// 한 페이지에 표시할 관리자 예약 내역 글 목록
	@Override
	public List<Map<String, String>> getResrvAdminList(Map<String, Object> paraMap) {
		List<Map<String,String>> reservList = dao.getResrvAdminList(paraMap);
		return reservList;
	}


	// 관리자 예약 내역 확인에서 예약 상태 가져오기
	@Override
	public List<ReservationVO> statusButton() {
		List<ReservationVO> statusList = dao.statusButton();
		return statusList;
	}


	// 자원 예약 승인 메소드
	@Override
	public int reservConfirm(Map<String, String> paraMap) {
		int n = dao.reservConfirm(paraMap);
		return n;
	}


	// 자원 예약 취소 메소드
	@Override
	public int reservCancle(Map<String, String> paraMap) {
		int n = dao.reservCancle(paraMap);
		return n;
	}


	// 자원 반납 메소드
	@Override
	public int reservReturn(Map<String, String> paraMap) {
		int n = dao.reservReturn(paraMap);
		return n;
	}


	// 예약 내역 상세보기
	@Override
	public Map<String, String> viewReservation(Map<String, String> paraMap) {
		Map<String, String> map = dao.viewReservation(paraMap);
		return map;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
