package com.spring.groovy.community.controller;

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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.FileManager;
import com.spring.groovy.common.Myutil;
import com.spring.groovy.common.Pagination;
import com.spring.groovy.community.model.CommunityCommentVO;
import com.spring.groovy.community.model.CommunityPostFileVO;
import com.spring.groovy.community.model.CommunityPostVO;
import com.spring.groovy.community.service.InterCommunityService;
import com.spring.groovy.management.model.MemberVO;

@Controller
@RequestMapping(value = "/community/*")
public class CommunityController {
	
	private InterCommunityService service;
	private FileManager fileManager;

	@Autowired
	public CommunityController(InterCommunityService service, FileManager fileManager) {
		this.service = service;
		this.fileManager = fileManager;
	}

	// 글 목록 페이지요청
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/list.on")
	public ModelAndView getCommunityList(ModelAndView mav, Pagination pagination, HttpServletRequest request) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		
		Map<String, String> paraMap = BeanUtils.describe(pagination); // pagination을 Map으로

		// 전체 글 개수 구하기
		int listCnt = service.getPostCnt(paraMap);
		pagination.setPageInfo(listCnt); // 총 페이지, 시작행, 마지막행 설정
		paraMap.putAll(BeanUtils.describe(pagination)); // pagination을 Map으로
		
		// 정렬 설정
		setSorting(request, paraMap);

		// 한 페이지에 표시할 글 목록
		mav.addObject("postList", service.getPostList(paraMap));
		
		// 페이지바
		String url = request.getContextPath() + "/community/list.on";
		pagination.setQueryString("&sortType="+paraMap.get("sortType")+"&sortOrder="+paraMap.get("sortOrder"));
		mav.addObject("pagebar", pagination.getPagebar(url));
		mav.addObject("paraMap", paraMap);
		
		// 현재 url 저장
		String communityBackUrl = Myutil.getCurrentURL(request);
		HttpSession session = request.getSession();
		session.setAttribute("communityBackUrl", request.getContextPath() + communityBackUrl);
		
		mav.setViewName("community/post_list.tiles2");
		return mav;
		
	}
	
	// 글내용 조회 페이지요청
	@RequestMapping(value = "/detail.on")
	public ModelAndView getCommunityDetail(ModelAndView mav, HttpServletRequest request, @RequestParam("post_no") String post_no) {
		
		MemberVO loginuser = getLoginUser(request);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("post_no", post_no);
		
		// 글 내용 조회 + 조회수 증가
		CommunityPostVO post = service.getPostDetailWithCnt(paraMap);
		
		// 첨부파일 조회
		List<CommunityPostFileVO> postFileList = service.getPostFiles(post_no);

		mav.addObject("post", post);
		mav.addObject("postFileList", postFileList);
		
		mav.setViewName("community/post_detail.tiles2");
		return mav;
		
	}
	
	// 댓글 조회
	@ResponseBody
	@RequestMapping(value = "/getComment.on")
	public String getComment(HttpServletRequest request, @RequestParam("post_no") String post_no) {
		
		// 댓글 조회
		List<CommunityCommentVO> cmtList = service.getComment(post_no);
		
		JSONArray cmtArr = new JSONArray(cmtList);
		return String.valueOf(cmtArr);
	
	}
	
	// 글 작성 페이지요청
	@RequestMapping(value = "/write.on")
	public ModelAndView getWriteForm(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("community/post_form.tiles2");
		return mav;
		
	}
	
	// 글 작성하기
	@ResponseBody
	@PostMapping(value = "/addPost.on", produces = "text/plain;charset=UTF-8")
	public String addPost(MultipartHttpServletRequest mtfRequest, CommunityPostVO post) {
		
		MemberVO loginuser = getLoginUser(mtfRequest);
		post.setFk_empno(loginuser.getEmpno());
		
		Map<String, Object> paraMap = new HashMap<>();
		
		paraMap.put("post", post);
		
		// service로 넘길 파일정보가 담긴 리스트
		List<CommunityPostFileVO> fileList = new ArrayList<CommunityPostFileVO>();
		
		// 첨부파일이 있을 시
		if (mtfRequest.getFiles("fileList").size() > 0) {
			
			// 파일 업로드 경로 지정
			String path = setFilePath(mtfRequest, "files");
			
			// view에서 넘어온 파일들
			List<MultipartFile> multiFileList = mtfRequest.getFiles("fileList");
			
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
				
				CommunityPostFileVO cfvo = new CommunityPostFileVO();
				
				// cfvo set
				cfvo.setFilename(filename);
				cfvo.setOriginalFilename(originalFilename);
				filesize = attach.getSize(); // 첨부파일의 크기 (단위: byte)
				cfvo.setFilesize(String.valueOf(filesize));
				
				fileList.add(cfvo);
			}
		}
		paraMap.put("fileList", fileList);
		
		boolean result = service.addPost(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);

		return jsonObj.toString();
		
	}
		
	// 글 삭제하기
	@ResponseBody
	@PostMapping(value = "/deletePost.on", produces = "text/plain;charset=UTF-8")
	public String deletePost(HttpServletRequest request, @RequestParam("post_no") String post_no) {
		
		JSONObject json = new JSONObject();

		MemberVO loginuser = getLoginUser(request);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("post_no", post_no); // 삭제하려는 글번호
		
		// 조회수 증가 없는 글 조회
		CommunityPostVO post = service.getPostDetail(paraMap);
		
		try {
			// 글 작성자와 로그인한 사용자가 다르다면
			if (!post.getFk_empno().equals(loginuser.getEmpno()))
				json.put("msg", "다른 사용자의 글은 삭제할 수 없습니다!");
			
			else {
				boolean result = service.deletePost(paraMap);
				json.put("msg", (result)? "글이 성공적으로 삭제되었습니다." : "글 삭제를 실패하였습니다.");
			}
			
		} catch (NullPointerException e) {
			// 해당 글이 없다면
			json.put("msg", "해당하는 글이 없습니다!");
		}
		
		return String.valueOf(json);
	}
	
	// 글 수정하기 폼 페이지 요청
	@GetMapping(value = "/editPost.on")
	public ModelAndView editPost(ModelAndView mav, HttpServletRequest request, @RequestParam("post_no") String post_no) {
		
		MemberVO loginuser = getLoginUser(request);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("post_no", post_no); // 수정하려는 글번호
		
		// 조회수 증가 없는 글 조회
		CommunityPostVO post = service.getPostDetail(paraMap);
		
		try {
			// 글 작성자와 로그인한 사용자가 다르다면
			if (!post.getFk_empno().equals(loginuser.getEmpno())) {
				mav.addObject("message", "다른 사용자의 글은 수정할 수 없습니다!");
				mav.addObject("loc", "javascript:history.back()");
				mav.setViewName("msg");
			}
			else {
				mav.addObject("post", post);
				mav.setViewName("community/edit_form.tiles2");
			}
			
		} catch (NullPointerException e) {
			// 해당 글이 없다면
			mav.addObject("message", "해당하는 글이 없습니다!");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	// 글 수정하기 요청
	@ResponseBody
	@PostMapping(value = "/editPostEnd.on", produces = "text/plain;charset=UTF-8")
	public String editPost(MultipartHttpServletRequest mtfRequest, CommunityPostVO post) {
		
		Map<String, Object> paraMap = new HashMap<>();
		
		paraMap.put("post", post);
		
		// service로 넘길 파일정보가 담긴 리스트
		List<CommunityPostFileVO> fileList = new ArrayList<CommunityPostFileVO>();
		
		// 첨부파일이 있을 시
		if (mtfRequest.getFiles("fileList").size() > 0) {
			
			// 파일 업로드 경로 지정
			String path = setFilePath(mtfRequest, "files");
			
			// view에서 넘어온 파일들
			List<MultipartFile> multiFileList = mtfRequest.getFiles("fileList");
			
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
				
				CommunityPostFileVO cfvo = new CommunityPostFileVO();
				
				// cfvo set
				cfvo.setFilename(filename);
				cfvo.setOriginalFilename(originalFilename);
				filesize = attach.getSize(); // 첨부파일의 크기 (단위: byte)
				cfvo.setFilesize(String.valueOf(filesize));
				
				fileList.add(cfvo);
			}
		}
		paraMap.put("fileList", fileList);
		
		// 글 수정하기
		boolean result = service.editPost(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);

		return jsonObj.toString();
			
	}
	
	// 첨부파일 삭제하기
	@ResponseBody
	@PostMapping(value = "/deleteFile.on", produces = "text/plain;charset=UTF-8")
	public String deleteFile(HttpServletRequest request, @RequestParam("post_file_no") String post_file_no) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("post_file_no", post_file_no); // 삭제하려는 파일번호
		
		// 파일 테이블에서 파일삭제
		boolean result = service.deleteFile(post_file_no, setFilePath(request, "files"));

		JSONObject json = new JSONObject();
		json.put("result", result);
		return String.valueOf(json);
	}
	
	// ajax로 첨부파일 가져오기
	@ResponseBody
	@RequestMapping(value = "/getPostFiles.on", produces = "text/plain;charset=UTF-8")
	public String getPostFiles(HttpServletRequest request, @RequestParam("post_no") String post_no) {

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("post_no", post_no); // 글번호
		
		// 첨부파일 조회
		List<CommunityPostFileVO> postFileList = service.getPostFiles(post_no);
		
		JSONArray jsonArr = new JSONArray(postFileList);
		
		return String.valueOf(jsonArr);
	}
	
	// 댓글 작성
	@ResponseBody
	@RequestMapping(value = "/addComment.on", produces = "text/plain;charset=UTF-8")
	public String addComment(HttpServletRequest request, CommunityCommentVO comment) {

		MemberVO loginuser = getLoginUser(request);
		comment.setFk_empno(loginuser.getEmpno());
		
		// 댓글 작성하기
		boolean result = service.addComment(comment);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);

		return jsonObj.toString();
			
	}
	
	// 로그인 사용자 정보 가져오기
	private MemberVO getLoginUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		return loginuser;
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
	
	// 파일 업로드 경로 지정
	private String setFilePath(HttpServletRequest request, String directory) {
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + directory;
		
		return path;
	}
	
}
