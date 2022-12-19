package com.spring.groovy.notice.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.notice.model.NoticeFileVO;
import com.spring.groovy.notice.model.NoticeVO;

public interface InterNoticeService {

	// 전체 글 개수 구하기
	int getNoticeTotalCnt(Map<String, String> paraMap);

	
	// 페이지 글목록
	Object getNoticeList(Map<String, String> paraMap);

	// 글작성하기
	boolean writeEnd(Map<String, Object> paraMap);

	// 글 상세 조회 + 조회수 증가
	NoticeVO getNoticeDetailViewCnt(Map<String, String> paraMap);

	// 첨부파일 목록 조회(글 상세 조회)
	List<NoticeFileVO> getFilesDetail(String seq);

	// 글 조회 (수정용 - 조회수 증가 X )
	NoticeVO getNoticeDetailNoCnt(Map<String, String> paraMap);

	// 글 수정하기
	boolean editNotice(Map<String, Object> paraMap);

	// (글 수정) 기존에 첨부된 파일 삭제
	boolean deleteFile(String notice_file_seq, String path);

	// 글 정보 확인(글 삭제)
	NoticeVO getPostInfo(Map<String, String> paraMap);

	// 글 삭제
	boolean deletePost(Map<String, String> paraMap);

}
