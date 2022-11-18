package com.spring.groovy.management.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	

}
