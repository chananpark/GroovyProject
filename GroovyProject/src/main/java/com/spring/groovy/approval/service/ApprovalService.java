package com.spring.groovy.approval.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.approval.model.DraftVO;
import com.spring.groovy.approval.model.InterApprovalDAO;

@Service
public class ApprovalService implements InterApprovalService {

	private InterApprovalDAO dao;
	
    @Autowired
    public ApprovalService(InterApprovalDAO dao) {
        this.dao = dao;
    }
	
	@Override
	public int getTeamDraftCnt(Map<String, Object> paraMap) {
		return dao.getTeamDraftCnt(paraMap);
	}

	@Override
	public List<DraftVO> getTeamDraftList(Map<String, Object> paraMap) {
		return dao.getTeamDraftList(paraMap);
	}

	@Override
	public int getSentDraftCnt(Map<String, Object> paraMap) {
		return dao.getSentDraftCnt(paraMap);
	}

	@Override
	public List<DraftVO> getSentDraftList(Map<String, Object> paraMap) {
		return dao.getSentDraftList(paraMap);
	}

	@Override
	public int getProcessedDraftCnt(Map<String, Object> paraMap) {
		return dao.getProcessedDraftCnt(paraMap);
	}

	@Override
	public List<DraftVO> getProcessedDraftList(Map<String, Object> paraMap) {
		return dao.getProcessedDraftList(paraMap);
	}
	
	@Override
	public int getSavedDraftCnt(Map<String, Object> paraMap) {
		return dao.getSavedDraftCnt(paraMap);
	}
	
	@Override
	public List<DraftVO> getSavedDraftList(Map<String, Object> paraMap) {
		return dao.getSavedDraftList(paraMap);
	}

	@Override
	public int deleteDraftList(String[] deleteArr) {
		return dao.deleteDraftList(deleteArr);
	}

	@Override
	public List<DraftVO> getMyDraftProcessed(String empno) {
		return dao.getMyDraftProcessed(empno);
	}

	@Override
	public List<Object> getRequestedDraftNo(Map<String, Object> paraMap) {
		return dao.getRequestedDraftNo(paraMap);
	}
	
	@Override
	public int getRequestedDraftCnt(Map<String, Object> paraMap) {
		return dao.getRequestedDraftCnt(paraMap);
	}

	@Override
	public List<DraftVO> getRequestedDraftList(Map<String, Object> paraMap) {
		return dao.getRequestedDraftList(paraMap);
	}


}
