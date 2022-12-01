package com.spring.groovy.management.model;

import java.util.List;

public class ProofVO {

	private String proofno;             // 증명서번호
	private String fk_empno;           // 사원번호
	private String issuedate;           // 발급일자(sysdate)
	private String issueuse;              // 발급용도(1 은행제출용, 2 공공기관용)
	
	private String name; // join
	
	
	public String getProofno() {
		return proofno;
	}
	public void setProofno(String proofno) {
		this.proofno = proofno;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getIssuedate() {
		return issuedate;
	}
	public void setIssuedate(String issuedate) {
		this.issuedate = issuedate;
	}
	public String getIssueuse() {
		return issueuse;
	}
	public void setIssueuse(String issueuse) {
		this.issueuse = issueuse;
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
}
