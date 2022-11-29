package com.spring.groovy.approval.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.groovy.approval.model.ApprovalVO;
import com.spring.groovy.approval.model.BiztripReportVO;
import com.spring.groovy.approval.model.DraftFileVO;
import com.spring.groovy.approval.model.DraftVO;
import com.spring.groovy.approval.model.ExpenseListVO;
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
	public List<Map<String, String>> getEmpList(Map<String, Object> paraMap) {
		return dao.getEmpList(paraMap);
	}
	
	// 부문 목록 가져오기
	@Override
	public List<Map<String, String>> getBumunList(Map<String, Object> paraMap) {
		return dao.getBumunList(paraMap);
	}

	// 부서 목록 가져오기
	@Override
	public List<Map<String, String>> getDeptList(Map<String, Object> paraMap) {
		return dao.getDeptList(paraMap);
	}

	// 환경설정 - 결재라인 저장
	@Override
	public int saveApprovalLine(SavedAprvLineVO sapVO) {
		return dao.saveApprovalLine(sapVO);
	}

	// 저장된 결재라인 불러오기
	@Override
	public List<SavedAprvLineVO> getSavedAprvLine(Map<String, String> paraMap) {
		return dao.getSavedAprvLine(paraMap);
	}

	// 저장된 결재라인 결재자 정보 가져오기
	@Override
	public List<MemberVO> getSavedAprvEmpInfo(List<String> empnoList) {
		return dao.getSavedAprvEmpInfo(empnoList);
	}

	// 공통결재라인 목록 불러오기
	@Override
	public List<Map<String, String>> getOfficialAprvList() {
		return dao.getOfficialAprvList();
	}

	// 환경설정-공통결재라인 한개 불러오기
	@Override
	public List<MemberVO> getOneOfficialAprvLine(String official_aprv_line_no) {
		return dao.getOneOfficialAprvLine(official_aprv_line_no);
	}

	// 업무기안 작성하기(트랜잭션)
	@Override
	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public boolean addDraft(Map<String, Object> paraMap) {
		
		int n = 0;
		boolean result = false;

		// 기안문서 번호 생성
		String draft_no = getDraftNo();

		DraftVO dvo = (DraftVO)paraMap.get("dvo");
		dvo.setDraft_no(draft_no); // 생성된 기안번호 set
		
		// 기안 테이블 insert
		n = dao.addDraft(dvo);
		result = (n == 1)? true : false;

		// 기안 테이블 insert가 실패했으면 리턴
		if (!result)
			return result;
		
		// 결재 정보 리스트
		List<ApprovalVO> apvoList = (List<ApprovalVO>) paraMap.get("apvoList");
			
		for (ApprovalVO apvo : apvoList) {
			apvo.setFk_draft_no(draft_no); // 기안번호 set하기
		}
		
		// 결재 테이블 insert
		n = dao.addApproval(apvoList);
		result = (n == apvoList.size())? true : false;
		
		// 결재테이블 insert가 실패했으면 리턴
		if (!result)
			return result;
		
		// 첨부 파일 리스트
		List<DraftFileVO> fileList = (List<DraftFileVO>) paraMap.get("fileList");
		
		// 첨부파일이 있다면
		if (fileList != null && fileList.size() > 0) {
			for (DraftFileVO dfvo : fileList) {
				dfvo.setFk_draft_no(draft_no); // 기안번호 set하기
			}
			
			// 첨부 파일 insert
			n = dao.addFiles(fileList);
			result = (n == fileList.size())? true : false;
			
			// 첨부 파일 테이블 insert가 실패했으면 리턴
			if (!result)
				return result;
		}
		
		// 지출내역 리스트
		List<ExpenseListVO> evoList = (List<ExpenseListVO>) paraMap.get("evoList");
		
		// 지출내역이  있다면
		if (evoList != null && evoList.size() > 0) {
			for (ExpenseListVO evo : evoList) {
				evo.setFk_draft_no(draft_no); // 기안번호 set하기
			}
			
			// 지출내역 insert
			n = dao.addExpenseList(evoList);
			result = (n == evoList.size())? true : false;
			
			// 지출내역 테이블 insert가 실패했으면 리턴
			if (!result)
				return result;
		}
		
		// 출장보고서라면
		BiztripReportVO brvo = (BiztripReportVO)paraMap.get("brvo");
		if (brvo != null) {
			brvo.setFk_draft_no(draft_no); // 기안번호 set하기
			
			// 출장보고 insert
			n = dao.addBiztripReport(brvo);
			result = (n == 1)? true : false;
			
			// 출장보고 테이블 insert가 실패했으면 리턴
			if (!result)
				return result;
		}
		
		return result;
	}

	// 기안문서번호 생성하기
	private String getDraftNo() {
		Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String currentTime = dateFormat.format(currentDate.getTime());
		
		// 시퀀스 번호 얻어오기
		int seq = dao.getDraftNo();
		
		// 기안문서번호 생성 (날짜-시퀀스번호)
		String draft_no = currentTime + "-" + seq;
		return draft_no;
	}
	
	// 업무기안 임시저장하기(트랜잭션)
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
	
	// 30일 지난 임시저장 글 삭제하기
	@Override
	@Scheduled(cron="0 0 0 * * *")
	public void autoDeleteSavedDraft() {
		dao.autoDeleteSavedDraft();
	}

	// 기안문서 조회
	@Override
	public Map<String, Object> getDraftDetail(DraftVO dvo) {
				
		Map<String, Object> draftMap = new HashMap<String, Object>();
		
		// draft에서 select
		dvo = dao.getDraftInfo(dvo);
		draftMap.put("dvo", dvo);
		
		// approval에서 select
		List<ApprovalVO> avoList = dao.getApprovalInfo(dvo);
		draftMap.put("avoList", avoList);
		
		// file에서 select
		List<DraftFileVO> dfvoList = dao.getDraftFileInfo(dvo);
		draftMap.put("dfvoList", dfvoList);
		
		// 지출결의서라면
		if (dvo.getFk_draft_type_no() == 2) {
			List<ExpenseListVO> evoList = dao.getExpenseListInfo(dvo);
			draftMap.put("evoList", evoList);
		}
		
		// 출장보고서라면
		if (dvo.getFk_draft_type_no() == 3) {
			BiztripReportVO brvo = dao.getBiztripReportInfo(dvo);
			draftMap.put("brvo", brvo);
		}
		
		return draftMap;
	}

	// 결재 처리하기
	@Override
	public boolean updateApproval(ApprovalVO avo) {
		
		int n = dao.updateApproval(avo);
		
		return n > 0? true: false; 
	}

	// 공통 결재라인 가져오기
	@Override
	public List<MemberVO> getRecipientList(String type_no) {
		return dao.getRecipientList(type_no);
	}


}
	