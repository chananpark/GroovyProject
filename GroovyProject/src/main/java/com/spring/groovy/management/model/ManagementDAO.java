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


	
	
	
	// ================================================================================= //
	
	//관리자 사원관리 - 사원조회
	@Override
	public List<MemberVO> searchInfoAdmin(Map<String, Object> paraMap) {
		List<MemberVO> empList = sqlsession.selectList("minsu.searchInfoAdmin", paraMap);
		return empList;
	}

	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 사원조회 전체 글 개수 구하기
	@Override
	public int getcountList(Pagination pagination) {
		int n = sqlsession.selectOne("minsu.getcountList", pagination);
		return n;
	}
	
	// 관리자 사원관리 - 사원조회 한 페이지에 표시할 글 목록
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

	
	
	
	
	
	
}
