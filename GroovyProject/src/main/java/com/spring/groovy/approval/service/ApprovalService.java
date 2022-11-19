package com.spring.groovy.approval.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.approval.model.DraftVO;
import com.spring.groovy.approval.model.InterApprovalDAO;
import com.spring.groovy.common.Pagination;

@Service
public class ApprovalService implements InterApprovalService {

	private InterApprovalDAO dao;
	
    @Autowired
    public ApprovalService(InterApprovalDAO dao) {
        this.dao = dao;
    }
	
	@Override
	public int getTeamDraftCnt(Pagination pagination) {
		return dao.getTeamDraftCnt(pagination);
	}

	@Override
	public List<DraftVO> getTeamDraftList(Map<String, Object> paraMap) {
		return dao.getTeamDraftList(paraMap);
	}

}
