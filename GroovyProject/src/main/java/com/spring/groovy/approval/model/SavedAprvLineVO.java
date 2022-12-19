package com.spring.groovy.approval.model;

public class SavedAprvLineVO {

	private int aprv_line_no;        
	private String aprv_line_name;
	private int fk_empno;    
	private int fk_approval_empno1;     
	private Integer fk_approval_empno2;      
	private Integer fk_approval_empno3; 
	private Integer fk_approval_empno4;
	
	public Integer getAprv_line_no() {
		return aprv_line_no;
	}
	public void setAprv_line_no(Integer aprv_line_no) {
		this.aprv_line_no = aprv_line_no;
	}
	public String getAprv_line_name() {
		return aprv_line_name;
	}
	public void setAprv_line_name(String aprv_line_name) {
		this.aprv_line_name = aprv_line_name;
	}
	public Integer getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(Integer fk_empno) {
		this.fk_empno = fk_empno;
	}
	public Integer getFk_approval_empno1() {
		return fk_approval_empno1;
	}
	public void setFk_approval_empno1(Integer fk_approval_empno1) {
		this.fk_approval_empno1 = fk_approval_empno1;
	}
	public Integer getFk_approval_empno2() {
		return fk_approval_empno2;
	}
	public void setFk_approval_empno2(Integer fk_approval_empno2) {
		this.fk_approval_empno2 = fk_approval_empno2;
	}
	public Integer getFk_approval_empno3() {
		return fk_approval_empno3;
	}
	public void setFk_approval_empno3(Integer fk_approval_empno3) {
		this.fk_approval_empno3 = fk_approval_empno3;
	}
	public Integer getFk_approval_empno4() {
		return fk_approval_empno4;
	}
	public void setFk_approval_empno4(Integer fk_approval_empno4) {
		this.fk_approval_empno4 = fk_approval_empno4;
	}
	
}
