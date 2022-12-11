package com.spring.groovy.survey.service;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.groovy.survey.model.AskVO;
import com.spring.groovy.survey.model.InterSurveyDAO;
import com.spring.groovy.survey.model.SurveyVO;

@Service
public class SurveyService implements InterSurveyService {

	@Autowired
	private InterSurveyDAO dao;
	
	// 관리자 - 설문작성(설문번호) 이곳에서 결과값이 true인지 아닌지 설정
	@Override
	@SuppressWarnings("unchecked")  // => 경고를 나태나는 노란줄을 안보이게 설정 (unchecked - 검증되지 않은 연산자 관련 경고 )
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
		// 트랜젝션 => 한번에 수행되야하는 연산들을 자동으로 처리해줌
		// 트랙잭션은 4가지의 성질을 갖고 있다. --> 원자성, 일관성, 격리성, 영속성
		// propagation : 트랜잭션 동작 도중 다른 트랜잭션을 호출할 때, 어떻게 할 것인지 지정하는 옵션이다
		// isolation:트랜잭션에서 일관성없는 데이터 허용 수준을 설정한다
		// rollbackFor : 특정 예외 발생 시 rollback한다.
		// REQUIRED : 이미 진행중인 트랜잭션이 있다면 해당 트랜잭션 속성을 따르고, 진행중이 아니라면 새로운 트랜잭션을 생성한다.
		// READ_COMMITED (level 1) : 커밋된 데이터에 대해 읽기 허용
	public String addSurvey(Map<String, Object> paramap) {
		
		boolean result = false;
		
		// 글번호를 알아오는 매소드
		String surno = dao.getsurno();
		
		SurveyVO svo = (SurveyVO) paramap.get("svo");
		svo.setSurno(surno); // svo에 있는 설문지번호 set
		
		// 설문지 insert하기(surno에 알아온 설문지번호를넣은후 svo에 담는다.)
		int n = dao.getsurveyList(svo);
		System.out.println(surno+" 서비스service");
		System.out.println(n+"service");
		
		result = (n == 1)? true: false;
		// bool 변수 = 변수 ? true : false ;
		// A ? B : C ; 라고 생각했을 때 A가 참이면 B를 리턴, 거짓이면 C를 리턴한다.
		
		if(!result) // n이 1이 아니라면
		return null;
		
		return surno;
	}

		
		


	// 관리자 - 설문작성(한 문항씩 insert하기)
	@Override
	public int getAskList(Map<String, Object> paramap) {
		return dao.getAskList(paramap);
	}
	
}
