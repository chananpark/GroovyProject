package com.spring.groovy.approval.model;

public class DraftVO {
	
	private String draft_no; // 문서번호(기본키)
	private int fk_draft_type_no; // 기안 종류 번호
	private String draft_type; // 기안 종류
	private int fk_draft_empno; // 기안자 사원번호
	private String draft_subject; // 문서 제목
	private String draft_content; // 문서 내용
	private String draft_comment; // 기안 의견
	private String draft_date; // 작성일자
	private int draft_status; // 결재 상태 (0: 진행중, 1: 승인, 2: 반려)
	private int urgent_status; // 긴급여부(0: 부, 1: 여)

	private String draft_emp_name; // 기안자 이름(join)
	private String draft_department; // 기안부서(join)

	private String approval_date; // 결재완료일	(join)
	
	public String getDraft_no() {
		return draft_no;
	}

	public void setDraft_no(String draft_no) {
		this.draft_no = draft_no;
	}

	public int getFk_draft_type_no() {
		return fk_draft_type_no;
	}

	public void setFk_draft_type_no(int fk_draft_type_no) {
		this.fk_draft_type_no = fk_draft_type_no;
		
		setDraft_type(fk_draft_type_no);
	}

	public String getDraft_type() {
		return draft_type;
	}

	public void setDraft_type(int fk_draft_type_no) {

		switch (fk_draft_type_no) {
		case 1:
			this.draft_type = "업무품의";
			break;
			
		case 2:
			this.draft_type = "지출결의서";
			break;

		case 3:
			this.draft_type = "출장보고서";
			break;
		}
		
	}
	
	public void setDraft_type(String draft_type) {
		this.draft_type = draft_type;
	}

	public int getFk_draft_empno() {
		return fk_draft_empno;
	}

	public void setFk_draft_empno(int fk_draft_empno) {
		this.fk_draft_empno = fk_draft_empno;
	}

	public String getDraft_subject() {
		return draft_subject;
	}

	public void setDraft_subject(String draft_subject) {
		this.draft_subject = draft_subject;
	}

	public String getDraft_content() {
		return draft_content;
	}

	public void setDraft_content(String draft_content) {
		this.draft_content = draft_content;
	}

	public String getDraft_comment() {
		return draft_comment;
	}

	public void setDraft_comment(String draft_comment) {
		this.draft_comment = draft_comment;
	}

	public String getDraft_date() {
		return draft_date;
	}

	public void setDraft_date(String draft_date) {
		this.draft_date = draft_date;
	}

	public String getDraft_status() {
		switch (draft_status) {
		case 1:
			return "완료";
			
		case 2:
			return "반려";
			
		default:
			return "진행중";
		}
	}

	public void setDraft_status(int draft_status) {
		this.draft_status = draft_status;
	}

	public String getDraft_emp_name() {
		return draft_emp_name;
	}

	public void setDraft_emp_name(String draft_emp_name) {
		this.draft_emp_name = draft_emp_name;
	}

	public String getDraft_department() {
		return draft_department;
	}

	public void setDraft_department(String draft_department) {
		this.draft_department = draft_department;
	}

	public String getApproval_date() {
		return approval_date;
	}

	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}

	public int getUrgent_status() {
		return urgent_status;
	}

	public void setUrgent_status(int urgent_status) {
		this.urgent_status = urgent_status;
	}
	
}
