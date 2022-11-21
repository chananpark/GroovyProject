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

	@Override
	public int getSentDraftCnt(Pagination pagination) {
		return dao.getSentDraftCnt(pagination);
	}

	@Override
	public Object getSentDraftList(Map<String, Object> paraMap) {
		return dao.getSentDraftList(paraMap);
	}

	@Override
	public int getProcessedDraftCnt(Pagination pagination) {
		return dao.getProcessedDraftCnt(pagination);
	}

	@Override
	public Object getProcessedDraftList(Map<String, Object> paraMap) {
		return dao.getProcessedDraftList(paraMap);
	}
	
	@Override
	public int getSavedDraftCnt(Pagination pagination) {
		return dao.getSavedDraftCnt(pagination);
	}
	
	@Override
	public Object getSavedDraftList(Map<String, Object> paraMap) {
		return dao.getSavedDraftList(paraMap);
	}

	@Override
	public int deleteDraftList(String[] deleteArr) {
		return dao.deleteDraftList(deleteArr);
	}

}
