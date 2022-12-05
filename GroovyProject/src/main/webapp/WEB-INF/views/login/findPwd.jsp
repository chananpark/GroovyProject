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
		
		$("button#btn_next").click(function(){
			func_next();
		}); // end of $("button#btn_next").click(function(){ -------------------
	
		
		
	}); // end of $(document).ready(function(){ ------------------------------

		
	// >>> Function Declartion <<<

	// >>> 다음으로 넘어가는 함수 생성하기 <<< 
	function func_next() {
		const frm = document.frm_findPwd;
		frm.url = "<%=ctxPath%>/findPwdEnd.on";
		frm.action="POsT";
		frm.submit();
	}

	

</script>


<div id="myContainer">
<div id="body" align="center" class="flex-content join-content">
<form name="frm_findPwd">

	<div id="container"  class="card card-body" >
		<h3 style="font-weight: bold;">비밀번호 찾기</h3>
		<p style="color:#b3b3b3 ">Email 주소를 입력하세요.</p>
		
		<table style="margin: 2% auto;">
			<tbody>
			<tr>
				<th>아이디 : </th>
				<td><input type="email" name="cpemail" id="cpemail" required/></td>
			</tr>
			<tr>
				<th>주민번호 :  </th>
				<td><input id="jubun1" type="text" name="jubun1" required/> - <input type="text" id="jubun2" name="jubun2"  required/></td>
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