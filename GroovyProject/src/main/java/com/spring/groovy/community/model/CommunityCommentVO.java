package com.spring.groovy.community.model;

public class CommunityCommentVO {

	private int comment_no; // 댓글번호(기본키)         
	private String fk_empno; // 댓글 작성자 사원번호(외래키)
	private String fk_post_no; // 글번호(외래키)
	private String comment_content; // 댓글 내용 
	private String comment_date; // 댓글 작성일시           
	private int group_no; // 댓글 그룹 번호         
	private int parent_comment_no; // 원댓글 번호         
	private int depth; // 댓글 계층
	
	private String name; // 작성자 이름 (join)
	private String empimg; // 작성자 프로필사진 (join)
	
	public int getComment_no() {
		return comment_no;
	}
	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
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
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public String getComment_date() {
		return comment_date;
	}
	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public int getParent_comment_no() {
		return parent_comment_no;
	}
	public void setParent_comment_no(int parent_comment_no) {
		this.parent_comment_no = parent_comment_no;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
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
