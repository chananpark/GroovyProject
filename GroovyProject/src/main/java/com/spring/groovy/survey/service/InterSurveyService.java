package com.spring.groovy.survey.service;

import com.spring.groovy.survey.model.AskVO;
import com.spring.groovy.survey.model.SurveyVO;

public interface InterSurveyService {

	
	// 관리자 - 설문작성(설문조사 번호 insert하기)
	int getsurveyList(SurveyVO svo);

	// 관리자 - 설문작성(한 문항씩 insert하기)
	int getAskList(AskVO avo);

}
