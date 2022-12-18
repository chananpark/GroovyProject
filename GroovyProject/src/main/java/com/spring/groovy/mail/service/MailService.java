package com.spring.groovy.mail.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.chatting.websockethandler.MessageVO;
import com.spring.groovy.mail.model.InterMailDAO;
import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.mail.model.TagVO;
import com.spring.groovy.management.model.MemberVO;

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
			System.out.println("nnn"+n);
			if(n!=1) {
				return n;
			}
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
			if(n==0) {
				return 0;
			}
		}
		return mail_no_List.size();
	}
	// 태그 추가
	@Override
	public int tagAdd(Map<String, String> paraMap) {
		
		List<String> fk_mail_no_List = commaArray(paraMap.get("fk_mail_no_List"));		
		for(String fk_mail_no : fk_mail_no_List) {
			paraMap.put("fk_mail_no",fk_mail_no);
			int n = dao.tagAdd(paraMap);
			if(n==0) {
				return 0;
			}
		}
		return fk_mail_no_List.size();
	}
	// 태그 삭제
	@Override
	public int tagDelete(Map<String, String> paraMap) {

		int n = dao.tagDelete(paraMap);
		return n;
	}
	
	// 읽음처리
	@Override
	public int read(Map<String, String> paraMap) {
		
		List<String> mailno_List = commaArray(paraMap.get("mailno_List"));		
		for(String mail_no : mailno_List) {
			paraMap.put("mailNo",mail_no);
			System.out.println("mail_no"+mail_no);
			dao.readMail(paraMap);
		}
		return mailno_List.size();
	}
	
	@Override
	public List<String> getreplyList(String getfK_recipient_address) {
		List<String> cpemail_List = commaArray(getfK_recipient_address);		
		List<String> replyList = new ArrayList<String>();
		for(String cpemail : cpemail_List) {
			String reply = dao.getreply(cpemail);
			replyList.add(reply);
		}
		
		return replyList;
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int goAddChatroom(Map<String, String> paraMap) {
		List<String> recipient_address_List = commaArray(paraMap.get("recipient_address"));	
		
		// 채번부터
		String room_no = dao.getSeqChatNo();
		paraMap.put("room_no", room_no);
		// 채번한 번호와 제목으로 방 생성
		int n = dao.addChatroom(paraMap);
		int i = 0;
		int m = 0;
		if(n==1) {
			
			for(String cpemail : recipient_address_List) {
				// 각 이메일로 사원번호 알아와서 채팅방에 사원번호 추가
				System.out.println("cpemail"+cpemail);
				String empNo = dao.getEmpno(cpemail);
				paraMap.put("empNo", empNo); // 사원번호 자리는 계속 새값을 넣어줌
				m = dao.addChatMember(paraMap);
				i += m;
			}
			
		}
		return i;
	}
	
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int goChangeChatroom(Map<String, String> paraMap) {
		
		List<String> recipient_address_List = commaArray(paraMap.get("recipient_address"));	
		
			// 방번호로 검색해서 멤버리스트 가져옴
			// for 문 돌려서 있으면 놔두고 없으면 추가

			int success = 1;
			for(String cpemail : recipient_address_List) {
				String empNo = dao.getEmpno(cpemail);
				paraMap.put("empNo", empNo);
				int m = dao.addChatMember(paraMap);
				if(m!=1) {
					success = 0;
					System.out.println("엥");
				}
			}
			
			int n = dao.updateChatroom(paraMap);
			
			if(n!=1) {
				success = 0;
				System.out.println("엥엥엥");
			}

		
			// success 가 0이면 사고난거
			return success;
	}
	
	@Override
	public List<Map<String, String>> getChatroomList(String empno) {
		List<Map<String, String>> chatroomList = dao.getChatroomList(empno);
		return chatroomList;
	}
	
	@Override
	public int addMessage(MessageVO MessageVO) {
		int n = dao.addMessage(MessageVO);
		return n;
	}
	
	@Override
	public List<MessageVO> getMessageList(String no) {
		 List<MessageVO> messageList = dao.getMessageList(no);
		return messageList;
	}
	
	@Override
	public int orgImportantCheck(Map<String, String> paraMap) {

		List<String> emp_no_List = commaArray(paraMap.get("emp_no"));
		
		for(String no : emp_no_List) {
			paraMap.put("no",no);
			int n = dao.orgImportantUpdate(paraMap);
			if(n!=1) {
				return n;
			}
		}
		

		return emp_no_List.size();
	}

	
	@Override
	public List<String> getMember(String roomNo) {
		List<String> memberList = dao.getMember(roomNo);
		return memberList;
	}

	// 채팅방 나가기
	@Override
	public int deleteMember(Map<String, String> paraMap) {
		int n = dao.deleteMember(paraMap);
		return n;
	}

	
	
	
	// , 로 구분되는 문자열 ArrayList<String> 로 반환
	public List<String> commaArray(String str){
		List<String> resultList = new ArrayList<String>();
		
		if(!str.trim().isEmpty()) {
			resultList = new ArrayList<String>(Arrays.asList(str.split(","))); 
		}
		return resultList;
	}

	@Override
	public List<String> getTotalCountTag(Map<String, Object> paraMap) {
		List<String> TagMailList = dao.getTotalCountTag(paraMap);
		return TagMailList;
	}

	@Override
	public String getPwd(String mail_no) {
		String pwd = dao.getPwd(mail_no);
		return pwd;
	}





	

	
	

	

	


	

}
