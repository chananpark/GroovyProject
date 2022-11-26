<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>결재라인 불러오기</title>
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

ul {
	list-style: none;
}

</style>

<script>

// 저장된 결재라인 목록
let aprvLineArray = JSON.parse('${aprvLineArray}');

$(()=>{
	
	console.log(aprvLineArray);
	
	let html = "";
	aprvLineArray.forEach((el) => {
		html += "<li>"
				+ "<label><input type='radio' name='aprvLine' value=" + el.aprv_line_no + ">" + el.aprv_line_name + "</label>"
				+ "</li>";
	});
	
	$("#aprvList").html(html);
});

const submitAprvLine = () => {
	
	// 선택된 결재라인 알아오기
	const selectedAprvLine = $('input[name=aprvLine]:checked').val();
	
	const json = {"aprvLine":selectedAprvLine};
	
 	window.opener.postMessage(json, '*');
	window.self.close();
}
</script>

</head>
<body>

<div class='container'>
	<div style="display: table; width: 50%;">
		<div style="display: table-cell; vertical-align: middle;">
		<ul id='aprvList' >
		</ul>
		<button type='button' class='btn btn-secondary' onclick='self.close()'>취소</button>
		<button type='button' class='btn btn-primary' onclick='submitAprvLine()'>확인</button>
		</div>
	</div>
</div>
</body>
</html>