package com.spring.groovy.mail.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class TagVO {
	private String tag_no;
	private String fK_mail_address;    // 태그 지정자 이메일
	private String tag_color;         // 태그 색
	private String tag_name;      // 참조메일주소
	private String fk_mail_no;      // 메일제목 


	

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




	

	
	public String getTag_no() {
		return tag_no;
	}

	public void setTag_no(String tag_no) {
		this.tag_no = tag_no;
	}

	public String getFk_mail_no() {
		return fk_mail_no;
	}

	public void setFk_mail_no(String fk_mail_no) {
		this.fk_mail_no = fk_mail_no;
	}
	
	public List<String> getMail_no_list() {
		List<String> resultList = commaArray(fk_mail_no);
	
		return resultList;

	}

	public List<String> commaArray(String str){
		List<String> resultList = new ArrayList<String>();
		
		if(!str.trim().isEmpty()) {
			resultList = new ArrayList<String>(Arrays.asList(str.split(","))); 
		}
		return resultList;
	}
	

	
}