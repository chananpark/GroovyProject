package com.spring.groovy.approval.model;

public class DraftVO {
	
	private int draft_no; // 문서번호
	private String draft_type; // 기안 종류
	private int fk_draft_empno; // 기안자 사원번호
	private String draft_emp_name; // 기안자 이름
	private String draft_subject; // 문서 제목
	private String draft_content; // 문서 내용
	private String draft_comment; // 기안 의견
	private String draft_date; // 작성일자
	private String org_filename; // 원본 파일명
	private String filename; // 저장된 파일명
	private int filesize; // 파일크기
	private int temp; // 임시저장 여부 (0: 임시저장아님, 1: 임시저장)
	private int draft_seq; // 기안 시퀀스
	private String draft_status; // 결재 상태 (0: 진행중, 1: 승인, 2: 반려)
	private String draft_department; // 기안부서
	private int urgent_status; // 긴급여부(0: 부, 1: 여)
	
	private String approval_date; // 결재완료일
	
	
	public int getDraft_no() {
		return draft_no;
	}

	public void setDraft_no(int draft_no) {
		this.draft_no = draft_no;
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

	public String getOrg_filename() {
		return org_filename;
	}

	public void setOrg_filename(String org_filename) {
		this.org_filename = org_filename;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getFilesize() {
		return filesize;
	}

	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}

	public int getTemp() {
		return temp;
	}

	public void setTemp(int temp) {
		this.temp = temp;
	}

	public String getDraft_type() {
		return draft_type;
	}

	public void setDraft_type(String draft_type) {
		this.draft_type = draft_type;
	}

	public String getDraft_status() {
		return draft_status;
	}

	public void setDraft_status(String draft_status) {
		switch (draft_status) {
		case "1":
			this.draft_status = "완료";
			break;
			
		case "2":
			this.draft_status = "반려";
			break;

		default:
			this.draft_status = "진행중";
			break;
		}
	}

	public int getDraft_seq() {
		return draft_seq;
	}

	public void setDraft_seq(int draft_seq) {
		this.draft_seq = draft_seq;
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
