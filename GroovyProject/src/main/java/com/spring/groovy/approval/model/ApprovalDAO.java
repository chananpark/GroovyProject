package com.spring.groovy.approval.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groovy.common.Pagination;

@Repository
public class ApprovalDAO implements InterApprovalDAO {
	
	private SqlSessionTemplate sqlsession;
	
	public ApprovalDAO(SqlSessionTemplate sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Override
	public int getTeamDraftCnt(Pagination pagination) {
		return sqlsession.selectOne("chanan.getTeamDraftCnt", pagination);
	}

	@Override
	public List<DraftVO> getTeamDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getTeamDraftList", paraMap);
	}

	@Override
	public int getSentDraftCnt(Pagination pagination) {
		return sqlsession.selectOne("chanan.getSentDraftCnt", pagination);
	}

	@Override
	public Object getSentDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getSentDraftList", paraMap);
	}

	@Override
	public int getProcessedDraftCnt(Pagination pagination) {
		return sqlsession.selectOne("chanan.getProcessedDraftCnt", pagination);
	}

	@Override
	public Object getProcessedDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getProcessedDraftList", paraMap);
	}
	
	@Override
	public int getSavedDraftCnt(Pagination pagination) {
		return sqlsession.selectOne("chanan.getSavedDraftCnt", pagination);
	}
	
	@Override
	public Object getSavedDraftList(Map<String, Object> paraMap) {
		return sqlsession.selectList("chanan.getSavedDraftList", paraMap);
	}

	@Override
	public int deleteDraftList(String[] deleteArr) {
		return sqlsession.delete("chanan.deleteDraftList", deleteArr);
	}

}
