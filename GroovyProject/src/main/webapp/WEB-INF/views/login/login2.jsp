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

<script type="text/javascript">


	$(document).ready(function(){
		
		$("div#first_error").hide();
		$("div#result_error").hide();
		
		$("button#btn_next").click(function(){
			func_login();
		}); // end of $("button#btn_next").click(function(){
		
		// 엔터를 했을 경우
		$("input#pwd").keydown(function(e){
			
			if(e.keyCode == 13) { 
				func_login();
			}
			
		}); // end of $("input#pwd").keydown(function(e){
		
			
		// === 비밀번호 === //
	   	$("input#pwd").blur( function(e) {
	   		
			const $target = $(e.target);
		
			const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-z])(?=.*[^a-z0-9]).*$/g);
			const bool = regExp.test( $target.val() );
			
			 if($target.val() == "") {
		        	// 비밀번호 입력칸이 공백인 경우
		        	 $target.parent().find("div#first_error").show();
		    }
			 else {
				 
					if(!bool) {
						// 암호가 정규표현식에 위배된 경우
						$("div#result_error").show();
					}
					else {
						// 비밀번호 입력칸에 글자가 들어온경우
				       	 $("div#result_error").hide();
					}
			 }
		}); // end of $("input#pwd").blur() ----------------- // 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
	}); // end of $(document).ready(function(){ ----------------------
		
	// >>> Function Declartion <<<
	function findPwd(cpemail){ // -------------------------
		
		const url = "<%=ctxPath%>/findPwd.on";
		const name = "findPwd";
		const option = "width=550, height=500, top=130, left=500";
		
		window.open(url, name, option);
	} // end of function managePopup(){} ---------------
	
	
	// >>> 다음으로 넘어가는 함수 생성하기 <<< 
	function func_login() {
		
		const frm = document.frm_login
		frm.action = "<%= ctxPath%>/login2.on";
		frm.method = "POST";
		frm.submit();
		
	} // end of function func_login() {-------------------------
		
		

</script>


<div id="myContainer">

	<div id="body" class="body" align="center" class="flex-content join-content">
	<form name="frm_login">
	
		<div style="color: white; font-size: 30px; font-weight:bold; margin: 3%;">Groovy</div>
		
		<div id="container" class="card card-body">
			<h3 style="font-weight: bold;">로그인</h3>
			<div style="padding:0 1%; color:#086BDE; border: solid 1px #cccccc; margin: 2% auto; width: 200px; font-size: 13px; padding: 1% 0;" readonly>${loginuser.cpemail}</div>
			<input type="hidden" name="cpemail" value="${loginuser.cpemail}"/>
			
			<div style="color:#b3b3b3; margin: 5% 0 0 5%;" align="left">비밀번호(8자이상 15자 이하로 입력해주세요)</div>
			<input type="password" name="pwd" id="pwd" style="width: 90%; background-color:#E3F2FD; border:none; height: 35px; margin: auto;" autofocus="autofocus" required/>
			<div id="first_error" style="color:red; font-size: 12px;">비밀번호를 입력해주세요</div>
			<div id="result_error">비밀번호 형식에 맞지 않습니다.</div>
			<div></div>
			
			<div style="margin: 5% 0 0 20%;">
				<a onclick="findPwd('cpemail')" name="findPwd">비밀번호를 잊으셨나요?</a>
				<button type="button" id="btn_back" onclick="javascript:history.back()">뒤로</button>
				<button type="button" id="btn_next">다음</button>
			</div>
		</div>
	</form>	
	 </div>
	</div>
</body>
</html>


