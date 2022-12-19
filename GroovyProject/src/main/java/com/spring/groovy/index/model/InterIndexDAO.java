package com.spring.groovy.index.model;

import java.util.List;
import java.util.Map;

import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.schedule.model.CalendarScheduleVO;

public interface InterIndexDAO {

	// 오늘의 명언 가져오기
	String getTodayProverb(Map<String, String> paraMap);

	// 이달의 생일 직원 가져오기
	List<MemberVO> getMonthlyBirthday();

	// 오늘의 일정
	List<CalendarScheduleVO> getSchedule(Map<String, Object> paraMap);
	
	// 최근 받은메일 5개 가져오기
	List<MailVO> getMailList(Map<String, Object> paraMap);

}
