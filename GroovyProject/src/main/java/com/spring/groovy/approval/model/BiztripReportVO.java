package com.spring.groovy.approval.model;

public class BiztripReportVO {
	
	private int biztrip_report_no; // 출장 보고 번호(기본키)
	private String fk_draft_no; // 기안 문서 번호(외래키)
	private String trip_purpose; // 출장 목적
	private String trip_start_date; // 출장 시작일
	private String trip_end_date; // 출장 종료일
	private String trip_location; // 출장 지역
	
	public int getBiztrip_report_no() {
		return biztrip_report_no;
	}
	public void setBiztrip_report_no(int biztrip_report_no) {
		this.biztrip_report_no = biztrip_report_no;
	}
	public String getFk_draft_no() {
		return fk_draft_no;
	}
	public void setFk_draft_no(String fk_draft_no) {
		this.fk_draft_no = fk_draft_no;
	}
	public String getTrip_purpose() {
		return trip_purpose;
	}
	public void setTrip_purpose(String trip_purpose) {
		this.trip_purpose = trip_purpose;
	}
	public String getTrip_start_date() {
		return trip_start_date;
	}
	public void setTrip_start_date(String trip_start_date) {
		this.trip_start_date = trip_start_date;
	}
	public String getTrip_end_date() {
		return trip_end_date;
	}
	public void setTrip_end_date(String trip_end_date) {
		this.trip_end_date = trip_end_date;
	}
	public String getTrip_location() {
		return trip_location;
	}
	public void setTrip_location(String trip_location) {
		this.trip_location = trip_location;
	}
	
	

}
