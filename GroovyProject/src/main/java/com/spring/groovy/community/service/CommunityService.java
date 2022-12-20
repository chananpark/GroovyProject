package com.spring.groovy.community.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nhncorp.lucy.security.xss.XssPreventer;
import com.spring.groovy.approval.model.DraftFileVO;
import com.spring.groovy.common.FileManager;
import com.spring.groovy.community.model.CommunityCommentVO;
import com.spring.groovy.community.model.CommunityLikeVO;
import com.spring.groovy.community.model.CommunityPostFileVO;
import com.spring.groovy.community.model.CommunityPostVO;
import com.spring.groovy.community.model.InterCommunityDAO;

@Service
public class CommunityService implements InterCommunityService {

	private InterCommunityDAO dao;
	private FileManager fileManager;
	
    @Autowired
    public CommunityService(InterCommunityDAO dao, FileManager fileManager) {
        this.dao = dao;
        this.fileManager = fileManager;
    }

	// 글 작성하기
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public boolean addPost(Map<String, Object> paraMap) {
		
		int n = 0;
		boolean result = false;
		
		// 글번호 생성
		String post_no = dao.getPostNo();
		
		CommunityPostVO post = (CommunityPostVO)paraMap.get("post");
		post.setPost_no(post_no); // 글번호 set
		
		// 글 작성하기
		n = dao.addPost(post);
		
		result = (n == 1)? true: false;
		
		// 글 작성 실패 시 리턴
		if (!result)
			return false;
		
		// 임시저장했던 글이라면
		String temp_post_no = (String) paraMap.get("temp_post_no");
		if (temp_post_no != null && !"".equals(temp_post_no)) {
			// 임시저장글 삭제
			n = dao.delTempPost(temp_post_no);
			
			result = (n == 1)? true: false;
			
			// 임시저장글 삭제 실패 시 리턴
			if (!result)
				return false;
		}
		
		// 첨부 파일 리스트
		List<CommunityPostFileVO> fileList = (List<CommunityPostFileVO>) paraMap.get("fileList");
		
		// 첨부파일이 있다면
		if (fileList != null && fileList.size() > 0) {
			for (CommunityPostFileVO cfvo : fileList) {
				cfvo.setFk_post_no(post_no); // 글번호 set
			}
			
			// 첨부 파일 insert
			n = dao.addFiles(fileList);
			result = (n == fileList.size())? true : false;
			
			// 첨부 파일 테이블 insert가 실패했으면 리턴
			if (!result)
				return result;
		}
		
		 return result;
	}

	// 전체 글 개수 구하기
	@Override
	public int getPostCnt(Map<String, String> paraMap) {
		return dao.getPostCnt(paraMap);
	}

	// 한 페이지에 표시할 글 목록
	@Override
	public List<CommunityPostVO> getPostList(Map<String, String> paraMap) {
		return dao.getPostList(paraMap);
	}

	// 글 내용 조회 + 조회수 증가
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	@Override
	public CommunityPostVO getPostDetailWithCnt(Map<String, String> paraMap) {
		
		// 글내용 조회
		CommunityPostVO post = dao.getPostDetail(paraMap);

		try {
			// 다른 사람이 쓴 글이라면 
			if (!post.getFk_empno().equals(paraMap.get("empno"))) {
				// 조회수 증가
				dao.addPostHit(post);
			
				// 조회수 증가 후 다시 읽어오기
				post = dao.getPostDetail(paraMap);
			}
			
			// 글내용 태그 원복
			String originalContent = XssPreventer.unescape(post.getPost_content());
			post.setPost_content(originalContent);
			
		} catch(NullPointerException e) {
			// 존재하지 않는 글이라면 여기로
		}
		
		return post;
	}
	
	// 조회수 증가 없는 글 조회
	@Override
	public CommunityPostVO getPostDetail(Map<String, String> paraMap) {
		
		// 글내용 조회
		return dao.getPostDetail(paraMap);
	}

	// 댓글 목록 조회
	@Override
	public List<CommunityCommentVO> getComment(String post_no) {
		return dao.getComment(post_no);
	}

	// 글 삭제하기	
	@Override
	public boolean deletePost(Map<String, String> paraMap) {

		int n = dao.deletePost(paraMap);
		return n == 1 ? true : false;
		
	}

	// 첨부파일 조회
	@Override
	public List<CommunityPostFileVO> getPostFiles(String post_no) {
		return dao.getPostFiles(post_no);
	}

	// 파일 1개 삭제하기
	@Override
	public boolean deleteFile(String post_file_no, String path) {
		
		// 파일번호로 파일 조회
		CommunityPostFileVO file = dao.getFile(post_file_no);
		
		// 테이블에서 파일 삭제
		int n = dao.deleteFile(post_file_no);
		
		if (n==1) {
			// 서버에서 파일 삭제
			fileManager.doFileDelete(file.getFilename(), path);
		}
		
		return (n==1)? true: false;
	}
	
	// 모든 첨부파일 삭제하기
	@Override
	public boolean deleteAttachedFiles(Map<String, String> paraMap) {
		
		// 파일번호로 파일 조회
		List<CommunityPostFileVO> fileList = dao.getPostFiles(paraMap.get("post_no"));
		
		// 테이블에서 첨부파일 삭제
		int n = dao.deleteAttachedFiles(paraMap.get("post_no"));
		
		if (n == fileList.size()) {
			// 서버에서 파일 삭제
			for(CommunityPostFileVO file : fileList)  {
				fileManager.doFileDelete(file.getFilename(), paraMap.get("filePath"));
			}
			return true;
		}
		else
			return false;
		
	}

	// 글 수정하기
	@SuppressWarnings("unchecked")
	@Override
	public boolean editPost(Map<String, Object> paraMap) {
		int n = 0;
		boolean result = false;
		
		CommunityPostVO post = (CommunityPostVO)paraMap.get("post");
		
		// 글 수정하기
		n = dao.editPost(post);
		
		result = (n == 1)? true: false;
		
		// 글 작성 실패 시 리턴
		if (!result)
			return false;
		
		// 첨부 파일 리스트
		List<CommunityPostFileVO> fileList = (List<CommunityPostFileVO>) paraMap.get("fileList");
		
		// 첨부파일이 있다면
		if (fileList != null && fileList.size() > 0) {
			for (CommunityPostFileVO cfvo : fileList) {
				cfvo.setFk_post_no(post.getPost_no()); // 글번호 set
			}
			
			// 첨부 파일 insert
			n = dao.addFiles(fileList);
			result = (n == fileList.size())? true : false;
			
			// 첨부 파일 테이블 insert가 실패했으면 리턴
			if (!result)
				return result;
		}
		
		 return result;
	}

	// 댓글 작성하기
	@Override
	public boolean addComment(CommunityCommentVO comment) {
		
		int n = dao.addComment(comment);
		
		return (n==1)? true: false;
	}

	// 댓글 수정하기
	@Override
	public boolean editComment(CommunityCommentVO comment) {

		int n = dao.editComment(comment);
		
		return (n==1)? true: false;
	}

	// 댓글 삭제하기
	@Override
	public boolean delComment(CommunityCommentVO comment) {
		
		int n = dao.delComment(comment);
		
		return (n > 1)? true: false;
	}

	// 첨부파일 1개 조회
	@Override
	public CommunityPostFileVO getAttachedFile(String post_file_no) {
		return dao.getAttachedFile(post_file_no);
	}

	// 답댓글 작성
	@Override
	public boolean addReComment(CommunityCommentVO comment) {
		
		int n = dao.addReComment(comment);
		
		return (n==1)? true: false;
	}
	
	// 임시저장하기
	@Override
	public String savePost(Map<String, Object> paraMap) {
		
		String temp_post_no = (String) paraMap.get("temp_post_no");

		// 기존에 임시저장되었던 글이 아니라면
		if (temp_post_no == null || "".equals(temp_post_no)) {

			// 임시저장 번호 시퀀스 가져오기
			temp_post_no = dao.getTempPostNo();
		}

		paraMap.put("temp_post_no", temp_post_no);
		
		// 임시저장 테이블에 insert
		int n = dao.savePost(paraMap);
		
		return (n==1)? temp_post_no: null;
	}

	// 임시저장 목록 가져오기
	@Override
	public List<Map<String, String>> getSavedPostList(String fk_empno) {
		
		List<Map<String, String>> resultMapList = dao.getSavedPostList(fk_empno);
		
		// 글내용 태그 원복
		for (Map<String, String> map : resultMapList) {
			String content = XssPreventer.unescape(map.get("post_content"));
			content = content.replaceAll("\"", "\\\\\""); // "를 \"로 치환
			map.put("post_content", content);
		}
		
		return resultMapList;
	}

	// 30일 지난 임시저장 글 삭제하기
	@Override
	@Scheduled(cron="0 0 0 * * *")
	public void autoDeleteTempPost() {
		dao.autoDeleteTempPost();
	}
	
	// 좋아요 목록 조회
	@Override
	public List<CommunityLikeVO> getLikeList(String post_no) {
		return dao.getLikeList(post_no);
	}

	// 좋아요 누르기/취소하기
	@Override
	public boolean updateLike(CommunityLikeVO like) {
		
		if(like.getLike_no() == null || "".equals(like.getLike_no())) {
			// like 시퀀스 가져오기
			String like_no = dao.getLikeNo();
			like.setLike_no(like_no);
		}
		
		// 좋아요 누르기/취소하기
		int n = dao.updateLike(like);
		
		return (n==1)? true: false;
	}

	// 임시저장글 조회하기
	@Override
	public CommunityPostVO getTempPost(String temp_post_no) {
		return dao.getTempPost(temp_post_no);
	}

	// 임시저장 삭제하기
	@Override
	public boolean delTempPost(String temp_post_no) {
		int n = dao.delTempPost(temp_post_no);
		
		return (n == 1)? true: false;
	}

}
