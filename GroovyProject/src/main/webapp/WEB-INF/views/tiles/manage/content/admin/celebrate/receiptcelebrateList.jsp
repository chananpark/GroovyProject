<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    
<!-- Font Awesome 5 Icons !!이걸써줘야 아이콘웹에서 아이콘 쓸 수 있다!!-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    
<style>

	div#div_celebSearch {
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
		width: 5%;
		display: inline-block;
		margin: 1% 0;
	}
	

	 /* === 모달 CSS === */
	
   .modal-dialog.modals-fullsize_detailCelebrate {
	    min-width:1200px;
	    min-height: 500px;
	    border: solid 1px red;
    }
    
   

	.modal-content {
		width:700px;
		border: solid 1px orange;
	}
	
	.font > tr> th {
		font-weight: normal;
	}
	

</style>

<script>

	$(document).ready(function(){
		
		$('.subadmenu').show();
		$('.eachmenu4').show();
		
		
		
		
	}); // end of $(document).ready(function(){
		
		
	// >>> Function Declartion<<<	
	// >>> 해당 회원을 클릭하면<<< 
	function go_detailInfo(){
		
	
	
	} // end of function go_detailInfo(){
		

</script>






<form name="frm_celebSearch">
<div id="div_celebSearch">
	
	<div style='margin: 1% 0 3% 1%'>
		<h4>경조비관리</h4>
	</div>
	
	
	<div class='mx-4'  style="background-color:#e3f2fd; width: 100%; height: 45px;">
		<div style="margin-left: 73%;" class="pt-1">
			<span>
				<select style="width: 100px; border:solid 1px #cccccc;" name="searchType"> 
					<option> ====== </option>
					<option value="1">명절상여금</option>
					<option value="2">생일상여금</option>
					<option value="3">휴가비</option>
				</select> 
			</span>
			<input type="text"style="width: 120px; border:solid 1px #cccccc;" name="searchWord"/>
			<button class="btn btn-sm" style="background-color: #086BDE; color:white; width: 60px;font-size:14px;"><i class="fas fa-search"></i>검색</button>
		</div>
	</div>
	

	
	<div style="margin-top: 7%;">
	<h5 class='mx-4'>경조비 지급목록</h5>
	<table class="table table-bordered table-sm mx-4 ">
		<thead>
			<tr>
				<th>NO</th>
				<th>신청번호</th>
				<th>사원번호</th>
				<th>사원명</th>
				<th>경조구분</th>
				<th>경조금액</th>
				<th>결재상태</th>
				<th>신청일</th>
				<th>상세보기</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${not empty requestScope.celebList}">
		<c:forEach var="celebList" items="${requestScope.celebList}" varStatus="status">
			<tr class="text-center border">
				<td ><c:out value="${status.count}" /></td>
				<td >${celebList.clbno}</td>
				<td >${celebList.fk_empno}</td>
				<td >${celebList.name}</td>
				<td>
					<c:choose>
						<c:when test="${celebList.clbtype eq '1'}">명절상여금</c:when>
						<c:when test="${celebList.clbtype eq '2'}">생일상여금</c:when>
						<c:otherwise>휴가비</c:otherwise>
					</c:choose> 
				</td>
				<td><fmt:formatNumber value="${celebList.clbpay}" pattern="#,###"/></td>
				<td>
					<c:choose>
						<c:when test="${celebList.clbstatus eq '1'}">완료(승인)</c:when>
						<c:otherwise>미승인</c:otherwise>
					</c:choose>
				<td >${celebList.clbdate}</td>
				<td><button data-toggle="modal" data-target="#go_detailCelebrate" id="btn_viewCeleb">상세보기</button></td> 
			</tr>
			</c:forEach>
			</c:if>
		</tbody>
	</table>
	</div>
</div>
</form>

	
<%-- 정보수정 페이지바 --%>
<div align="right" style="margin: 3% 0;">${pagebar}</div>


<%-- 경조비지급목록 상세보기 모달창 --%>
 <div class="modal" id="detailCelebrate" >
   <div class="modal-dialog" role="document">
      	
        <div class="modal-content">
        
        <div class="modal-header">
         <!-- 모달창의 header 부분에 해당한다.  -->
          <h4 class="modal-title"></h4>
          <input type="button" onclick="window.print()" value="인쇄" style="background-color:#086BDE; color:white; border:none; width: 50px;"/>
          <button type="button" class="close mr-3" data-dismiss="modal">×</button>
        </div>
        
		<div class='modal-body px-3'>
          <div align="center" style="padding: 2%;">
                  
         <h4 class="float-center mb-5">경조비 지급내역</h4>
         
         <table class="table table-bordered table-sm">
	         <tbody class="font">
	         <tr>
	         	<th>신청번호</th>
	         	<td><input type="text" style="border: none;" /></td>
	         	<th>사원번호</th>
	         	<td><input type="text" style="border: none;" /></td>
	         </tr>
	         <tr>
	         	<th>부서명</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th>사원명</th>
	         	<td><input type="text" style="border: none;" /></td>
	         </tr>
	         </tbody>
         </table>
         
         <table class="table table-bordered table-sm mt-5">
	         <tbody class="font">
	         <tr>
	         	<th>신청일자</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th>은행</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	         <tr>
	         	<th>예금주</th>
	         	<td><input type="text" style="border: none;" /></td>
	         	<th>계좌번호</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	          <tr>
	         	<th>경조구분</th>
	         	<td><input type="text" style="border: none;" /></td>
	         	<th>금액</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	         </tbody>
         </table>
         </div>
         </div>
       </div>
    </div>
 </div>


