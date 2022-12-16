package com.spring.groovy.mail.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.chatting.websockethandler.MessageVO;

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
	
	// =================== 메일 추가 ========================= //
	@Override
	public int getSeqMailNo() {
		int n = sqlsession.selectOne("jinseok.getSeqMailNo");
		return n;
	}
	@Override
	public int addMail(Map<String, Object> paraMap) {
		int n = sqlsession.insert("jinseok.addMail",paraMap);
		return n;
	}
	@Override
	public int addMailRecipient(Map<String, Object> paraMap) {
		List<String> resultList = new ArrayList<String>();
		int n = 0;
		String FK_Recipient_address= (String)paraMap.get("FK_Recipient_address");
		if(!FK_Recipient_address.trim().isEmpty()) {
			resultList = new ArrayList<String>(Arrays.asList(FK_Recipient_address.split(","))); 
		}
		for(String address: resultList) {
			paraMap.put("addressType", "FK_Recipient_address_individual");
			paraMap.put("address", address);
			n = sqlsession.insert("jinseok.addMailRecipient",paraMap);
		}
		
		return n;
	}
	// =================== 메일 추가끝 ========================= //

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

	@Override
	public List<TagVO> getTagListSide(String mail_address) {
		List<TagVO> tagList = sqlsession.selectList("jinseok.getTagListSide",mail_address);
		return tagList;
	}

	/** 중요 체크 or 해제 전 확인 */
	@Override
	public int importantCheck(String mail_recipient_no) {
		int n = sqlsession.selectOne("jinseok.importantCheck",mail_recipient_no);
		return n;
	}
	/** 중요 체크 or 해제 전 확인 */
	@Override
	public int importantUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("jinseok.importantUpdate",paraMap);
		return n;
	}

	/** 중요 체크 or 해제 전 확인 */
	@Override
	public int importantCheckM(String mail_no) {
		int n = sqlsession.selectOne("jinseok.importantCheckM",mail_no);
		return n;
	}
	/** 중요 체크 or 해제 전 확인 */
	@Override
	public int importantUpdateM(Map<String, String> paraMap) {
		int n = sqlsession.update("jinseok.importantUpdateM",paraMap);
		return n;
	}

	@Override
	public int deleteUpdate(String mail_recipient_no) {
		int n = sqlsession.update("jinseok.deleteUpdate",mail_recipient_no);
		return n;
	}
	
	@Override
	public int deleteUpdateM(String mail_no) {
		int n = sqlsession.update("jinseok.deleteUpdateM",mail_no);
		return n;
	}

	

	@Override
	public int tagCheckM(Map<String, String> paraMap) {
		int n = sqlsession.update("jinseok.tagCheckM",paraMap);
		return n;
	}

	/** 답장시 완성되는 이메일 값 만들어서 반환 */
	@Override
	public String getreply(String cpemail) {
		String reply = sqlsession.selectOne("jinseok.getreply",cpemail);
		return reply;
	}

	@Override
	public String getSeqChatNo() {
		String no = sqlsession.selectOne("jinseok.getSeqChatNo");
		return no;
	}

	@Override
	public int addChatroom(Map<String, String> paraMap) {
		int n = sqlsession.insert("jinseok.addChatroom",paraMap);
		return n;
	}

	@Override
	public String getEmpno(String cpemail) {
		String n = sqlsession.selectOne("jinseok.getEmpno",cpemail);
		return n;
	}

	@Override
	public int addChatMember(Map<String, String> paraMap) {
		int n = sqlsession.insert("jinseok.addChatMember",paraMap);
		return n;
	}

	@Override
	public List<Map<String, String>> getChatroomList(String empno) {
		List<Map<String, String>> chatroomList = sqlsession.selectList("jinseok.getChatroomList",empno);
		return chatroomList;
	}

	@Override
	public int addMessage(MessageVO messageVO) {
		int n = sqlsession.insert("jinseok.addMessage",messageVO);
		return n;
	}

	@Override
	public List<MessageVO> getMessageList(String no) {
		List<MessageVO> messageList = sqlsession.selectList("jinseok.getMessageList",no);
		return messageList;
	}

	@Override
	public int orgImportantUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("jinseok.orgImportantUpdate", paraMap);
		return n;
	}

	@Override
	public List<String> getMember(String roomNo) {
		List<String> messageList = sqlsession.selectList("jinseok.getMember",roomNo);
		return messageList;
	}
	// 멤버 지우기
	@Override
	public int deleteMember(Map<String, String> paraMap) {
		int n = sqlsession.delete("jinseok.deleteMember",paraMap);
		return n;
	}

	// 방 정보 변경하기
	@Override
	public int updateChatroom(Map<String, String> paraMap) {
		int n = sqlsession.update("jinseok.updateChatroom",paraMap);
		return n;
	}

	
	

	

	

	

}
