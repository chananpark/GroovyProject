package com.spring.groovy.management.model;

public class EmployeeVO {
	
	private String empno;            // 사원번호
	private String signimg;          // 사원사진
	private String cpemail;          // 회사이메일 (AES-256 암호화/복호화 대상)
	private String name;             // 회원명
	private String pwd;               //비밀번호 (SHA-256 암호화 대상)
	private String position;          // 직급
	private String jubun;             // 주민번호
	private String postcode;          // 우편번호
	private String address;           // 주소
	private String detailaddress;     // 상세주소
	private String extraaddress;      // 참고항목
	private String empimg;            // 사원이미지파일
	private String birthday;          // 생년월일   
	private String bumun;             // 부문 
	private String department;        // 부서(팀)
	private String pvemail;           // 개인이메일 (AES-256 암호화/복호화 대상)
	private String mobile;            // 연락처 (AES-256 암호화/복호화 대상)
	private String depttel;           // 내선번호
	private String joindate;          // 입사일자
	private String empstauts;         // 재직구분 (3개월이후 정직원)
	private String bank;              // 은행
	private String account;           // 계좌번호
	private String annualcnt;          // 연차갯수
	
	
	
	
	
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getSignimg() {
		return signimg;
	}
	public void setSignimg(String signimg) {
		this.signimg = signimg;
	}
	public String getCpemail() {
		return cpemail;
	}
	public void setCpemail(String cpemail) {
		this.cpemail = cpemail;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getJubun() {
		return jubun;
	}
	public void setJubun(String jubun) {
		this.jubun = jubun;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailaddress() {
		return detailaddress;
	}
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	public String getExtraaddress() {
		return extraaddress;
	}
	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}
	public String getEmpimg() {
		return empimg;
	}
	public void setEmpimg(String empimg) {
		this.empimg = empimg;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
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
	public String getPvemail() {
		return pvemail;
	}
	public void setPvemail(String pvemail) {
		this.pvemail = pvemail;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getDepttel() {
		return depttel;
	}
	public void setDepttel(String depttel) {
		this.depttel = depttel;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getEmpstauts() {
		return empstauts;
	}
	public void setEmpstauts(String empstauts) {
		this.empstauts = empstauts;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getAnnualcnt() {
		return annualcnt;
	}
	public void setAnnualcnt(String annualcnt) {
		this.annualcnt = annualcnt;
	}
	
	
	
	
	
}
