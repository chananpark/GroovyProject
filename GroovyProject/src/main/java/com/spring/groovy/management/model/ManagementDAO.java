package com.spring.groovy.management.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


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

	
	
	//관리자 사원관리 - 사원조회
	@Override
	public List<MemberVO> searchInfoAdmin() {
		List<MemberVO> empList = sqlsession.selectList("minsu.searchInfoAdmin");
		return empList;
	}

}
