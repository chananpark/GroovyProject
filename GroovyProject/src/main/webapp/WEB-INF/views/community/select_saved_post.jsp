<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>임시저장 불러오기</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css">

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%=ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<%=ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<%-- sweet alert --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<%-- ajaxForm --%>
<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery.form.min.js"></script>

<style>

label {
	cursor: pointer;
}

</style>

<script>

// 임시저장 글 배열
let savedPostArray = JSON.parse('${savedPostArray}');

window.onload = function(){

	let body = "";
	
	savedPostArray.forEach(el => {
		body += "<div class='card small my-4'><div class='card-header'>"
			 + "<input type='radio' id='"+el.temp_post_no+"' name='temp_post_no' value='"+el.temp_post_no+"'/>"
			 + "<label for='"+el.temp_post_no+"'> " + el.plain_post_subject + "</span></div>"
			 + "<div class='card-body'>";
			 
		if (el.plain_post_content.length > 10)
			body += "<p>"+el.plain_post_content.substring(0,10)+"...</p>";
		else
			body += "<p>"+el.plain_post_content+"</p>";
			
			body += "</div></div>";
	});
	
	$("#savedPostContainer").html(body);
	
}

// 확인버튼 클릭 시
const submitAprvLine = () => {
	
	// 선택된 임시저장 글번호
	const selected_no = $("input[name='temp_post_no']:checked").val();
	
	// 선택된 번호에 해당하는 제목,내용
	const selectedPostArray = savedPostArray.find(el => el.temp_post_no == selected_no);

 	window.opener.postMessage(selectedPostArray, '*');
	window.self.close();
}
</script>

</head>
<body>

<div class='container-fluid'>
	<div id='savedPostContainer'>
	</div>
	<div class='text-center'>
		<button type='button' class='btn btn-secondary' onclick='self.close()'>취소</button>
		<button type='button' style='background-color:#086BDE; color:white' class='btn' onclick='submitAprvLine()'>확인</button>
	</div>
</div>
</body>
</html>