package com.spring.groovy.approval.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groovy.management.model.MemberVO;

@Repository
public class ApprovalDAO implements InterApprovalDAO {
	
	private SqlSessionTemplate sqlsession;
	
	public ApprovalDAO(SqlSessionTemplate sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Override
	public int getTeamDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("chanan.getTeamDraftCnt", paraMap);
	}

	@Override
	public List<DraftVO> getTeamDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getTeamDraftList", paraMap);
	}

	@Override
	public int getSentDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("chanan.getSentDraftCnt", paraMap);
	}

	@Override
	public List<DraftVO> getSentDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getSentDraftList", paraMap);
	}

	@Override
	public int getProcessedDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("chanan.getProcessedDraftCnt", paraMap);
	}

	@Override
	public List<DraftVO> getProcessedDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getProcessedDraftList", paraMap);
	}
	
	@Override
	public int getSavedDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("chanan.getSavedDraftCnt", paraMap);
	}
	
	@Override
	public List<DraftVO> getSavedDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getSavedDraftList", paraMap);
	}

	@Override
	public int deleteDraftList(String[] deleteArr) {
		return sqlsession.delete("chanan.deleteDraftList", deleteArr);
	}

	@Override
	public List<DraftVO> getMyDraftProcessed(String empno) {
		return sqlsession.selectList("chanan.getMyDraftProcessed", empno);
	}

	@Override
	public List<Object> getRequestedDraftNo(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getRequestedDraftNo", paraMap);
	}
	
	@Override
	public int getRequestedDraftCnt(Map<String, Object> paraMap) {
		return sqlsession.selectOne("chanan.getRequestedDraftCnt", paraMap);
	}

	@Override
	public List<DraftVO> getRequestedDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getRequestedDraftList", paraMap);
	}

	// 사원 목록 가져오기
	@Override
	public List<Map<String, String>> getEmpList(MemberVO loginuser) {
		return sqlsession.selectList("chanan.getEmpList", loginuser);
	}
	
	// 부문 목록 가져오기
	@Override
	public List<Map<String, String>> getBumunList(MemberVO loginuser) {
		return sqlsession.selectList("chanan.getBumunList", loginuser);
	}

	// 부서 목록 가져오기
	@Override
	public List<Map<String, String>> getDeptList(MemberVO loginuser) {
		return sqlsession.selectList("chanan.getDeptList", loginuser);
	}

	// 환경설정 - 결재라인 저장
	@Override
	public int saveApprovalLine(SavedAprvLineVO sapVO) {
		return sqlsession.insert("chanan.saveApprovalLine", sapVO);
	}
	
	// 기안문서 번호 얻어오기
	@Override
	public int getDraftNo() {
		return sqlsession.selectOne("chanan.getDraftNo");
	}
	
	// draft 테이블에 insert
	@Override
	public int addDraft(DraftVO dvo) {
		return sqlsession.insert("chanan.addDraft", dvo);
	}
	
	// approval 테이블에 insert
	@Override
	public int addApproval(List<ApprovalVO> apvoList) {
		return sqlsession.update("chanan.addApproval", apvoList);
	}
	
	// draft_file 테이블에 insert
	@Override
	public int addFiles(List<DraftFileVO> fileList) {
		return sqlsession.update("chanan.addFiles", fileList);
	}

	// 저장된 결재라인 불러오기
	@Override
	public List<SavedAprvLineVO> getSavedAprvLine(Map<String, String> paraMap) {
		return sqlsession.selectList("chanan.getSavedAprvLine", paraMap);
	}

	// 저장된 결재라인 결재자 정보 가져오기
	@Override
	public List<MemberVO> getSavedAprvEmpInfo(List<String> aprvEmpList) {
		return sqlsession.selectList("chanan.getSavedAprvEmpInfo", aprvEmpList);
	}

	// 임시저장 시퀀스 얻어오기
	@Override
	public int getTempDraftNo() {
		return sqlsession.selectOne("chanan.getTempDraftNo");
	}

	// 기안 임시저장하기
	@Override
	public int saveDraft(DraftVO dvo) {
		return sqlsession.insert("chanan.saveDraft", dvo);
	}

	// 결재정보 임시저장하기
	@Override
	public int saveApproval(List<ApprovalVO> apvoList) {
		return sqlsession.update("chanan.saveApproval", apvoList);
	}

}
