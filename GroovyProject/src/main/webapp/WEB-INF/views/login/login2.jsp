<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


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

	body{
		background-color: #086BDE;
	}
	
	div#container{
		background-color: white;
		padding: 1%;
		min-height: 100px;
		width: 55%;
	}

	div#body{
		width: 55%;
		margin-top: 10%;
		margin: 10% auto 4% auto;
	}
	
	div#container{
		background-color: white;
		padding: 3%;
		min-height: 200px;
	}
	
	#btn_join,#btn_back,#btn_next{
		border: none;	
	}
	
	#btn_next{
		background-color:  #086BDE; 
		color: white; 
		width: 55px; 
		padding: 1%;
		border-radius: 10%;
	}
	
	#btn_back{
		background-color: #d9d9d9; 
		color:black;
		width: 55px; 
		padding: 1%;
		border-radius: 10%;
	}
	
	input {
		cursor: pointer;
	}
	
	
	input:focus {
		border: solid 2px #086BDE;
	}
	
	
</style>    
</head>
<body>
<div id="myContainer">

	<div id="body" class="body" align="center" class="flex-content join-content">
	<form name="frm_login">
	
		<div style="color: white; font-size: 30px; font-weight:bold; margin: 3%;">Groovy</div>
		
		<div id="container" class="card card-body">
			<h3 style="font-weight: bold;">로그인</h3>
			<input neme="email" style="padding: 0 1%; color:#086BDE; border: solid 1px #cccccc; margin: 2% auto;" readonly/>
			
			<div style="color:#b3b3b3; margin: 5% 0 0 5%;" align="left" >비밀번호(8자이상 32자 이하로 입력해주세요)</div>
			<input type="text" name="email" style="width: 90%; border: solid 2px #086BDE; height: 35px; margin: auto;" autofocus required/>
			<div align="left" style="color:#b3b3b3; margin: 2% 0 0 5%;"><input type="checkbox" />자동로그인</div>
			
			<div style="margin: 2% 0 0 20%;">
				<button type="button" style="background-color: white; border: none;"><a href="#">비밀번호를 잊으셨나요?</a></button>
				<button type="button" id="btn_back" onclick="javascript:history.back()">뒤로</button>
				<button type="button" id="btn_next" >다음</button>
			</div>
		</div>
		
	</form>	
	 </div>
	</div>
</body>
</html>


