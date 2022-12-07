package com.spring.groovy.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.Sha256;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.management.service.InterManagementService;

@Controller
public class LoginController {

	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterManagementService service;

	// 로그인 - 처음화면
	@RequestMapping(value="/login.on")
	public ModelAndView login(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String cpemail = request.getParameter("cpemail");
			MemberVO loginuser = service.getLogin(cpemail);
			

			if(loginuser == null) { // 로그인 실패시
				
				String message = "존재하지 않는 이메일입니다.";
				String loc = request.getContextPath()+"/login.on";
				// 원래는 위와 같이 index.action 이 아니라 사용자의 암호를 변경해주는 페이지로 잡아주어야 한다. 
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
				
				return mav;
			}
			
			// 입력한 이메일이 있는경우 
			request.setAttribute("loginuser", loginuser);
			// session(세션)에 로그인 되어진 사용자 정보인 loginuser 를  키이름을 "loginuser" 으로 저장시켜두는 것이다.
			
			mav.setViewName("login/login2");
			return mav;
		}
		else { // GET방식일 경우
			
			mav.setViewName("login/login");
			return mav;
		}
	
	}
	
	  // 로그인 - 비밀번호입력
	 @RequestMapping(value="/login2.on", method= {RequestMethod.POST} ) 
	 public ModelAndView login2(ModelAndView mav,HttpServletRequest request) {
		 
		 ///MemberVO loginuser = (MemberVO) request.getParameter("loginuser");
		 
		 String cpemail = request.getParameter("cpemail");
		 String pwd = request.getParameter("pwd");
		 
		 Map<String,String> paraMap = new HashMap<String, String>();
		 
		 paraMap.put("cpemail", cpemail);
		 paraMap.put("pwd", pwd);
		 
		 MemberVO loginuser = service.login2(paraMap);
		 
		 if(loginuser == null) { // 비밀번호가 틀린경우
				
			String message = "비밀번호가 일치하지 않습니다..";
			String loc = request.getContextPath()+"/login.on";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
			
			return mav;
		}
	 
		 HttpSession session = request.getSession();
		 session.setAttribute("loginuser", loginuser);
		 // session(세션)에 로그인 되어진 사용자 정보인 loginuser 를  키이름을 "loginuser" 으로 저장시켜두는 것이다.
		
		 mav.setViewName("redirect:/index.on");
	 
		return mav;
	 }
	 

	  // 로그인 - 비밀번호 찾기
	 @RequestMapping(value="/findPwd.on" ) 
	 public ModelAndView findPwd(ModelAndView mav,HttpServletRequest request, MemberVO mvo) {
		 mav.setViewName("login/findPwd");
		return mav;
	 }
	 
	  // 로그인 - 비밀번호 찾기 값입력
	 @RequestMapping(value="/findPwdEnd.on", method= {RequestMethod.POST} ) 
	 public ModelAndView findPwdEnd(ModelAndView mav,HttpServletRequest request, MemberVO mvo) {
		 
		 String cpemail = request.getParameter("cpemail");
		 String jubun1 = request.getParameter("jubun1");
		 String jubun2 = request.getParameter("jubun2");
		 
		 String jubun = jubun1+ "-" + jubun2;
		 
		 Map<String,String>paraMap = new HashMap<>();
		 paraMap.put("cpemail",cpemail);
		 paraMap.put("jubun",jubun);
		 
		 MemberVO employee = service.findPwd(paraMap);
		 
		 if(employee == null) { // 이메일과 주민번호가 일치하지 않는경우
				
				String message = "일치하는 정보가 없습니다.";
				String loc = request.getContextPath()+"/login.on";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
				
				return mav;
			}
		 
		 mav.setViewName("login/findPwdEnd");
		 mav.addObject("employee", employee);
		return mav;
	 }
	 
	 
	 
	 
		 
	  // 로그인 - 비밀번호 변경하기
	 @RequestMapping(value="/findPwdChange.on", method= {RequestMethod.POST}) 
	 public ModelAndView findPwdEndReal(ModelAndView mav,HttpServletRequest request, MemberVO mvo) {
		 
		 String cpemail = request.getParameter("cpemail");
		 String pwd = request.getParameter("pwd");
		 
		 Map<String,Object>paraMap = new HashMap<>();
		 paraMap.put("cpemail",cpemail);
		 paraMap.put("pwd",pwd);
		 
		 int n = service.updatePwd(paraMap);
		 
		 if(n != 1) { // 이메일과 주민번호가 일치하지 않는경우
				
			 String message = "비밀번호 변경이 실패되었습니다.";
			 String loc = request.getContextPath()+"/login.on";
			
			 mav.addObject("message", message);
			 mav.addObject("loc", loc);
			 mav.setViewName("msg");
			
			return mav;
			}
		 
			String message = "비밀번호가 변경되었습니다.";
			String loc = request.getContextPath()+"/login.on";
			 
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
			return mav;
	 }
	 
	 
	 // 로그아웃 
	 @RequestMapping(value="/logout.on", method= {RequestMethod.POST}) 
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request){
	

		// 로그아웃시 시작페이지로 돌아가는 것임 //
		HttpSession session = request.getSession();
		session.invalidate();
		
		String message = "로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/login.on";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		mav.setViewName("msg");
		
		return mav;
 
	 }
	
}
