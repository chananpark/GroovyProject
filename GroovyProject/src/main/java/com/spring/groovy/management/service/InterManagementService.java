package com.spring.groovy.management.service;

import java.util.Map;

import com.spring.groovy.management.model.MemberVO;

public interface InterManagementService {

	
	// 로그인- 이메일 입력
	MemberVO getLogin(String cpemail);

	
	// 로그인- 비밀번호 입력
	MemberVO login2(Map<String, String> paraMap);

}
