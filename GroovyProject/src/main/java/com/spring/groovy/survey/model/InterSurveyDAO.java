package com.spring.groovy.survey.model;

import java.util.Map;

public interface InterSurveyDAO {

	// 다음설문번호를 알아오는 매소드
	String getsurno();
	
	// 관리자 - 설문작성(설문조사 번호 insert하기)
	int getsurveyList(SurveyVO svo);
	
	// 관리자 - 설문작성(한 문항씩 insert하기)
	int getAskList(Map<String, Object> paramap);


	

	
	
	
	
	
	
	
	
	
}
