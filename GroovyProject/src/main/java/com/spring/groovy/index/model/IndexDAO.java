package com.spring.groovy.index.model;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.schedule.model.CalendarScheduleVO;

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

	// 오늘의 일정
	@Override
	public List<CalendarScheduleVO> getSchedule(Map<String, Object> paraMap) {
		List<CalendarScheduleVO> scheduleList = sqlsession.selectList("index.getSchedule", paraMap);
		return scheduleList;
	}

	@Override
	public List<MailVO> getMailList(Map<String, Object> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("index.getMailList", paraMap);
		return mailList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
