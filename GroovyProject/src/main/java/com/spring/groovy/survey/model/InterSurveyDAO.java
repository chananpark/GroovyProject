package com.spring.groovy.survey.model;

import java.util.List;
import java.util.Map;

import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.MemberVO;

public interface InterSurveyDAO {

	// 설문리스트 목록 - 전체 글 개수 구하기(페이징) 
	int getcountSurveyList(Pagination pagination);
		

		
	// 다음설문번호를 알아오는 매소드
	String getsurno();
	
	// 관리자 - 설문작성(설문조사 번호 insert하기)
	int getsurveyList(SurveyVO svo);
	
	// 관리자 - 설문작성(한 문항씩 insert하기)
	int getAskList(Map<String, Object> paramap);
	
	// 설문리스트 목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	List<SurveyVO> getSurveyCnt(Map<String, Object> paraMap);

	// 설문리스트 - 설문참여
	List<AskVO> surveyJoin(Map<String, Object> paramap);


	//  답변한 설문지 insert
	int surveyJoinEnd(Map<String, Object> paramap);


	// 관리자 설문리스트 목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	List<SurveyVO> surveyManage(Map<String, Object> paraMap);


	//  설문리스트 목록  -설문 참여자 수 구하기(페이징) 
	int getJoinEmpCnt(JoinSurveyVO jvo);


	//  설문리스트 목록  -설문 참여자 수 구하기(페이징) 
	int getEmpCnt(MemberVO mvo);


	// 설문결과를 조회하는 select
	List<SurveyVO> resultView(Map<String, Object> paraMap);


	// 설문지를 삭제 delete
	int surveyDelete(Map<String, Object> paraMap);


	

	

	
	
	
	
	
	
	
	
	
}
