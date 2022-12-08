package com.spring.groovy.survey.model;

public interface InterSurveyDAO {

	
	// 관리자 - 설문작성(설문조사 번호 insert하기)
	int getsurveyList(SurveyVO svo);

	// 관리자 - 설문작성(한 문항씩 insert하기)
	int getAskList(AskVO avo);

	
	
	
	
	
	
	
}
