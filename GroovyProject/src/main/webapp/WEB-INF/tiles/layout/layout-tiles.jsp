<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 
┌─────┐  ┌─────┐  ┌─────┐ ┌─────┐ ┌─┐  ┌─┐ ┌─┐  ┌─┐
│ ┌───┘  │ ┌─┐ │  │ ┌─┐ │ │ ┌─┐ │ │ │  │ │ │ │  │ │
│ │ ┌──┐ │ └─┘ └┐ │ │ │ │ │ │ │ │ │ │  │ │ │ └──┘ │
│ │ └┐ │ │ ┌──┐ │ │ │ │ │ │ │ │ │ │ │  │ │ └────┐ │
│ └──┘ │ │ │  │ │ │ └─┘ │ │ └─┘ │ └┐└──┘┌┘      │ │
└──────┘ └─┘  └─┘ └─────┘ └─────┘  └────┘       └─┘
 --!>

<title>Groovy :: The Best Groupware</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<<<<<<< HEAD
<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css">
=======
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css">
>>>>>>> branch 'main' of https://github.com/Chanan-Park/GroovyProject.git

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript"
	src="<%=ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="<%=ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="<%=ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>

<%--  jquery-ui --%>
<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.css" />
<script type="text/javascript"
	src="<%=ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

<%-- ajaxForm --%>
<script type="text/javascript"
	src="<%=ctxPath%>/resources/js/jquery.form.min.js"></script>

<%-- sweet alert --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<%-- 폰트 --%>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css" />

<style>
@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css");

*{
	font-family: -apple-system, BlinkMacSystemFont, "Apple SD Gothic Neo", "Pretendard Variable", Pretendard, Roboto, "Noto Sans KR", "Segoe UI", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
}

#myHeader {
	min-height: 100px;
	display: flex;
}

#myHeader nav {
	background-color: white;
}

#myContent {
	min-height: 1200px;
}

#mySide {
	min-height: 1200px;
	background-color: #F9F9F9;
	padding-top: 4%;
}

#mySide a {
	color: black;
}

#mySide .navbar-nav {
	margin-left: 10%;
}

#mySide ul {
	list-style-type: none;
}

#mySide nav li {
	font-size: 12.5pt;
}

#mySide nav li li {
	font-size: 11.5pt;
}

.badge {
	vertical-align: middle;
}
</style>
</head>
<body>
	<div id="myContainer">
		<div id="myHeader">
			<tiles:insertAttribute name="header" />
		</div>

		<div class="row">
			<div class="col col-2 container" id="mySide">
				<tiles:insertAttribute name="side" />
			</div>

			<div class="col m-4 pl-0 pr-4" id="myContent">
				<tiles:insertAttribute name="content" />
			</div>
		</div>
	</div>
</body>
</html>