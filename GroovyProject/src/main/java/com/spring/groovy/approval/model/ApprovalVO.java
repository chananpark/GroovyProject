package com.spring.groovy.approval.model;

public class ApprovalVO {
	
	private int approval_no; // 결재번호(기본키)         
	private String fk_draft_no; // 기안문서번호(외래키)
	private int fk_approval_empno; // 결재자 사원번호      
	private int levelno; // 결재순서  
	private int approval_status; // 결재상태(0:미결, 1:결재, 2:반려, -1: 처리불가(아래에서 반려함))      
	private String approval_comment; // 결재의견
	private String approval_date; // 결재일자
	public int getApproval_no() {
		return approval_no;
	}
	public void setApproval_no(int approval_no) {
		this.approval_no = approval_no;
	}
	public String getFk_draft_no() {
		return fk_draft_no;
	}
	public void setFk_draft_no(String fk_draft_no) {
		this.fk_draft_no = fk_draft_no;
	}
	public int getFk_approval_empno() {
		return fk_approval_empno;
	}
	public void setFk_approval_empno(int fk_approval_empno) {
		this.fk_approval_empno = fk_approval_empno;
	}
	public int getLevelno() {
		return levelno;
	}
	public void setLevelno(int levelno) {
		this.levelno = levelno;
	}
	public int getApproval_status() {
		return approval_status;
	}
	public void setApproval_status(int approval_status) {
		this.approval_status = approval_status;
	}
	public String getApproval_comment() {
		return approval_comment;
	}
	public void setApproval_comment(String approval_comment) {
		this.approval_comment = approval_comment;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	
	

}
