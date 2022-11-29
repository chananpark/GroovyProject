package com.spring.groovy.approval.model;

import java.util.List;

public class ExpenseListVO {

	private int expense_list_no; // 지출 내역번호(기본키)
	private String fk_draft_no; // 기안 문서 번호(외래키)
	private String expense_date; // 지출일자
	private String expense_type; // 지출분류
	private String expense_detail; // 지출내역
	private int expense_amount; // 금액
	private String expense_remark; // 비고
	
	private List<ExpenseListVO> evoList;

	public int getExpense_list_no() {
		return expense_list_no;
	}
	public void setExpense_list_no(int expense_list_no) {
		this.expense_list_no = expense_list_no;
	}
	public String getFk_draft_no() {
		return fk_draft_no;
	}
	public void setFk_draft_no(String fk_draft_no) {
		this.fk_draft_no = fk_draft_no;
	}
	public String getExpense_date() {
		return expense_date;
	}
	public void setExpense_date(String expense_date) {
		this.expense_date = expense_date;
	}
	public String getExpense_type() {
		return expense_type;
	}
	public void setExpense_type(String expense_type) {
		this.expense_type = expense_type;
	}
	public String getExpense_detail() {
		return expense_detail;
	}
	public void setExpense_detail(String expense_detail) {
		this.expense_detail = expense_detail;
	}
	public int getExpense_amount() {
		return expense_amount;
	}
	public void setExpense_amount(int expense_amount) {
		this.expense_amount = expense_amount;
	}
	public String getExpense_remark() {
		return expense_remark;
	}
	public void setExpense_remark(String expense_remark) {
		this.expense_remark = expense_remark;
	}
	public List<ExpenseListVO> getEvoList() {
		return evoList;
	}
	public void setEvoList(List<ExpenseListVO> evoList) {
		this.evoList = evoList;
	}
}
