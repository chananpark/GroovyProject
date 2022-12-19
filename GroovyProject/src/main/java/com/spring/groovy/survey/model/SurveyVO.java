package com.spring.groovy.survey.model;

public class SurveyVO {

	private String  surno;		    // 설문번호
	private String fk_empno;	    // 사원번호
	private String surtitle;  		// 설문제목
	private String surexplain;    	// 설문설명
	private String surcreatedate;   // 설문생성일  sysdate
	private String surstart; 	    // 설문시작일
	private String surend;	 		// 설문종료일
	private String surstatus;       // 상태(0 임시저장, 1 저장)  default 1
	private String suropenstatus;   // 설문결과공개여부(0비공개, 1공개)  default 1
	private String fk_surtarget;	// 설문대상(1전직원, 0직접선택)
	
	private String fk_department_no; // 조인
	private String surjoindate;      // 조인(JoinSurveyVO)
	
	private String surtarget; 		// 조인(targetvo)
	
	
	public String getSurno() {
		return surno;
	}
	public void setSurno(String surno) {
		this.surno = surno;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getSurtitle() {
		return surtitle;
	}
	public void setSurtitle(String surtitle) {
		this.surtitle = surtitle;
	}
	public String getSurexplain() {
		return surexplain;
	}
	public void setSurexplain(String surexplain) {
		this.surexplain = surexplain;
	}
	public String getSurcreatedate() {
		return surcreatedate;
	}
	public void setSurcreatedate(String surcreatedate) {
		this.surcreatedate = surcreatedate;
	}
	public String getSurstart() {
		return surstart;
	}
	public void setSurstart(String surstart) {
		this.surstart = surstart;
	}
	public String getSurend() {
		return surend;
	}
	public void setSurend(String surend) {
		this.surend = surend;
	}
	public String getSurstatus() {
		return surstatus;
	}
	public void setSurstatus(String surstatus) {
		this.surstatus = surstatus;
	}
	public String getSuropenstatus() {
		return suropenstatus;
	}
	public void setSuropenstatus(String suropenstatus) {
		this.suropenstatus = suropenstatus;
	}
	public String getFk_surtarget() {
		return fk_surtarget;
	}
	public void setFk_surtarget(String fk_surtarget) {
		this.fk_surtarget = fk_surtarget;
	}
	
	
	public String getFk_department_no() {
		return fk_department_no;
	}
	public void setFk_department_no(String fk_department_no) {
		this.fk_department_no = fk_department_no;
	}
	public String getSurjoindate() {
		return surjoindate;
	}
	public void setSurjoindate(String surjoindate) {
		this.surjoindate = surjoindate;
	}
	public String getSurtarget() {
		return surtarget;
	}
	public void setSurtarget(String surtarget) {
		this.surtarget = surtarget;
	}
	
	
	
}
