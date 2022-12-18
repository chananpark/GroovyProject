package com.spring.groovy.approval.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.approval.model.ApprovalVO;
import com.spring.groovy.approval.model.DraftFileVO;
import com.spring.groovy.approval.model.DraftVO;
import com.spring.groovy.approval.model.OfficialAprvLineVO;
import com.spring.groovy.approval.model.SavedAprvLineVO;
import com.spring.groovy.management.model.MemberVO;

public interface InterApprovalService {

	// 팀문서함 전체 글 개수 조회
	int getTeamDraftCnt(Map<String, Object> paraMap);

	// 팀문서함 페이징처리한 리스트 조회
	List<DraftVO> getTeamDraftList(Map<String, Object> paraMap);

	// 개인문서함 - 상신함 전체 글 개수 조회
	int getSentDraftCnt(Map<String, Object> paraMap);

	// 개인문서함 - 상신함 페이징처리한 리스트 조회
	List<DraftVO> getSentDraftList(Map<String, Object> paraMap);

	// 개인문서함 - 결재함 전체 글 개수 조회
	int getProcessedDraftCnt(Map<String, Object> paraMap);

	// 개인문서함 - 결재함 페이징처리한 리스트 조회
	List<DraftVO> getProcessedDraftList(Map<String, Object> paraMap);

	// 개인문서함 - 임시저장함 전체 글 개수 조회
	int getSavedDraftCnt(Map<String, Object> paraMap);

	// 개인문서함 - 임시저장함 페이징처리한 리스트 조회
	List<DraftVO> getSavedDraftList(Map<String, Object> paraMap);

	// 개인문서함 - 임시저장함 글삭제
	int deleteDraftList(String[] deleteArr);

	// 진행 중 문서  5개 가져오기
	List<DraftVO> getMyDraftProcessing(String empno);
	
	// 결재완료된 문서 5개 가져오기
	List<DraftVO> getMyDraftProcessed(String empno);

	// 결재 대기 문서의 문서번호들 조회
	List<String> getRequestedDraftNo(Map<String, Object> paraMap);
	
	// 결재대기문서 전체 글 개수 조회
	int getRequestedDraftCnt(Map<String, Object> paraMap);
	
	// 결재대기문서 페이징처리한 리스트 조회
	List<DraftVO> getRequestedDraftList(Map<String, Object> paraMap);

	// 결재 예정 문서의 문서번호들 조회
	List<Object> getUpcomingDraftNo(Map<String, Object> paraMap);

	// 결재 예정 문서 전체 글 개수 조회
	int getUpcomingDraftCnt(Map<String, Object> paraMap);

	// 결재예정문서 페이징처리한 리스트 조회
	List<DraftVO> getUpcomingDraftList(Map<String, Object> paraMap);
	
	// 사원 목록 가져오기
	List<Map<String, String>> getEmpList(Map<String, Object> paraMap);

	// 부문 목록 가져오기
	List<Map<String, String>> getBumunList(Map<String, Object> paraMap);
	
	// 부서 목록 가져오기
	List<Map<String, String>> getDeptList(Map<String, Object> paraMap);

	// 환경설정 - 결재라인 저장
	int saveApprovalLine(SavedAprvLineVO sapVO);

	// 업무기안 작성하기
	boolean addDraft(Map<String, Object> paraMap);
	
	// 저장된 결재라인 불러오기
	List<SavedAprvLineVO> getSavedAprvLine(Map<String, String> paraMap);

	// 저장된 결재라인 결재자 정보 가져오기
	List<MemberVO> getSavedAprvEmpInfo(List<String> empnoList);
	
	// 환경설정-저장된 결재라인 한개 불러오기
	List<MemberVO> getOneAprvLine(String aprv_line_no);

	// 업무기안 임시저장하기
	String saveTempDraft(Map<String, Object> paraMap);
	
	// 30일 지난 임시저장 글 삭제하기
	void autoDeleteSavedDraft();

	// 기안문서 상세 조회
	Map<String, Object> getDraftDetail(DraftVO dvo);
	
	// 기안문서 조회
	DraftVO getDraftInfo(DraftVO dvo);

	// 임시저장 문서 조회
	Map<String, Object> getTempDraftDetail(DraftVO dvo);

	// 첨부파일 1개 조회
	DraftFileVO getOneAttachedFile(String draft_file_no);
	
	// 모든 첨부파일 조회
	List<DraftFileVO> getAllAttachedFile(String draft_no);

	// 결재단계 사원번호 조회
	String checkApproval(ApprovalVO avo);
	
	// 자신의 다음 결재단계 조회
	int checkApprovalProxy(ApprovalVO avo);
		
	// 결재 처리하기
	boolean updateApproval(ApprovalVO avo);

	// 공통결재라인(수신처) 가져오기
	List<MemberVO> getRecipientList(String type_no);

	// 관리자메뉴-공통결재라인 목록 불러오기
	List<Map<String, String>> getOfficialAprvList();
	
	// 관리자메뉴-공통결재라인 삭제하기
	boolean delOfficialAprvLine(Map<String, String> paraMap);

	// 공통결재라인 여부 사용으로 변경하기
	boolean setUseOfficialLine(String draft_type_no);

	// 공통결재라인 없는 양식 목록 불러오기
	List<Map<String, String>> getNoOfficialAprvList();

	// 관리자메뉴-공통결재라인 한개 불러오기
	List<MemberVO> getOneOfficialAprvLine(String official_aprv_line_no);
	
	// 관리자메뉴-공통결재라인 저장
	int saveOfficialApprovalLine(OfficialAprvLineVO oapVO);

	// 환경설정-결재라인 수정
	int editApprovalLine(SavedAprvLineVO sapVO);
	
	// 환경설정-결재라인 삭제
	int delApprovalLine(SavedAprvLineVO sapVO);

	// 환경설정-서명이미지 수정
	int updateSignature(Map<String, String> paraMap);
	
	// 기안 상신취소하기
	boolean cancelDraft(DraftVO dvo);

	// 첨부파일 삭제하기
	boolean deleteFiles(Map<String, Object> paraMap);

}
