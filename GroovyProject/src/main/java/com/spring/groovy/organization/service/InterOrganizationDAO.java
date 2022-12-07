package com.spring.groovy.organization.service;

import java.util.List;
import java.util.Map;

public interface InterOrganizationDAO {

	List<Map<String, String>> getDepartmentList();

	/** 페이징 할 목록의 수 가져오기 */
	int getEmpTotalCount(Map<String, Object> paraMap);
	/** 페이징 처리할 목록 가져오기 */
	List<Map<String, String>> empListSearchWithPaging(Map<String, Object> paraMap);


}
