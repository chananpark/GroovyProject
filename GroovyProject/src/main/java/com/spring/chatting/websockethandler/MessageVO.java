package com.spring.chatting.websockethandler;

import java.util.Date;

import com.google.gson.Gson;

// === #199. (웹채팅관련9) === //

public class MessageVO {

	private String message;
	private String type;
	private String to;
	private String no; // 방번호
	private String fk_member_no; // 보낸이 번호
	private Date send_time; // 보낸시간
	private String name; // join 용
	


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getSend_time() {
		return send_time;
	}

	public void setSend_time(Date send_time) {
		this.send_time = send_time;
	}

	public String getFk_member_no() {
		return fk_member_no;
	}

	public void setFk_member_no(String fk_member_no) {
		this.fk_member_no = fk_member_no;
	}

	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getTo() {
		return to;
	}
	
	public void setTo(String to) {
		this.to = to;
	}
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	
	////////////////////////////////////////////////////////////////
	
	public static MessageVO convertMessage(String source) {
		
		Gson gson = new Gson();
		
		MessageVO messageVO = gson.fromJson(source, MessageVO.class);
		                                 // source 는 JSON 형태로 되어진 문자열
                           // gson.fromJson(source, MessageVO.class); 은 
                           // JSON 형태로 되어진 문자열 source를 실제 MessageVO 객체로 변환해준다.
		return messageVO;
	}
	
	
	
	
}
