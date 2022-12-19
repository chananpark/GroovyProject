package com.spring.groovy.community.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.nhncorp.lucy.security.xss.XssPreventer;
import com.spring.groovy.common.FileManager;
import com.spring.groovy.common.Myutil;
import com.spring.groovy.common.Pagination;
import com.spring.groovy.community.model.CommunityCommentVO;
import com.spring.groovy.community.model.CommunityLikeVO;
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

		String unescaped = XssPreventer.unescape(pagination.getSearchWord());
		pagination.setSearchWord(unescaped);
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
		request.setAttribute("communityBackUrl", request.getContextPath() + communityBackUrl);
		
		mav.setViewName("community/post_list.tiles2");
		return mav;
		
	}
	
	// 글내용 조회 페이지요청
	@RequestMapping(value = "/detail.on")
	public ModelAndView getCommunityDetail(ModelAndView mav, HttpServletRequest request, @RequestParam("post_no") String post_no) {
		
		MemberVO loginuser = Myutil.getLoginUser(request);
		
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
		
		MemberVO loginuser = Myutil.getLoginUser(mtfRequest);
		post.setFk_empno(loginuser.getEmpno());
		
		Map<String, Object> paraMap = new HashMap<>();
		
		paraMap.put("post", post);
		paraMap.put("temp_post_no", mtfRequest.getParameter("temp_post_no"));
		
		// service로 넘길 파일정보가 담긴 리스트
		List<CommunityPostFileVO> fileList = new ArrayList<CommunityPostFileVO>();
		
		// 첨부파일이 있을 시
		if (mtfRequest.getFiles("fileList").size() > 0) {
			
			// 파일 업로드 경로 지정
			String path = Myutil.setFilePath(mtfRequest, "files");
			
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
	
	// 글 임시저장하기
	@ResponseBody
	@PostMapping(value = "/savePost.on", produces = "text/plain;charset=UTF-8")
	public String savePost(MultipartHttpServletRequest mtfRequest, CommunityPostVO post) {
		
		MemberVO loginuser = Myutil.getLoginUser(mtfRequest);
		post.setFk_empno(loginuser.getEmpno());
		
		// 제목이 비어있다면
		if (post.getPost_subject() == null || "".equals(post.getPost_subject())) {
			Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
			String currentTime = dateFormat.format(currentDate.getTime());
			
			post.setPost_subject(currentTime + "에 임시저장된 글");
		}
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("post", post);
		paraMap.put("temp_post_no", mtfRequest.getParameter("temp_post_no"));
		
		// 임시저장하기
		String temp_post_no = service.savePost(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("temp_post_no", temp_post_no);
		
		return jsonObj.toString();
		
	}
	
	// 임시저장글 삭제하기
	@ResponseBody
	@PostMapping(value = "/deleteTempPost.on", produces = "text/plain;charset=UTF-8")
	public String deleteSavePost(HttpServletRequest request, @RequestParam("temp_post_no") String temp_post_no) {
		
		MemberVO loginuser = Myutil.getLoginUser(request);
		String empno =  loginuser.getEmpno();
		
		// 임시저장글 조회하기
		CommunityPostVO post = service.getTempPost(temp_post_no);
		
		boolean result = false;
		JSONObject jsonObj = new JSONObject();
		
		if (post.getFk_empno().equals(empno)) {
			// 임시저장 삭제하기
			result = service.delTempPost(temp_post_no);
		} else {
			jsonObj.put("msg", "다른 사람의 임시저장 글은 삭제할 수 없습니다!");
		}
		
		jsonObj.put("result", result);
		
		return jsonObj.toString();
		
	}
	
	// 임시저장 글 불러오기 팝업창 요청
	@RequestMapping(value = "/getSavedPost.on", produces = "text/plain;charset=UTF-8")
	public ModelAndView getSavedPost(ModelAndView mav, HttpServletRequest request) {
		
		MemberVO loginuser = Myutil.getLoginUser(request);
		String fk_empno = loginuser.getEmpno();
		
		// 임시저장 목록 가져오기
		List<Map<String, String>> savedPostList = service.getSavedPostList(fk_empno);
	
		JSONArray savedPostArray = new JSONArray(savedPostList);
		mav.addObject("savedPostArray", String.valueOf(savedPostArray));

		mav.setViewName("community/select_saved_post");

		return mav;
	}
	
	// 글 삭제하기
	@ResponseBody
	@PostMapping(value = "/deletePost.on", produces = "text/plain;charset=UTF-8")
	public String deletePost(HttpServletRequest request, @RequestParam("post_no") String post_no) {
		
		JSONObject json = new JSONObject();

		MemberVO loginuser = Myutil.getLoginUser(request);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("post_no", post_no); // 삭제하려는 글번호
		
		// 조회수 증가 없는 글 조회
		CommunityPostVO post = service.getPostDetail(paraMap);
		
		try {
			// 글 작성자와 로그인한 사용자가 다르다면
			if (!post.getFk_empno().equals(loginuser.getEmpno()))
				json.put("msg", "다른 사용자의 글은 삭제할 수 없습니다!");
			
			else {
				paraMap.put("filePath", Myutil.setFilePath(request, "files")); // 파일 저장 경로
				
				// 파일삭제
				boolean result = service.deleteAttachedFiles(paraMap);
				
				// 파일삭제 성공 시
				if (result) {
					// 게시글 삭제
					result = service.deletePost(paraMap);
				}
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
		
		MemberVO loginuser = Myutil.getLoginUser(request);
		
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
			String path = Myutil.setFilePath(mtfRequest, "files");
			
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
		
		// 파일삭제
		boolean result = service.deleteFile(post_file_no, Myutil.setFilePath(request, "files"));

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

		MemberVO loginuser = Myutil.getLoginUser(request);
		comment.setFk_empno(loginuser.getEmpno());
		
		// 댓글 작성하기
		boolean result = service.addComment(comment);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);

		return jsonObj.toString();
	}
	
	// 답댓글 작성
	@ResponseBody
	@RequestMapping(value = "/addReComment.on", produces = "text/plain;charset=UTF-8")
	public String addReComment(HttpServletRequest request, CommunityCommentVO comment) {

		MemberVO loginuser = Myutil.getLoginUser(request);
		comment.setFk_empno(loginuser.getEmpno());
		
		// 댓글 작성하기
		boolean result = service.addReComment(comment);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		
		return jsonObj.toString();
	}
	
	// 댓글 수정
	@ResponseBody
	@PostMapping(value = "/editComment.on", produces = "text/plain;charset=UTF-8")
	public String editComment(HttpServletRequest request, CommunityCommentVO comment) {

		MemberVO loginuser = Myutil.getLoginUser(request);

		boolean result = false;
		// 댓글 작성자와 로그인한 사용자가 같을때
		if (loginuser.getEmpno().equals(comment.getFk_empno())) {
			// 댓글 수정하기
			result = service.editComment(comment);
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		
		return jsonObj.toString();
		
	}
	
	// 댓글 삭제
	@ResponseBody
	@PostMapping(value = "/delComment.on", produces = "text/plain;charset=UTF-8")
	public String delComment(HttpServletRequest request, CommunityCommentVO comment) {
		
		MemberVO loginuser = Myutil.getLoginUser(request);

		boolean result = false;
		// 댓글 작성자와 로그인한 사용자가 같을때
		if (loginuser.getEmpno().equals(comment.getFk_empno())) {
			// 댓글 삭제하기
			result = service.delComment(comment);
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		
		return jsonObj.toString();
		
	}
	
	// 파일 다운로드
	@ResponseBody
	@RequestMapping(value = "/download.on")
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) {
		
		// 첨부파일 번호
		String post_file_no = request.getParameter("post_file_no");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null;

		try {
			CommunityPostFileVO pfvo = service.getAttachedFile(post_file_no); // 파일 조회
			
			// 글번호가 없거나 파일 이름이 없다면
			if (pfvo == null || (pfvo != null && pfvo.getFilename() == null)) {
				out = response.getWriter();
				out.println("<script type='text/javascript'>alert('존재하지 않는 파일입니다.'); history.back();</script>");
				return;
			}
			
			String filename = pfvo.getFilename(); // 저장된 파일 이름
			String originalFilename = pfvo.getOriginalFilename(); // 원본 파일 이름
			
			// 첨부파일이 저장되어 있는 WAS 서버의 디스크 경로명을 알아온다.
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			String path = root+"resources"+File.separator+"files";
			
			boolean flag = false;// file 다운로드 성공, 실패를 알려주는 용도
			
			// FileManager의 파일 다운로드 메소드 호출
			flag = fileManager.doFileDownload(filename, originalFilename, path, response);
			
			if (!flag) { // 파일 다운로드 실패 시
				out = response.getWriter();
				out.println("<script type='text/javascript'>alert('파일 다운로드 실패');</script>");
			}
			
		} catch (IOException e) { // 입출력예외가 발생한 경우
			try {
				e.printStackTrace();
				out = response.getWriter();
				out.println("<script type='text/javascript'>alert('파일 다운로드 불가');</script>");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}
	
	// 좋아요 목록 조회
	@ResponseBody
	@PostMapping(value = "/getLikeList.on", produces = "text/plain;charset=UTF-8")
	public String getLikeList(@RequestParam("post_no") String post_no) {

		// 좋아요 목록 조회
		List<CommunityLikeVO> likeList = service.getLikeList(post_no);
		
		JSONArray jsonArr = new JSONArray(likeList);
		
		return String.valueOf(jsonArr);
	}
	
	// 좋아요 누르기/취소하기
	@ResponseBody
	@PostMapping(value = "/updateLike.on", produces = "text/plain;charset=UTF-8")
	public String updateLike(HttpServletRequest request, CommunityLikeVO like) {
		
		boolean result = service.updateLike(like);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		
		return jsonObj.toString();
		
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
	
}
