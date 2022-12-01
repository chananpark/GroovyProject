package com.spring.groovy.management.model;

import java.util.List;

public class PayVO {

	private String payno;           // 급여번호
	private String fk_empno;        // 사원번호
	private String pay;             // 기본급
	private String annualpay;       // 연차수당
	private String overtimepay;     // 초과근무수당
	private String paymentdate;     // 지급일자(특정일자)
	private String postcode;        // 우편번호
	
	

	public String getPayno() {
		return payno;
	}
	public void setPayno(String payno) {
		this.payno = payno;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	public String getAnnualpay() {
		return annualpay;
	}
	public void setAnnualpay(String annualpay) {
		this.annualpay = annualpay;
	}
	public String getOvertimepay() {
		return overtimepay;
	}
	public void setOvertimepay(String overtimepay) {
		this.overtimepay = overtimepay;
	}
	public String getPaymentdate() {
		return paymentdate;
	}
	public void setPaymentdate(String paymentdate) {
		this.paymentdate = paymentdate;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	

}
