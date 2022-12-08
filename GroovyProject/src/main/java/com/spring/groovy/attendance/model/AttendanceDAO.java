package com.spring.groovy.attendance.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groovy.management.model.MemberVO;

//=== #32. DAO 선언 === 
@Repository
public class AttendanceDAO implements InterAttendanceDAO {
	
	@Resource  // bean 중에서 SqlSessionTemplate 클래스인데 이름(id)이 abc 인 것을 찾는다.
	private SqlSessionTemplate sqlsession; // 로컬 DB mymvc_user 에 연결
	// Type 및 Bean 이름이 동일한 것을  찾아서 주입해준다. 

	
	
	// 출근하기
	@Override
	public int goStartWork(Map<String, String> paraMap) {		
		int n = sqlsession.insert("hyewon.goStartWork", paraMap);
		return n;
	}
	
	// 퇴근하기
	@Override
	public int goEndWork(Map<String, String> paraMap) {
		int n = sqlsession.update("hyewon.goEndWork", paraMap);
		return n;
	}

	
	// 사이드바에 출근시간 퇴근시간 얻어오기
	@Override
	public Map<String, String> getWorkTimes(Map<String, String> paraMap) {
		Map<String, String> workTimeMap = sqlsession.selectOne("hyewon.getWorkTimes", paraMap);
		return workTimeMap;
	}
	
	// 사이드바에 부서 얻어오기
	@Override
	public Map<String, String> getDepartment(Map<String, String> paraMap) {
		Map<String, String> partMap = sqlsession.selectOne("hyewon.getDepartment", paraMap);
		return partMap;
	}
	
	// 근태 신청하기 
	@Override
	public int requestAttendance(Map<String, String> paraMap) {
		System.out.println("dao  empno:" + paraMap.get("empno"));
		System.out.println("dao  attend_index:" + paraMap.get("attend_index"));
		System.out.println("dao  usedate:" + paraMap.get("usedate"));
		System.out.println("dao  starttime:" + paraMap.get("starttime"));
		System.out.println("dao  endtime:" + paraMap.get("endtime"));
		System.out.println("dao  place:" + paraMap.get("place"));
		System.out.println("dao  reason:" + paraMap.get("reason"));
		
	
		
		int n = sqlsession.insert("hyewon.requestAttendance", paraMap);
		return n;
	}
	
	
	// my attend status
	@Override
	public List<AttendanceVO> myAttendStatusList(Map<String, String> paraMap) {
		List<AttendanceVO> myAttendStatusList = sqlsession.selectList("hyewon.myAttendStatusList", paraMap);
		return myAttendStatusList;
	}

	// 내 근태조회 상단 박스에 이번주 근무시간 얻어오기
	@Override
	public Map<String, String> getWeeklyWorkTimes(Map<String, String> paraMap) {
		Map<String, String> weeklyWorkTimesMap = sqlsession.selectOne("hyewon.getWeeklyWorkTimes", paraMap);
		return weeklyWorkTimesMap;
	}

	// 내 근태조회 상단 박스에 이번달 근무시간 얻어오기
	@Override
	public Map<String, String> getMonthlyWorkTimes(Map<String, String> paraMap) {
		Map<String, String> monthlyworkTimesMap = sqlsession.selectOne("hyewon.getMonthlyWorkTimes", paraMap);
		return monthlyworkTimesMap;
	}

	
	// 근태 신청내역 조회
	@Override
	public List<AttandanceRequestVO> getRequestList(Map<String, String> paraMap) {
		List<AttandanceRequestVO> getRequestList = sqlsession.selectList("hyewon.getRequestList", paraMap);
		return getRequestList;
	}

	// 근태 사용내역 조회
	@Override
	public List<AttandanceRequestVO> getUsedAttendList(Map<String, String> paraMap) {
		List<AttandanceRequestVO> getUsedAttendList = sqlsession.selectList("hyewon.getUsedAttendList", paraMap);
		return getUsedAttendList;
	}
	
	// 내 근태관리 상단 박스에 기간별 근태상태 얻어오기
	@Override
	public Map<String, String> getBoxAttend(Map<String, String> paraMap) {
		Map<String, String> boxAttendMap = sqlsession.selectOne("hyewon.getBoxAttend", paraMap);
		return boxAttendMap;
	}

	
	// 부서별 근태조회에서 부서정보박스 정보 얻어오기
	@Override
	public List<MemberVO> getTeamInfoBox(Map<String, String> paraMap) {
		List<MemberVO> teamInfoList = sqlsession.selectList("hyewon.getTeamInfoBox", paraMap);				
		return teamInfoList;
	}

	
	// 부서별 근태조회에서 개인정보박스 정보 얻어오기
	@Override
	public Map<String, String> getPersonalInfoBox(Map<String, String> paraMap) {
		Map<String, String> PersonalInfoMap = sqlsession.selectOne("hyewon.getPersonalInfoBox", paraMap);
		
		return PersonalInfoMap;
	}
	
	// 부서별 근태조회에서 회원 근태 정보 얻어오기
	@Override
	public List<Map<String, String>> getWeeklyWorkList(Map<String, String> paraMap) {
		List<Map<String, String>> weeklyWorkList = sqlsession.selectList("hyewon.getWeeklyWorkList", paraMap);
		return weeklyWorkList;
	}

	// [일별] 부서별 근태조회에서 회원 근태 정보 얻어오기
	@Override
	public List<Map<String, String>> getDailyWorkList(Map<String, String> paraMap) {
		List<Map<String, String>> dailyWorkList = sqlsession.selectList("hyewon.getDailyWorkList", paraMap);
		return dailyWorkList;
	}

	// 근태 신청내역 삭제
	@Override
	public int deleteRequest(Map<String, String> paraMap) {
		int n = sqlsession.delete("hyewon.deleteRequest", paraMap);
		return n;
	}

	
	// 부서 근태 관리 - 박스 정보 얻어오기 (출근 미체크)
	@Override
	public String getCntstartnochk(Map<String, String> paraMap) {
		String cntstartnochk = sqlsession.selectOne("hyewon.getCntstartnochk", paraMap);
		return cntstartnochk;
	}
	// 부서 근태 관리 - 박스 정보 얻어오기 (퇴근 미체크)
	@Override
	public String getCntendnochk(Map<String, String> paraMap) {
		String cntendnochk = sqlsession.selectOne("hyewon.getCntendnochk", paraMap);
		return cntendnochk;
	}
	// 부서 근태 관리 - 박스 정보 얻어오기 (무단결근)
	@Override
	public String getCntabsent(Map<String, String> paraMap) {
		String cntabsent = sqlsession.selectOne("hyewon.getCntabsent", paraMap);
		return cntabsent;
	}
	// 부서 근태 관리 - 박스 정보 얻어오기 (연차)
	@Override
	public String getCntdayoff(Map<String, String> paraMap) {
		String cntdayoff = sqlsession.selectOne("hyewon.getCntdayoff", paraMap);
		return cntdayoff;
	}
	// 부서 근태 관리 - 박스 정보 얻어오기 (연장근무)
	@Override
	public String getSumextend(Map<String, String> paraMap) {
		String sumextend = sqlsession.selectOne("hyewon.getSumextend", paraMap);
		return sumextend;
	}

	// 부서관리 총 게시물 건수(totalCount)
	@Override
	public int getTotalCnt(Map<String, Object> filterMap) {
		int totalCnt = sqlsession.selectOne("hyewon.getTotalCnt", filterMap);
		return totalCnt;
	}

	// 페이징처리한 글목록 가져오기(검색까지 포함)
	@Override
	public List<Map<String, String>> getTeamSearchList(Map<String, Object> filterMap) {
		List<Map<String, String>> teamSearchList = sqlsession.selectList("hyewon.getTeamSearchList", filterMap);
		return teamSearchList;
	}
	    
	
	
	
	
	
	 


	
	
}
