package com.spring.groovy.survey.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.MemberVO;

@Repository
public class SurveyDAO implements InterSurveyDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	
	// 설문리스트 목록 - 전체 글 개수 구하기(페이징) 
	@Override
	public int getcountSurveyList(Pagination pagination) {
		return sqlsession.selectOne("minsu.getcountSurveyList", pagination);
	}
			
	// 설문리스트 목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	@Override
	public List<SurveyVO> getSurveyCnt(Map<String, Object> paraMap) {
		return sqlsession.selectList("minsu.getSurveyCnt", paraMap);
	}
	
	
		
	// 다음설문번호를 알아오는 매소드
	@Override
	public String getsurno() {
		return sqlsession.selectOne("minsu.getsurno");
	}
	
	
	// 관리자 - 설문작성(설문조사 번호 insert하기)
	@Override
	public int getsurveyList(SurveyVO svo) {
		return sqlsession.insert("minsu.getsurveyList", svo);
	}
	
	
	// 관리자 - 설문작성(한 문항씩 insert하기)
	@Override
	public int getAskList(Map<String, Object> paramap) {
		return sqlsession.insert("minsu.getAskList",paramap);
	}

	// 설문리스트 - 설문참여
	@Override
	public List<AskVO> surveyJoin(Map<String, Object> paramap) {
		return sqlsession.selectList("minsu.surveyJoin", paramap);
	}

	//  답변한 설문지 insert
	@Override
	public int surveyJoinEnd(Map<String, Object> paramap) {
		return sqlsession.insert("minsu.surveyJoinEnd", paramap);
	}

	// 관리자 설문리스트 목록 - 한 페이지에 표시할 글 목록  (페이징 페이지수를 알아온다음에 10개씩보여줌) (페이징)
	@Override
	public List<SurveyVO> surveyManage(Map<String, Object> paraMap) {
		return sqlsession.selectList("minsu.surveyManage", paraMap);
	}

	//  설문리스트 목록  -설문 참여자 수 구하기(페이징) 
	@Override
	public int getJoinEmpCnt(JoinSurveyVO jvo) {
		return sqlsession.selectOne("minsu.getJoinEmpCnt", jvo);
	}

	//  설문리스트 목록  -설문 참여자 수 구하기(페이징) 
	@Override
	public int getEmpCnt(MemberVO mvo) {
		return sqlsession.selectOne("minsu.getEmpCnt", mvo);
	}

	// 설문결과를 조회하는 select
	@Override
	public List<SurveyVO> resultView(Map<String, Object> paraMap) {
		return sqlsession.selectList("minsu.resultView", paraMap);
	}

	// 설문지를 삭제 delete
	@Override
	public int surveyDelete(Map<String, Object> paraMap) {
		return sqlsession.delete("minsu.surveyDelete", paraMap);
	}
	
	
	
	
	
}
