package com.spring.groovy.approval.model;

import java.util.List;

public class ApprovalVO {

	private int approval_no; // 결재번호(기본키)         
	private String fk_draft_no; // 기안문서번호(외래키)
	private int fk_approval_empno; // 결재자 사원번호      
	private int levelno; // 결재순서  
	private int approval_status; // 결재상태(0:미결, 1:결재, 2:반려, -1: 처리불가(아래에서 반려함))      
	private String approval_comment; // 결재의견
	private String approval_date; // 결재일자
	private int external; // 결재선 성격(0: 내부결재, 1:외부결재)
	
	private String name; // 결재자 이름(join)
	private String department; // 결재자 부서(join)
	private String position; // 결재자 직급(join)
	private String signimg; // 결재자 서명 이미지(join)
	private String empimg; // 결재자 프로필이미지(join)
	
	private List<ApprovalVO> avoList;
	
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
	public List<ApprovalVO> getAvoList() {
		return avoList;
	}
	public void setAvoList(List<ApprovalVO> avoList) {
		this.avoList = avoList;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getSignimg() {
		return signimg;
	}
	public void setSignimg(String signimg) {
		this.signimg = signimg;
	}
	public String getEmpimg() {
		return empimg;
	}
	public void setEmpimg(String empimg) {
		this.empimg = empimg;
	}
	public int getExternal() {
		return external;
	}
	public void setExternal(int external) {
		this.external = external;
	}
	

}
