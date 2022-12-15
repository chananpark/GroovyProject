package com.spring.groovy.approval.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groovy.management.model.MemberVO;

@Repository
public class ApprovalDAO implements InterApprovalDAO {
	
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	public ApprovalDAO(SqlSessionTemplate sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Override
	public int getTeamDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("approval.getTeamDraftCnt", paraMap);
	}

	@Override
	public List<DraftVO> getTeamDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getTeamDraftList", paraMap);
	}

	@Override
	public int getSentDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("approval.getSentDraftCnt", paraMap);
	}

	@Override
	public List<DraftVO> getSentDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getSentDraftList", paraMap);
	}

	@Override
	public int getProcessedDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("approval.getProcessedDraftCnt", paraMap);
	}

	@Override
	public List<DraftVO> getProcessedDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getProcessedDraftList", paraMap);
	}
	
	@Override
	public int getSavedDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("approval.getSavedDraftCnt", paraMap);
	}
	
	@Override
	public List<DraftVO> getSavedDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getSavedDraftList", paraMap);
	}

	@Override
	public int deleteDraftList(String[] deleteArr) {
		return sqlsession.delete("approval.deleteDraftList", deleteArr);
	}

	// 진행중 문서 5개 가져오기
	@Override
	public List<DraftVO> getMyDraftProcessing(String empno) {
		return sqlsession.selectList("approval.getMyDraftProcessing", empno);
	}

	// 결재완료 문서 5개 가져오기
	@Override
	public List<DraftVO> getMyDraftProcessed(String empno) {
		return sqlsession.selectList("approval.getMyDraftProcessed", empno);
	}

	// 결재 대기 문서의 문서번호들 조회
	@Override
	public List<String> getRequestedDraftNo(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getRequestedDraftNo", paraMap);
	}
	
	// 결재대기문서 전체 글 개수 조회
	@Override
	public int getRequestedDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("approval.getRequestedDraftCnt", paraMap);
	}

	// 결재대기문서 페이징처리한 리스트 조회
	@Override
	public List<DraftVO> getRequestedDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getRequestedDraftList", paraMap);
	}
	
	// 결재 예정 문서의 문서번호들 조회
	@Override
	public List<Object> getUpcomingDraftNo(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getUpcomingDraftNo", paraMap);
	}
	
	// 결재 예정 문서 전체 글 개수 조회
	@Override
	public int getUpcomingDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("approval.getRequestedDraftCnt", paraMap);
	}
	
	// 결재 예정 문서 페이징처리한 리스트 조회
	@Override
	public List<DraftVO> getUpcomingDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getUpcomingDraftList", paraMap);
	}

	// 사원 목록 가져오기
	@Override
	public List<Map<String, String>> getEmpList(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getEmpList", paraMap);
	}
	
	// 부문 목록 가져오기
	@Override
	public List<Map<String, String>> getBumunList(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getBumunList", paraMap);
	}

	// 부서 목록 가져오기
	@Override
	public List<Map<String, String>> getDeptList(Map<String, Object> paraMap) {
		return sqlsession.selectList("approval.getDeptList", paraMap);
	}

	// 기안문서 번호 얻어오기
	@Override
	public int getDraftNo() {
		return sqlsession.selectOne("approval.getDraftNo");
	}
	
	// draft 테이블에 insert
	@Override
	public int addDraft(DraftVO dvo) {
		return sqlsession.insert("approval.addDraft", dvo);
	}
	
	// approval 테이블에 insert
	@Override
	public int addApproval(List<ApprovalVO> apvoList) {
		return sqlsession.insert("approval.addApproval", apvoList);
	}
	
	// draft_file 테이블에 insert
	@Override
	public int addFiles(List<DraftFileVO> fileList) {
		return sqlsession.insert("approval.addFiles", fileList);
	}

	// 지출내역 리스트 insert
	@Override
	public int addExpenseList(List<ExpenseListVO> evoList) {
		return sqlsession.insert("approval.addExpenseList", evoList);
	}

	// 출장보고 insert
	@Override
	public int addBiztripReport(BiztripReportVO brvo) {
		return sqlsession.insert("approval.addBiztripReport", brvo);
	}

	// 저장된 결재라인 불러오기
	@Override
	public List<SavedAprvLineVO> getSavedAprvLine(Map<String, String> paraMap) {
		return sqlsession.selectList("approval.getSavedAprvLine", paraMap);
	}

	// 저장된 결재라인 결재자 정보 가져오기
	@Override
	public List<MemberVO> getSavedAprvEmpInfo(List<String> empnoList) {
		return sqlsession.selectList("approval.getSavedAprvEmpInfo", empnoList);
	}

	// 환경설정-저장된 결재라인 한개 불러오기
	@Override
	public List<MemberVO> getOneAprvLine(String aprv_line_no) {
		return sqlsession.selectList("approval.getOneAprvLine", aprv_line_no);
	}

	// 환경설정-결재라인 저장
	@Override
	public int saveApprovalLine(SavedAprvLineVO sapVO) {
		return sqlsession.insert("approval.saveApprovalLine", sapVO);
	}
	
	// 환경설정-결재라인 수정
	@Override
	public int editApprovalLine(SavedAprvLineVO sapVO) {
		return sqlsession.insert("approval.editApprovalLine", sapVO);
	}
	
	// 환경설정-결재라인 삭제
	@Override
	public int delApprovalLine(SavedAprvLineVO sapVO) {
		return sqlsession.insert("approval.delApprovalLine", sapVO);
	}

	// 공통 결재라인 불러오기
	@Override
	public List<Map<String, String>> getOfficialAprvList() {
		return sqlsession.selectList("approval.getOfficialAprvList");
	}

	// 환경설정-공통결재라인 한개 불러오기
	@Override
	public List<MemberVO> getOneOfficialAprvLine(String official_aprv_line_no) {
		return sqlsession.selectList("approval.getOneOfficialAprvLine", official_aprv_line_no);
	}

	// 기안 내용 조회
	@Override
	public DraftVO getDraftInfo(DraftVO dvo) {
		return sqlsession.selectOne("approval.getDraftInfo", dvo);
	}

	// 결재정보 조회
	@Override
	public List<ApprovalVO> getApprovalInfo(DraftVO dvo) {
		return sqlsession.selectList("approval.getApprovalInfo", dvo);
	}

	// 첨부파일 조회
	@Override
	public List<DraftFileVO> getDraftFileInfo(DraftVO dvo) {
		return sqlsession.selectList("approval.getDraftFileInfo", dvo);
	}

	// 지출내역 조회
	@Override
	public List<ExpenseListVO> getExpenseListInfo(DraftVO dvo) {
		return sqlsession.selectList("approval.getExpenseListInfo", dvo);
	}
	
	// 출장보고 조회
	@Override
	public BiztripReportVO getBiztripReportInfo(DraftVO dvo) {
		return sqlsession.selectOne("approval.getBiztripReportInfo", dvo);
	}

	// 결재단계 사원번호 조회
	@Override
	public String checkApproval(ApprovalVO avo) {
		return sqlsession.selectOne("approval.checkApproval", avo);
	}

	// 자신의 다음 결재단계 조회
	@Override
	public int checkApprovalProxy(ApprovalVO avo) {
		return sqlsession.selectOne("approval.checkApprovalProxy", avo);
	}

	// 결재 처리하기
	@Override
	public int updateApproval(Map<String, Object> approvalMap) {
		sqlsession.selectOne("approval.updateApproval", approvalMap);
		return (int) approvalMap.get("o_updateCnt");
	}
	
	// 공통 결재라인 가져오기
	@Override
	public List<MemberVO> getRecipientList(String type_no) {
		return sqlsession.selectList("approval.getRecipientList", type_no);
	}

	// 첨부파일 1개 조회
	@Override
	public DraftFileVO getOneAttachedFile(String draft_file_no) {
		return sqlsession.selectOne("approval.getOneAttachedFile", draft_file_no);
	}

	// 모든 첨부파일 조회
	@Override
	public List<DraftFileVO> getAllAttachedFile(String draft_no) {
		return sqlsession.selectList("approval.getAllAttachedFile", draft_no);
	}

	// 관리자메뉴-공통결재라인 저장
	@Override
	public int saveOfficialApprovalLine(OfficialAprvLineVO oapVO) {
		return sqlsession.update("approval.saveOfficialApprovalLine", oapVO);
	}

	// 환경설정-서명이미지 수정
	@Override
	public int updateSignature(Map<String, String> paraMap) {
		return sqlsession.update("approval.updateSignature", paraMap);
	}

	// 임시저장 시퀀스 얻어오기
	@Override
	public String getTempDraftNo() {
		return sqlsession.selectOne("approval.getTempDraftNo");
	}

	// 기안 임시저장하기
	@Override
	public int addTempDraft(DraftVO dvo) {
		return sqlsession.update("approval.addTempDraft", dvo);
	}

	// 결재정보 임시저장하기
	@Override
	public int addTempApproval(List<ApprovalVO> apvoList) {
		return sqlsession.update("approval.addTempApproval", apvoList);
	}

	// 임시 지출내역 insert
	@Override
	public int addTempExpenseList(List<ExpenseListVO> evoList) {
		return sqlsession.update("approval.addTempExpenseList", evoList);
	}

	// 임시 출장보고 insert
	@Override
	public int addTempBiztripReport(BiztripReportVO brvo) {
		return sqlsession.insert("approval.addTempBiztripReport", brvo);
	}
	
	// 30일 지난 임시저장 글 삭제하기
	@Override
	public void autoDeleteSavedDraft() {
		sqlsession.delete("approval.autoDeleteSavedDraft");
	}

	// temp_draft에서 select
	@Override
	public DraftVO getTempDraftInfo(DraftVO dvo) {
		return sqlsession.selectOne("approval.getTempDraftInfo", dvo);
	}
	
	// temp_approval에서 select
	@Override
	public List<ApprovalVO> getTempApprovalInfo(DraftVO dvo) {
		return sqlsession.selectList("approval.getTempApprovalInfo", dvo);
	}

	// temp 지출내역 select
	@Override
	public List<ExpenseListVO> getTempExpenseListInfo(DraftVO dvo) {
		return sqlsession.selectList("approval.getTempExpenseListInfo", dvo);
	}
	
	// temp 출장보고 select
	@Override
	public BiztripReportVO getTempBiztripReportInfo(DraftVO dvo) {
		return sqlsession.selectOne("approval.getTempBiztripReportInfo", dvo);
	}

	// 임시저장된 결재목록 삭제
	@Override
	public int deleteAprvList(String temp_draft_no) {
		return sqlsession.delete("approval.deleteAprvList", temp_draft_no);
	}

	// 임시저장된 지출내역 삭제
	@Override
	public int deleteEvoList(String temp_draft_no) {
		return sqlsession.delete("approval.deleteEvoList", temp_draft_no);
	}

	// 임시저장 문서 삭제
	@Override
	public int deleteTempDraft(String temp_draft_no) {
		return sqlsession.delete("approval.deleteTempDraft", temp_draft_no);
	}

	// draft -> temp_draft 테이블로 옮기기
	@Override
	public int moveDraft(Map<String, Object> paraMap) {
		return sqlsession.update("approval.moveDraft", paraMap);
	}

	// approval -> temp_approval로 옮기기
	@Override
	public int moveApproval(Map<String, Object> paraMap) {
		return sqlsession.update("approval.moveApproval", paraMap);
	}

	// expense_list -> temp_expense_list로 옮기기
	@Override
	public int moveExpenseList(Map<String, Object> paraMap) {
		return sqlsession.update("approval.moveExpenseList", paraMap);
	}

	// biztrip_report -> temp_biztrip_report로 옮기기
	@Override
	public int moveBiztripList(Map<String, Object> paraMap) {
		return sqlsession.update("approval.moveBiztripList", paraMap);
	}

	// 첨부파일 삭제하기
	@Override
	public int deleteFiles(List<DraftFileVO> dfvoList) {
		return sqlsession.delete("approval.deleteFiles", dfvoList);
	}
	
	// 기안 1개 삭제하기
	@Override
	public int deleteOneDraft(String draft_no) {
		return sqlsession.delete("approval.deleteOneDraft", draft_no);
	}

}
