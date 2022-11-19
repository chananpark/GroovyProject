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

}
