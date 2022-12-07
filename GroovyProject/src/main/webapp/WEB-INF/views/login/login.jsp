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
		margin: 10% auto 4% auto;
	}
	
	div#container{
		background-color: white;
		padding: 2%;
		min-height: 100px;
		width: 30%;
	}
	
	#btn_join,#btn_next{
		border: none;	
		margin-top: 7%;
	}
	
	#btn_next{
		background-color:  #086BDE; 
		color: white; 
		width: 55px; 
		padding: 1%;
		border-radius: 10%;
		margin-left: 55%;
	}
	
	
	
	div#btn_service{
		color: white;
		font-size: 13px;
		margin-top: 1%;
	}
	
	div#btn_service > a{
		color: white;
		margin-right:2%;
	}
	
	
</style>    
</head>
<body>


<script type="text/javascript">

	$(document).ready(function(){
		
		// === 다음버튼을 누르면 === //
		$("button#btn_next").click(function(){
			func_login();
		}); // end of $("button#btn_next").click(function(){---------------------
			
			
		// 엔터를 했을 경우
		$("input#pwd").keydown(function(e){
			if(e.keyCode == 13) { 
				func_login();
			}
		}); // end of $("input#pwd").keydown(function(e){
			
		
		
		
		
	}); // end of $(document).ready(function(){ ------------------------------

		
	// >>> Function Declartion <<<

	// >>> 다음으로 넘어가는 함수 생성하기 <<< 
	function func_login() {
		
		const cpemail = $("input#cpemail").val();
		
		if(cpemail.trim() == "") {
			alert("이메일을 입력해주세요");
			$("input#email").val("");
			$("input#email").focus();
			return;  // 종료
		}
			
		const frm = document.frm_login
		
		frm.action = "<%= ctxPath%>/login.on";
		frm.method = "POST";
		frm.submit();
		
	} // end of function func_login() {-------------------------


</script>


<div id="myContainer">
<div id="body" align="center" class="flex-content join-content">
<form name="frm_login">

	<div style="color: white; font-size: 30px; font-weight:bold; margin: 3%;">Groovy</div>
	
	<div id="container"  class="card card-body" >
		<h3 style="font-weight: bold;">로그인</h3>
		<p style="color:#b3b3b3 ">Email 주소를 입력하세요.</p>
		
		<input type="email" name="cpemail" id="cpemail" style="width: 90%; background-color:#E3F2FD; border: none; height: 35px; margin:auto;" required/>
		
		<div align="center">
			<button type="button" id="btn_next" style="color: white;" >다음</button>
		</div>
	</div>
	
	<div id="btn_service">
		<a>개인정보 처리방침</a>
		<a>서비스 이용약관</a>
		<a>위치기반서비스 이용약관</a></br>
		<a>마케팅 이용 수신동의</a>
	</div>
	
</form>	
 </div>
</div>


</body>
</html>