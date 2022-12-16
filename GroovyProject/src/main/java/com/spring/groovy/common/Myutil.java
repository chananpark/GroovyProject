package com.spring.groovy.common;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.spring.groovy.management.model.MemberVO;

public class Myutil {

	// *** url 에서 ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드 생성하기 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		String currentURL = request.getRequestURL().toString();
		// http://localhost:9090/MyMVC/member/memberList.up 
		// 물음표 앞까지만 나온다.
		
		String queryString = request.getQueryString();
		// sizePerPage=10&currentShowPageNo=5&searchType=name&searchWord=%EC%A0%95 
		// 물음표 다음의 검색어가 포함된 URL 
		// get 방식일 경우
		// post 방식에서는 null 이 나온다.
		
		if(queryString != null) { // get 방식일 경우
			currentURL += "?" + queryString;
		}
		
		String ctxPath = request.getContextPath();
		// MYMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length(); // 21 + 6(/MyMVC)
		
		currentURL = currentURL.substring(beginIndex); // ctxPath 뒤에서 부터 끝까지 잘라온 것
		// /member/memberList.up?sizePerPage=10&currentShowPageNo=5&searchType=name&searchWord=%EC%A0%95
		
		return currentURL;
	}
	
	// ** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 ** //
	public static String secureCode(String str) {
		/*
		// 스마트에디터를 사용하지 않는 경우
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		*/
		
		str = str.replaceAll("<script", "&lt;script");
		
		return str;
	}
	
	// 로그인 사용자 정보 가져오기
	public static MemberVO getLoginUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		return loginuser;
	}
	

	// 파일 업로드 경로 지정
	public static String setFilePath(HttpServletRequest request, String directory) {
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + directory;
		
		return path;
	}
} // end of public class Myutil
