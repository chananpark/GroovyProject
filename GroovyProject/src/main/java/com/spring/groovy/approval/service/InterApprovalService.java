package com.spring.groovy.approval.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.approval.model.DraftVO;
import com.spring.groovy.common.Pagination;

public interface InterApprovalService {

	int getTeamDraftCnt(Pagination pagination);

	List<DraftVO> getTeamDraftList(Map<String, Object> paraMap);

}
