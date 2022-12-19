package com.spring.groovy.notice.controller;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.FileManager;
import com.spring.groovy.common.Myutil;
import com.spring.groovy.common.Pagination;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.notice.model.NoticeFileVO;
import com.spring.groovy.notice.model.NoticeVO;
import com.spring.groovy.notice.service.InterNoticeService;

@Component

@Controller
public class NoticeController {
	
	private InterNoticeService service;
	private FileManager fileManager;
	
	@Autowired
	public NoticeController(InterNoticeService service, FileManager fileManager) {
		this.service = service;
		this.fileManager = fileManager;
	}
	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/notice/list.on")
	public ModelAndView noticeList(ModelAndView mav, Pagination pagination, HttpServletRequest request) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		
		Map<String, String> paraMap = BeanUtils.describe(pagination); // pagination을 Map으로
		
		int cnt = service.getNoticeTotalCnt(paraMap); // 전체 글 개수 구하기
		pagination.setPageInfo(cnt); // 총 페이지, 시작행, 마지막행 설정
		paraMap.putAll(BeanUtils.describe(pagination)); // pagination을 Map으로
		
		// 정렬 설정
		setSorting(request, paraMap);

		// 글 목록
		mav.addObject("postList", service.getNoticeList(paraMap));
		
		// 페이지바
		String url = request.getContextPath() + "/notice/list.on";
		pagination.setQueryString("&sortType="+paraMap.get("sortType")+"&sortOrder="+paraMap.get("sortOrder"));
		mav.addObject("pagebar", pagination.getPagebar(url));
		mav.addObject("paraMap", paraMap);
		
		// 현재 url 저장
		String noticeBackUrl = Myutil.getCurrentURL(request);
		HttpSession session = request.getSession();
		session.setAttribute("noticeBackUrl", request.getContextPath() + noticeBackUrl);
		
		mav.setViewName("notice/notice_list.tiles2");
		return mav;
		
	}
	
	
	@RequestMapping(value = "/notice/write.on")
	public ModelAndView getWriteForm(ModelAndView mav, HttpServletRequest request) {
		String groupno = request.getParameter("groupno");
		String fk_seq = request.getParameter("fk_seq");
		String depthno = request.getParameter("depthno");
		String subject = request.getParameter("subject");
		
		mav.addObject("groupno", groupno);
		mav.addObject("depthno", depthno);
		mav.addObject("fk_seq", fk_seq);
		mav.addObject("subject", subject);
		
		mav.setViewName("notice/notice_write.tiles2");
		return mav;
		
	}
	
	// #54. 게시판 글쓰기 완료 요청 === //
	@ResponseBody
	@PostMapping(value="/notice/writeEnd.on", produces = "text/plain;charset=UTF-8")
	public String writeEnd(Map<String, Object> paraMap, NoticeVO noticevo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 + 파일첨부하기
		
		HttpSession session = mrequest.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// System.out.println("컨트롤러 93 empno: "+loginuser.getEmpno());
		
		noticevo.setFk_empno(loginuser.getEmpno());		
		noticevo.setName(loginuser.getName());
		
		// System.out.println("fk_seq: "+noticevo.getFk_seq());
				
		paraMap.put("noticevo", noticevo);
		
		// service로 넘길 파일정보가 담긴 리스트
		List<NoticeFileVO> fileList = new ArrayList<NoticeFileVO>();
		
		// 첨부파일이 있을 시
		if (mrequest.getFiles("fileList").size() > 0) {
			
			// 파일 업로드 경로 지정		
			String root = session.getServletContext().getRealPath("/");				
			String path = root + "resources" + File.separator + "files";
			// System.out.println("path: "+path);
			// path: C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\GroovyProject\resources\files
			
			// view에서 넘어온 파일들
			List<MultipartFile> multiFileList = mrequest.getFiles("fileList");
			
			// 파일 업로드하기
			for (MultipartFile attach : multiFileList) {
				
				String filename = ""; // 저장될 파일명
				String originalFilename = ""; // 원본 파일명
				byte[] bytes = null; // 파일 내용물
				long filesize = 0; // 파일 크기
				
				try {
					// 첨부파일의 내용물을 읽어온다.
					bytes = attach.getBytes();
					
					// originalFilename을 읽어온다.
					originalFilename = attach.getOriginalFilename();
					/*
					System.out.println("originalFilename: "+originalFilename);
					System.out.println("bytes: "+bytes);
					System.out.println("path: "+path);
					*/
					// 새로운 파일명으로 디스크에 저장한다.
					filename = fileManager.doFileUpload(bytes, originalFilename, path);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				NoticeFileVO nfvo = new NoticeFileVO();
				
				nfvo.setFilename(filename);
				nfvo.setOriginalfilename(originalFilename);
				filesize = attach.getSize(); // 첨부파일의 크기 (단위: byte)
				nfvo.setFilesize(String.valueOf(filesize));
				
				fileList.add(nfvo);
			}
		}
		
		paraMap.put("fileList", fileList);
		
		boolean result = service.writeEnd(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);

		return jsonObj.toString();
	}
	
	// 글 상세 페이지
	@RequestMapping(value = "/notice/detail.on")
	public ModelAndView getCommunityDetail(ModelAndView mav, HttpServletRequest request, @RequestParam("seq") String seq) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("seq", seq);
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchType == null) {
			searchType = "";
		}
		if(searchWord == null) {
			searchWord = "";
		}
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		// 글 내용 조회 + 조회수 증가
		NoticeVO noticevo = service.getNoticeDetailViewCnt(paraMap);
		
		// 첨부파일 조회
		List<NoticeFileVO> fileList = service.getFilesDetail(seq);

		mav.addObject("noticevo", noticevo);
		mav.addObject("fileList", fileList);
				
		mav.setViewName("notice/notice_detail.tiles2");
		return mav;
		
	}
	
	
	// 게시글 목록 조회 시 정렬 설정하기
	private void setSorting(HttpServletRequest request, Map<String, String> paraMap) {
		// 정렬기준
		String sortType = request.getParameter("sortType");
		sortType = sortType == null ? "post_date" : sortType;
		paraMap.put("sortType", sortType);

		// 정렬순서
		String sortOrder = request.getParameter("sortOrder");
		sortOrder = sortOrder == null ? "desc" : sortOrder;
		paraMap.put("sortOrder", sortOrder);
	}
	
	// 
	// 글 수정하기 폼 페이지 요청
	@GetMapping(value = "/notice/edit.on")
	public ModelAndView edit(ModelAndView mav, HttpServletRequest request, @RequestParam("seq") String seq) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq); // 수정하려는 글번호
		
		String searchWord = "";
		paraMap.put("searchWord", searchWord);
		
		// 조회수 증가 없는 글 조회
		NoticeVO noticevo = service.getNoticeDetailNoCnt(paraMap);
		
		try {
			// 글 작성자와 로그인한 사용자가 다르다면
			if (!noticevo.getFk_empno().equals(loginuser.getEmpno())) {
				mav.addObject("message", "다른 사용자의 글은 수정할 수 없습니다!");
				mav.addObject("loc", "javascript:history.back()");
				mav.setViewName("msg");
			}
			else {
				mav.addObject("noticevo", noticevo);
				mav.setViewName("notice/notice_edit.tiles2");
			}
			
		} catch (NullPointerException e) {
			// 해당 글이 없다면
			mav.addObject("message", "해당하는 글이 없습니다!");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	// ajax로 첨부파일 가져오기
	@ResponseBody
	@RequestMapping(value = "/notice/getNoticeFiles.on", produces = "text/plain;charset=UTF-8")
	public String getNoticeFiles(HttpServletRequest request, @RequestParam("seq") String seq) {

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq); // 글번호
		
		// 첨부파일 조회
		List<NoticeFileVO> fileList = service.getFilesDetail(seq);
		
		JSONArray jsonArr = new JSONArray(fileList);
		
		return String.valueOf(jsonArr);
	}

	 
	// 글 수정하기 요청
	@ResponseBody
	@PostMapping(value = "/notice/editEnd.on", produces = "text/plain;charset=UTF-8")
	public String editPost(MultipartHttpServletRequest mrequest, NoticeVO noticevo) {
		
		Map<String, Object> paraMap = new HashMap<>();
		
		paraMap.put("noticevo", noticevo);
		
		HttpSession session = mrequest.getSession();
		
		// service로 넘길 파일정보가 담긴 리스트
		List<NoticeFileVO> fileList = new ArrayList<NoticeFileVO>();
		
		// 첨부파일이 있을 시
		if (mrequest.getFiles("fileList").size() > 0) {
			
			// 파일 업로드 경로 지정
			String root = session.getServletContext().getRealPath("/");				
			String path = root + "resources" + File.separator + "files";
			
			// view에서 넘어온 파일들
			List<MultipartFile> multiFileList = mrequest.getFiles("fileList");
			
			// 파일 업로드하기
			for (MultipartFile attach : multiFileList) {
				
				String filename = ""; // 저장될 파일명
				String originalFilename = ""; // 원본 파일명
				byte[] bytes = null; // 파일 내용물
				long filesize = 0; // 파일 크기
				
				try {
					// 첨부파일의 내용물을 읽어온다.
					bytes = attach.getBytes();
					
					// originalFilename을 읽어온다.
					originalFilename = attach.getOriginalFilename();
					
					// 새로운 파일명으로 디스크에 저장한다.
					filename = fileManager.doFileUpload(bytes, originalFilename, path);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				NoticeFileVO nfvo = new NoticeFileVO();
				
				// nfvo set
				nfvo.setFilename(filename);
				nfvo.setOriginalfilename(originalFilename);
				filesize = attach.getSize(); // 첨부파일의 크기 (단위: byte)
				nfvo.setFilesize(String.valueOf(filesize));
				
				fileList.add(nfvo);
				
				// System.out.println("fileList 넘김");
			}
		}
		paraMap.put("fileList", fileList);
		
		// 글 수정하기
		boolean result = service.editNotice(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);

		return jsonObj.toString();
			
	}
	
	// (글 수정) 기존에 첨부된 파일 삭제
	@ResponseBody
	@PostMapping(value = "/notice/deleteFile.on", produces = "text/plain;charset=UTF-8")
	public String deleteFile(HttpServletRequest request, @RequestParam("notice_file_seq") String notice_file_seq) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("notice_file_seq", notice_file_seq); // 삭제하려는 파일번호
		
		HttpSession session = request.getSession();
		
		String root = session.getServletContext().getRealPath("/");				
		String path = root + "resources" + File.separator + "files";
		
		// 파일 테이블에서 파일삭제
		boolean result = service.deleteFile(notice_file_seq, path);

		JSONObject json = new JSONObject();
		json.put("result", result);
		return String.valueOf(json);
	}
	
	
	// 글삭제
	@ResponseBody
	@PostMapping(value = "/notice/deletePost.on", produces = "text/plain;charset=UTF-8")
	public String deletePost(HttpServletRequest request, @RequestParam("seq") String seq) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq); // 삭제하려는 파일번호
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 글 정보 확인
		NoticeVO noticevo = service.getPostInfo(paraMap);
		
		JSONObject json = new JSONObject();
		
		try {
			// 글 작성자와 로그인한 사용자가 다르다면
			if (!noticevo.getFk_empno().equals(loginuser.getEmpno()))
				json.put("msg", "다른 사용자의 글은 삭제할 수 없습니다!");
			
			else { // 글 삭제
				boolean result = service.deletePost(paraMap);
				json.put("msg", (result)? "글이 성공적으로 삭제되었습니다." : "글 삭제를 실패하였습니다.");
			}
			
		} catch (NullPointerException e) {
			// 해당 글이 없다면
			json.put("msg", "해당하는 글이 없습니다!");
		}
		
		return String.valueOf(json);
	}
	
	
}
