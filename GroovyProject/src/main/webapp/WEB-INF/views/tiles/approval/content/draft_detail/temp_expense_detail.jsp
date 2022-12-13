<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>
<style>

.table {
	font-size: small;
}

.table th {
	background-color: #E3F2FD;
	vertical-align: middle;
	text-align: center;
}

.draftInfo,
.approvalLineInfo {
	display: inline-block;
}

.draftInfo {
	float: left;
}

.approvalLineInfo {
	float: right;
}

.approvalLineInfo table td, .approvalLineInfo table th{
	text-align: center;
}

.approvalLineInfo  tr:nth-child(3) > td {
	height: 100px;
	width: 100px;
	border-bottom-style: none;
}

.approvalLineInfo  tr:nth-child(4) > td {
	border-top-style: none;
}

#attachContainer p{
	padding: 1%;
	margin: 0;
	font-size: small;
	text-align: left;
}

#draftTable th{
	width: 20%;
}

#fileInfo {
	background-color: #E3F2FD;
}

#fileName {
	
}

.commentTable {
	width: 100%;
	margin: 0 auto;
}

.commentTable td {
	text-align: left;
}

.commentTable td#date {
	text-align: right;
	width: 200px;
}

.commentTable td#profile {
	width: 150px;
}

.card-header {
	background-color: #E3F2FD;
}

a {
	color: black;
}
</style>

<script>
//재상신 버튼 클릭시 - 문서 수정하기 페이지 요청
const editDraft = () => {
	location.href="<%=ctxPath%>/approval/edit.on?draft_no=${draftMap.dvo.draft_no}&fk_draft_type_no=${draftMap.dvo.fk_draft_type_no}";
}

// 물품 총합
let sumAmount = 0;
</script>

<div class="container">

	<div>
		<button id="editDraftBtn" type='button' class='btn btn-lg' onclick="editDraft()"><i class="far fa-edit"></i> 재상신</button>
	</div>
			
	<div class="card">
	<c:if test="${not empty draftMap}">
		<div class="card-header py-3" align="center">
			<h3>
				<strong>지 출 결 의 서</strong>
			</h3>
			
		</div>
		<div class="card-body text-center p-4">
			<!-- 문서정보 -->
			<div class='draftInfo' style='width: 35%'>
				<h5 class='text-left my-4'>문서정보</h5>
				<table class='table table-bordered text-left'>
					<tr>
						<th>기안자</th>
						<td>${draftMap.dvo.draft_emp_name}</td>
					</tr>
					<tr>
						<th>소속</th>
						<td>${draftMap.dvo.draft_department}</td>
					</tr>
					<tr>
						<th>기안일</th>
						<td>${fn:substring(draftMap.dvo.draft_date,0,10)}</td>
					</tr>
					<tr>
						<th>문서번호</th>
						<td>${draftMap.dvo.draft_no}</td>
					</tr>
				</table>
			</div>
			
			<!-- 결재라인 -->
			<div class='approvalLineInfo' style='width:40%'>
				<h5 class='text-left my-4'>결재정보</h5>
				<c:if test="${internalList != '[]'}">
				<table class='mr-4 table table-sm table-bordered text-left' style="width:auto">
					<tr>
						<th rowspan='5' style='font-size: medium; vertical-align: middle; width: 30px'>결<br>재<br>선</th>
					</tr>
					<tr class='in position'>
					</tr>
					<tr class='in approval_status'>
					</tr>
					<tr class='in name'>
					</tr>
				</table>
				</c:if>
			</div>
			<script>
				const internalList = JSON.parse('${internalList}');
				const externalList = JSON.parse('${externalList}');
				
				let html = "";
				
				if(internalList.length > 0) {
					internalList.forEach(el => {
						html = "<td>" + el.position + "</td>";
						$("tr.in.position").append(html);
	
						html = "<td> </td>";
						$("tr.in.approval_status").append(html);
						
						html = "<td>" + el.name + "</td>";
						$("tr.in.name").append(html);
					});
				}
			</script>
			
			<!-- 수신처 -->
			<c:if test="${externalList != '[]'}">
			<div class='approvalLineInfo' style='clear:both; width:40%'>
				<table class='mr-4 table table-sm table-bordered text-left' style="width:auto">
					<tr>
						<th rowspan='5' style='font-size: medium; vertical-align: middle; width: 30px'>수<br>신</th>
					</tr>
					<tr class='position ex'>
					</tr>
					<tr class='approval_status ex'>
					</tr>
					<tr class='name ex'>
					</tr>
					<tr class='approval_date ex'>
					</tr>
				</table>
			</div>
			
			<script>
				html = "";
				externalList.forEach(el => {
					html = "<td>" + el.position + "</td>";
					$("tr.ex.position").append(html);
					
					let approval_status = "";
					if (el.approval_status == 1)
						approval_status = "<img src='<%=ctxPath%>/resources/images/"+el.signimg+"' width='100'/>";
					else if (el.approval_status == 2) 
						approval_status = "<h3 class='text-danger'>반려</h3>";

					html = "<td>"+approval_status+"</td>";					
					$("tr.ex.approval_status").append(html);
					
					html = "<td>" + el.name + "</td>";
					$("tr.ex.name").append(html);
					
					let approval_date = el.approval_date || "미결재";
					html = "<td>" + approval_date.substring(0,10) + "</td>";
					$("tr.ex.approval_date").append(html);
				});
				
			</script>
			</c:if>
			<!-- 결재라인 끝 -->
			
			<div style="clear:both; padding-top: 8px; margin-bottom: 30px;">
			</div>
			
			<!-- 문서내용 -->
			<!-- 제목 및 지출사유 -->
			<table class='table table-sm table-bordered text-left' id='draftTable'>
				<tr>
					<th>제목</th>
					<td>${draftMap.dvo.draft_subject}</td>
				</tr>
				<tr>
					<th>지출사유</th>
					<td>${draftMap.dvo.draft_content}</td>
				</tr>
			</table>
			<!-- 제목 및 지출사유 끝 -->
			
			<!-- 지출내역 표 -->
			<table class='table table-sm table-bordered mt-4' id='expenseListTable'>
				<thead>
					<tr>
						<th><span> 일자 </span></th>
						<th><span> 분류 </span></th>
						<th><span> 사용 내역 </span></th>
						<th><span> 금액 </span></th>
						<th><span> 비고 </span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${draftMap.evoList}" var="evo">
					<tr>
						<td>${fn:substring(evo.expense_date, 0, 10)}</td>
						<td>${evo.expense_type}</td>
						<td>${evo.expense_detail}</td>
						<td><fmt:formatNumber value="${evo.expense_amount}" pattern="#,###"/></td>
						<td>${evo.expense_remark}</td>
					</tr>
					<script>
						sumAmount += Number("${evo.expense_amount}");
					</script>
					</c:forEach>
					
				</tbody>
				<tfoot>					
					<tr>
						<th colspan="3">합계</th>
						<td colspan='2' id='sum'></td>
					</tr>
				</tfoot>
			</table>
			<script>
				$("#sum").text(sumAmount);
			</script>
			<!-- 지출내역 표 끝 -->
			<!-- 문서내용 끝 -->
		</div>
	</c:if>
	<c:if test="${empty draftMap}">
	해당하는 문서가 없습니다.
	</c:if>
	</div>
</div>
