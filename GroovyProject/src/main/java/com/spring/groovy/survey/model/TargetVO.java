package com.spring.groovy.survey.model;

public class TargetVO {

	
	private String surtarget;   // 설문대상(1전직원, 0직접선택) default 1 
	private String fk_surno;   // 설문번호
	
	
	
	public String getSurtarget() {
		return surtarget;
	}
	public void setSurtarget(String surtarget) {
		this.surtarget = surtarget;
	}
	public String getFk_surno() {
		return fk_surno;
	}
	public void setFk_surno(String fk_surno) {
		this.fk_surno = fk_surno;
	}
	
	
	
	
}
