package com.spring.groovy.notice.model;

import org.springframework.web.multipart.MultipartFile;

public class NoticeFileVO {

	private String notice_file_seq;            // 글번호
	private String fk_seq;       // 사용자ID   
	private String originalfilename;        // 글제목
	private String filename;        // 글내용
	private String filesize;      // 글조회수
	
	
	////////////////////////////////////////////////////////////////////////////////////
	
	/*
    === 파일을 첨부하도록 VO 수정하기
                먼저, 오라클에서 tbl_board 테이블에 3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다. 
	*/
	private MultipartFile attach;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	       진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	           조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	    /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과  
	      동일해야만 파일첨부가 가능해진다.!!!!
	*/
	
 	////////////////////////////////////////////////////////////////////////////////////
	
	public NoticeFileVO(String notice_file_seq, String fk_seq, String originalfilename, String filename,
			String filesize, MultipartFile attach) {
		super();
		this.notice_file_seq = notice_file_seq;
		this.fk_seq = fk_seq;
		this.originalfilename = originalfilename;
		this.filename = filename;
		this.filesize = filesize;
		this.attach = attach;
	}
	
	public NoticeFileVO() {
		
	}
	
	////////////////////////////////////////////////////////////////////////////////////
	
	
	
	


	public MultipartFile getAttach() {
		return attach;
	}


	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}


	public String getNotice_file_seq() {
		return notice_file_seq;
	}


	public void setNotice_file_seq(String notice_file_seq) {
		this.notice_file_seq = notice_file_seq;
	}


	public String getFk_seq() {
		return fk_seq;
	}


	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}


	public String getOriginalfilename() {
		return originalfilename;
	}


	public void setOriginalfilename(String originalfilename) {
		this.originalfilename = originalfilename;
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
