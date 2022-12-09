package com.spring.groovy.survey.model;

public class JoinSurveyVO {

	
	
	private String joinsurno;       //설문참여번호
	private String fk_empno;		// 사원번호
	private String fk_surno;		// 설문번호
	private String fk_questno;	    // 문항번호
	private String answer;		    // 답변
	private String sursubdate;      // 답변제출일 sysdate
	
	
	
	public String getJoinsurno() {
		return joinsurno;
	}
	public void setJoinsurno(String joinsurno) {
		this.joinsurno = joinsurno;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getFk_surno() {
		return fk_surno;
	}
	public void setFk_surno(String fk_surno) {
		this.fk_surno = fk_surno;
	}
	public String getFk_questno() {
		return fk_questno;
	}
	public void setFk_questno(String fk_questno) {
		this.fk_questno = fk_questno;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getSursubdate() {
		return sursubdate;
	}
	public void setSursubdate(String sursubdate) {
		this.sursubdate = sursubdate;
	}

	
	
}
