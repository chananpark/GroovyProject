package com.spring.groovy.attendance.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

//=== #32. DAO 선언 === 
@Repository
public class AttendanceDAO implements InterAttendanceDAO {
	
	@Resource  // bean 중에서 SqlSessionTemplate 클래스인데 이름(id)이 abc 인 것을 찾는다.
	private SqlSessionTemplate sqlsession; // 로컬 DB mymvc_user 에 연결
	// Type 및 Bean 이름이 동일한 것을  찾아서 주입해준다. 
	
}
