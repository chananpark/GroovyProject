package com.spring.groovy.mail.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class TagVO {
	
	private String fK_mail_address;    // 태그 지정자 이메일
	private String tag_color;         // 태그 색
	private String tag_name;      // 참조메일주소
	private String mail_no;      // 메일제목 

	private List<String> mail_no_list; // 비교용 날짜
	
	

	public String getfK_mail_address() {
		return fK_mail_address;
	}

	public void setfK_mail_address(String fK_mail_address) {
		this.fK_mail_address = fK_mail_address;
	}

	public String getTag_color() {
		return tag_color;
	}

	public void setTag_color(String tag_color) {
		this.tag_color = tag_color;
	}

	public String getTag_name() {
		return tag_name;
	}

	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}

	public String getMail_no() {
		return mail_no;
	}

	public void setMail_no(String mail_no) {
		this.mail_no = mail_no;
	}

	public List<String> getMail_no_list() {
		List<String> resultList = new ArrayList<String>();
				
			if(mail_no.trim().isEmpty()) {
				return resultList;
			}
			else {
				resultList = new ArrayList<String>(Arrays.asList(mail_no.split(","))); 
				 
				return resultList;
			}
	}
	
	// 지정 못하게 막음
	private void setMail_no_list(List<String> mail_no_list) {
		this.mail_no_list = mail_no_list;
	}
	

	
}