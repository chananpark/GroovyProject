package com.spring.groovy.notice.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO implements InterNoticeDAO {
	
	@Resource  // bean 중에서 SqlSessionTemplate 클래스인데 이름(id)이 abc 인 것을 찾는다.
	private SqlSessionTemplate sqlsession; // 로컬 DB mymvc_user 에 연결
	// Type 및 Bean 이름이 동일한 것을  찾아서 주입해준다. 

	// 전체 글 개수 구하기
	@Override
	public int getNoticeTotalCnt(Map<String, String> paraMap) {
		int cnt = sqlsession.selectOne("hyewon.getNoticeTotalCnt", paraMap);
		return cnt;
	}

	// 페이지 글목록
	
	@Override
	public Object getNoticeList(Map<String, String> paraMap) {
		return sqlsession.selectList("hyewon.getNoticeList", paraMap);
	}
	
	
	// === tbl_board 테이블에서 groupno 컬럼의 최대값 알아오기 === //
	@Override
	public int getGroupnoMax() {
		int maxgroupno = sqlsession.selectOne("hyewon.getGroupnoMax");
		return maxgroupno;
	}

	// 글번호 알아오기
	@Override
	public String getNoticeSeq() {
		String seq = sqlsession.selectOne("hyewon.getNoticeSeq");
		return seq;
	}

	// 글 작성하기
	@Override
	public int writeEnd(NoticeVO noticevo) {
		int n = sqlsession.insert("hyewon.writeEnd", noticevo);
		return n;
	}

	// 첨부 파일 insert
	@Override
	public int insertFiles(List<NoticeFileVO> fileList) {
		int n = sqlsession.insert("hyewon.insertFiles", fileList);
		return n;
	}

	// 글내용 상세 조회
	@Override
	public NoticeVO getNoticeDetail(Map<String, String> paraMap) {
		return sqlsession.selectOne("hyewon.getNoticeDetail", paraMap);
	}

	// 조회수 증가
	@Override
	public void addReadCnt(Map<String, String> paraMap) {
		sqlsession.update("hyewon.addReadCnt", paraMap);
		
	}

	// 첨부파일 목록 조회(글 상세 조회)
	@Override
	public List<NoticeFileVO> getFilesDetail(String seq) {
		return sqlsession.selectList("hyewon.getFilesDetail", seq);
	}

	// 글 수정하기
	@Override
	public int editNotice(NoticeVO noticevo) {
		return sqlsession.update("hyewon.editNotice", noticevo);
	}

	// 파일번호로 파일 정보 조회
	@Override
	public NoticeFileVO getFileInfo(String notice_file_seq) {
		return sqlsession.selectOne("hyewon.getFileInfo", notice_file_seq);
	}

	// (글 수정) 테이블에서 파일 삭제
	@Override
	public int deleteFile(String notice_file_seq) {
		return sqlsession.delete("hyewon.deleteFile", notice_file_seq);
	}

	
	// 글 정보 확인
	@Override
	public NoticeVO getPostInfo(Map<String, String> paraMap) {
		return sqlsession.selectOne("hyewon.getPostInfo", paraMap);
	}

	// 글 삭제
	@Override
	public int deletePost(Map<String, String> paraMap) {
		return sqlsession.delete("hyewon.deletePost", paraMap);
	}

}
