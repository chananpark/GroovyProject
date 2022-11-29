package com.spring.groovy.management.model;

import javax.swing.Spring;

public class CelebrateVO {

	
	private Spring clbno;           // 경조비신청번호
	private Spring fk_empno;        // 사원번호
	private Spring clbdate;         // 신청일자
	private Spring clbpay;          // 신청금액  (1- 50, 2-20, 3-30 )
	private Spring clbtype;         // 경조구분 (1명절상여금, 2생일상여금, 3휴가상여금)
	private Spring clbstatus; 		// 승인여부 (0 미승인, 1 승인)
	
	
	
	public Spring getClbno() {
		return clbno;
	}
	public void setClbno(Spring clbno) {
		this.clbno = clbno;
	}
	public Spring getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(Spring fk_empno) {
		this.fk_empno = fk_empno;
	}
	public Spring getClbdate() {
		return clbdate;
	}
	public void setClbdate(Spring clbdate) {
		this.clbdate = clbdate;
	}
	public Spring getClbpay() {
		return clbpay;
	}
	public void setClbpay(Spring clbpay) {
		this.clbpay = clbpay;
	}
	public Spring getClbtype() {
		return clbtype;
	}
	public void setClbtype(Spring clbtype) {
		this.clbtype = clbtype;
	}
	public Spring getClbstatus() {
		return clbstatus;
	}
	public void setClbstatus(Spring clbstatus) {
		this.clbstatus = clbstatus;
	}
	
}
