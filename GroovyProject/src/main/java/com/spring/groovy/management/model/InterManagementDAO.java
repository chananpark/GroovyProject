package com.spring.groovy.management.model;

import java.util.List;
import java.util.Map;

import com.spring.groovy.common.Pagination;

public interface InterManagementDAO {

	
	// 로그인- 이메일입력
	MemberVO getLogin(String cpemail);

	
	// 로그인- 비밀번호 입력
	MemberVO login2(Map<String, String> paraMap);

	
	// =========================================================== //
	//재직증명서 - 재직증명서신청(insert)
	int proofEmployment(ProofVO pvo);

	// 재직증명서 신청내역을 가져오기(select)
	List<ProofVO> getProofList(String empno);
	
	
	
	
	// =========================================================== //
	//관리자 사원관리 - 사원조회
	List<MemberVO> searchInfoAdmin(Map<String, Object> paraMap);

	// 사원조회 검색 전체 글 개수 구하기
	int getcountList(Pagination pagination);

	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 글 목록
	List<MemberVO> getOnePageCnt(Map<String, Object> paraMap);

	//관리자 사원관리 - 사원등록
	int getRegisterInfo(Map<String, Object> paraMap);

	

	
	
	
	
	

}
