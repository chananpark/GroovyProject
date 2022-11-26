package com.spring.groovy.approval.model;

import org.springframework.web.multipart.MultipartFile;

public class DraftFileVO {
	
	// 파일이 저장되는 필드 => WAS(톰캣) 디스크에 저장됨.
	private MultipartFile attach;
	private int draft_file_no; // 첨부파일번호(기본키)
	private String fk_draft_no; // 문서번호(외래키)
	private String originalFilename; // 원본 파일명
	private String filename; // 저장된 파일명
	private String filesize; // 파일크기
	
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public int getDraft_file_no() {
		return draft_file_no;
	}
	public void setDraft_file_no(int draft_file_no) {
		this.draft_file_no = draft_file_no;
	}
	public String getFk_draft_no() {
		return fk_draft_no;
	}
	public void setFk_draft_no(String fk_draft_no) {
		this.fk_draft_no = fk_draft_no;
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
