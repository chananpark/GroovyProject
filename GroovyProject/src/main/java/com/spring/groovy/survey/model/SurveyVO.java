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
	
	
	
	
	
	
	
	
}
