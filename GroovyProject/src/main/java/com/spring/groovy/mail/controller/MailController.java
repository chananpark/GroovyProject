package com.spring.groovy.mail.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.Pagination;
import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.mail.model.TagVO;
import com.spring.groovy.mail.service.InterMailService;



@Controller
public class MailController {

	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterMailService service;
	
	/*
	
	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private F
	ileManager fileManager;
	*/
	@RequestMapping(value = "/mail/receiveMailBox.on")
	public ModelAndView receiveMailBox(ModelAndView mav, Pagination pagination) {

		 mav = mailpaginglist(mav, pagination, "FK_Recipient_address");
		 mav.setViewName("mail/mailbox/receieve_mailbox.tiles");
		// ==> views/tiles/mail/content/mailBox/receieve_mailbox.jsp
		
		return mav;		
	}
	
	@RequestMapping(value = "/mail/sendMailBox.on")
	public ModelAndView sendMailBox(ModelAndView mav, Pagination pagination) {

		 mav = mailpaginglist(mav, pagination, "FK_Sender_address");
		 mav.setViewName("mail/mailbox/send_mailbox.tiles");
		// ==> views/tiles/mail/content/mailBox/receieve_mailbox.jsp
		
		return mav;		
		// ==> views/tiles/mail/content/mailBox/send_mailbox.jsp
	}
	
	@RequestMapping(value = "/mail/importantMailBox.on")
	public ModelAndView importantMailBox(ModelAndView mav, Pagination pagination) {

		mav = mailpaginglist(mav, pagination, "important");
		 mav.setViewName("mail/mailbox/important_mailbox.tiles");
	
		return mav;	
		// ==> views/tiles/mail/content/mailBox/important_mailbox.jsp
	}
	
	@RequestMapping(value = "/mail/writeMail.on")
	public String writeMail(HttpServletRequest request) {

		return "mail/mailbox/write_mail.tiles";
		// ==> views/tiles/mail/content/mailBox/receieve_mailbox.jsp
	}
	@RequestMapping(value = "/mail/viewMail.on")
	public String viewMail(HttpServletRequest request) {

		return "mail/mailbox/view_mail.tiles";
		// ==> views/tiles/mail/content/mailBox/receieve_mailbox.jsp
	}
	
	// 채팅
	@RequestMapping(value = "/chat.on")
	public String chat(HttpServletRequest request) {

		return "chat/chatMain.tiles";
		// ==> views/tiles/chat/content/chatMain.jsp
	}
	
	// 1. `**Controller**`에 아래와 같이 에러 처리 메소드를 생성한다.
	// 만약 사용자가 **`pageSize`**나 **`currentPage`**에 문자 or 정수형 범위 이상을 입력했다면 에러페이지를 띄우는 것임
	
	@ExceptionHandler(org.springframework.validation.BindException.class)
	public String error(Exception e) {
	    return "error";
	}
	
	///////////////////////////////////////////
	public ModelAndView mailpaginglist(ModelAndView mav,Pagination pagination, String listType) {
		Map<String, Object> paraMap = new HashMap<>();
//		 String FK_Recipient_address = loginuser 에서 가져올거임임임임임임임임임임임임임임임임임임임임임임임임임임임임임임임임임임임임
		 String mail_address = "kjsaj0525@groovy.com";

		 paraMap.put("mail_address", mail_address);
		 paraMap.put("listType", listType);
		 
		 // 내 태그 가져오기
		 List<TagVO> tagList = null;
		 
		 tagList=service.getTagList(mail_address);
		 
		 
		 for(TagVO tag :tagList ) {
		 	System.out.println("getTag_color:"+tag.getTag_color());
			System.out.println("getMail_no_list:"+tag.getMail_no_list());
	
		 }
		 

		 
		 List<MailVO> mailList = null;
		 
		 String searchType = pagination.getSearchType(); 
		 String searchWord = pagination.getSearchWord();
		 System.out.println(searchType);
		 System.out.println(searchWord);
		 // 둘다 없다면 "" 처리
		 if(searchType == null || (!"subject".equals(searchType) && !"FK_Sender_address".equals(searchType)) ) {
			searchType = "";
		 }
		
		 if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
		 	searchWord = "";
		 }
		 paraMap.put("searchType",searchType);
		 paraMap.put("searchWord",searchWord);	
		 

		 
		 // 총 게시물 건수(totalCount)
		 int listCnt  = service.getTotalCount(paraMap);
		 
		 Map<String, Object> resultMap = pagination.getPageRange(listCnt );
		 
		 
		 paraMap.put("startRno",resultMap.get("startRno"));
		 paraMap.put("endRno",(resultMap.get("endRno")));
		 

		
		 
		 mailList = service.mailListSearchWithPaging(paraMap);
		 // 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
		 

		
		// 아래의 것은 검색대상 컬럼과 검색어를 뷰단 페이지에서 유지시키기 위한 것임.
		 if( !"".equals(searchType) && !"".equals(searchWord) ) {
			 mav.addObject("paraMap", paraMap);
		 }
		 
		mav.addObject("pagebar", pagination.getPagebar("/groovy/getBoardList.on"));
	

		System.out.println(mailList);
		mav.addObject("mailList", mailList);
		mav.addObject("tagList", tagList);
		/*
		for(MailVO mail :mailList ) {
			System.out.println("sendTime:"+mail.getSend_time());
	
			System.out.println("send_time_date"+mail.getSend_time_date());
		}
		*/
		return mav;

	}

}
