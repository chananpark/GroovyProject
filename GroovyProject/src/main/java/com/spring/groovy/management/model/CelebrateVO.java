package com.spring.groovy.management.model;

import java.util.List;

public class CelebrateVO {

	
	private String clbno;           // 경조비신청번호
	private String fk_empno;        // 사원번호
	private String clbdate;         // 신청일자
	private String clbpay;          // 신청금액  (1- 50, 2-20, 3-30 )
	private String clbtype;         // 경조구분 (1명절상여금, 2생일상여금, 3휴가상여금)
	private String clbstatus; 		// 승인여부 (0 미승인, 1 승인)
	
	private String name;  // 조인
	
	
	
	public String getClbno() {
		return clbno;
	}
	public void setClbno(String clbno) {
		this.clbno = clbno;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getClbdate() {
		return clbdate;
	}
	public void setClbdate(String clbdate) {
		this.clbdate = clbdate;
	}
	public String getClbpay() {
		return clbpay;
	}
	public void setClbpay(String clbpay) {
		this.clbpay = clbpay;
	}
	public String getClbtype() {
		return clbtype;
	}
	public void setClbtype(String clbtype) {
		this.clbtype = clbtype;
	}
	public String getClbstatus() {
		return clbstatus;
	}
	public void setClbstatus(String clbstatus) {
		this.clbstatus = clbstatus;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	

	
}
