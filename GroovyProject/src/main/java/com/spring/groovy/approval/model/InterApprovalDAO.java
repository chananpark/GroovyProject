package com.spring.groovy.approval.model;

import java.util.List;
import java.util.Map;

import com.spring.groovy.common.Pagination;

public interface InterApprovalDAO {

	// 팀문서함 전체 글 개수 조회
	int getTeamDraftCnt(Pagination pagination);

	// 팀문서함 페이징처리한 리스트 조회
	List<DraftVO> getTeamDraftList(Map<String, Object> paraMap);

	// 개인문서함 - 상신함 전체 글 개수 조회
	int getSentDraftCnt(Pagination pagination);

	// 개인문서함 - 상신함 페이징처리한 리스트 조회
	Object getSentDraftList(Map<String, Object> paraMap);

	// 개인문서함 - 결재함 전체 글 개수 조회
	int getProcessedDraftCnt(Pagination pagination);

	// 개인문서함 - 결재함 페이징처리한 리스트 조회
	Object getProcessedDraftList(Map<String, Object> paraMap);
	
	// 개인문서함 - 임시저장함 전체 글 개수 조회
	int getSavedDraftCnt(Pagination pagination);
	
	// 개인문서함 - 임시저장함 페이징처리한 리스트 조회
	Object getSavedDraftList(Map<String, Object> paraMap);

	// 개인문서함 - 임시저장함 글삭제
	int deleteDraftList(String[] deleteArr);

}
