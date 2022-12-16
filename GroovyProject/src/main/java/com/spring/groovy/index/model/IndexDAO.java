package com.spring.groovy.index.model;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groovy.management.model.MemberVO;

@Repository
public class IndexDAO implements InterIndexDAO {
	
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	public IndexDAO(SqlSessionTemplate sqlsession) {
		this.sqlsession = sqlsession;
	}

	// 오늘의 명언 가져오기
	@Override
	public String getTodayProverb(Map<String, String> paraMap) {
		return sqlsession.selectOne("index.getTodayProverb", paraMap);
	}
	
	// 오늘의 명언 가져오기
	@Override
	public List<MemberVO> getMonthlyBirthday() {
		return sqlsession.selectList("index.getMonthlyBirthday");
	}
}
