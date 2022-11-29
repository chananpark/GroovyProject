package com.spring.groovy.mail.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MailDAO implements InterMailDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	@Override
	public int getTotalCount(Map<String, Object> paraMap) {
		int n = sqlsession.selectOne("jinseok.getTotalCount", paraMap);
		return n;
	}

	@Override
	public List<MailVO> mailListSearchWithPaging(Map<String, Object> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("jinseok.mailListSearchWithPaging", paraMap);
		return mailList;
	}

	@Override
	public List<TagVO> getTagList(String mail_address) {
		List<TagVO> tagList = sqlsession.selectList("jinseok.getTagList", mail_address);
		return tagList;
	}

	@Override
	public int addMail(Map<String, Object> paraMap) {
		int n = sqlsession.insert("jinseok.addMail",paraMap);
		return n;
	}

	@Override
	public MailVO getOneMail(String mailNo) {
		System.out.println(mailNo);
		MailVO mail = sqlsession.selectOne("jinseok.getOneMail",mailNo);
		return mail;
	}

	@Override
	public List<String> getMailList() {
		List<String> mailList = sqlsession.selectList("jinseok.getMailList");
		return mailList;
	}

	@Override
	public List<TagVO> getTagListByMailNo(Map<String, String> paraMap) {
		List<TagVO> tagList = sqlsession.selectList("jinseok.getTagListByMailNo",paraMap);
		return tagList;
	}

	@Override
	public void readMail(Map<String, String> paraMap) {
		
		sqlsession.update("jinseok.readMail",paraMap);
		
	}

}
