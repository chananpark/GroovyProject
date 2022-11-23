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

	
	// ================================================================================= //
	//재직증명서 - 재직증명서신청 (Ajax)
	@Override
	public int getproofEmployment(ProofVO pvo) {
		int n = sqlsession.insert("minsu.getproofEmployment", pvo);
		return n;
	}

		
	
	
	// ================================================================================= //
	
	//관리자 사원관리 - 사원조회
	@Override
	public List<MemberVO> searchInfoAdmin() {
		List<MemberVO> empList = sqlsession.selectList("minsu.searchInfoAdmin");
		return empList;
	}

	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 사원조회 전체 글 개수 구하기
	@Override
	public int getsearchInfoAdmin(Pagination pagination) {
		int n = sqlsession.selectOne("minsu.getsearchInfoAdmin", pagination);
		return n;
	}
	
	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 글 목록
	@Override
	public int getSearchInfoAdminList(Map<String, Object> paraMap) {
		int n = sqlsession.selectOne("minsu.getSearchInfoAdminList", paraMap);
		return 0;
	}
	
	
	
	//관리자 사원관리 - 사원등록
	@Override
	public int getRegisterInfo(Map<String, String> paraMap) {
		int n = sqlsession.insert("minsu.getRegisterInfo",paraMap);
		return n;
	}


	
	
	
	
	
	
}
