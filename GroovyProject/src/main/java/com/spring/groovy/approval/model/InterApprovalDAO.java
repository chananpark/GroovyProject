package com.spring.groovy.approval.model;

import java.util.List;
import java.util.Map;

import com.spring.groovy.management.model.MemberVO;

public interface InterApprovalDAO {

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

	// 진행중 문서 5개 가져오기
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

	// 결재 예정 문서 페이징처리한 리스트 조회
	List<DraftVO> getUpcomingDraftList(Map<String, Object> paraMap);
	
	// 사원 목록 가져오기
	List<Map<String, String>> getEmpList(Map<String, Object> paraMap);

	// 부문 목록 가져오기
	List<Map<String, String>> getBumunList(Map<String, Object> paraMap);

	// 부서 목록 가져오기
	List<Map<String, String>> getDeptList(Map<String, Object> paraMap);

	// 기안문서 번호 얻어오기
	int getDraftNo();

	// draft 테이블에 insert
	int addDraft(DraftVO dvo);

	// approval 테이블에 insert
	int addApproval(List<ApprovalVO> apvoList);

	// draft_file 테이블에 insert
	int addFiles(List<DraftFileVO> fileList);

	// 지출내역 리스트 insert
	int addExpenseList(List<ExpenseListVO> evoList);

	// 출장보고 insert
	int addBiztripReport(BiztripReportVO brvo);
	
	// 저장된 결재라인 불러오기
	List<SavedAprvLineVO> getSavedAprvLine(Map<String, String> paraMap);

	// 저장된 결재라인 결재자 정보 가져오기
	List<MemberVO> getSavedAprvEmpInfo(List<String> empnoList);

	// 공통결재라인 목록 불러오기
	List<Map<String, String>> getOfficialAprvList();

	// 공통결재라인 없는 양식 목록 불러오기
	List<Map<String, String>> getNoOfficialAprvList();

	// 환경설정 - 결재라인 저장
	int saveApprovalLine(SavedAprvLineVO sapVO);
	
	// 환경설정-결재라인 수정
	int editApprovalLine(SavedAprvLineVO sapVO);
	
	// 환경설정-결재라인 삭제
	int delApprovalLine(SavedAprvLineVO sapVO);

	// 환경설정-공통결재라인 한개 불러오기
	List<MemberVO> getOneOfficialAprvLine(String official_aprv_line_no);
	
	// 환경설정-저장된 결재라인 한개 불러오기
	List<MemberVO> getOneAprvLine(String aprv_line_no);

	// 임시저장 번호 얻어오기
	String getTempDraftNo();

	// 기안 임시저장하기
	int addTempDraft(DraftVO dvo);

	// 결재정보 임시저장하기
	int addTempApproval(List<ApprovalVO> apvoList);

	// 30일 지난 임시저장 글 삭제하기
	void autoDeleteSavedDraft();

	// draft에서 select
	DraftVO getDraftInfo(DraftVO dvo);

	// approval에서 select
	List<ApprovalVO> getApprovalInfo(DraftVO dvo);

	// file에서 select
	List<DraftFileVO> getDraftFileInfo(DraftVO dvo);
	
	// 지출내역 select
	List<ExpenseListVO> getExpenseListInfo(DraftVO dvo);

	// 출장보고 select
	BiztripReportVO getBiztripReportInfo(DraftVO dvo);
	
	// 첨부파일 1개 조회
	DraftFileVO getOneAttachedFile(String draft_file_no);
	
	// 모든 첨부파일 조회
	List<DraftFileVO> getAllAttachedFile(String draft_no);

	// 결재단계 사원번호 조회
	String checkApproval(ApprovalVO avo);
	
	// 자신의 다음 결재단계 조회
	int checkApprovalProxy(ApprovalVO avo);

	// 결재 처리하기
	int updateApproval(Map<String, Object> approvalMap);

	// 기안종류번호로 공통결재라인 가져오기
	List<MemberVO> getRecipientList(String type_no);

	// 관리자메뉴-공통결재라인 삭제하기
	int delOfficialAprvLine(String official_aprv_line_no);

	// 공통결재라인 사용 안함으로 바꾸기
	int setNoUseOfficialAprvLine(String draft_type_no);

	// 공통결재라인 여부 사용으로 변경하기
	int setUseOfficialLine(String draft_type_no);

	// 공통결재선 번호 가져오기
	int getNewOfficialLineNo();

	// 관리자메뉴-공통결재라인 저장
	int saveOfficialApprovalLine(OfficialAprvLineVO oapVO);

	// 환경설정-서명이미지 수정
	int updateSignature(Map<String, String> paraMap);

	// temp_draft에서 select
	DraftVO getTempDraftInfo(DraftVO dvo);

	// temp_approval에서 select
	List<ApprovalVO> getTempApprovalInfo(DraftVO dvo);
	
	// temp 지출내역 select
	List<ExpenseListVO> getTempExpenseListInfo(DraftVO dvo);

	// temp 출장보고 select
	BiztripReportVO getTempBiztripReportInfo(DraftVO dvo);

	// 임시 지출내역 insert
	int addTempExpenseList(List<ExpenseListVO> evoList);

	// 임시 출장보고 insert
	int addTempBiztripReport(BiztripReportVO brvo);

	// 임시저장된 결재목록 삭제
	int deleteAprvList(String temp_draft_no);

	// 임시저장된 지출내역 삭제
	int deleteEvoList(String temp_draft_no);

	// 임시저장 문서 삭제
	int deleteTempDraft(String temp_draft_no);

	// draft -> temp_draft 테이블로 옮기기
	int moveDraft(Map<String, Object> paraMap);

	// approval -> temp_approval로 옮기기
	int moveApproval(Map<String, Object> paraMap);

	// expense_list -> temp_expense_list로 옮기기
	int moveExpenseList(Map<String, Object> paraMap);

	// biztrip_report -> temp_biztrip_report로 옮기기
	int moveBiztripList(Map<String, Object> paraMap);

	// 첨부파일 삭제하기
	int deleteFiles(List<DraftFileVO> dfvoList);

	// 기안 1개 삭제하기
	int deleteOneDraft(String draft_no);

}
