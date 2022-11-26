package com.spring.groovy.approval.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.groovy.approval.model.ApprovalVO;
import com.spring.groovy.approval.model.DraftFileVO;
import com.spring.groovy.approval.model.DraftVO;
import com.spring.groovy.approval.model.InterApprovalDAO;
import com.spring.groovy.approval.model.SavedAprvLineVO;
import com.spring.groovy.management.model.MemberVO;

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

	// 사원 목록 가져오기
	@Override
	public List<Map<String, String>> getEmpList(MemberVO loginuser) {
		return dao.getEmpList(loginuser);
	}
	
	// 부문 목록 가져오기
	@Override
	public List<Map<String, String>> getBumunList(MemberVO loginuser) {
		return dao.getBumunList(loginuser);
	}

	// 부서 목록 가져오기
	@Override
	public List<Map<String, String>> getDeptList(MemberVO loginuser) {
		return dao.getDeptList(loginuser);
	}

	// 환경설정 - 결재라인 저장
	@Override
	public int saveApprovalLine(SavedAprvLineVO sapVO) {
		return dao.saveApprovalLine(sapVO);
	}

	// 업무기안 작성하기(트랜잭션)
	@Override
	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public boolean addWorkDraft(Map<String, Object> paraMap) {
		
		int n = 0;
		boolean result = false;

		Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String currentTime = dateFormat.format(currentDate.getTime());
		
		// 시퀀스 번호 얻어오기
		int seq = dao.getDraftNo();
		
		// 기안번호 생성 (날짜-시퀀스번호)
		String draft_no = currentTime + "-" + seq;

		DraftVO dvo = (DraftVO)paraMap.get("dvo");
		dvo.setDraft_no(draft_no); // 생성된 기안번호 set
		
		// 기안 테이블 insert
		n = dao.addDraft(dvo);
		result = (n == 1)? true : false;

		// 기안 테이블 insert가 실패했으면 리턴
		if (!result) {
			return result;
		}
		
		// 결재 정보 리스트
		List<ApprovalVO> apvoList = (List<ApprovalVO>) paraMap.get("apvoList");
			
		for (ApprovalVO apvo : apvoList) {
			apvo.setFk_draft_no(draft_no); // 기안번호 set하기
		}
		
		// 결재 테이블 insert
		n = dao.addApproval(apvoList);
		result = (n == apvoList.size())? true : false;

		// 첨부 파일 리스트
		List<DraftFileVO> fileList = (List<DraftFileVO>) paraMap.get("fileList");
		
		// 결재테이블 insert가 실패했거나 첨부파일이 없으면 그대로 result 리턴
		if (!result || fileList.size() == 0) {
			return result;
		}
		
		for (DraftFileVO dfvo : fileList) {
			dfvo.setFk_draft_no(draft_no); // 기안번호 set하기
		}
		
		n = dao.addFiles(fileList);
		result = (n == fileList.size())? true : false;
		
		return result;
	}
	
	// 업무기안 임시저장하기
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public boolean saveWorkDraft(Map<String, Object> paraMap) {

		int n = 0;
		boolean result = false;
		
		// 시퀀스 얻어오기
		int temp_draft_no = dao.getTempDraftNo();
		
		DraftVO dvo = (DraftVO)paraMap.get("dvo");
		dvo.setDraft_no(String.valueOf(temp_draft_no));// 생성된 임시저장번호 set
		
		// 기안 임시저장 테이블 insert
		n = dao.saveDraft(dvo);
		result = (n == 1)? true : false;
		
		// 결재 정보 리스트
		List<ApprovalVO> apvoList = (List<ApprovalVO>) paraMap.get("apvoList");
		
		if (!result || apvoList.size() == 0) {
			return result;
		}

		// 결재 정보가 있다면
		for (ApprovalVO apvo : apvoList)
			apvo.setFk_draft_no(String.valueOf(temp_draft_no)); // 기안번호 set하기
		
		// 결재 테이블 insert
		n = dao.saveApproval(apvoList);
		result = (n == apvoList.size())? true : false;
		
		return result;
	}

	// 저장된 결재라인 불러오기
	@Override
	public List<SavedAprvLineVO> getSavedAprvLine(Map<String, String> paraMap) {
		return dao.getSavedAprvLine(paraMap);
	}

	// 저장된 결재라인 결재자 정보 가져오기
	@Override
	public List<MemberVO> getSavedAprvEmpInfo(List<String> aprvEmpList) {
		return dao.getSavedAprvEmpInfo(aprvEmpList);
	}


}
	