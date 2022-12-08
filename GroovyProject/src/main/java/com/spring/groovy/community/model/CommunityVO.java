package com.spring.groovy.community.model;

public class CommunityVO {
	
	private int post_no; // 글번호         
	private int fk_empno; // 작성자 사원번호         
	private String post_subject; // 제목 
	private String post_content; // 내용           
	private String post_date; // 작성일자           
	private int post_hit; // 조회수         
	private int post_status; // 글 상태 (1: 사용가능, 0: 삭제됨)
	
	private String name; // 작성자 이름 (join)
	private int commentCnt; // 댓글 개수 (join)
	private int fileCnt; // 첨부파일 개수 (join)
	
	public int getPost_no() {
		return post_no;
	}
	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}
	public int getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(int fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getPost_subject() {
		return post_subject;
	}
	public void setPost_subject(String post_subject) {
		this.post_subject = post_subject;
	}
	public String getPost_content() {
		return post_content;
	}
	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}
	public String getPost_date() {
		return post_date;
	}
	public void setPost_date(String post_date) {
		this.post_date = post_date;
	}
	public int getPost_hit() {
		return post_hit;
	}
	public void setPost_hit(int post_hit) {
		this.post_hit = post_hit;
	}
	public int getPost_status() {
		return post_status;
	}
	public void setPost_status(int post_status) {
		this.post_status = post_status;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	public int getFileCnt() {
		return fileCnt;
	}
	public void setFileCnt(int fileCnt) {
		this.fileCnt = fileCnt;
	}

}
