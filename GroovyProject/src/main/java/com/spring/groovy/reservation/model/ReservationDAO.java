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

	
	// 예약 내역 전체 개수 구하기
	@Override
	public int getResrvAdminSearchCnt(Map<String, Object> paraMap) {
		int n = sqlsession.selectOne("yeojin.getResrvAdminSearchCnt", paraMap);
		return n;
	}


	// 한 페이지에 표시할 관리자 예약 내역 글 목록
	@Override
	public List<Map<String, String>> getResrvAdminList(Map<String, Object> paraMap) {
		List<Map<String,String>> reservList = sqlsession.selectList("yeojin.getResrvAdminList", paraMap);
		return reservList;
	}

	
	// 관리자 예약 내역 확인에서 예약 상태 가져오기
	@Override
	public List<ReservationVO> statusButton() {
		List<ReservationVO> statusList = sqlsession.selectList("yeojin.statusButton");
		return statusList;
	}


	// 자원 예약 승인 메소드
	@Override
	public int reservConfirm(Map<String, String> paraMap) {
		int n = sqlsession.update("yeojin.reservConfirm", paraMap);
		return n;
	}


	// 자원 예약 취소 메소드
	@Override
	public int reservCancle(Map<String, String> paraMap) {
		int n = sqlsession.update("yeojin.reservCancle", paraMap);
		return n;
	}


	// 자원 반납 메소드
	@Override
	public int reservReturn(Map<String, String> paraMap) {
		int n = sqlsession.update("yeojin.reservReturn", paraMap);
		return n;
	}


	// 예약 내역 상세보기
	@Override
	public Map<String, String> viewReservation(Map<String, String> paraMap) {
		Map<String, String> map = sqlsession.selectOne("yeojin.viewReservation", paraMap);
		return map;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
