package com.spring.groovy.management.model;


import org.springframework.web.multipart.MultipartFile;


public class MemberVO {
	
	private String empno;             // 사원번호
	private String signimg;           // 사원사진
	private String cpemail;           // 회사이메일 (AES-256 암호화/복호화 대상)
	private String name;              // 회원명
	private String pwd;               //비밀번호 (SHA-256 암호화 대상)
	private String position;          // 직급    
	private String jubun;             // 주민번호
	private String postcode;          // 우편번호
	private String address;           // 주소
	private String detailaddress;     // 상세주소
	private String extraaddress;      // 참고항목
	private String empimg;            // 사원이미지파일
	private String birthday;          // 생년월일   
	private String gender;			  // 성별                     남:1  여:2
	private String bumun;             // 부문 
	private String department;        // 부서(팀)
	private String pvemail;           // 개인이메일 (AES-256 암호화/복호화 대상)
	private String mobile;            // 연락처 (AES-256 암호화/복호화 대상)
	private String depttel;           // 내선번호
    private String joindate;		  // 입사일자
	private String empstauts;         // 재직구분 (3개월이후 정직원)
	private String bank;              // 은행
	private String account;           // 계좌번호
	private String annualcnt;          // 연차갯수
	private String fk_position_no;     // 직급번호(외래키)     1 선임 2 책임  3 팀장   4 부문장  5 대표이사
	private String fk_bumun_no;		   // -- 부문번호(외래키)  1 이사실 2 경영지원본부 3 IT사업부문 4 마케팅영업부문
	private String fk_department_no;   // -- 부서번호(기본키)  1 이사실 2 인사총무팀 3개발팀 4 5 6 마케팅

	private String pay; // 조인(연봉(기본급 => 연봉/12))
	
	// 첨부파일에 필요한 필드
	private MultipartFile attach;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	      진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
              조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	   /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과   
	     동일해야만 파일첨부가 가능해진다.!!!!
    */
	
	
	

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
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
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
	public String getFk_position_no() {
		return fk_position_no;
	}
	public void setFk_position_no(String fk_position_no) {
		this.fk_position_no = fk_position_no;
	}
	public String getFk_bumun_no() {
		return fk_bumun_no;
	}
	public void setFk_bumun_no(String fk_bumun_no) {
		this.fk_bumun_no = fk_bumun_no;
	}
	public String getFk_department_no() {
		return fk_department_no;
	}
	public void setFk_department_no(String fk_department_no) {
		this.fk_department_no = fk_department_no;
	}
	
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	
	
	
	
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
}
