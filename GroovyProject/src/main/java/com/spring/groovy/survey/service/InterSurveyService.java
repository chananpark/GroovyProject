package com.spring.groovy.survey.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.common.Pagination;
import com.spring.groovy.survey.model.AskVO;
import com.spring.groovy.survey.model.JoinSurveyVO;
import com.spring.groovy.survey.model.SurveyVO;


public interface InterSurveyService {
	

	 // 설문리스트 목록 - 전체 글 개수 구하기(페이징) 
	int getcountSurveyList(Pagination pagination);
	
	// 설문리스트 목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	Object getSurveyCnt(Map<String, Object> paraMap);

		
	// 관리자 - 설문작성(설문번호) 이곳에서 결과값이 true인지 아닌지 설정
	String addSurvey(Map<String, Object> paramap);

	// 관리자 - 설문작성(한 문항씩 insert하기)
	int getAskList(Map<String, Object> paramap);

	// 설문리스트 - 설문참여
	List<AskVO> surveyJoin(Map<String, Object> paramap);

	//  답변한 설문지 insert
	int surveyJoinEnd(Map<String, Object> paramap);

	



}
