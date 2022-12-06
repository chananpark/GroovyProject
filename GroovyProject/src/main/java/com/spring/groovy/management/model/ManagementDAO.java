package com.spring.groovy.management.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groovy.common.Pagination;


@Repository
public class ManagementDAO implements InterManagementDAO {

	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	// 로그인 - 이메일
	@Override
	public MemberVO getLogin(String cpemail) {
		MemberVO loginuser = sqlsession.selectOne("minsu.getLogin", cpemail);
		return loginuser;
		
	}

	// 로그인- 비밀번호 입력
	@Override
	public MemberVO login2(Map<String, String> paraMap) {
		MemberVO loginuser = sqlsession.selectOne("minsu.login2",paraMap);
		return loginuser;
	}

	// 로그인 - 비밀번호 찾기 값입력
	@Override
	public MemberVO findPwd(Map<String, String> paraMap) {
		 MemberVO employee = sqlsession.selectOne("minsu.findPwd", paraMap);
		return employee;
	}

	
	
	
	
	// ================================================================================= //
	
	
	// 사원정보 수정
	@Override
	public int viewInfoEnd(Map<String, Object> paraMap) {
		int n = sqlsession.update("minsu.viewInfoEnd", paraMap);
		return n;
	}
	
	// 사원정보 수정 - 이메일 (이메일중복확인 Ajax)
	@Override
	public int checkPvEmail(String pvemail) {
		int n = sqlsession.selectOne("minsu.checkPvEmail", pvemail);
		return n;
	}
	
	
	
	
	
	//재직증명서 - 재직증명서신청 (insert)
	@Override
	public int proofEmployment(ProofVO pvo) {
		int n = sqlsession.insert("minsu.proofEmployment", pvo);
		return n;
	}

	// 재직증명서 신청내역을 가져오기(select)
	@Override
	public List<ProofVO> getProofList(String empno) {
		List<ProofVO> proofList = sqlsession.selectList("minsu.getProofList", empno);
		return proofList;
	}

	//공용 경조비관리 - 경조비신청
	@Override
	public int receiptCelebrate(CelebrateVO cvo) {
		int n = sqlsession.insert("minsu.receiptCelebrate", cvo);
		return n;
	}
	

	//공용 경조비관리 - 경조비신청목록
	@Override
	public List<CelebrateVO> getCelebrateList(String empno) {
		List<CelebrateVO> celebList = sqlsession.selectList("minsu.getCelebrateList",empno);
		return celebList;
	}


	
	
	// ================================================================================= //
	
	//관리자 사원관리 - 사원조회
	@Override
	public List<MemberVO> searchInfoAdmin(Map<String, Object> paraMap) {
		List<MemberVO> empList = sqlsession.selectList("minsu.searchInfoAdmin", paraMap);
		return empList;
	}

	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 사원조회 전체 글 개수 구하기(페이징)
	@Override
	public int getcountList(Pagination pagination) {
		int n = sqlsession.selectOne("minsu.getcountList", pagination);
		return n;
	}
	
	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 글 목록(페이징)
	@Override
	public List<MemberVO> getOnePageCnt(Map<String, Object> paraMap) {
		return sqlsession.selectList("minsu.getOnePageCnt", paraMap);
	}
	
	
	//관리자 사원관리 - 사원등록
	@Override
	public int getRegisterInfo(Map<String, Object> paraMap) {
		int n = sqlsession.insert("minsu.getRegisterInfo",paraMap);
		return n;
	}

	//관리자 사원관리 - 사원등록(이메일중복확인 Ajax)
	@Override
	public int cpEmailList(String cpemail) {
		int n = sqlsession.selectOne("minsu.cpEmailList",cpemail);
		return n;
	}

	// 사원등록 - 내선번호를 갖고오기위해 필요함
/*
	@Override
	public List<MemberVO> manageList() {
		List<MemberVO> manageList = sqlsession.selectList("minsu.manageList");
		return manageList;
	}
*/
	
	
	// ================================================================================= //



	
	// 재직증명서 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	@Override
	public int getcountPfList(Pagination pagination) {
		int n = sqlsession.selectOne("minsu.getcountPfList",pagination);
		return n;
	}

	// 재직증명서 - 한 페이지에 표시할 글 목록   (페이징)
	@Override
	public List<ProofVO> getOnePagePfCnt(Map<String, Object> paraMap) {
		return sqlsession.selectList("minsu.getOnePagePfCnt", paraMap);
	}

	 // 경조비 목록 - 전체 글 개수 구하기(페이징) 
	@Override
	public int getcountCelebList(Pagination pagination) {
		int n = sqlsession.selectOne("minsu.getcountCelebList", pagination);
		return n;
	}

	// 경조비 목록 - 한 페이지에 표시할 글 목록 (페이징)
	@Override
	public List<CelebrateVO> getCelebPageCelebCnt(Map<String, Object> paraMap) {
		return sqlsession.selectList("minsu.getCelebPageCelebCnt", paraMap);
	}

	// 공용 증명서 - 월급리스트
	@Override
	public List<PayVO> paySearch(Map<String, Object> paramap) {
		List<PayVO> payList = sqlsession.selectList("minsu.paySearch", paramap);
		return payList;
	}

	
	//관리자 사원관리 - 경조비지급목록
	@Override
	public List<CelebrateVO> receiptcelebrateList() {
		List<CelebrateVO> celebList = sqlsession.selectList("minsu.receiptcelebrateList");
		return celebList;
	}

	
	// 경조비지급목록 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	@Override
	public int getcountClList(Pagination pagination) {
		int n = sqlsession.selectOne("minsu.getcountClList", pagination);
		return n;
	}

	
	// 경조비지급목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	@Override
	public List<CelebrateVO> getOnePageClCnt(Map<String, Object> paraMap) {
		List<CelebrateVO> celebList = sqlsession.selectList("minsu.getOnePageClCnt", paraMap);
		return celebList;
	}

	
	//관리자 사원관리 - 경조비신청현황
	@Override
	public List<CelebrateVO>  receiptCelebrateStatus() {
		List<CelebrateVO> celbStatusList =sqlsession.selectList("minsu.receiptCelebrateStatus");
		return celbStatusList;
	}

	
	// 경조비신청현황 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	@Override
	public int getcountClSList(Pagination pagination) {
		int n = sqlsession.selectOne("minsu.getcountClSList",pagination);
		return n;
	}

	// 경조비신청현황 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	@Override
	public List<CelebrateVO> getOnePageClSCnt(Map<String, Object> paraMap) {
		List<CelebrateVO> celbStatusList= sqlsession.selectList("minsu.getOnePageClSCnt", paraMap);
		return celbStatusList;
	}

	
	// 관리자 사원관리 - 경조비신청현황(결제상태 변경 Ajax)
	@Override
	public int receiptCelebrateStatusEnd(Map<String, Object> paramap) {
		int n = sqlsession.update("minsu.receiptCelebrateStatusEnd", paramap);
		return n;
	}

	// 관리자 - 재직증명서
	@Override
	public List<ProofVO> proofEmploymentSearch() {
		List<ProofVO> proofList = sqlsession.selectList("minsu.proofEmploymentSearch");
		return proofList;
	}

	
	// 재직증명서 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	@Override
	public int getcountProofList(Pagination pagination) {
		int n = sqlsession.selectOne("minsu.getcountProofList", pagination);
		return n;
	}

	// 재직증명서 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	@Override
	public List<ProofVO> getOnePageProofCnt(Map<String, Object> paraMap) {
		List<ProofVO> proofListPG = sqlsession.selectList("minsu.getOnePageProofCnt", paraMap);
		return proofListPG;
	}

	
	// 로그인 - 비밀번호 변경하기
	@Override
	public int updatePwd(Map<String, Object> paraMap) {
		int n = sqlsession.update("minsu.updatePwd", paraMap);
		return n;
	}

	

	
	



	
	
	
}
