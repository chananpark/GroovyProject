package com.spring.groovy.approval.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.approval.service.InterApprovalService;
import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.MemberVO;


@Controller
@RequestMapping(value = "/approval/*")
public class ApprovalController {
	
    private InterApprovalService service;
    
    @Autowired
    public ApprovalController(InterApprovalService service) {
        this.service = service;
    }

	// 전자결재 홈 페이지요청
	@RequestMapping(value = "/home.on")
	public String approvalHome(HttpServletRequest request) {

		return "approval/home.tiles";
	}
	
	// 개인문서함-상신함 페이지요청
	@RequestMapping(value = "/personal/sent.on")
	public ModelAndView sentDraftList(ModelAndView mav, Pagination pagination, HttpServletRequest request) {
		
		// 전체 글 개수 구하기
		int listCnt = service.getSentDraftCnt(pagination);

		Map<String, Object> paraMap = pagination.getPageRange(listCnt); // startRno, endRno
		
		MemberVO loginuser = getLoginUser(request);
		// 로그인한 사용자 사원번호
		paraMap.put("empno", loginuser.getEmpno());
		
		// 정렬 설정
		setSorting(request, paraMap);
		
		// 한 페이지에 표시할 글 목록
		mav.addObject("draftList", service.getSentDraftList(paraMap));
		
		// 페이지바
		mav.addObject("pagebar", pagination.getPagebar(request.getContextPath()+"/personal/sent.on"));
		mav.addObject("paraMap", paraMap);
		
		mav.setViewName("approval/my_draft/sent.tiles");
		return mav;
	}
	
	// 개인문서함-결재함 페이지요청
	@RequestMapping(value = "/personal/processed.on")
	public ModelAndView processdDraftList(ModelAndView mav, Pagination pagination, HttpServletRequest request) {

		// 전체 글 개수 구하기
		int listCnt = service.getProcessedDraftCnt(pagination);

		Map<String, Object> paraMap = pagination.getPageRange(listCnt); // startRno, endRno
		
		MemberVO loginuser = getLoginUser(request);
		// 로그인한 사용자 사원번호
		paraMap.put("empno", loginuser.getEmpno());
		
		// 정렬 설정
		setSorting(request, paraMap);
		
		// 한 페이지에 표시할 글 목록
		mav.addObject("draftList", service.getProcessedDraftList(paraMap));
		
		// 페이지바
		mav.addObject("pagebar", pagination.getPagebar(request.getContextPath()+"/personal/processed.on"));
		mav.addObject("paraMap", paraMap);
		
		mav.setViewName("approval/my_draft/processed.tiles");
		return mav;
	}
	
	// 개인문서함-임시저장함 페이지요청
	@RequestMapping(value = "/personal/saved.on")
	public ModelAndView savedDraftList(ModelAndView mav, Pagination pagination, HttpServletRequest request) {

		// 전체 글 개수 구하기
		int listCnt = service.getSavedDraftCnt(pagination);

		Map<String, Object> paraMap = pagination.getPageRange(listCnt); // startRno, endRno
		
		MemberVO loginuser = getLoginUser(request);
		// 로그인한 사용자 사원번호
		paraMap.put("empno", loginuser.getEmpno());
		
		// 정렬 설정
		setSorting(request, paraMap);
		
		// 한 페이지에 표시할 글 목록
		mav.addObject("draftList", service.getSavedDraftList(paraMap));
		
		// 페이지바
		mav.addObject("pagebar", pagination.getPagebar(request.getContextPath()+"/personal/processed.on"));
		mav.addObject("paraMap", paraMap);
		
		mav.setViewName("approval/my_draft/saved.tiles");
		return mav;
	}
	
	// 개인문서함-임시저장함 글삭제
	@ResponseBody
	@PostMapping(value = "/delete.on", produces="text/plain;charset=UTF-8")
	public String deleteDraftList(ModelAndView mav, HttpServletRequest request) {
		
		// 지울 파일 목록
		String deleteList = request.getParameter("deleteList");
		
		String[] deleteArr = deleteList.split(",");
		
		int result = service.deleteDraftList(deleteArr);
			
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",result);
		
		return jsonObj.toString();
	}
	
	// 팀문서함 페이지요청
	@RequestMapping(value = "/team.on")
	public ModelAndView teamDraftList(ModelAndView mav, Pagination pagination, HttpServletRequest request) {
		// 전체 글 개수 구하기
		int listCnt = service.getTeamDraftCnt(pagination);

		Map<String, Object> paraMap = pagination.getPageRange(listCnt); // startRno, endRno
		
		MemberVO loginuser = getLoginUser(request);
		// 로그인한 사용자 부서
		paraMap.put("department", loginuser.getDepartment());
		
		// 정렬 설정
		setSorting(request, paraMap);
		
		// 한 페이지에 표시할 글 목록
		mav.addObject("draftList", service.getTeamDraftList(paraMap));
		
		// 페이지바
		mav.addObject("pagebar", pagination.getPagebar(request.getContextPath()+"/team.on"));
		mav.addObject("paraMap", paraMap);
		
		mav.setViewName("approval/team_draft.tiles"); // View
		return mav;
	}
	
	// 문서함 목록 엑셀 다운로드
	@RequestMapping(value = "excel/downloadExcelFile.on")
	public String downloadExcelFile(Model model, HttpServletRequest request) {
		
		Enumeration<String> params = request.getParameterNames();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
	    while (params.hasMoreElements()) {
	        String key = params.nextElement().toString();
	        String value = request.getParameter(key);

	        map.put(key, value);  
	    }
		
		// 다운로드할 글 목록
		String downloadList = String.valueOf(map.get("downloadList"));
		String[] downloadArray = downloadList.split(",");
		
		// 다운로드할 문서함 이름
		String listName = String.valueOf(map.get("listName"));

		// 헤더 셀에 들어갈 이름 목록
		String header = String.valueOf(map.get("header"));
		String[] headerArray = header.split(",");
		int length = headerArray.length;
		
		// 워크북 객체 생성
		SXSSFWorkbook workbook = new SXSSFWorkbook();

		// 시트생성
		SXSSFSheet sheet = workbook.createSheet(listName);

		// 행의 위치를 나타내는 변수
		int rowLocation = 0;

		// CellStyle 정렬(Alignment)
		CellStyle mergeRowStyle = workbook.createCellStyle(); // 셀 병합 스타일
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);

		CellStyle headerStyle = workbook.createCellStyle(); // 헤더스타일
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);

		// CellStyle 배경색(ForegroundColor)
		mergeRowStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
		mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

		headerStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

		// CellStyle 데이터 포맷 설정하기
		CellStyle moneyStyle = workbook.createCellStyle();
		moneyStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0")); // 천단위 쉼표

		// Cell 폰트(Font) 설정하기
		Font mergeRowFont = workbook.createFont();
		mergeRowFont.setFontName("나눔고딕");
		mergeRowFont.setFontHeight((short) 500);
		mergeRowFont.setColor(IndexedColors.WHITE.getIndex());
		mergeRowFont.setBold(true);
		mergeRowStyle.setFont(mergeRowFont);

		// CellStyle 테두리 Border
		headerStyle.setBorderTop(BorderStyle.THICK);
		headerStyle.setBorderBottom(BorderStyle.THICK);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);

		// Cell Merge 셀 병합시키기

		// 병합할 행 만들기
		Row mergeRow = sheet.createRow(rowLocation); // 0번째 행

		// 병합할 행에 셀 스타일 주기
		for (int i = 0; i < length; i++) {
			Cell cell = mergeRow.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			cell.setCellValue(listName);
		}

		// 셀 병합하기 => 첫 번째 행을 병합한다.
		sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 6)); // 시작 행, 끝 행, 시작 열, 끝 열

		// 헤더 행 생성
		Row headerRow = sheet.createRow(++rowLocation);

		// 헤더 열 생성
		for (int i = 0; i < length; i++) {
			Cell headerCell = headerRow.createCell(i);
			headerCell.setCellValue(headerArray[i]);
			headerCell.setCellStyle(headerStyle);
		}

		// 내용에 해당하는 행 및 셀 생성하기
		Row bodyRow = null;
		Cell bodyCell = null;

		// 반복횟수
		int loop = (int) Math.ceil((downloadArray.length / (length * (1.0))));
	    for(int i = 0, j = 0; i < loop; i++) {
    	
	    	// 행생성
	    	bodyRow = sheet.createRow(i + (rowLocation+1));
	    	
	    	// 열 생성
			for (int k = 0; k < length; k++) {
		    	bodyCell = bodyRow.createCell(k);
		    	bodyCell.setCellValue(downloadArray[j++]);
			}
		    	
	    }
	    
	    sheet.trackAllColumnsForAutoSizing();
		// 열 너비 설정
		for (int i = 0; i < length; i++) {
			sheet.autoSizeColumn(i);
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 700);
		}

		model.addAttribute("locale", Locale.KOREA);
		model.addAttribute("workbook", workbook);
		model.addAttribute("workbookName", listName);

		return "excelDownloadView"; // 엑셀 다운로드 뷰 역할을 해주는 bean
	}
	
	// 결재하기-결재대기문서 페이지요청
	@RequestMapping(value = "/requested.on")
	public String requestedDraftList(HttpServletRequest request) {
		
		return "approval/requested_draft.tiles";
	}
	
	// 업무기안 작성 페이지요청
	@RequestMapping(value = "/write/work.on")
	public String writeWorkDraft(HttpServletRequest request) {
		
		return "approval/write_form/work_form.tiles";
	}
	
	// 지출결의서 작성 페이지요청
	@RequestMapping(value = "/write/expense.on")
	public String writeExpenseReport(HttpServletRequest request) {
		
		return "approval/write_form/expense_form.tiles";
	}
	
	// 출장보고서 작성 페이지요청
	@RequestMapping(value = "/write/businessTrip.on")
	public String writeBusinessTripReport(HttpServletRequest request) {
		
		return "approval/write_form/business_trip_form.tiles";
	}
	
	// 기안조회 페이지요청
	@RequestMapping(value = "/detail.on")
	public String showDraft(HttpServletRequest request) {
		
		// if문으로 기안 종류에 따라 다른 페이지 리턴
		return "approval/draft_detail/work_detail.tiles";
	}	
	
	@RequestMapping(value = "/detail2.on")
	public String showDraft2(HttpServletRequest request) {
		
		return "approval/draft_detail/expense_detail.tiles";
	}	
	
	@RequestMapping(value = "/detail3.on")
	public String showDraft3(HttpServletRequest request) {
		
		return "approval/draft_detail/business_trip_detail.tiles";
	}	
	
	// 결재라인 선택 팝업창 요청
	@RequestMapping(value = "/setApprovalLine.on")
	public String setApprovalLine(HttpServletRequest request) {
		
		// 결재라인 선택 jsp
		return "approval/select_approval_member";
		
	}	
	
	// 환경설정-결재라인관리 페이지요청
	@RequestMapping(value = "/config/approvalLine.on")
	public String configApprovalLine(HttpServletRequest request) {
		
		return "approval/config/approvalLine.tiles";
	}
	
	// 환경설정-결재라인 추가 페이지요청
	@RequestMapping(value = "/config/approvalLine/add.on")
	public String addApprovalLine(HttpServletRequest request) {
		
		return "approval/config/approvalLine_add.tiles";
	}
	
	// 환경설정-서명관리 페이지요청
	@RequestMapping(value = "/config/signature.on")
	public String configSignature(HttpServletRequest request) {
		
		return "approval/config/signature.tiles";
	}
	
	@ExceptionHandler(Exception.class)
	private String error(Exception e) {
		e.printStackTrace();
	    return "error";
	}

	// 로그인 사용자 정보 가져오기
	private MemberVO getLoginUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		return loginuser;
	}

	// 문서함 조회 시 정렬 설정하기
	private void setSorting(HttpServletRequest request, Map<String, Object> paraMap) {
		// 정렬기준
		String sortType = request.getParameter("sortType");
		sortType = sortType == null? "draft_date" : sortType;
		paraMap.put("sortType", sortType);
		
		// 정렬순서
		String sortOrder = request.getParameter("sortOrder");
		sortOrder = sortOrder == null? "desc" : sortOrder;
		paraMap.put("sortOrder", sortOrder);
	}
}
