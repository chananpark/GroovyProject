package com.spring.groovy.survey.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.survey.model.AskVO;
import com.spring.groovy.survey.model.InterSurveyDAO;
import com.spring.groovy.survey.model.SurveyVO;

@Service
public class SurveyService implements InterSurveyService {

	@Autowired
	private InterSurveyDAO dao;

	
	// 관리자 - 설문작성(설문조사 번호 insert하기)
	@Override
	public int getsurveyList(SurveyVO svo) {
		return dao.getsurveyList(svo);
	}
	
	// 관리자 - 설문작성(설문번호 알아오기)
	@Override
	public Map<String, Object> getsurveyNO(SurveyVO svo) {
		return dao.getsurveyNO(svo);
	}

	// 관리자 - 설문작성(한 문항씩 insert하기)
	@Override
	public int getAskList(Map<String, Object> paramap) {
		return dao.getAskList(paramap);
	}
	
	
	
	
	
}
