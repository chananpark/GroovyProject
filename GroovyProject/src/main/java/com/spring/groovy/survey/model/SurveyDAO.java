package com.spring.groovy.survey.model;

import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class SurveyDAO implements InterSurveyDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// 설문번호를 알아오는 메소드
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

	


	
	
	
}
