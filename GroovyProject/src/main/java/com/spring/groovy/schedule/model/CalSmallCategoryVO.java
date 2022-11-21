package com.spring.groovy.schedule.model;

public class CalSmallCategoryVO {

	private String smcatgono;     // 캘린더 소분류 번호
	private String fk_lgcatgono;  // 캘린더 대분류 번호
	private String smcatgoname;   // 캘린더 소분류 명
	private String fk_empno;     // 캘린더 소분류 작성자 유저아이디
	
	public String getSmcatgono() {
		return smcatgono;
	}
	
	public void setSmcatgono(String smcatgono) {
		this.smcatgono = smcatgono;
	}
	
	public String getFk_lgcatgono() {
		return fk_lgcatgono;
	}
	
	public void setFk_lgcatgono(String fk_lgcatgono) {
		this.fk_lgcatgono = fk_lgcatgono;
	}
	
	public String getSmcatgoname() {
		return smcatgoname;
	}
	
	public void setSmcatgoname(String smcatgoname) {
		this.smcatgoname = smcatgoname;
	}
	
	public String getFk_empno() {
		return fk_empno;
	}
	
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	
}
