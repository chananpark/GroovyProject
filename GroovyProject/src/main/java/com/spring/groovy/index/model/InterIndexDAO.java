package com.spring.groovy.index.model;

import java.util.List;
import java.util.Map;

import com.spring.groovy.management.model.MemberVO;

public interface InterIndexDAO {

	// 오늘의 명언 가져오기
	String getTodayProverb(Map<String, String> paraMap);

	// 이달의 생일 직원 가져오기
	List<MemberVO> getMonthlyBirthday();

}
