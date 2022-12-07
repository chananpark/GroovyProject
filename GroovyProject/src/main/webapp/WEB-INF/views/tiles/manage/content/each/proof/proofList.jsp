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
	
	button#detail {
		background-color:#F9F9F9
	}
	
	 /* === 모달 CSS === */
	
    .modal-dialog.modals-fullsize_viewDetailProof {
	    min-width:1200px;
	    min-height: 1000px;
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
		
		 $('.eachmenu6').show();
		 
		 $("#viewDetailProof").on("show.bs.modal", function(e) {
				var data1 = $(e.relatedTarget).data('proofList');
				var data2 = $(e.relatedTarget).data('loginuser');
				
				alert(data1 +":"+ data2);
				
			/*     $("#contents.modal-body").val(data1);
			    $("#text-contents.body-contents").html(data1);
			    $("#contents.modal-body").val(data2);
			    $("#text-contents.body-contents").html(data2); */
			});
		 
		 $(".readonly").attr('readonly',false); // 수정불가
		 
			
		 
		 
	
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
				<th>증명서종류</th>
				<th>사원번호</th>
				<th>용도</th>
				<th>신청일</th>
				<th>출력</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${requestScope.proofList != null }">
			<c:forEach var="emp"  items="${requestScope.proofList}"  varStatus="status">
			<tr class="text-center border">
				<td>${emp.proofno}</td>
				<td>재직증명서</td>
				<td >${emp.fk_empno}</td>
				<td ><c:choose><c:when test="${emp.issueuse eq '1'}">은행제출용</c:when><c:otherwise>공공기관제출용</c:otherwise></c:choose></td>
				<td>${emp.issuedate}</td>
				<td>
					<!-- <button class="btn btn-sm" id="detail" data-toggle="modal" data-target="#viewDetailProof" > -->
					<a href="#" id="detail" data-toggle="modal" data-target="#viewDetailProof"  data-backdrop="static">출력</a> 
					<!-- </button> -->
				</td> 
			</tr>
			</c:forEach>
			</c:if>
			<c:if test="${requestScope.proofList == null }"> 신청하신 내역이 존재하지 않습니다.
			</c:if>
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
      	
       <div class="modal-content">
        <div class="modal-header">
        
          <!-- 모달창의 header 부분에 해당한다.  -->
          <h4 class="modal-title"></h4>
          <input type="button" onclick="window.print()" value="인쇄" style="background-color:#086BDE; color:white; border:none;"/>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>

         <div class='modal-body px-3' id="contents">
          <div align="center" style="padding: 2%; ">
                  
         <h4 class="float-center mb-5">재직증명서</h4>
         
         <table class="table table-bordered table-sm">
         	<thead>
         		<tr><th colspan='4'>인적사항</th></tr>
         	</thead>
	         <tbody class="font body-contents" id="text-contents">
	         <tr>
	         	<th>성명</th>
	         	<td><input type="text" style="border: none;" name="name" value="${loginuser.name}" readonly/></td>
	         	<th>주민번호</th>
	         	<td><input type="text" style="border: none;" name="jubun" value="${loginuser.jubun}" readonly/></td>
	         </tr>
	         <tr>
	         	<th>연락처</th>
	         	<td><input type="text" style="border: none;" name="mobile" value="${loginuser.mobile}" readonly/></td>
	         	<th>연락처</th>
	         	<td><input type="text" style="border: none;" name="mobile" value="${loginuser.mobile}" readonly/></td>
	         </tr>
	         <tr>
	         	<th >주소 </th>
	         	<td colspan="3"><input type="text" style="border: none; width: 500px;" name="address" readonly value="${loginuser.postcode}${loginuser.address}${loginuser.detailaddress}${loginuser.extraaddress}"/></td>
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
		         	<td><input type="text" style="border: none;" value="(주)그루비" readonly/></td>
		         	<th>사용용도</th>
		         	<td name="issueuse"><c:choose><c:when test="${emp.issueuse eq '1'}">은행제출용</c:when><c:otherwise>공공기관제출용</c:otherwise></c:choose></td>
		         </tr>
		        <tr>
		         	<th>근무부서</th>
		         	<td><input type="text" style="border: none;" name="department" value="${loginuser.department}" readonly/></td>
		         	<th>입사일 </th>
		         	<td><input type="text" style="border: none;" name="joindate" value="${loginuser.joindate}" readonly/></td>
		         </tr>
		          <tr>
		         	<th>직급</th>
		         	<td><input type="text" style="border: none;" name="position" value="${loginuser.position}" readonly/></td>
		         	<th>재직기간</th>
		         	<td><input type="text" style="border: none;" readonly/></td>
		         </tr>
		       
	         </tbody>
         </table>
         
         <div class="float-center mt-5" style="font-size: 16px;">
        	 <input type="text"  style="border: none;" name="issuedate" value="${emp.issuedate}" readonly/>
        	 <div>(주) Groovy</div>
         </div>
         
         </div>
         </div>
       </div>
    </div>
 </div>



