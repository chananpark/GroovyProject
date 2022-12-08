package com.spring.groovy.common;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommonController {
	@Autowired
	private FileManager fm;
	
	// ==== 스마트에디터. 드래그앤드롭을 사용한 다중사진 파일업로드 ====
	   @RequestMapping(value="/image/multiPhotoUpload.on", method={RequestMethod.POST})
	   public void multiPhotoUpload(HttpServletRequest request, HttpServletResponse response) {
	   
	      HttpSession session = request.getSession();
	      String root = session.getServletContext().getRealPath("/"); 
	      
	      String ctxPath = request.getContextPath();
	      String path = root + "resources"+File.separator+"file"+File.separator+"images";


	      File dir = new File(path);
	      if(!dir.exists()) {
	          dir.mkdirs();
	      }    
	               
	      try {
	           String filename = request.getHeader("file-name");
	                
	             InputStream is = request.getInputStream();
	             
	             String newFilename = fm.doFileUpload(is, filename, path);
	          
	             int width = fm.getImageWidth(path+File.separator+newFilename);
	         
	             if(width > 600) {
	                width = 600;
	             }  
	            
	            
	            String strURL = "";
	            strURL += "&bNewLine=true&sFileName="+newFilename; 
	            strURL += "&sWidth="+width;
	            strURL += "&sFileURL="+ctxPath+"/resources/file/images/"+newFilename;
	            System.out.println("strURL"+strURL);

	            // === 웹브라우저 상에 사진 이미지를 쓰기 === //
	            PrintWriter out = response.getWriter();
	            out.print(strURL);
	            
	      } catch(Exception e){
	            e.printStackTrace();
	      }
	      
	   }
	
}
