package com.spring.groovy.management.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.common.FileManager;
import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.CelebrateVO;
import com.spring.groovy.management.model.InterManagementDAO;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.management.model.PayVO;
import com.spring.groovy.management.model.ProofVO;

@Service
public class ManagementService implements InterManagementService {

	@Autowired     // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterManagementDAO dao;
	
	// 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private AES256 aes;

	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	// 로그인- 이메일 입력
	@Override
	public MemberVO getLogin(String cpemail) {
		MemberVO loginuser = dao.getLogin(cpemail);
		if(loginuser == null) {
			
		}
		return loginuser;
	}
	
	
	// 로그인- 비밀번호
	@Override
	public MemberVO login2(Map<String, String> paraMap) {
		
		MemberVO loginuser = dao.login2(paraMap);
		
		// 사원 이메일 나중에 복호화 하기
		/*
		if(loginuser != null) {
			
			String email = "";
			
			try {
				email = aes.decrypt(loginuser.getEmail());
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} 
			
			loginuser.setEmail(email);
		}
		*/
		
		
		return loginuser;
	}
	
	// 로그인 - 비밀번호 찾기 값입력
	@Override
	public MemberVO findPwd(Map<String, String> paraMap) {
		 MemberVO employee = dao.findPwd(paraMap);
		return employee;
	}

		
	// 로그인 - 비밀번호 변경하기
	@Override
	public int updatePwd(Map<String, Object> paraMap) {
		int n = dao.updatePwd(paraMap);
		return n;
	}

		
		
	// ================================================================================= //

	// 사원정보 수정
	@Override
	public int viewInfoEnd(Map<String, Object> paraMap) {
		int n = dao.viewInfoEnd(paraMap);
		return n;
	}


	// 사원정보 수정 - 이메일 (이메일중복확인 Ajax)
	@Override
	public int checkPvEmail(String pvemail) {
		int n = dao.checkPvEmail(pvemail);
		return n;
	}


	

	
	
	//재직증명서 - 재직증명서신청 (insert)
	@Override
	public int proofEmployment(ProofVO pvo) {
		int n = dao.proofEmployment(pvo);
		return n;
	}
	
	// 재직증명서 신청내역을 가져오기(select)
	@Override
	public List<ProofVO> getProofList(String empno) {
		List<ProofVO> proofList = dao.getProofList(empno);
		return proofList;
	}
	
	

	//공용 경조비관리 - 경조비신청
	@Override
	public int receiptCelebrate(CelebrateVO cvo) {
		int n = dao.receiptCelebrate(cvo);
		return n;
	}
	

	//공용 경조비관리 - 경조비신청목록
	@Override
	public List<CelebrateVO> getCelebrateList(String empno) {
		List<CelebrateVO> celebList = dao.getCelebrateList(empno);
		return celebList;
	}



	
	// ================================================================================= //
	
	//관리자 사원관리 - 사원조회
	@Override
	public List<MemberVO> searchInfoAdmin(Map<String, Object> paraMap) {
		List<MemberVO> empList =  dao.searchInfoAdmin(paraMap);
		return empList;
	}

	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 사원조회 전체 글 개수 구하기(페이징)
	@Override
	public int getcountList(Pagination pagination) {
		int n = dao.getcountList(pagination);
		return n;
	}
		
	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 글 목록(페이징)
	@Override
	public List<MemberVO> getOnePageCnt(Map<String, Object> paraMap) {
		return dao.getOnePageCnt(paraMap);
	}

	//관리자 사원관리 - 사원등록
	@Override
	public int getRegisterInfo(Map<String, Object> paraMap) {
		int n = dao.getRegisterInfo(paraMap);
		return n;
	}

	//관리자 사원관리 - 사원등록(이메일중복확인 Ajax)
	@Override
	public int checkCpEmail(String cpemail) {
		int n = dao.cpEmailList(cpemail);
		return n;
	}

	// 사원등록 - 내선번호를 갖고오기위해 필요함
/*
	@Override
	public List<MemberVO> manageList() {
		List<MemberVO> manageList = dao.manageList();
		return manageList;
	}
*/
	
	
	
	
	
	
	
	
	
	// ================================================================================= //
	

	// 재직증명서 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	@Override
	public int getcountPfList(Pagination pagination) {
		int n = dao.getcountPfList(pagination);
		return n;
	}

	// 재직증명서 - 한 페이지에 표시할 글 목록   (페이징)
	@Override
	public List<ProofVO> getOnePagePfCnt(Map<String, Object> paraMap) {
		return dao.getOnePagePfCnt(paraMap);
	}

	 // 경조비 목록 - 전체 글 개수 구하기(페이징) 
	@Override
	public int getcountCelebList(Pagination pagination) {
		int n = dao.getcountCelebList(pagination);
		return n;
	}

	// 경조비 목록 - 한 페이지에 표시할 글 목록 (페이징)
	@Override
	public List<CelebrateVO> getCelebPageCelebCnt(Map<String, Object> paraMap) {
		return dao.getCelebPageCelebCnt(paraMap);
	}

	// 공용 증명서 - 월급리스트
	@Override
	public List<PayVO> paySearch(Map<String, Object> paramap) {
		List<PayVO> payList =dao.paySearch(paramap);
		
		
		return payList;
	}

	
	
	
	//관리자 사원관리 - 경조비지급목록
	@Override
	public List<CelebrateVO> receiptcelebrateList() {
		List<CelebrateVO> celebList = dao.receiptcelebrateList();
		return celebList;
	}


	// 경조비지급목록 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	@Override
	public int getcountClList(Pagination pagination) {
		int n = dao.getcountClList(pagination);
		return n;
	}

	// 경조비지급목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	@Override
	public List<CelebrateVO> getOnePageClCnt(Map<String, Object> paraMap) {
		List<CelebrateVO> celebList = dao.getOnePageClCnt(paraMap);
		return celebList;
	}


	//관리자 사원관리 - 경조비신청현황
	@Override
	public List<CelebrateVO> receiptCelebrateStatus() {
		List<CelebrateVO> celbStatusList = dao.receiptCelebrateStatus();
		return celbStatusList;
	}


	// 경조비신청현황 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	@Override
	public int getcountClSList(Pagination pagination) {
		int n = dao.getcountClSList(pagination);
		return 0;
	}

	// 경조비신청현황 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	@Override
	public List<CelebrateVO> getOnePageClSCnt(Map<String, Object> paraMap) {
		List<CelebrateVO> celbStatusList= dao.getOnePageClSCnt(paraMap);
		return celbStatusList;
	}

	// 관리자 사원관리 - 경조비신청현황(결제상태 변경 Ajax)
	@Override
	public int receiptCelebrateStatusEnd(Map<String, Object> paramap) {
		int n = dao.receiptCelebrateStatusEnd(paramap);
		return n;
	}

	// 관리자 - 재직증명서
	@Override
	public List<ProofVO> proofEmploymentSearch() {
		List<ProofVO> proofList = dao.proofEmploymentSearch();
		return proofList;
	}

	// 재직증명서 한 페이지에 표시할 재직증명서 전체 글 개수 구하기(페이징)
	@Override
	public int getcountProofList(Pagination pagination) {
		int n = dao.getcountProofList(pagination);
		return n;
	}


	// 재직증명서 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	@Override
	public List<ProofVO> getOnePageProofCnt(Map<String, Object> paraMap) {
		List<ProofVO> proofListPG = dao.getOnePageProofCnt(paraMap);
		return proofListPG;
	}

	// 공용 증명서 - 월급리스트
	@Override
	public List<PayVO> payView(Map<String, Object> paramap) {
		return dao.payView(paramap);
	}


	// 관리자 - 급여관리(급여조회)
	@Override
	public List<PayVO> paySearchAdmin(Map<String, Object> paramap) {
		return dao.paySearchAdmin(paramap);
	}

	// 관리자 - 급여관리(급여조회) 한 페이지에 표시할 전체 글 개수 구하기(페이징)
	@Override
	public int getcountPayList(Pagination pagination) {
		return dao.getcountPayList(pagination);
	}

	// 공용 - 급여관리(급여조회) 한 페이지에 표시할  전체 글 개수 구하기(페이징)
	@Override
	public int getSalaryList(Pagination pagination) {
		return dao.getSalaryList(pagination);
	}

	// 공용 - 급여관리(기본외수당조회) 한 페이지에 표시할  전체 글 개수 구하기(페이징)
	@Override
	public int getOverPayList(Pagination pagination) {
		return dao.getOverPayList(pagination);
	}



	
	
	
	
}
