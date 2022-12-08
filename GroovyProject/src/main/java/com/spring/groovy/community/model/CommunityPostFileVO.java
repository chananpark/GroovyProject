package com.spring.groovy.community.model;

public class CommunityPostFileVO {

	private int post_file_no; // 파일번호(기본키)
	private String fk_post_no; // 글번호(외래키)       
	private String originalFilename; // 원본 파일명
	private String filename; // 저장된 파일명
	private String filesize; // 파일크기
	
	public int getPost_file_no() {
		return post_file_no;
	}
	public void setPost_file_no(int post_file_no) {
		this.post_file_no = post_file_no;
	}
	public String getFk_post_no() {
		return fk_post_no;
	}
	public void setFk_post_no(String fk_post_no) {
		this.fk_post_no = fk_post_no;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	
	
}
