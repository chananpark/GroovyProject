package com.spring.groovy.mail.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.mail.model.TagVO;

public interface InterMailService {
	/** 특정 유저의 받은메일 총 갯수를 알아오는 식*/
	int getTotalCount(Map<String, Object> paraMap);

	/** 페이징한 메일 정보만 가져오기 */
	List<MailVO> mailListSearchWithPaging(Map<String, Object> paraMap);

	/** 로그인한 유저의 메일 주소를 넣어 그 유저의 태그를 가져오기 */
	List<TagVO> getTagList(String mail_address);

	/** 메일 추가하기 */
	int addMail(Map<String, Object> paraMap);

	/** 메일 하나 불러오기 */
	MailVO getOneMail(String mail_no);

	/** 메일리스트(자동완성용) 가져오기 */
	List<String> getMailList();

	/** 메일번호에 맞는 태그 정보를 가져오기 */
	List<TagVO> getTagListByMailNo(Map<String, String> paraMap);

}
