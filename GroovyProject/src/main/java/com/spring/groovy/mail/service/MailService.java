package com.spring.groovy.mail.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.mail.model.InterMailDAO;
import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.mail.model.TagVO;

@Service
public class MailService implements InterMailService {

	@Autowired     // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterMailDAO dao;
	
	@Override
	public int getTotalCount(Map<String, Object> paraMap) {
		int totalCount = dao.getTotalCount(paraMap);
		return totalCount;
	}

	@Override
	public List<MailVO> mailListSearchWithPaging(Map<String, Object> paraMap) {
		List<MailVO> mailList = null;
		
		mailList = dao.mailListSearchWithPaging(paraMap);
		return mailList;
	}

	@Override
	public List<TagVO> getTagList(String mail_address) {
		List<TagVO> tagList = dao.getTagList(mail_address);
		return tagList;
	}

	@Override
	public int addMail(Map<String, Object> paraMap) {
		int n = dao.addMail(paraMap);
		return n;
	}

	@Override
	public MailVO getOneMail(String mail_no) {
		MailVO mail = dao.getOneMail(mail_no);
		return mail;
	}

	@Override
	public List<String> getMailList() {

		List<String> mailList = dao.getMailList();
		return mailList;
	}

	@Override
	public List<TagVO> getTagListByMailNo(Map<String, String> paraMap) {
		List<TagVO> tagList = dao.getTagListByMailNo(paraMap);
		if(paraMap.get("mailNo") != null) {
			dao.readMail(paraMap);
		}
		
		return tagList;
	}

}
