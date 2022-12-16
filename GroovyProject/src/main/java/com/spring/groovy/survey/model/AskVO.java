package com.spring.groovy.survey.model;

public class AskVO {

	
	
	private String questno;     // 문항번호
	private String fk_surno;	// 설문번호
	private String question;	// 설문질문
	private String option1;		// 선택지1
	private String option2;		// 선택지2
	private String option3;		// 선택지3
	private String option4;		// 선택지4
	private String option5;		// 선택지5
	
	private String surtitle;	// 조인
	private String surexplain;	// 조인
	
	
	
	public String getQuestno() {
		return questno;
	}
	public void setQuestno(String questno) {
		this.questno = questno;
	}
	public String getFk_surno() {
		return fk_surno;
	}
	public void setFk_surno(String fk_surno) {
		this.fk_surno = fk_surno;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getOption1() {
		return option1;
	}
	public void setOption1(String option1) {
		this.option1 = option1;
	}
	public String getOption2() {
		return option2;
	}
	public void setOption2(String option2) {
		this.option2 = option2;
	}
	public String getOption3() {
		return option3;
	}
	public void setOption3(String option3) {
		this.option3 = option3;
	}
	public String getOption4() {
		return option4;
	}
	public void setOption4(String option4) {
		this.option4 = option4;
	}
	public String getOption5() {
		return option5;
	}
	public void setOption5(String option5) {
		this.option5 = option5;
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
	
	
	
	
}
