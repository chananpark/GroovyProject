package com.spring.groovy.survey.service;

import java.util.Map;

import com.spring.groovy.survey.model.AskVO;
import com.spring.groovy.survey.model.SurveyVO;

public interface InterSurveyService {

	
	// 관리자 - 설문작성(설문조사 번호 insert하기)
	int getsurveyList(SurveyVO svo);
	
	// 관리자 - 설문작성(설문번호 알아오기)
	Map<String, Object> getsurveyNO(SurveyVO svo);

	// 관리자 - 설문작성(한 문항씩 insert하기)
	int getAskList(Map<String, Object> paramap);


}
