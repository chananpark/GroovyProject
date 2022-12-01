package com.spring.groovy.mail.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class MailVO {
	

	private String mail_no;          // 메일번호 
	private String fK_sender_address;    // 발신자메일주소
	private String fK_recipient_address;         // 수신자메일주소
	private String fK_referenced_address; 
	private String subject;      // 메일제목 
	private String contents;           // 메일내용
	private String send_time;    // 발신시간
	
	private String sender_delete;       // 보낸 쪽에서 보낸메일함에서 안보이도록 지울때
	
	private String sender_important;       // 중요표시(보낸이) check 0 안중요 1 중요
	
	private String filename;       // WAS(톰캣)에 저장될 파일명(2022103109271535243254235235234.png)   
	private String orgfilename;       // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
	private String filesize;       // 파일크기
	private String mail_pwd;       // 메일암호
	
	// ==== 조인 ====
	private String mail_recipient_no;  
	private String fK_recipient_address_individual;  
	private String fK_referenced_address_individual;      // 참조메일주소
	private String read_check;      // 읽음여부
	private String recipient_delete;       // 받은 쪽에서 받은메일함에서 안보이게 지울때
	private String recipient_important;       // 중요표시(받는이) check 0 안중요 1 중요
	



	private Date send_time_date; // 비교용 날짜
	
	
	
	


	public String getMail_recipient_no() {
		return mail_recipient_no;
	}
	public void setMail_recipient_no(String mail_recipient_no) {
		this.mail_recipient_no = mail_recipient_no;
	}
	public String getfK_recipient_address_individual() {
		return fK_recipient_address_individual;
	}
	public void setfK_recipient_address_individual(String fK_recipient_address_individual) {
		this.fK_recipient_address_individual = fK_recipient_address_individual;
	}
	public String getfK_referenced_address_individual() {
		return fK_referenced_address_individual;
	}
	public void setfK_referenced_address_individual(String fK_referenced_address_individual) {
		this.fK_referenced_address_individual = fK_referenced_address_individual;
	}
	public void setSend_time_date(Date send_time_date) {
		this.send_time_date = send_time_date;
	}
	public String getMail_no() {
		return mail_no;
	}
	public void setMail_no(String mail_no) {
		this.mail_no = mail_no;
	}
	public String getfK_sender_address() {
		return fK_sender_address;
	}
	public void setfK_sender_address(String fK_sender_address) {
		this.fK_sender_address = fK_sender_address;
	}
	public String getfK_recipient_address() {
		return fK_recipient_address;
	}
	public void setfK_recipient_address(String fK_recipient_address) {
		this.fK_recipient_address = fK_recipient_address;
	}
	public String getfK_referenced_address() {
		return fK_referenced_address;
	}
	public void setfK_referenced_address(String fK_referenced_address) {
		this.fK_referenced_address = fK_referenced_address;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getSend_time() {
		return send_time;
	}
	public void setSend_time(String send_time) {

		this.send_time = send_time;
	}
	public String getRead_check() {
		return read_check;
	}
	public void setRead_check(String read_check) {
		this.read_check = read_check;
	}
	public String getSender_delete() {
		return sender_delete;
	}
	public void setSender_delete(String sender_delete) {
		this.sender_delete = sender_delete;
	}
	public String getRecipient_delete() {
		return recipient_delete;
	}
	public void setRecipient_delete(String recipient_delete) {
		this.recipient_delete = recipient_delete;
	}
	public String getSender_important() {
		return sender_important;
	}
	public void setSender_important(String sender_important) {
		this.sender_important = sender_important;
	}
	public String getRecipient_important() {
		return recipient_important;
	}
	public void setRecipient_important(String recipient_important) {
		this.recipient_important = recipient_important;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOrgfilename() {
		return orgfilename;
	}
	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	public String getMail_pwd() {
		return mail_pwd;
	}
	public void setMail_pwd(String mail_pwd) {
		this.mail_pwd = mail_pwd;
	}

	
	public Date getSend_time_date() throws ParseException {
		

		// 포맷터
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date send_time_date;
        //System.out.println("send_time"+send_time);
        
        send_time_date = formatter.parse(send_time);
        //System.out.println("send_time_date"+send_time_date);
        // 문자열 -> Date
        this.send_time_date = send_time_date;
        return send_time_date;
	}
	

	
	public List<String> getFK_recipient_address_array	() {

		List<String> resultList = commaArray(fK_recipient_address);
		
		return resultList;
	 }

	
	public List<String> getFK_referenced_address_array	() {

		List<String> resultList = commaArray(fK_referenced_address);
		
		return resultList;
	 }
	
	public List<String> getFilename_array	() {

		List<String> resultList = commaArray(filename);
		
		return resultList;
	 }
	public List<String> getOrgfilename_array	() {

		List<String> resultList = commaArray(orgfilename);
		
		return resultList;
	 }
	public List<String> getFilesize_array	() {

		List<String> resultList = commaArray(filesize);
		
		return resultList;
	 }
	
	
	public int getUserindex(String cpemail) {
		
		List<String> resultList = commaArray(fK_recipient_address);
		
		int n = 0;
		for(int i=0; i<resultList.size() ;i++) {
			if(cpemail == resultList.get(i)) {
				n = i;
				break;
			}
		}
		return n;
	}
	

	
	public List<String> commaArray(String str){
		List<String> resultList = new ArrayList<String>();
		
		if(!str.trim().isEmpty()) {
			resultList = new ArrayList<String>(Arrays.asList(str.split(","))); 
		}
		return resultList;
	}
	
	
	// 원래는 중간에 값 바꿔서 배출하는 용돈데 테이블 변경으로 폐기
	/*
	public String changeArr(List<String> arr, int index, String val){
		StringBuilder sb =new StringBuilder();
		for(int i=0 ; i<arr.size(); i++ ) {
			if(i == index) {
				sb.append(val);
			}
			else {
				sb.append(arr.get(i));
			}
			sb.append(",");
		}
		String result = sb.toString();
		if (result.endsWith(",")) {
            return result.substring(0, result.length() - 1);
        }
		return result;
	}
	*/
	
	
	
	
}