package com.spring.groovy.approval.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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

import com.spring.groovy.approval.service.InterApprovalService;
import com.spring.groovy.common.Pagination;


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
	public String sentDraftList(HttpServletRequest request) {
		
		return "approval/my_draft/sent.tiles";
	}
	
	// 개인문서함-결재함 페이지요청
	@RequestMapping(value = "/personal/processed.on")
	public String processdDraftList(HttpServletRequest request) {
		
		return "approval/my_draft/processed.tiles";
	}
	
	// 개인문서함-임시저장함 페이지요청
	@RequestMapping(value = "/personal/saved.on")
	public String savedDraftList(HttpServletRequest request) {
		
		return "approval/my_draft/saved.tiles";
	}
	
	// 팀문서함 페이지요청
	@RequestMapping(value = "/team.on")
	public ModelAndView teamDraftList(ModelAndView mav, Pagination pagination, @RequestParam(value = "sortType", required = false) String sortType) {
		// 전체 글 개수 구하기
		int listCnt = service.getTeamDraftCnt(pagination);

		// startRno, endRno
		Map<String, Object> paraMap = pagination.getPageRange(listCnt);
		
		// 정렬기준
		sortType = sortType == null? "desc" : sortType;
		paraMap.put("sortType", sortType);
		
		// 한 페이지에 표시할 글 목록
		mav.addObject("draftList", service.getTeamDraftList(paraMap));
		
		// 페이지바
		mav.addObject("pagebar", pagination.getPagebar("/groovy/team.on"));
		mav.addObject("paraMap", paraMap);
		
		mav.setViewName("approval/team_draft.tiles"); // View
		return mav;
	}
	
	@RequestMapping(value = "excel/downloadExcelFile.on")
	public String downloadExcelFile(Model model,  @RequestParam("downloadList") String downloadList) {
		
		String[] downloadArray = downloadList.split(",");
		
		// 워크북 객체 생성
		SXSSFWorkbook workbook = new SXSSFWorkbook();

		// 시트생성
		SXSSFSheet sheet = workbook.createSheet("팀 문서함 목록");

		// 열 너비 설정
		sheet.setColumnWidth(0, 3000);
		sheet.setColumnWidth(1, 3000);
		sheet.setColumnWidth(2, 3000);
		sheet.setColumnWidth(3, 2000);
		sheet.setColumnWidth(4, 4000);
		sheet.setColumnWidth(5, 2000);
		sheet.setColumnWidth(6, 2500);

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
		for (int i = 0; i < 7; i++) {
			Cell cell = mergeRow.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			cell.setCellValue("팀 문서함 목록");
		}

		// 셀 병합하기 => 첫 번째 행을 병합한다.
		sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 6)); // 시작 행, 끝 행, 시작 열, 끝 열

		// 헤더 행 생성
		Row headerRow = sheet.createRow(++rowLocation);

		// 해당 행의 첫번째 열 셀 생성
		Cell headerCell = headerRow.createCell(0);
		headerCell.setCellValue("결재완료일");
		headerCell.setCellStyle(headerStyle);

		// 해당 행의 두번째 열 셀 생성
		headerCell = headerRow.createCell(1);
		headerCell.setCellValue("기안일");
		headerCell.setCellStyle(headerStyle);

		// 해당 행의 세번째 열 셀 생성
		headerCell = headerRow.createCell(2);
		headerCell.setCellValue("종류");
		headerCell.setCellStyle(headerStyle);

		// 해당 행의 네번째 열 셀 생성
		headerCell = headerRow.createCell(3);
		headerCell.setCellValue("문서번호");
		headerCell.setCellStyle(headerStyle);

		// 해당 행의 다섯번째 열 셀 생성
		headerCell = headerRow.createCell(4);
		headerCell.setCellValue("제목");
		headerCell.setCellStyle(headerStyle);

		// 해당 행의 여섯번째 열 셀 생성
		headerCell = headerRow.createCell(5);
		headerCell.setCellValue("기안자");
		headerCell.setCellStyle(headerStyle);

		// 해당 행의 일곱번째 열 셀 생성
		headerCell = headerRow.createCell(6);
		headerCell.setCellValue("결재상태");
		headerCell.setCellStyle(headerStyle);

		// 내용에 해당하는 행 및 셀 생성하기
		Row bodyRow = null;
		Cell bodyCell = null;

		int loop = (int) Math.ceil((downloadArray.length / 7.0));
	    for(int i = 0, j = 0; i < loop; i++) {
    	
	    	// 행생성
	    	bodyRow = sheet.createRow(i + (rowLocation+1));
	    	
	    	// 결재완료일
	    	bodyCell = bodyRow.createCell(0);
	    	bodyCell.setCellValue(downloadArray[j++]);
	    	
	    	// 기안일
	    	bodyCell = bodyRow.createCell(1);
	    	bodyCell.setCellValue(downloadArray[j++]); 
	    	
	    	// 종류
	    	bodyCell = bodyRow.createCell(2);
	    	bodyCell.setCellValue(downloadArray[j++]); 
	    	
	    	// 문서번호
	    	bodyCell = bodyRow.createCell(3);
	    	bodyCell.setCellValue(downloadArray[j++]); 
	        	
	    	// 제목
	    	bodyCell = bodyRow.createCell(4);
	    	bodyCell.setCellValue(downloadArray[j++]); 
	    	
	    	// 기안자
	    	bodyCell = bodyRow.createCell(5);
	    	bodyCell.setCellValue(downloadArray[j++]);
	    	
	    	// 결재상태
	    	bodyCell = bodyRow.createCell(6);
	    	bodyCell.setCellValue(downloadArray[j++]); 
		    	
	    }

		model.addAttribute("locale", Locale.KOREA);
		model.addAttribute("workbook", workbook);
		model.addAttribute("workbookName", "팀 문서함 목록");

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
	
	// 결재라인 선택 페이지요청
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
	
	// 환경설정-서명관리 페이지요청
	@RequestMapping(value = "/config/signature.on")
	public String configSignature(HttpServletRequest request) {
		
		return "approval/config/signature.tiles";
	}
	
	@ExceptionHandler(java.sql.SQLSyntaxErrorException.class)
	public String error(Exception e) {
		e.printStackTrace();
	    return "error";
	}
	
	@ExceptionHandler(org.springframework.validation.BindException.class)
	public String error2(Exception e) {
		e.printStackTrace();
		return "error";
	}

}
