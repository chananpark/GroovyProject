package com.spring.groovy.approval.model;

import java.util.List;
import java.util.Map;

import com.spring.groovy.common.Pagination;

public interface InterApprovalDAO {

	int getTeamDraftCnt(Pagination pagination);

	List<DraftVO> getTeamDraftList(Map<String, Object> paraMap);

}
