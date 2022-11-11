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
<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css">

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
	
<style>
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
	padding-top: 10%;
}

#mySide nav {
	list-style-type: none;
	text-align: center;

}

#mySide nav li {
	display: inline-block;
	font-size: 20px;
	padding: 20px;
}

#mySide .navbar {
	display: inline; !important
}
</style>
</head>
<body>
	<div id="myContainer">
		<div id="myHeader">
			<tiles:insertAttribute name="header" />
		</div>

		<div class="row">
			<div class="col col-3" id="mySide">
				<tiles:insertAttribute name="side" />
			</div>

			<div class="col" id="myContent">
				<tiles:insertAttribute name="content" />
			</div>
		</div>
	</div>
</body>
</html>