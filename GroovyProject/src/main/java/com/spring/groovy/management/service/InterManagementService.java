package com.spring.groovy.management.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.CelebrateVO;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.management.model.PayVO;
import com.spring.groovy.management.model.ProofVO;

public interface InterManagementService {

	
	// 로그인- 이메일 입력
	MemberVO getLogin(String cpemail);

	
	// 로그인- 비밀번호 입력
	MemberVO login2(Map<String, String> paraMap);

	// ================================================================================= //
	
	// 사원정보 수정
	int viewInfoEnd(MemberVO mvo);
	

	// 사원정보 수정 - 이메일 (이메일중복확인 Ajax)
	int checkPvEmail(String pvemail);

	
	//재직증명서 - 재직증명서신청 (insert)
	int proofEmployment(ProofVO pvo);
	
	// 재직증명서 신청내역을 가져오기(select)
	List<ProofVO> getProofList(String empno);

	//공용 경조비관리 - 경조비신청
	int receiptCelebrate(CelebrateVO cvo);


	//공용 경조비관리 - 경조비신청목록
	List<CelebrateVO> getCelebrateList(String empno);
	
		
		
	// ================================================================================= //
	//관리자 사원관리 - 사원조회
	List<MemberVO> searchInfoAdmin(Map<String, Object> paraMap);

	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 사원조회 전체 글 개수 구하기(페이징)
	int getcountList(Pagination pagination);
	
	// 한 페이지에 표시할 글 목록 (페이징)
	List<MemberVO> getOnePageCnt(Map<String, Object> paraMap);

	
	//관리자 사원관리 - 사원등록(이메일중복확인 Ajax)
	int checkCpEmail(String cpemail);
	

	//관리자 사원관리 - 사원등록
	int getRegisterInfo(Map<String, Object> paraMap);

	// 사원등록 - 내선번호를 갖고오기위해 필요함
	List<MemberVO> manageList();




	

	// ================================================================================= //


	// 재직증명서 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	int getcountPfList(Pagination pagination);


	// 재직증명서 - 한 페이지에 표시할 글 목록  (페이징)
	List<ProofVO> getOnePagePfCnt(Map<String, Object> paraMap);

	 // 경조비 목록 - 전체 글 개수 구하기(페이징) 
	int getcountCelebList(Pagination pagination);

	// 경조비 목록 - 한 페이지에 표시할 글 목록 (페이징)
	List<CelebrateVO> getCelebPageCelebCnt(Map<String, Object> paraMap);

	// 공용 증명서 - 월급리스트
	List<PayVO> paySearch(Map<String, Object> paramap);

	//관리자 사원관리 - 경조비지급목록
	List<CelebrateVO> receiptcelebrateList();

	// 경조비지급목록 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	int getcountClList(Pagination pagination);

	// 경조비지급목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	List<CelebrateVO> getOnePageClCnt(Map<String, Object> paraMap);

	//관리자 사원관리 - 경조비신청현황
	List<CelebrateVO> receiptCelebrateStatus();









	

	
	





}
