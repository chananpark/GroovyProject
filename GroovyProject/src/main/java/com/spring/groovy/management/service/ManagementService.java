package com.spring.groovy.management.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.InterManagementDAO;
import com.spring.groovy.management.model.MemberVO;

@Service
public class ManagementService implements InterManagementService {

	@Autowired     // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterManagementDAO dao;
	
	
	// 로그인- 이메일 입력
	@Override
	public MemberVO getLogin(String cpemail) {
		
		MemberVO loginuser = dao.getLogin(cpemail);
		
		if(loginuser == null) {
			
		}
		
		return loginuser;
	}
	
	
	// 로그인- 이메일 입력
	@Override
	public MemberVO login2(Map<String, String> paraMap) {
		
		MemberVO loginuser = dao.login2(paraMap);
		return loginuser;
	}
	
	// ================================================================================= //
	

	//관리자 사원관리 - 사원조회
	@Override
	public List<MemberVO> searchInfoAdmin() {
		List<MemberVO> empList =  dao.searchInfoAdmin();
		return empList;
	}

	// 관리자 사원관리 - 사원조회 전체 글 개수 구하기
	@Override
	public int getsearchInfoAdmin(Pagination pagination) {
		int n = dao.getsearchInfoAdmin(pagination);
		return n;
	}

	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 글 목록
	@Override
	public Object getSearchInfoAdminList(Map<String, Object> paraMap) {
		int n = dao.getSearchInfoAdminList(paraMap);
		return n;
	}

	//관리자 사원관리 - 사원등록
	@Override
	public int getRegisterInfo(Map<String, String> paraMap) {
		int n = dao.getRegisterInfo(paraMap);
		return n;
	}

	

	
	
	
	
}
