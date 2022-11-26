package com.spring.groovy.approval.service;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;

import com.spring.groovy.approval.model.DraftVO;
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

	// 결재완료된 문서 5개 가져오기
	List<DraftVO> getMyDraftProcessed(String empno);

	// 결재 대기 문서의 문서번호들 조회
	List<Object> getRequestedDraftNo(Map<String, Object> paraMap);
	
	// 결재대기문서 전체 글 개수 조회
	int getRequestedDraftCnt(Map<String, Object> paraMap);
	
	// 결재대기문서 페이징처리한 리스트 조회
	List<DraftVO> getRequestedDraftList(Map<String, Object> paraMap);

	// 사원 목록 가져오기
	List<Map<String, String>> getEmpList(MemberVO loginuser);

	// 부문 목록 가져오기
	List<Map<String, String>> getBumunList(MemberVO loginuser);
	
	// 부서 목록 가져오기
	List<Map<String, String>> getDeptList(MemberVO loginuser);

	// 환경설정 - 결재라인 저장
	int saveApprovalLine(SavedAprvLineVO sapVO);

	// 업무기안 작성하기
	boolean addWorkDraft(Map<String, Object> paraMap);
	
	// 저장된 결재라인 불러오기
	List<SavedAprvLineVO> getSavedAprvLine(Map<String, String> paraMap);

	// 저장된 결재라인 결재자 정보 가져오기
	List<MemberVO> getSavedAprvEmpInfo(List<String> aprvEmpList);
	
	// 업무기안 임시저장하기
	boolean saveWorkDraft(Map<String, Object> paraMap);

}
