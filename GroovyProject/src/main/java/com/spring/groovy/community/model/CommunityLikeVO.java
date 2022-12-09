package com.spring.groovy.community.model;

public class CommunityLikeVO {

	private String like_no; // 좋아요 번호(기본키)
	private String fk_empno; // 누른사람 사원 번호(외래키)
	private String fk_post_no; // 글번호(외래키)
	
	private String name; // 누른사람 이름(join)
	private String empimg; // 누른사람 사원이미지(join)
	
	public String getLike_no() {
		return like_no;
	}
	public void setLike_no(String like_no) {
		this.like_no = like_no;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getFk_post_no() {
		return fk_post_no;
	}
	public void setFk_post_no(String fk_post_no) {
		this.fk_post_no = fk_post_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmpimg() {
		return empimg;
	}
	public void setEmpimg(String empimg) {
		this.empimg = empimg;
	}

	
}
