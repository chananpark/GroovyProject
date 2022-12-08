package com.spring.groovy.community.model;

import java.util.List;
import java.util.Map;

public interface InterCommunityDAO {

	// 글번호 생성
	String getPostNo();
	
	// 글 작성하기
	int addPost(CommunityPostVO cpvo);
	
	// 전체 글 개수 구하기
	int getPostCnt(Map<String, String> paraMap);
	
	// 한 페이지에 표시할 글 목록
	List<CommunityPostVO> getPostList(Map<String, String> paraMap);

	// 글내용 조회
	CommunityPostVO getPostDetail(Map<String, String> paraMap);
	
	// 조회수 증가
	void addPostHit(CommunityPostVO post);

	// 댓글 목록 조회
	List<CommunityCommentVO> getComment(String post_no);

	// 글 삭제하기	
	int deletePost(Map<String, String> paraMap);

	// 첨부 파일 insert
	int addFiles(List<CommunityPostFileVO> fileList);

	// 첨부파일 조회
	List<CommunityPostFileVO> getPostFiles(String post_no);

	// 파일번호로 파일 조회
	CommunityPostFileVO getFile(String post_file_no);
	
	// 파일 테이블에서 파일 삭제하기
	int deleteFile(String post_file_no);

	// 글 수정하기
	int editPost(CommunityPostVO post);

	// 댓글 작성하기
	int addComment(CommunityCommentVO comment);


}
