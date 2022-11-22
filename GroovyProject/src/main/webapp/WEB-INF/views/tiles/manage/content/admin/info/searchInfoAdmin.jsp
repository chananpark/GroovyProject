<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>   



    
<!-- Font Awesome 5 Icons !!이걸써줘야 아이콘웹에서 아이콘 쓸 수 있다!!-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    
<style>

	div#div_searchInfo {
		padding: 5% 2%;
		width: 95%;
	}
	
	button{
		border: none;
	}

	th {
	font-weight: bold;
	background-color: #e3f2fd; 
	text-align: center;
	}
	
	div > button {
		width: 6%;
		display: inline-block;
		margin: 1% 0;
	}
	

</style>

<script type="text/javascript">

	$(document).ready(function(){
	
		$('.eachmenu3').show();
		 
		 
	}); // end of $(document).ready(function(){
		
		
	// >>> Function Declartion<<<	

	
	// end of function go_detailInfo(){
		

</script>






<form name="frm_searchInfo">
<div id="div_searchInfo">
	
	<div style='margin: 1% 0 3% 1%'>
		<h4>사원정보</h4>
	</div>
	
	<div class='mx-4'  style="background-color:#e3f2fd; width: 100%; height: 45px;">
		<div class="pt-2">
			<span class="float-right">
			<span >
				<select style="width: 110px; border:solid 1px #cccccc;">
					<option>사원명</option>
					<option>부서명</option>
				</select> 
			</span>
			<input type="text"style="width: 120px; border:solid 1px #cccccc;"/>
			<button class="btn btn-sm mr-3" style="background-color: #086BDE; color:white;"><i class="fas fa-search"></i>검색</button>
			</span>
		</div>
	</div>
	
	<div style="margin-top: 5%;">
		<h5 class='mx-4'>사원조회</h5>
		<table class="table table-bordered table-sm mx-4 ">
			<thead>
				<tr>
					<th>사원번호</th>
					<th>성명</th>
					<th>직책</th>
					<th>부서</th>
					<th>회사이메일</th>
					<th>핸드폰번호</th>
					<th>입사일자</th>
				</tr>
			</thead>
			<tbody  onclick="go_detailInfo">
				<tr class="text-center border" id="list">
					<c:forEach  var="employee" items="${requestScope.empList}" varStatus="status">
					<tr>
						<td>${employee.empno}</td> 
						<td>${employee.name}</td>
						<td>${employee.position}</td>
						<td>${employee.department}</td>
						<td>${employee.cpemail}</td>
						<td>${employee.mobile}</td>
						<td>${employee.joindate}</td>
					</tr>
					</c:forEach>
				</tr>
			</tbody>
		</table>
	</div>
	
	
</div>
</form>

