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

	// 댓글 수정하기
	int editComment(CommunityCommentVO comment);

	// 댓글 삭제하기
	int delComment(CommunityCommentVO comment);

	// 첨부파일 1개 조회
	CommunityPostFileVO getAttachedFile(String post_file_no);

	// 답댓글 작성
	int addReComment(CommunityCommentVO comment);

	// 임시저장 번호 시퀀스 가져오기
	String getTempPostNo();

	// 임시저장 테이블에 insert
	int savePost(Map<String, Object> paraMap);

	// 임시저장 목록 가져오기
	List<Map<String, String>> getSavedPostList(String fk_empno);

	// 임시저장글 삭제
	int delTempPost(String temp_post_no);

	// 30일 지난 임시저장 글 삭제하기
	void autoDeleteTempPost();
	
	// 좋아요 목록 조회
	List<CommunityLikeVO> getLikeList(String post_no);

	// like 시퀀스 가져오기
	String getLikeNo();

	// 좋아요 누르기/취소하기
	int updateLike(CommunityLikeVO like);


}
