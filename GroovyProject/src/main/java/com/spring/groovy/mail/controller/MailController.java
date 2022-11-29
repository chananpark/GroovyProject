package com.spring.groovy.mail.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;


import com.spring.groovy.common.Pagination;
import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.mail.model.TagVO;
import com.spring.groovy.mail.service.InterMailService;
import com.spring.groovy.management.model.MemberVO;



@Controller
public class MailController {

	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterMailService service;
	
	
	
	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	
	@RequestMapping(value = "/mail/receiveMailBox.on")
	public ModelAndView receiveMailBox(ModelAndView mav, Pagination pagination, HttpServletRequest request) {
		
		
		

		 mav = mailpaginglist(mav, pagination, "FK_Recipient_address", request);
		 mav.addObject("pagebar", pagination.getPagebar("/groovy/mail/receiveMailBox.on"));
		 mav.setViewName("mail/mailbox/receieve_mailbox.tiles");
		// ==> views/tiles/mail/content/mailBox/receieve_mailbox.jsp
		
		return mav;		
	}
	
	@RequestMapping(value = "/mail/sendMailBox.on")
	public ModelAndView sendMailBox(ModelAndView mav, Pagination pagination, HttpServletRequest request) {

		 mav = mailpaginglist(mav, pagination, "FK_Sender_address",request);
		 mav.addObject("pagebar", pagination.getPagebar("/groovy/mail/sendMailBox.on"));
		 mav.setViewName("mail/mailbox/send_mailbox.tiles");
		
		return mav;		
		// ==> views/tiles/mail/content/mailBox/send_mailbox.jsp
	}
	
	@RequestMapping(value = "/mail/importantMailBox.on")
	public ModelAndView importantMailBox(ModelAndView mav, Pagination pagination, HttpServletRequest request) {

		mav = mailpaginglist(mav, pagination, "important",request);
		mav.addObject("pagebar", pagination.getPagebar("/groovy/mail/importantMailBox.on"));
		 mav.setViewName("mail/mailbox/important_mailbox.tiles");
	
		return mav;	
		// ==> views/tiles/mail/content/mailBox/important_mailbox.jsp
	}
	
	@RequestMapping(value = "/mail/writeMail.on")
	public String writeMail(HttpServletRequest request) {
		
		// 자동완성용 메일리스트 가져오기 
		List<String> mailList = service.getMailList();
		


		request.setAttribute("mailList", mailList);

		return "mail/mailbox/write_mail.tiles";
		// ==> views/tiles/mail/content/mailBox/receieve_mailbox.jsp
	}
	
	@RequestMapping(value = "/mail/viewMail.on")
	public String viewMail(HttpServletRequest request) {
		String mailNo = request.getParameter("mailNo");
		
		MailVO mailVO = service.getOneMail(mailNo);
		

		HttpSession session = request.getSession();

		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		Map<String, String> paraMap = new HashedMap<>();
		paraMap.put("mailNo", mailNo);
		paraMap.put("FK_MAIL_ADDRESS", loginuser.getCpemail());
		
		int userIndex = mailVO.getUserindex(loginuser.getCpemail());
		
		String read_check = mailVO.changeArr(mailVO.getRead_check_array(), userIndex, "1");
		paraMap.put("read_check", read_check);
		
		List<TagVO> tagList = null;
		tagList = service.getTagListByMailNo(paraMap);
		
		
		
		request.setAttribute("mailVO", mailVO);
		
		return "mail/mailbox/view_mail.tiles";
		// ==> views/tiles/mail/content/mailBox/receieve_mailbox.jsp
	}
	

	@RequestMapping(value="/mail/download.on")
	public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
		
		String mailNo = request.getParameter("mailNo");
		int index = Integer.parseInt(request.getParameter("index"));
		// 첨부파일이 있는 글번호 
		
		/*
		     첨부파일이 있는 글번호를 가지고
		   tbl_board 테이블에서 filename 컬럼의 값과 orgfilename 컬럼의 값을 가져와야 한다.
		   filename 컬럼의 값은 202210281630581204316300601400.jpg 와 같은 것이고
		   orgfilename 컬럼의 값은  berkelekle심플라운드01.jpg 와 같은 것이다.    
		*/
		

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("mailNo", mailNo);

		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null;
		// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
				
		try {
		     Integer.parseInt(mailNo);
		     MailVO mailvo = service.getOneMail(mailNo);
		
		     if(mailvo == null || (mailvo != null && mailvo.getFilename() == null ) ) {
		    	 out = response.getWriter();
				 // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
					
				 out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일 없으므로 파일다운로드가 불가합니다.'); history.back();</script>"); 
				 return; // 종료
		     }
		     else {
		    	 // 정상적으로 다운로드를 할 경우 
		    	 String fileName = mailvo.getFilename_array().get(index);

			     String orgFilename = mailvo.getOrgfilename_array().get(index);

 
				 String path = "C:\\Users\\sist\\git\\GroovyProject\\GroovyProject\\src\\main\\webapp\\resources\\files";

				 
				 // **** file 다운로드 하기 **** //
				 boolean flag = false;  // file 다운로드 성공, 실패를 알려주는 용도
				 flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
				 // file 다운로드 성공시 flag 는 true,
				 // file 다운로드 실패시 flag 는 false 를 가진다.
				 
				 if(!flag) {
					 // 다운로드가 실패할 경우 메시지를 띄워준다.
					 out = response.getWriter();
					 // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
						
					 out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>"); 
				 }
		     }
		     
		} catch(NumberFormatException | IOException e) {
			try {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			
		}
		
	}

	@ResponseBody
	@RequestMapping(value = "/addMail.on", method= {RequestMethod.POST},produces="text/plain;charset=UTF-8")
	public String addMail(MultipartHttpServletRequest mrequest) {
		
		List<MultipartFile> fileList = mrequest.getFiles("fileList");
		System.out.println(fileList);

		StringBuilder originalFilenamesb =new StringBuilder();
		StringBuilder newFileNamesb =new StringBuilder();
		StringBuilder fileSizesb =new StringBuilder();
		
		String originalFilename ="";
		String newFileName ="";
		String fileSize ="";
		
		JSONObject jsonObj = new JSONObject();
		int n =0;
		
		
		
		
		boolean fileUploadCK = true;
		// 파일 저장
		if( !fileList.isEmpty() ) {
			for(MultipartFile file : fileList) {

				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				
				System.out.println("~~~~ 확인용 webapp 의 절대경로 => " + root);
		//		~~~~ 확인용 webapp 의 절대경로 => > C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\GroovyProject\
				String path = root+"resources"+ File.separator +"files";

		//			System.out.println("~~~~ 확인용 path => " + path);		
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 것	
				try {
					bytes = file.getBytes();
					// 첨부파일의 내용물을 읽어오는 것
					String ogfilename = file.getOriginalFilename();
					originalFilenamesb.append(ogfilename+",");
					newFileNamesb.append(fileManager.doFileUpload(bytes, ogfilename, path)+",");					
					fileSizesb.append(String.valueOf(file.getSize())+","); // 첨부파일의 크기(단위는 byte임)
			
					
				} catch (Exception e) {
					fileUploadCK = false;
					e.printStackTrace();
					
					
				}
			}// end of for
			originalFilename = originalFilenamesb.toString();
			newFileName = newFileNamesb.toString();
			fileSize = fileSizesb.toString();

			originalFilename = 	removeComma(originalFilename);
			newFileName = 	removeComma(newFileName);
			fileSize = 	removeComma(fileSize);

		}// 파일 업로드 끝
		
		if(fileUploadCK) {// 업로드 잘 됐으면 메일 보내기 실행
			
			
			Map<String, Object> paraMap = new HashMap<>();
			
			HttpSession session = mrequest.getSession();

			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			 
			String FK_Sender_address = loginuser.getCpemail();
			System.out.println(FK_Sender_address);
			paraMap.put("FK_Sender_address",FK_Sender_address);
			paraMap.put("FK_Recipient_address",mrequest.getParameter("recipient_address"));
			
			System.out.println("originalFilename"+originalFilename);
			
			paraMap.put("originalFilename",originalFilename);
			paraMap.put("newFileName",newFileName);
			paraMap.put("fileSize",mrequest.getParameter("fileSize"));
			
			paraMap.put("subject",mrequest.getParameter("subject"));
			paraMap.put("contents", secureCode(mrequest.getParameter("contents")));
			
			System.out.println("send_time!"+mrequest.getParameter("send_time"));
			if(mrequest.getParameter("send_time") != "" && mrequest.getParameter("send_time") != null) {
				paraMap.put("send_time",mrequest.getParameter("send_time"));
			}
			else {
				paraMap.put("send_time","");
			}
			
			
			if(mrequest.getParameter("password") != null) {
				String mail_pwd = mrequest.getParameter("password");
				paraMap.put("mail_pwd",mail_pwd);
			}
			else {
				paraMap.put("mail_pwd","");
			}

			n = service.addMail(paraMap); 


		}
		else {// 업로드중 문제 발생
			
			n=-1;
			
		}
		
		jsonObj.put("n", n);

		return jsonObj.toString(); 
		

	}
	
	// 채팅
	@RequestMapping(value = "/chat.on")
	public String chat(HttpServletRequest request) {

		return "chat/chatMain.tiles";
		// ==> views/tiles/chat/content/chatMain.jsp
	}
	
	// 채팅방 띄우기
	@RequestMapping(value = "/chat/chatroom.on")
	public String chatroom(HttpServletRequest request) {

		return "chat/chatroom.tiles";
		// ==> views/tiles/chat/content/chatMain.jsp
	}
	
	// 1. `**Controller**`에 아래와 같이 에러 처리 메소드를 생성한다.
	// 만약 사용자가 **`pageSize`**나 **`currentPage`**에 문자 or 정수형 범위 이상을 입력했다면 에러페이지를 띄우는 것임
	
	@ExceptionHandler(org.springframework.validation.BindException.class)
	public String error(Exception e) {
	    return "error";
	}
	
	///////////////////////////////////////////
	public ModelAndView mailpaginglist(ModelAndView mav,Pagination pagination, String listType, HttpServletRequest request) {
		 Map<String, Object> paraMap = new HashMap<>();
		 HttpSession session = request.getSession();

		 MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

		 String mail_address = loginuser.getCpemail();

		 paraMap.put("mail_address", mail_address);
		 paraMap.put("listType", listType);
		 
		 // 내 태그 가져오기
		 List<TagVO> tagList = null;
		 Map<String, String> paraMap2 = new HashMap<>();
		 paraMap2.put("FK_MAIL_ADDRESS", mail_address);
		 
		 tagList=service.getTagListByMailNo(paraMap2);
		 
		 
		 for(TagVO tag :tagList ) {
		 	System.out.println("getTag_color:"+tag.getTag_color());
			System.out.println("getMail_no_list:"+tag.getMail_no_list());
	
		 }
		 

		 
		 List<MailVO> mailList = null;
		 
		 String searchType = pagination.getSearchType(); 
		 String searchWord = pagination.getSearchWord();
		 System.out.println(searchType);
		 System.out.println(searchWord);
		 // 둘다 없다면 "" 처리
		 if(searchType == null || (!"subject".equals(searchType) && !"FK_Sender_address".equals(searchType)) ) {
			searchType = "";
		 }
		
		 if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
		 	searchWord = "";
		 }
		 paraMap.put("searchType",searchType);
		 paraMap.put("searchWord",searchWord);	
		 

		 
		 // 총 게시물 건수(totalCount)
		 int listCnt  = service.getTotalCount(paraMap);
		 
		 Map<String, Object> resultMap = pagination.getPageRange(listCnt );
		 
		 
		 paraMap.put("startRno",resultMap.get("startRno"));
		 paraMap.put("endRno",(resultMap.get("endRno")));
		 

		
		 
		 mailList = service.mailListSearchWithPaging(paraMap);
		 // 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
		 

		
		// 아래의 것은 검색대상 컬럼과 검색어를 뷰단 페이지에서 유지시키기 위한 것임.
		 if( !"".equals(searchType) && !"".equals(searchWord) ) {
			 mav.addObject("paraMap", paraMap);
		 }
		 
		
	

		System.out.println(mailList);
		mav.addObject("mailList", mailList);
		mav.addObject("tagList", tagList);
		/*
		for(MailVO mail :mailList ) {
			System.out.println("sendTime:"+mail.getSend_time());
	
			System.out.println("send_time_date"+mail.getSend_time_date());
		}
		*/
		return mav;

	}
	
	static String removeComma(String str) {
        if (str.endsWith(",")) {
            return str.substring(0, str.length() - 1);
        }
 
        return str;
    }
	
	static String secureCode(String str) {
		
		/*	
			=== 스마트에디터를 사용 안 할 경우 ===
			str = str.replaceAll("<", "&lt;");
			str = str.replaceAll(">", "&gt;");
		*/	
			// 스마트에디터를 사용할 경우
			str = str.replaceAll("<script", "&lt;script");
			return str;
	}
	


}
