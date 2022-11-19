package com.spring.groovy.attendance.model;

public class AttendanceVO {
	
	private String fk_empno;    // 사원번호
	private String usedate;         // 날짜
	private String workend;      // 퇴근시간
	private String trip;         // 출장여부
	private String tripstart;    // 출장시작 (ex. 2022-10-10 11:00)
	private String tripend;      // 출장종료 (ex. 2022-10-10 11:00)
	private String dayoff;       // 연차여부
	private String extendstart;  // 연장근무시작시간
	
	
	
	////////////////////////////////////////////////////////////////////
	
	public AttendanceVO() {}
	
	
	
	public AttendanceVO(String fk_empno, String usedate, String workend, String trip, String tripstart, String tripend,
			String dayoff, String extendstart) {
		super();
		this.fk_empno = fk_empno;
		this.usedate = usedate;
		this.workend = workend;
		this.trip = trip;
		this.tripstart = tripstart;
		this.tripend = tripend;
		this.dayoff = dayoff;
		this.extendstart = extendstart;
	}



	////////////////////////////////////////////////////////////////////
	
	
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getUsedate() {
		return usedate;
	}
	public void setUsedate(String usedate) {
		this.usedate = usedate;
	}
	public String getWorkend() {
		return workend;
	}
	public void setWorkend(String workend) {
		this.workend = workend;
	}
	public String getTrip() {
		return trip;
	}
	public void setTrip(String trip) {
		this.trip = trip;
	}
	public String getTripstart() {
		return tripstart;
	}
	public void setTripstart(String tripstart) {
		this.tripstart = tripstart;
	}
	public String getTripend() {
		return tripend;
	}
	public void setTripend(String tripend) {
		this.tripend = tripend;
	}
	public String getDayoff() {
		return dayoff;
	}
	public void setDayoff(String dayoff) {
		this.dayoff = dayoff;
	}
	public String getExtendstart() {
		return extendstart;
	}
	public void setExtendstart(String extendstart) {
		this.extendstart = extendstart;
	}
	
	

}
