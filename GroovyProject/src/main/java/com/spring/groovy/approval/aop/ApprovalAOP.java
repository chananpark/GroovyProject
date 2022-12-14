package com.spring.groovy.approval.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.groovy.common.Myutil;

@Aspect
@Component
public class ApprovalAOP {
	
	@Pointcut("execution(public * com.spring..ApprovalController.*List(..))")
	public void saveCurrentUrl() {}
	
	@Before("saveCurrentUrl()")
	public void loginCheck(JoinPoint joinpoint) {
		HttpServletRequest request = (HttpServletRequest)joinpoint.getArgs()[0];
		
		// 현재 url 저장
		String approvalBackUrl = Myutil.getCurrentURL(request);
		request.setAttribute("approvalBackUrl", request.getContextPath() + approvalBackUrl);
	}
}
