package com.spring.groovy.organization.model;

import java.util.List;
import java.util.Map;

public interface InterOrganizationService {

	/** 부서 정보 가져오기 */
	List<Map<String, String>> getDepartmentList();

	int getEmpTotalCount(Map<String, Object> paraMap);

}
