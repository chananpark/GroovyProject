package com.spring.groovy.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nhncorp.lucy.security.xss.XssPreventer;
import com.spring.groovy.common.FileManager;
import com.spring.groovy.community.model.CommunityPostFileVO;
import com.spring.groovy.notice.model.InterNoticeDAO;
import com.spring.groovy.notice.model.NoticeFileVO;
import com.spring.groovy.notice.model.NoticeVO;


@Service
public class NoticeService implements InterNoticeService {

	
	private InterNoticeDAO ndao;	
	private FileManager fileManager;
	
	@Autowired
    public NoticeService(InterNoticeDAO ndao, FileManager fileManager) {
        this.ndao = ndao;
        this.fileManager = fileManager;
    }

	// 전체 글 개수 구하기
	@Override
	public int getNoticeTotalCnt(Map<String, String> paraMap) {
		int cnt = ndao.getNoticeTotalCnt(paraMap);
		return cnt;
	}


	// 페이지 글목록
	
	@Override
	public Object getNoticeList(Map<String, String> paraMap) {
		return ndao.getNoticeList(paraMap);
	}
	
	
	// 글 작성하기
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public boolean writeEnd(Map<String, Object> paraMap) {
		
		boolean result = false;		
		
		NoticeVO noticevo = (NoticeVO)paraMap.get("noticevo");
		
		// 글번호 알아오기
		// String seq = ndao.getNoticeSeq();
		
		if("".equals(noticevo.getFk_seq())) {
			// 원글쓰기인경우
			// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야한다.
			int groupno = ndao.getGroupnoMax() + 1;
			
			noticevo.setGroupno(String.valueOf(groupno));
		}
		
		// 글 작성하기
		int n1 = ndao.writeEnd(noticevo);
		// System.out.println("service 69 n1: "+n1);
		
		result = (n1 == 1)? true: false;
				
		// 글 작성 실패 시 리턴
		if (!result)
			return false;
		
		// 글번호 알아오기
		String seq = ndao.getNoticeSeq();
		 		
		// 첨부 파일 리스트
		List<NoticeFileVO> fileList = (List<NoticeFileVO>) paraMap.get("fileList");
		
		// 첨부파일이 있다면
		if (fileList != null && fileList.size() > 0) {
			for (NoticeFileVO nfvo : fileList) {
				nfvo.setFk_seq(seq); // 글번호 set
			}
			
			// 첨부 파일 insert
			int n2 = ndao.insertFiles(fileList);
			System.out.println("service 91 n2: "+n2);
			
			result = (n2 == fileList.size())? true : false;
			
			// 첨부 파일 테이블 insert가 실패했으면 리턴
			if (!result)
				return false;
		}
		
		 return result;
	}

	// 글 상세 조회 + 조회수 증가
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	@Override
	public NoticeVO getNoticeDetailViewCnt(Map<String, String> paraMap) {
		
		// 글내용 조회
		NoticeVO noticevo = ndao.getNoticeDetail(paraMap);

		try {
			// 다른 사람이 쓴 글이라면 
			if (!noticevo.getFk_empno().equals(paraMap.get("empno"))) {
				// 조회수 증가
				ndao.addReadCnt(paraMap);
			
				// 글내용 다시 조회
				noticevo = ndao.getNoticeDetail(paraMap);
			}
			
			// 글내용 태그 원복
			String originalContent = XssPreventer.unescape(noticevo.getContent());
			noticevo.setContent(originalContent);
			
		} catch(NullPointerException e) {
			// 존재하지 않는 글이라면 여기로
		}
		
		return noticevo;
	}

	
	// 첨부파일 목록 조회(글 상세 조회)
	@Override
	public List<NoticeFileVO> getFilesDetail(String seq) {
		return ndao.getFilesDetail(seq);
	}

	
	// 글 조회 (수정용 - 조회수 증가 X )
	@Override
	public NoticeVO getNoticeDetailNoCnt(Map<String, String> paraMap) {
		NoticeVO noticevo = ndao.getNoticeDetail(paraMap);
		return noticevo;
	}

	
	
	// 글 수정하기
	@SuppressWarnings("unchecked")
	@Override
	public boolean editNotice(Map<String, Object> paraMap) {
		int n = 0;
		boolean result = false;
		
		NoticeVO noticevo = (NoticeVO)paraMap.get("noticevo");
		
		// 글 수정하기
		n = ndao.editNotice(noticevo);
		// System.out.println("service 162 n : "+n);
		
		result = (n == 1)? true: false;
		
		// 글 작성 실패 시 리턴
		if (!result)
			return false;
		
		// 첨부 파일 리스트
		List<NoticeFileVO> fileList = (List<NoticeFileVO>) paraMap.get("fileList");
		
		// 첨부파일이 있다면
		if (fileList != null && fileList.size() > 0) {
			for (NoticeFileVO nfvo : fileList) {
				nfvo.setFk_seq(noticevo.getSeq()); // 글번호 set
			}
			
			// 첨부 파일 update
			n = ndao.insertFiles(fileList);
			System.out.println("service 181 n : "+n);
			result = (n == fileList.size())? true : false;
			
			// 첨부 파일 테이블 update가 실패했으면 리턴
			if (!result)
				return result;
		}
		
		 return result;
	}

	// (글 수정) 기존에 첨부된 파일 삭제
	@Override
	public boolean deleteFile(String notice_file_seq, String path) {

		// 파일번호로 파일 정보 조회
		NoticeFileVO nfvo = ndao.getFileInfo(notice_file_seq);
		
		// 테이블에서 파일 삭제
		int n = ndao.deleteFile(notice_file_seq);
		
		if (n==1) {
			// 서버에서 파일 삭제
			fileManager.doFileDelete(nfvo.getFilename(), path);
		}
		
		return (n==1)? true: false;
	}

	
	// 글 정보 확인
	@Override
	public NoticeVO getPostInfo(Map<String, String> paraMap) {
		NoticeVO noticevo = ndao.getPostInfo(paraMap);
		return noticevo;
	}

	// 글 삭제
	@Override
	public boolean deletePost(Map<String, String> paraMap) {
		int n = ndao.deletePost(paraMap);		
		return (n==1)? true: false;
	}
}
