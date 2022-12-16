<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Page</title>
</head>
<body>
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 400}">
		<h2>error 400</h2>
		<h2>잘못된 요청입니다.</h2>    
	</c:if>	
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
		<h2>error 404</h2>
		<h2>요청하신 페이지를 찾을 수 없습니다.</h2>    
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 405}">
		<h2>error 405</h2>
		<h2>요청된 메소드가 허용되지 않습니다.</h2>    
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 500}">
		<h2>error 500</h2>
		<h2>서버에 오류가 발생하여 요청을 수행할 수 없습니다.</h2>
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 503}">
		<h2>error 503</h2>
		<h2>서비스를 사용할 수 없습니다.</h2>
	</c:if>
</body>
</html>