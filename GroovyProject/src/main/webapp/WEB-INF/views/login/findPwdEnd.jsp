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
	
	#myContainer {
		padding-top: 5%;
	}
	
	
	input#cpemail {
		border: solid 1px #d9d9d9;
		margin-bottom: 1%;
	}
	
	input#jubun1,input#jubun2 {
		width: 85px;
		border: solid 1px #d9d9d9;
	}
	
	#btn_next{
		background-color:  #086BDE; 
		color: white; 
		width: 55px; 
		padding: 1%;
		border-radius: 10%;
		border: none;
	}
	
	th {
		width: 80px;
	}
	
</style>    
</head>
<body>


<script type="text/javascript">

	$(document).ready(function(){
		
		
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
		
	$("input#pwdCheck").blur( function(e) {
	   		
		const pwdCheck = $(e.target).val();
	
		const pwd = $("input#pwd").val();
		
		 if(pwdCheck != pwd) { // 비밀번호와 일치하지 않는경우
                	 $("div#pwdCheck").show();
	    }
		 
		 if(pwdCheck == "") {// 비밀번호 입력칸이 공백인 경우
			 $("div#first_error").show();
		 }
			 
			func_update();
	}); // end of $("input#pwd").blur() ----------------- // 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		
		$("button#btn_next").click(function(){
			func_next();
		}); // end of $("button#btn_next").click(function(){ -------------------
	
		
		
	}); // end of $(document).ready(function(){ ------------------------------

		
	// >>> Function Declartion <<<

	// >>> 다음으로 넘어가는 함수 생성하기 <<< 
	function func_update() {
		const frm = document.frm_findPwd;
		frm.url = "<%=ctxPath%>/findPwdEndReal.on";
		frm.action="POST";
		frm.submit();
	}

	

</script>


<div id="myContainer">
<div id="body" align="center" class="flex-content join-content">
<form name="frm_findPwd">

	<div id="container"  class="card card-body" >
		<h3 style="font-weight: bold;">비밀번호 찾기</h3>
		<p style="color:#b3b3b3 ">변경할 비밀번호를 입력해주세요</p>
		
		<table style="margin: 2% auto;">
			<tbody>
			<tr>
				<th>비밀번호 : </th>
				<td><input type="text" name="pwd" id="pwd" required/>
					<div id="first_error" style="color:red; font-size: 12px;">비밀번호를 입력해주세요</div>
					<div id="result_error">비밀번호 형식에 맞지 않습니다.</div>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인 :  </th>
				<td><input type="text" id="pwdCheck"required/>
					<div id="first_error" style="color:red; font-size: 12px;">비밀번호확인을 입력해주세요</div>
					<div id="result_error">비밀번호 형식에 맞지 않습니다.</div>
					<div id="pwdCheck">비밀번호가 일치하지 않습니다.</div>
				</td>
			</tr>
			
			</tbody>
		</table>
		<div align="center" class="mt-3">
			<button type="button" id="btn_next">다음</button>
		</div>
	</div>
	
	
	
</form>	
 </div>
</div>


</body>
</html>