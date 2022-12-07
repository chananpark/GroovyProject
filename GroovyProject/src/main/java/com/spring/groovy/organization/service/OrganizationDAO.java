package com.spring.groovy.organization.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class OrganizationDAO implements InterOrganizationDAO {
	@Resource
	private SqlSessionTemplate sqlsession;

	@Override
	public List<Map<String, String>> getDepartmentList() {
		List<Map<String, String>> departmentList = sqlsession.selectList("jinseok.getDepartmentList");
		return departmentList;
	}

	@Override
	public int getEmpTotalCount(Map<String, Object> paraMap) {
		int n = sqlsession.selectOne("jinseok.getEmpTotalCount", paraMap);

		return n;
	}

	@Override
	public List<Map<String, String>> empListSearchWithPaging(Map<String, Object> paraMap) {
		List<Map<String, String>> empList = sqlsession.selectList("jinseok.empListSearchWithPaging", paraMap);
		return empList;
	}
	
	
	
}
