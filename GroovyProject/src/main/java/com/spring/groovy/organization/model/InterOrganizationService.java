package com.spring.groovy.organization.model;

import java.util.List;
import java.util.Map;

public interface InterOrganizationService {

	/** 부서 정보 가져오기 */
	List<Map<String, String>> getDepartmentList();
	/** 페이징 처리할 사원정보 갯수 구하기 */
	int getEmpTotalCount(Map<String, Object> paraMap);
	/** 페이징 처리할 사원정보  구하기 */
	List<Map<String, String>> empListSearchWithPaging(Map<String, Object> paraMap);

}
