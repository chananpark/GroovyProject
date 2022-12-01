package com.spring.groovy.mail.model;

import java.util.List;
import java.util.Map;

public interface InterMailDAO {

	/** 특정 유저의 받은메일 총 갯수를 알아오는 식*/
	int getTotalCount(Map<String, Object> paraMap);

	/** 페이징한 메일 정보만 가져오기 */
	List<MailVO> mailListSearchWithPaging(Map<String, Object> paraMap);

	/** 로그인한 유저의 메일 주소를 넣어 그 유저의 태그를 가져오기 */
	List<TagVO> getTagList(String mail_address);

	/** 메일 추가하기 */
	int getSeqMailNo();
	int addMail(Map<String, Object> paraMap);
	int addMailRecipient(Map<String, Object> paraMap);

	/** 메일 하나 불러오기 */
	MailVO getOneMail(String mailNo);

	/** 메일리스트(자동완성용) 가져오기 */
	List<String> getMailList();

	/** 메일번호에 맞는 태그 정보를 가져오기 */
	List<TagVO> getTagListByMailNo(Map<String, String> paraMap);

	/** 읽음 처리 */
	void readMail(Map<String, String> paraMap);

	/** 사이드 전용 태그리스트 가져오기 */
	List<TagVO> getTagListSide(String mail_address);

	
	/** 중요 체크 or 해제 전 상태 확인 */
	int importantCheck(String mail_recipient_no);
	/** 중요 체크 업데이트 */
	int importantUpdate(Map<String, String> paraMap);

	/** 중요 체크 or 해제 전 상태 확인 by mail_no*/
	int importantCheckM(String mail_no);
	/** 중요 체크 업데이트 by mail_no*/
	int importantUpdateM(Map<String, String> paraMap);

	/** 삭제 by mail_recipient_no*/
	int deleteUpdate(String mail_recipient_no);
	/** 삭제 by mail_no*/
	int deleteUpdateM(String mail_no);

	/** 태그 by mail_no*/
	int tagCheckM(Map<String, String> paraMap);

	

	

	

	

}
