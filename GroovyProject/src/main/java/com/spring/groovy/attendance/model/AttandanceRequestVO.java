package com.spring.groovy.attendance.model;

public class AttandanceRequestVO {

	private String pk_requestid;  // 근태신청번호 attend_request_seq
	private String fk_userid;     // 사원번호
	private String attend_index;  // 근태종류
	private String starttime;     // 시작시간 (ex. 2022-10-10 11:00)
	private String endtime;       // 종료시간 (ex. 2022-10-10 11:00)
	private String place;         // 장소
	private String reason;        // 사유
	private String registerdate;  // 신청일자
	
	////////////////////////////////////////////////////////////////////
	
}
