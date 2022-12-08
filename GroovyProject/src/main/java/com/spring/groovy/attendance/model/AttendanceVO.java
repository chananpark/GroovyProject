package com.spring.groovy.attendance.model;

public class AttendanceVO {
	
	private String fk_empno;    // 사원번호
	private String workdate;         // 날짜
	private String workstart;         // 날짜
	private String workend;      // 퇴근시간
	private String trip;         // 출장여부
	private String tripstart;    // 출장시작 (ex. 2022-10-10 11:00)
	private String tripend;      // 출장종료 (ex. 2022-10-10 11:00)
	private String dayoff;       // 연차여부
	private String extendstart;  // 연장근무시작시간
	
	////////////////////////////////////////////////////////////////////
	
	private String triptime;    // 출장소요시간
	private String worktime;    // 일일 근무시간 합
	
	////////////////////////////////////////////////////////////////////
	
	public AttendanceVO() {}
	
	

	public AttendanceVO(String fk_empno, String workdate, String workend, String trip, String tripstart, String tripend,
			String dayoff, String extendstart, String triptime) {
		super();
		this.fk_empno = fk_empno;
		this.workdate = workdate;
		this.workend = workend;
		this.trip = trip;
		this.tripstart = tripstart;
		this.tripend = tripend;
		this.dayoff = dayoff;
		this.extendstart = extendstart;
		this.triptime = triptime;
	}











	////////////////////////////////////////////////////////////////////
	
	
	public String getFk_empno() {
		return fk_empno;
	}



	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}



	public String getWorkdate() {
		return workdate;
	}



	public void setWorkdate(String workdate) {
		this.workdate = workdate;
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




	////////////////////////////////////////////////////////////////////
	


	public String getTriptime() {
		return triptime;
	}





	public void setTriptime(String triptime) {
		this.triptime = triptime;
	}



	public String getWorktime() {
		return worktime;
	}



	public void setWorktime(String worktime) {
		this.worktime = worktime;
	}



	public String getWorkstart() {
		return workstart;
	}



	public void setWorkstart(String workstart) {
		this.workstart = workstart;
	}


}
