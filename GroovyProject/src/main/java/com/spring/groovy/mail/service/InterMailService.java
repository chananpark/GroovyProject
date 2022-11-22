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

}
