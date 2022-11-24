package com.spring.groovy.management.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.InterManagementDAO;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.management.model.ProofVO;

@Service
public class ManagementService implements InterManagementService {

	@Autowired     // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterManagementDAO dao;
	
	// 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private AES256 aes;

	
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
	// ================================================================================= //
	
	
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
	
	
	// ================================================================================= //
	
	//관리자 사원관리 - 사원조회
	@Override
	public List<MemberVO> searchInfoAdmin(Map<String, Object> paraMap) {
		List<MemberVO> empList =  dao.searchInfoAdmin(paraMap);
		return empList;
	}

	// 관리자 사원관리 - 사원조회 전체 글 개수 구하기
	@Override
	public int getcountList(Pagination pagination) {
		int n = dao.getcountList(pagination);
		return n;
	}

	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 글 목록
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





	

	
	
	
	
}
