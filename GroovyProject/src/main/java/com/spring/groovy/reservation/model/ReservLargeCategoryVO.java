package com.spring.groovy.reservation.model;

public class ReservLargeCategoryVO {

	private String lgcatgono;    		// 자원 대분류 번호
	private String lgcatgoname; 	 	// 자원 대분류 명 
	private String lgcategcontent;  	// 자원 대분류 설명
	
	public String getLgcatgono() {
		return lgcatgono;
	}
	
	public void setLgcatgono(String lgcatgono) {
		this.lgcatgono = lgcatgono;
	}
	
	public String getLgcatgoname() {
		return lgcatgoname;
	}
	
	public void setLgcatgoname(String lgcatgoname) {
		this.lgcatgoname = lgcatgoname;
	}

	public String getLgcategcontent() {
		return lgcategcontent;
	}

	public void setLgcategcontent(String lgcategcontent) {
		this.lgcategcontent = lgcategcontent;
	}
	
	
}
