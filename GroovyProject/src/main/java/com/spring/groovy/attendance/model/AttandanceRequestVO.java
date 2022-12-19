package com.spring.groovy.attendance.model;

public class AttandanceRequestVO {

	private String requestid;  // 근태신청번호 attend_request_seq
	private String fk_empno;     // 사원번호
	private String attend_index;  // 근태종류
	private String starttime;     // 시작시간 (ex. 2022-10-10 11:00)
	private String endtime;       // 종료시간 (ex. 2022-10-10 11:00)
	private String place;         // 장소
	private String reason;        // 사유
	private String registerdate;  // 신청일자
	
	
	////////////////////////////////////////////////////////////////////
	
	public AttandanceRequestVO() {}
	
	public AttandanceRequestVO(String requestid, String fk_empno, String attend_index, String starttime, String endtime,
			String place, String reason, String registerdate) {
		super();
		this.requestid = requestid;
		this.fk_empno = fk_empno;
		this.attend_index = attend_index;
		this.starttime = starttime;
		this.endtime = endtime;
		this.place = place;
		this.reason = reason;
		this.registerdate = registerdate;
	}
	
	////////////////////////////////////////////////////////////////////
	



	public String getRequestid() {
		return requestid;
	}
	public void setRequestid(String requestid) {
		this.requestid = requestid;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getAttend_index() {
		return attend_index;
	}
	public void setAttend_index(String attend_index) {
		this.attend_index = attend_index;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getRegisterdate() {
		return registerdate;
	}
	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}  
	
	
	
	
}
