package com.spring.groovy.approval.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

}
