package com.spring.groovy.survey.service;

import java.util.Map;

import com.spring.groovy.survey.model.AskVO;
import com.spring.groovy.survey.model.SurveyVO;

public interface InterSurveyService {
	

	// 관리자 - 설문작성(설문번호) 이곳에서 결과값이 true인지 아닌지 설정
	boolean addSurvey(Map<String, Object> paramap);

	// 관리자 - 설문작성(한 문항씩 insert하기)
	// int getAskList(Map<String, Object> paramap);



}
