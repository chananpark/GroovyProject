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
	
	button#btn_submit {
		color: white; 
		background-color:#086BDE;  
		font-size: 14px;
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
		
		 $('.eachmenu6').show();
	
	}); // end  of $(document).ready(function(){--------------------
	
	
	// >>> Function Declartion<<<	
	// >>> 해당 회원을 클릭하면<<< 
	function go_detailproof(){
		
	
	
	} // end of function go_detailInfo(){
		


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
			</span>
		</div>
	</div>

	
	<div class="mt-5">
	<h5 class='mx-4'>증명서목록</h5>
	<table class="table table-bordered table-sm m-4 ">
		<thead>
			<tr>
				<th>No</th>
				<th>증명서종류</th>
				<th>사원번호</th>
				<th>용도</th>
				<th>신청일</th>
				<th>출력</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="emp"  items="${requestScope.proofList}"  varStatus="status">
			<tr class="text-center border">
				<td>${emp.proofno}</td>
				<td>재직증명서</td>
				<td>${emp.fk_empno}</td>
				<td><c:choose><c:when test="${emp.issueuse eq '1'}">은행제출용</c:when><c:otherwise>공공기관제출용</c:otherwise></c:choose></td>
				<td>${emp.issuedate}</td>
				<td><button class="btn btn-sm" style="background-color:#F9F9F9" data-toggle="modal" data-target="#viewDetailProof" data-issueuse="${emp.issueuse}">출력</button></td> 
			</tr>
				</c:forEach>
		</tbody>
	</table>
	<div align="right">
		<button id="btn_submit" class="btn" ><a href="<%= ctxPath%>/manage/proof/proofEmployment.on" style="color: white;">신청</a></button>
	</div>
	</div>
</div>
</form>

<div>${pagebar}</div>



<%-- 재직증명서 상세보기 모달창 --%>
<div class="modal" id="viewDetailProof" >
   <div class="modal-dialog" role="document">
      <div class="modal-content modals-fullsize">
      	
      	<div style="margin-top: 2%;">
      		<button class="close" data-dismiss="modal" aria-hodden="true">X</button>
      	</div>
         <div class='modal-body px-3'>
          <div align="center" style="padding: 2%; margin: 8% auto;">
                  
         <h4 class="float-center mb-5">재직증명서</h4>
         
         <table class="table table-bordered table-sm">
         	<thead>
         		<tr><th colspan='4'>인적사항</th></tr>
         	</thead>
	         <tbody class="font">
	         <tr>
	         	<th>성명</th>
	         	<td><input type="text" style="border: none;" name="name" value="${session.loginuser.name}"/></td>
	         	<th>주민번호</th>
	         	<td><input type="text" style="border: none; name="jubun" value="${session.loginuser.jubun}" /></td>
	         </tr>
	         <tr>
	         	<th>연락처</th>
	         	<td><input type="text" style="border: none; name="mobile" value="${session.loginuser.mobile}"/></td>
	         	<th>주소 </th>
	         	<td><input type="text" style="border: none; name="address" value="${session.loginuser.address}"/></td>
	         </tr>
	         </tbody>
         </table>
         
         <table class="table table-bordered table-sm mt-5">
         
         	<thead>
         		<tr><th colspan='4'>재직사항</th></tr>
         	</thead>
         	
	         <tbody class="font">
		         <tr>
		         	<th>회사명</th>
		         	<td><input type="text" style="border: none; value="(주)그루비"/></td>
		         	<th>대표자 </th>
		         	<td><input type="text" style="border: none; name="" /></td>
		         </tr>
		        <tr>
		         	<th>근무부서</th>
		         	<td><input type="text" style="border: none; name="department" value="${session.loginuser.department}"/></td>
		         	<th>입사일 </th>
		         	<td><input type="text" style="border: none; name="joindate" value="${session.loginuser.joindate}"/></td>
		         </tr>
		          <tr>
		         	<th>직급</th>
		         	<td><input type="text" style="border: none;" name="position" value="${session.loginuser.position}"/></td>
		         	<th>재직기간</th>
		         	<td><input type="text" style="border: none;"/></td>
		         </tr>
		         <tr>
		         	<th>사용용도</th>
		         	<td><input type="text" style="border: none;" id="modalissueuse"name="issueuse" "/></td>
		         	<th></th>
		         	<td><input type="text" style="border: none;"/></td>
		         </tr>
	         </tbody>
         </table>
         
         <div class="float-center mt-5" style="font-size: 16px;">
        	 <div> 2022년 11월 15일 </div> <%-- 현재날짜 넣기 --%>
        	 <div>(주) Groovy</div>
         </div>
         
         </div>
         </div>
       </div>
    </div>
 </div>

	

