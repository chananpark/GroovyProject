package com.spring.groovy.notice.model;

import java.util.List;
import java.util.Map;

public interface InterNoticeDAO {

	// 전체 글 개수 구하기
	int getNoticeTotalCnt(Map<String, String> paraMap);

	

	// 페이지 글목록
	Object getNoticeList(Map<String, String> paraMap);

	// === tbl_board 테이블에서 groupno 컬럼의 최대값 알아오기 === //
	int getGroupnoMax();

	// 글번호 알아오기
	String getNoticeSeq();

	// 글 작성하기
	int writeEnd(NoticeVO noticevo);

	// 첨부 파일 insert
	int insertFiles(List<NoticeFileVO> fileList);

	// 글내용 상세 조회
	NoticeVO getNoticeDetail(Map<String, String> paraMap);

	// 조회수 증가
	void addReadCnt(Map<String, String> paraMap);

	// 첨부파일 목록 조회(글 상세 조회)
	List<NoticeFileVO> getFilesDetail(String seq);

	// 글 수정하기
	int editNotice(NoticeVO noticevo);

	// (글 수정) 파일번호로 파일 정보 조회
	NoticeFileVO getFileInfo(String notice_file_seq);

	// (글 수정) 테이블에서 파일 삭제
	int deleteFile(String notice_file_seq);

	// 글 정보 확인
	NoticeVO getPostInfo(Map<String, String> paraMap);

	// 글 삭제
	int deletePost(Map<String, String> paraMap);


}
