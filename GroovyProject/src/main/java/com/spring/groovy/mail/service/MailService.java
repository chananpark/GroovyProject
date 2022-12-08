package com.spring.groovy.mail.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addMail(Map<String, Object> paraMap) {
		int mail_no = dao.getSeqMailNo();
		paraMap.put("mail_no", mail_no);
		
		int n = dao.addMail(paraMap);
		int m=0;
		if(n == 1) {
			 m = dao.addMailRecipient(paraMap);
		}
		return m;
	}

	@Override
	public MailVO getOneMail(Map<String, String> paraMap) {
		String mail_no = paraMap.get("mailNo");
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

	@Override
	public List<TagVO> getTagListSide(String mail_address) {
		List<TagVO> tagList = dao.getTagListSide(mail_address);
		return tagList;
	}

	@Override
	public int importantCheck(String mail_recipient_no_str) {

		List<String> mail_recipient_no_List = commaArray(mail_recipient_no_str);
		
		for(String mail_recipient_no : mail_recipient_no_List) {
			int RECIPIENT_IMPORTANT =  dao.importantCheck(mail_recipient_no);
			
			Map<String, String> paraMap = new HashedMap<String, String>();
			paraMap.put("mail_recipient_no", mail_recipient_no);
			paraMap.put("RECIPIENT_IMPORTANT", String.valueOf(RECIPIENT_IMPORTANT));
			
			
			int n = dao.importantUpdate(paraMap);
		}
		

		return mail_recipient_no_List.size();
	}
	@Override
	public int importantCheckM(String mail_no_str) {
		
		List<String> mail_no_List = commaArray(mail_no_str);
		
		for(String mail_no : mail_no_List) {
			int SENDER_IMPORTANT =  dao.importantCheckM(mail_no);
			System.out.println("SENDER_IMPORTANT"+SENDER_IMPORTANT);
			
			Map<String, String> paraMap = new HashedMap<String, String>();
			paraMap.put("mail_no", mail_no);
			paraMap.put("SENDER_IMPORTANT", String.valueOf(SENDER_IMPORTANT));
			
			
			int n = dao.importantUpdateM(paraMap);
		}
		

		return mail_no_List.size();
	}

	@Override
	public int deleteCheck(String mail_recipient_no_str) {
		
		List<String> mail_recipient_no_List = commaArray(mail_recipient_no_str);		
		for(String mail_recipient_no : mail_recipient_no_List) {
			int n = dao.deleteUpdate(mail_recipient_no);
		}
		return mail_recipient_no_List.size();
	}

	@Override
	public int deleteCheckM(String mail_no_str) {
		
		List<String> mail_no_List = commaArray(mail_no_str);		
		for(String mail_no : mail_no_List) {
			int n = dao.deleteUpdateM(mail_no);
		}
		return mail_no_List.size();
	}



	@Override
	public int tagCheckM(Map<String, String> paraMap) {
		
		List<String> mail_no_List = commaArray(paraMap.get("mail_no_List"));		
		for(String mail_no : mail_no_List) {
			paraMap.put("mail_no",mail_no);
			int n = dao.tagCheckM(paraMap);
		}
		return mail_no_List.size();
	}
	
	
	
	// , 로 구분되는 문자열 ArrayList<String> 로 반환
	public List<String> commaArray(String str){
		List<String> resultList = new ArrayList<String>();
		
		if(!str.trim().isEmpty()) {
			resultList = new ArrayList<String>(Arrays.asList(str.split(","))); 
		}
		return resultList;
	}
	

}
