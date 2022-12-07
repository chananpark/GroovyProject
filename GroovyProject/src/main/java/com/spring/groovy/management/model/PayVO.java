package com.spring.groovy.management.model;

public class PayVO {

	private String payno;           // 급여번호
	private String fk_empno;        // 사원번호
	private int pay;            	// 기본급
	private int annualpay;      	// 연차수당
	private int overtimepay;     	// 초과근무수당
	private String paymentdate;     // 지급일자(특정일자)
	private int incomtax;     		// 소득세
	private int pension;     		// 국민연금
	private int insurance;     		// 건강보험
	
	private int overpay;       // 근무수당(합)
	private int allpay;       // 지급총액
	private int tax;      	  // 공제총액
	private int monthpay;     // 실지급액
	

	// == 조인 == // 
	private String name;        
	private String bumun;        
	private String department;      
	private String position;       
	private int salary;     
	
	
	
	


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
	public int getPay() {
		return pay;
	}
	public void setPay(int pay) {
		this.pay = pay;
	}
	public int getAnnualpay() {
		return annualpay;
	}
	public void setAnnualpay(int annualpay) {
		this.annualpay = annualpay;
	}
	public int getOvertimepay() {
		return overtimepay;
	}
	public void setOvertimepay(int overtimepay) {
		this.overtimepay = overtimepay;
	}

	public int getIncomtax() {
		return incomtax;
	}
	public void setIncomtax(int incomtax) {
		this.incomtax = incomtax;
	}
	public int getPension() {
		return pension;
	}
	public void setPension(int pension) {
		this.pension = pension;
	}
	public int getInsurance() {
		return insurance;
	}
	public void setInsurance(int insurance) {
		this.insurance = insurance;
	}
	
	public String getPaymentdate() {
		return paymentdate;
	}
	public void setPaymentdate(String paymentdate) {
		this.paymentdate = paymentdate;
	}

	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBumun() {
		return bumun;
	}
	public void setBumun(String bumun) {
		this.bumun = bumun;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	
	public int getAllpay() {
		return allpay;
	}
	public void setAllpay(int allpay) {
		this.allpay = allpay;
	}
	public int getTax() {
		return tax;
	}
	public void setTax(int tax) {
		this.tax = tax;
	}
	public int getMonthpay() {
		return monthpay;
	}
	public void setMonthpay(int monthpay) {
		this.monthpay = monthpay;
	}
	
	
	public int getOverpay() {
		return overpay;
	}
	public void setOverpay(int overpay) {
		this.overpay = overpay;
	}
	
	
	

}
