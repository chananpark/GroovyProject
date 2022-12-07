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
		width: 6%;
		display: inline-block;
		margin: 1% 0;
	}
	
	input { 
		width: 40px;
		border: none;
		align-content: center;
	}

</style>

<script>

	$(document).ready(function(){
		
		 $('.subadmenu').show();
		 $('.eachmenu4').show();
		
		 $("button#btn_update").click(function(e){
			 
			 const have = $("input").val();
			 
			
			 if(have != "") {
				 let result = confirm("정보를 수정하시겠습니까?");
					
					if (result == true){
						func_submit();
					}
			 }
			 else {
				 alert("처리할 내역이 존재하지 않습니다.");
			 }
			
		 }); // end of $("button#btn_update").click(function(e){ -----------------------
		 
		 
	}); // end of $(document).ready(function(){
		
		
	// >>> Function Declartion<<<	
	// >>> 해당 회원을 클릭하면<<< 
	function go_detailInfo(){
		
	
	
	} // end of function go_detailInfo(){
		

	// >>> 저장버튼을 누르면<<<
	function func_submit() {
		
		<%--  
		  // 보내야할 데이터를 선정하는 또 다른 방법
		  // jQuery에서 사용하는 것으로써,
		  // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
		  
		--%>
		const queryString = $("form[name='frm_celebSearch']").serialize();
		
		$.ajax({
			url:"<%=ctxPath%>/manage/admin/receiptCelebrateStatusEnd.on",
			data:queryString,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				
				if(json.n == 1) {
					alert("신청현황 변경을 모두 완료하였습니다.");
				}
				else {
					alert("신청현황 변경을 실패하였습니다.");
					location.href="javascript:history.back()"
				}
				
			},
			
		  	 error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		
		}); // $.ajax({ ---------------------
		
	}
		
		
		
		
		
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
	<h5 class='mx-4'>경조비신청현황</h5>
	<table class="table table-bordered table-sm mx-4 ">
		<thead>
			<tr>
				<th>No</th>
				<th>신청번호</th>
				<th>사원번호</th>
				<th>사원명</th>
				<th >경조구분</th>
				<th>경조금액</th>
				<th>결재상태</th>
				<th>신청일</th>
			</tr>
		</thead>
	
		<tbody>
			<c:if test="${not empty requestScope.celbStatusList}">
			<c:forEach var="celbStatusList" items="${requestScope.celbStatusList}" varStatus="status" > 
			<tr class="text-center border">
				<td ><c:out value="${status.count}" /></td>
				<td><input name="clbno" value="${celbStatusList.clbno}" readonly /></td>
				<td ><input name="fk_empno" value="${celbStatusList.fk_empno}" readonly /></td>
				<td><input name="name" value="${celbStatusList.name}" readonly readonly style="width:50px;" /></td>
				<td >
					<c:choose>
						<c:when test="${celbStatusList.clbtype eq '1'}"><input name="clbtype" value="명절상여금" readonly readonly style="width:80px;"/></c:when>
						<c:when test="${celbStatusList.clbtype eq '2'}"><input name="clbtype" value="생일상여금" readonly style="width:80px;" /></c:when>
						<c:otherwise><input name="clbtype" value="휴가비" readonly style="width:80px;" /></c:otherwise>
					</c:choose> 
				</td>
				<td ><fmt:formatNumber value="${celbStatusList.clbpay}" pattern="#,###"/></td>
				<td>
					<select style="width: 95%;" class="text-center border" name="clbno">
						<option value="0">미승인</option>
						<option value="1">승인(완료)</option>
					</select>
				</td>
				<td><input name="clbno" value="${celbStatusList.clbdate}" readonly style="width: 110px;" /></td>
				</tr>
			</c:forEach>
			</c:if>
		</tbody>
	</table>
	</div>
	<div align="center">
		<c:if test="${empty requestScope.celbStatusList}">
					 경조비 신청내역이 존재하지 않습니다.
		</c:if>
	</div>
	<div>${pagebar}</div>
	
	
	<%-- 정보수정 페이지에서 보이는 버튼 --%>
	<div align="right" style="margin: 3% 0;">
		<button id="btn_update" style="color: white; background-color:#086BDE; border: none; width: 80px;" >저장</button>
	</div>
</div>
</form>

