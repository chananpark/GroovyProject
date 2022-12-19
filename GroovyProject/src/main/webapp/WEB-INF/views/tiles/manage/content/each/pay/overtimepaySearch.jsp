<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>   



    
<!-- Font Awesome 5 Icons !!이걸써줘야 아이콘웹에서 아이콘 쓸 수 있다!!-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    
<style>
	
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
	
	input[type="date"] {
	cursor: pointer;
	}
	
	input {
		border: none;
	}
	

</style>

<script>

	$(document).ready(function(){
	
		 $('.eachmenu2').show();
		
		
	}); // end of $(document).ready(function(){
		
		
	// >>> Function Declartion<<<	
	
		

</script>






<form name="frm_celebSearch">

<div style='margin: 1% 0 5% 1%'>
	<h4>급여관리</h4>
</div>
	<input type="hidden" name="empno" value="${loginuser.empno}">
	
	<div style="margin-left: 73%;">
		<span>
			<select style="width: 100px; border:solid 1px #cccccc; border: none;" name="searchType">
				<option value="paymentdate">지급일</option>
				<option value="monthpay">실지급액</option>
			</select> 
		</span>
		<input type="text"style="width:145px; border:solid 1px #cccccc;" name="searchWord"/>
		<button class="btn btn-sm ml-1" style="background-color: #086BDE; color:white; width: 60px;"><i class="fas fa-search"></i>검색</button>
	</div>
	
	<div class='m-4' style="margin: 7% 0% 5% 0%; width: 95%;">
		<h5>기본외수당 목록</h5>
		<table class="table table-bordered table-sm mx-4 ">
			<thead>
				<tr>
					<th>No</th>
					<th>지급기준일</th>
					<th>부문</th>
					<th>부서</th>
					<th>직급</th>
					<th>사원명</th>
					<th>초과근무수당</th>
					<th>연차수당</th>
					<th>총지급액</th>
				</tr>
			</thead>
			<tbody  onclick="go_detailInfo">
				<c:forEach  var="emp" items="${requestScope.payList}" varStatus="status">
					<tr class="text-center border" id="list">
						<td>${status.count}</td>
						<td>${emp.paymentdate}</td>
						<td>${emp.bumun}</td>
						<td>${emp.department}</td>
						<td>${emp.position}</td>
						<td>${emp.name}</td>
						<td><fmt:formatNumber value="${emp.overtimepay}" pattern="#,###" /></td>
						<td><fmt:formatNumber value="${emp.annualpay}" pattern="#,###" /></td>
						<td><fmt:formatNumber value="${emp.overpay}" pattern="#,###" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</div>
</form>
	
	
<%-- 
	<div class="mt-5" id="detailPay">
		<h5 class='mx-4'>기본외수당 상세목록</h5>
		<table class="table table-bordered table-sm mx-4 ">
			<thead>
				<tr>
				<th>NO</th>
				<th>지급기준일</th>
				<th>초과근무수당</th>
				<th>연차수당</th>
				<th>합계</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach  var="emp" items="${requestScope.payList}" varStatus="status">
					<tr class="text-center border" >
						<td ><c:out value="${status.count}" /></td>
						<td>${emp.paymentdate}</td>
						
						<c:if test="${not empty emp.overtimepay}">
							<td><fmt:formatNumber value="${emp.overtimepay}" pattern="#,###" /></td>
						</c:if>
						<c:if test="${empty emp.overtimepay}">
							<td> - </td>
						</c:if>
						
							
						<c:if test="${not empty emp.annualpay}">
							<td><fmt:formatNumber value="${emp.annualpay}" pattern="#,###" /></td>
						</c:if>
						<c:if test="${empty emp.annualpay}">
							<td> - </td>
						</c:if>
						<td><fmt:formatNumber value="${emp.overpay}" pattern="#,###" /></td>
					</tr>
				</c:forEach>
			</tbody>
			
		</table>
	 --%>	
	<%-- 
		<table class="table table-bordered table-sm mx-4 ">
		<c:forEach  var="emp" items="${requestScope.payList}" varStatus="status">
			<tr>
				<th>NO</th>
				<td ><c:out value="${status.count}" /></td>
			</tr>	
			<tr>
				<th>지급기준일</th>
				<td>${emp.paymentdate}</td>
			</tr>		
			<tr>	
				<th>초과근무수당</th>
				<c:if test="${not empty emp.overtimepay}">
					<td>${emp.overtimepay}</td>
				</c:if>
			</tr>	
			<tr>	
				<th>연차수당</th>
				<c:if test="${not empty emp.annualpay}">
					<td>${emp.annualpay}</td>
				</c:if>
			</tr>		
		</c:forEach>
		</table>
	 --%>	

