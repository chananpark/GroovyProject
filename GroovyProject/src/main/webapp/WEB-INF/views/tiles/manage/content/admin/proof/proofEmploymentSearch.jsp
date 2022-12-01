<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>   

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<style>

	div#div_proofEmp {
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
	
		input[type="date"] {
		cursor: pointer;
	}
	
	 /* === 모달 CSS === */
	
    .modal-dialog.modals-fullsize_viewDetailProof {
	    width: 800px;
	    height: 40%;
    }
    
    .modals-fullsize {
    	width:800px;
    	height: 800px;
    }
    
    
    .modal-content.modals-fullsize {
	    height: auto;
	    min-height:50%;
	    border-radius: 0;
    }
    
    #viewDetailProof{
	    position: fixed;
	    left: -10%;
		top: 7%;
 	}
 
	.font > tr> th {
		font-weight: normal;
	}
	
</style>

<script>

	$(document).ready(function(){
		$('.subadmenu').show();
	
	
	}); // end  of $(document).ready(function(){--------------------
	

</script>




<form name="frm_proofEmp">
<div id="div_proofEmp">
	
	<div style='margin: 1% 0 3% 1%'>
		<h4>재직증명서</h4>
	</div>

	<div class='mx-4'  style="background-color:#e3f2fd; width: 100%; height: 45px;">
		<div style="margin-left: 73%;" class="pt-1">
			<span>
				<select style="width: 100px; border:solid 1px #cccccc;" name="searchType"> 
					<option> ====== </option>
					<option value="1">은행제출용</option>
					<option value="2">공공기관제출용</option>
				</select> 
			</span>
			<input type="text"style="width: 120px; border:solid 1px #cccccc;" name="searchWord"/>
			<button class="btn btn-sm" style="background-color: #086BDE; color:white; width: 60px;font-size:14px;"><i class="fas fa-search"></i>검색</button>
		</div>
	</div>

	
	<div class="mt-5">
	<h5 class='mx-4'>증명서목록</h5>
	<table class="table table-bordered table-sm m-4 ">
		<thead>
			<tr>
				<th>No</th>
				<th>신청번호</th>
				<th>사원번호</th>
				<th>사원명</th>
				<th>용도</th>
				<th>신청일</th>
			</tr>
		</thead>
		<tbody  onclick="go_viewDetailProof()" data-toggle="modal" data-target="#viewDetailProof">	
			<c:forEach var="proofList" items="${requestScope.proofList}" varStatus="status">
			<tr class="text-center border">
				<td ><c:out value="${status.count}" /></td>
				<td>${proofList.proofno}</td>
				<td>${proofList.fk_empno}</td>
				<td>${proofList.name}</td>
				<td>
					<c:choose>
						<c:when test="${proofList.issueuse eq '1'}">은행제출용</c:when>
						<c:otherwise>공공기관용</c:otherwise>
					</c:choose></td>
				<td>${proofList.issuedate}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</div>
</form>

