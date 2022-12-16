package com.spring.groovy.index.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.schedule.model.CalendarScheduleVO;

public interface InterIndexService {

	// 오늘의 명언 가져오기
	String getTodayProverb();

	// 이달의 생일 직원 가져오기
	List<MemberVO> getMonthlyBirthday();

	// 오늘의 일정
	List<CalendarScheduleVO> getSchedule(Map<String, Object> paraMap);

}
