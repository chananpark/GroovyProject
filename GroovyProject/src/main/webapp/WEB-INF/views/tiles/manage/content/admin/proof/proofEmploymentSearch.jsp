<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>   

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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

<div style='margin: 1% 0 5% 1%'>
	<h4>재직증명서</h4>
</div>
	<input type="hidden" name="empno" value="${loginuser.empno}">
	
	<div style="margin-left: 73%;">
		<span>
			<select style="width: 100px; border:solid 1px #cccccc; border: none;" name="searchType">
				<option value="1">은행제출용</option>
				<option value="2">공공기관제출용</option>
			</select> 
		</span>
		<input type="text"style="width:145px; border:solid 1px #cccccc;" name="searchWord"/>
		<button class="btn btn-sm ml-1" style="background-color: #086BDE; color:white; width: 60px;"><i class="fas fa-search"></i>검색</button>
	</div>
	
	<div class='m-4' style="margin: 7% 0% 5% 0%; width: 95%;">
		<h5>증명서목록</h5>
		<table class="table table-bordered table-sm ">
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
<div>${pagebar}</div>
