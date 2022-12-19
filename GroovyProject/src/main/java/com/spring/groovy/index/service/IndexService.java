package com.spring.groovy.index.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.index.model.InterIndexDAO;
import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.schedule.model.CalendarScheduleVO;

@Service
public class IndexService implements InterIndexService {
	
	private InterIndexDAO dao;
	
    @Autowired
    public IndexService(InterIndexDAO dao) {
        this.dao = dao;
    }

	// 오늘의 명언 가져오기
	@Override
	public String getTodayProverb() {
		
		Map<String, String> paraMap = new HashMap<>(); // OUT 파라미터
		paraMap.put("proverb", "");
		
		// 오늘의 명언 가져오기
		dao.getTodayProverb(paraMap);
		return paraMap.get("proverb");
		
	}

	// 이달의 생일 직원 가져오기
	@Override
	public List<MemberVO> getMonthlyBirthday() {
		return dao.getMonthlyBirthday();
	}
	
	
	// 오늘의 일정
	@Override
	public List<CalendarScheduleVO> getSchedule(Map<String, Object> paraMap) {
		List<CalendarScheduleVO> scheduleList = dao.getSchedule(paraMap);
		return scheduleList;
	}

	@Override
	public List<MailVO> getMailList(Map<String, Object> paraMap) {
		List<MailVO> mailList = dao.getMailList(paraMap);
		return mailList;
	}

}
