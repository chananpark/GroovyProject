package com.spring.groovy.notice.model;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVO {

	private String seq;            // 글번호
	private String fk_empno;       // 사용자ID
	private String name;           // 사용자 이름
	private String subject;        // 글제목
	private String content;        // 글내용
	private String readCount;      // 글조회수
	private String regDate;        // 글쓴시간
	private String status;         // 글삭제여부
	private String commentCount;   // 댓글의 개수 
	private String groupno;        // 답변글쓰기에 있어서 그룹번호 
	private String fk_seq;         // 원글(부모글)이 누구인지에 대한 정보값
	private String depthno;        // 답변글 이라면 원글(부모글)의 depthno + 1 / 원글이라면 0
	
	
	private String prev_seq;  
	private String prev_subject;    
	private String next_seq;        
	private String next_subject; 
	
	
	private String empimg;
	
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
	
	
	
	
	public NoticeVO(String seq, String fk_empno, String name, String subject, String content, String readCount,
			String regDate, String status, String commentCount, String groupno, String fk_seq, String depthno,
			String prev_seq, String prev_subject, String next_seq, String next_subject, String empimg,
			MultipartFile attach) {
		super();
		this.seq = seq;
		this.fk_empno = fk_empno;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.readCount = readCount;
		this.regDate = regDate;
		this.status = status;
		this.commentCount = commentCount;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		this.prev_seq = prev_seq;
		this.prev_subject = prev_subject;
		this.next_seq = next_seq;
		this.next_subject = next_subject;
		this.empimg = empimg;
		this.attach = attach;
	}




	////////////////////////////////////////////////////////////////////////////////////
	
	
	
	public NoticeVO() {
		// TODO Auto-generated constructor stub
	}


	public MultipartFile getAttach() {
		return attach;
	}


	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}


	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReadCount() {
		return readCount;
	}
	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	public String getGroupno() {
		return groupno;
	}
	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}
	public String getFk_seq() {
		return fk_seq;
	}
	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}
	public String getDepthno() {
		return depthno;
	}
	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}


	
	////////////////////////////////////////////////////////////////////
	
	
	public String getPrev_seq() {
		return prev_seq;
	}
	public void setPrev_seq(String prev_seq) {
		this.prev_seq = prev_seq;
	}
	public String getPrev_subject() {
		return prev_subject;
	}
	public void setPrev_subject(String prev_subject) {
		this.prev_subject = prev_subject;
	}
	public String getNext_seq() {
		return next_seq;
	}
	public void setNext_seq(String next_seq) {
		this.next_seq = next_seq;
	}
	public String getNext_subject() {
		return next_subject;
	}
	public void setNext_subject(String next_subject) {
		this.next_subject = next_subject;
	}
	public String getEmpimg() {
		return empimg;
	}
	public void setEmpimg(String empimg) {
		this.empimg = empimg;
	}	
	
	
	
	
	
	
	                                      
	 
	
}
