package com.spring.groovy.organization.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.spring.groovy.organization.service.InterOrganizationDAO;

@Service
public class OrganizationService implements InterOrganizationService {
	
	@Autowired     // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterOrganizationDAO dao;

	@Override
	public List<Map<String, String>> getDepartmentList() {
		List<Map<String, String>> departmentList = dao.getDepartmentList();
		return departmentList;
	}

	@Override
	public int getEmpTotalCount(Map<String, Object> paraMap) {
		int listCnt = dao.getEmpTotalCount(paraMap);
		return listCnt;
	}

	@Override
	public List<Map<String, String>> empListSearchWithPaging(Map<String, Object> paraMap) {
		List<Map<String, String>> empList = dao.empListSearchWithPaging(paraMap);
		return empList;
	}

}
