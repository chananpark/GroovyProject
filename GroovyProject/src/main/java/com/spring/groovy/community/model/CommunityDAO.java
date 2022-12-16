package com.spring.groovy.community.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommunityDAO implements InterCommunityDAO {

	private SqlSessionTemplate sqlsession;
	
	@Autowired
	public CommunityDAO(SqlSessionTemplate sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	// 글번호 생성
	@Override
	public String getPostNo() {
		return sqlsession.selectOne("community.getPostNo");
	}
	
	// 글 작성하기
	@Override
	public int addPost(CommunityPostVO cpvo) {
		return sqlsession.insert("community.addPost", cpvo);
	}

	// 전체 글 개수 구하기
	@Override
	public int getPostCnt(Map<String, String> paraMap) {
		return sqlsession.selectOne("community.getPostCnt", paraMap);
	}

	// 한 페이지에 표시할 글 목록
	@Override
	public List<CommunityPostVO> getPostList(Map<String, String> paraMap) {
		return sqlsession.selectList("community.getPostList", paraMap);
	}

	// 글내용 조회
	@Override
	public CommunityPostVO getPostDetail(Map<String, String> paraMap) {
		return sqlsession.selectOne("community.getPostDetail", paraMap);
	}

	// 조회수 증가
	@Override
	public void addPostHit(CommunityPostVO post) {
		sqlsession.update("community.addPostHit", post);
	}

	// 댓글 목록 조회
	@Override
	public List<CommunityCommentVO> getComment(String post_no) {
		return sqlsession.selectList("community.getComment", post_no);
	}

	// 글 삭제하기	
	@Override
	public int deletePost(Map<String, String> paraMap) {
		return sqlsession.update("community.deletePost", paraMap);
	}

	// 첨부 파일 insert
	@Override
	public int addFiles(List<CommunityPostFileVO> fileList) {
		return sqlsession.insert("community.addFiles", fileList);
	}

	// 첨부파일 조회
	@Override
	public List<CommunityPostFileVO> getPostFiles(String post_no) {
		return sqlsession.selectList("community.getPostFiles", post_no);
	}
	
	// 파일번호로 파일 한개 조회
	@Override
	public CommunityPostFileVO getFile(String post_file_no) {
		return sqlsession.selectOne("community.getFile", post_file_no);
	}
	
	// 파일 테이블에서 파일 삭제하기
	@Override
	public int deleteFile(String post_file_no) {
		return sqlsession.delete("community.deleteFile", post_file_no);
	}

	// 글 수정하기
	@Override
	public int editPost(CommunityPostVO post) {
		return sqlsession.update("community.editPost", post);
	}

	// 댓글 작성하기
	@Override
	public int addComment(CommunityCommentVO comment) {
		return sqlsession.insert("community.addComment", comment);
	}

	// 댓글 수정하기
	@Override
	public int editComment(CommunityCommentVO comment) {
		return sqlsession.update("community.editComment", comment);
	}

	// 댓글 삭제하기
	@Override
	public int delComment(CommunityCommentVO comment) {
		return sqlsession.update("community.delComment", comment);
	}

	// 첨부파일 1개 조회
	@Override
	public CommunityPostFileVO getAttachedFile(String post_file_no) {
		return sqlsession.selectOne("community.getAttachedFile", post_file_no);
	}

	// 답댓글 작성
	@Override
	public int addReComment(CommunityCommentVO comment) {
		return sqlsession.insert("community.addReComment", comment);
	}

	// 임시저장 번호 시퀀스 가져오기
	@Override
	public String getTempPostNo() {
		return sqlsession.selectOne("community.getTempPostNo");
	}

	// 임시저장 테이블에 insert or update
	@Override
	public int savePost(Map<String, Object> paraMap) {
		return sqlsession.update("community.savePost", paraMap);
	}

	// 임시저장 목록 가져오기
	@Override
	public List<Map<String, String>> getSavedPostList(String fk_empno) {
		return sqlsession.selectList("community.getSavedPostList", fk_empno);
	}

	// 임시저장글 삭제
	@Override
	public int delTempPost(String temp_post_no) {
		return sqlsession.delete("community.delTempPost", temp_post_no);
	}

	// 30일 지난 임시저장 글 삭제하기
	@Override
	public void autoDeleteTempPost() {
		sqlsession.delete("community.autoDeleteTempPost");
	}

	// 좋아요 목록 조회
	@Override
	public List<CommunityLikeVO> getLikeList(String post_no) {
		return sqlsession.selectList("community.getLikeList", post_no);
	}

	// like 시퀀스 가져오기
	@Override
	public String getLikeNo() {
		return sqlsession.selectOne("community.getLikeNo");
	}

	// 좋아요 누르기/취소하기
	@Override
	public int updateLike(CommunityLikeVO like) {
		return sqlsession.update("community.updateLike", like);
	}

	// 테이블에서 파일 삭제
	@Override
	public int deleteAttachedFiles(String post_no) {
		return sqlsession.delete("community.deleteAttachedFiles", post_no);
	}

	// 임시저장글 조회하기
	@Override
	public CommunityPostVO getTempPost(String temp_post_no) {
		return sqlsession.selectOne("community.getTempPost", temp_post_no);
	}

}
