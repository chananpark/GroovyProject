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

}
