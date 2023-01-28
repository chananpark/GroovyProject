package com.spring.groovy.index.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.approval.service.InterApprovalService;
import com.spring.groovy.common.FileManager;
import com.spring.groovy.index.service.InterIndexService;
import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.schedule.model.CalendarScheduleVO;

@Controller
public class IndexController {
	
	private InterApprovalService approvalService;
	private InterIndexService indexService;
	private FileManager fileManager;

	@Autowired
	public IndexController(InterApprovalService approvalService, InterIndexService indexService, FileManager fileManager) {
		this.approvalService = approvalService;
		this.indexService = indexService;
		this.fileManager = fileManager;
	}

	// === 인덱스 페이지 === //
	@RequestMapping(value="/") // 여기로 오면 index.action으로 가라
	public ModelAndView home(ModelAndView mav) {
		
		mav.setViewName("redirect:/index.on");
		return mav;
	} // end of public ModelAndView home()
	
	
	// === 인덱스 페이지 === //
	@RequestMapping(value="/index.on")
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {
		
		MemberVO loginuser = getLoginUser(request);
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());

		/* 결재 대기 문서 */
		List<String> draftNoList = approvalService.getRequestedDraftNo(paraMap);
		int requestedDraftCnt = draftNoList.size();
		
		mav.addObject("requestedDraftCnt", requestedDraftCnt);
		
		/* 오늘의 명언 */
		String proverb = indexService.getTodayProverb();
		mav.addObject("proverb", proverb);
		
		/* 이달의 생일 직원 */
		List<MemberVO> birthMem = indexService.getMonthlyBirthday();
		mav.addObject("birthMem", birthMem);
		
		
		/* 오늘의 일정 */
		Date date = new Date();
		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
		paraMap.put("sysdate",formatter.format(date));
		
		List<CalendarScheduleVO> scheduleList = indexService.getSchedule(paraMap);
		mav.addObject("scheduleList", scheduleList);
		
		/* 메일 5개 보여주기 */
		paraMap.put("cpemail", loginuser.getCpemail());
		List<MailVO> mailList = indexService.getMailList(paraMap);
		if(mailList.size() != 0) {
			mav.addObject("mailList", mailList);
		}
		
		
		mav.setViewName("index/index.tiles2");
		return mav;
	} // end of public ModelAndView index()
	
	// 로그인 사용자 정보 가져오기
	private MemberVO getLoginUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		return loginuser;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
