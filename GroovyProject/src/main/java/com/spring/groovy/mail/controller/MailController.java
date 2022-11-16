package com.spring.groovy.mail.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MailController {

	@RequestMapping(value = "/mail/receiveMailBox.on")
	public String receiveMailBox(HttpServletRequest request) {

		return "mail/mailbox/receieve_mailbox.tiles";
		// ==> views/tiles/mail/content/mailBox/receieve_mailbox.jsp
	}
	
	@RequestMapping(value = "/mail/sendMailBox.on")
	public String sendMailBox(HttpServletRequest request) {

		return "mail/mailbox/send_mailbox.tiles";
		// ==> views/tiles/mail/content/mailBox/send_mailbox.jsp
	}
	
	@RequestMapping(value = "/mail/importantMailBox.on")
	public String importantMailBox(HttpServletRequest request) {

		return "mail/mailbox/important_mailbox.tiles";
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

}
