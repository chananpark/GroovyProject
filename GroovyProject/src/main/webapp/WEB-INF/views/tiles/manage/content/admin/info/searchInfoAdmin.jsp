<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	

</style>

<script type="text/javascript">

	$(document).ready(function(){
	
		$('.subadmenu').show();
		$('.eachmenu3').show();
		
		// *** select 태그에 대한 이벤트는 click이 아닌 change이다. ***//
		// 페이지당 회원명수 선택 함수 생성하기
		$("select#sizePerPage").bind('change',function(){
			goSearch(); 
		});// end of $("select#sizePerPage").bind('change',function()------------------------------
				
		
		// === 검색어 엔터하면 === 
		$("input#searchWord").keyup(function(e){
			if(e.keyCode == 13){
				go_search();
			}
		}); // end of $("input#searchWord").keyup(function(){-------------------
			
		// === 검색버튼을 누르면 ===
		$("button#go_search").click(function(){
			go_search();
		}); // end of $("button#go_search").click(function(){------------------------
		
			
		// 검색시 검색조건 및 검색어 값 유지시키기
		if( ${not empty requestScope.paraMap} ) {
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}
		
			
		 
	}); // end of $(document).ready(function(){
		
		
	// >>> Function Declartion<<<	
	
	
	// >>> 검색기능 <<<
	function go_search() {
	
		const frm = document.frm_searchInfo;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/manage/admin/searchInfoAdmin.on";
		frm.submit();
		
	} // end of function go_search() { -----------------------
		
	
</script>






<form name="frm_searchInfo">
<div style='margin: 1% 0 5% 1%'>
	<h4>사원정보</h4>
</div>
	
	<div style="margin-left: 73%;">
		<span>
			<select style="width: 100px; border:solid 1px #cccccc; border: none;" name="searchType">
				<option value="name">사원명</option>
				<option value="department">부서명</option>
			</select> 
		</span>
			<input type="text" id="searchWord"  name="searchWord" placeholder="검색어를 입력하세요" style="width: 120px; border:solid 1px #cccccc;"/>
			<button class="btn btn-sm ml-1" id="go_search" style="background-color: #086BDE; color:white; width: 60px;"><i class="fas fa-search"></i>검색</button>
	</div>
	
	<div class='m-4' style="margin: 7% 0% 5% 0%; width: 95%;">
		<h5 >사원조회</h5>
		<table class="table table-bordered table-sm ">
			<thead>
				<tr>
					<th>사원번호</th>
					<th>성명</th>
					<th>부문</th>
					<th>부서</th>
					<th>직책</th>
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
						<td>${employee.bumun}</td>
						<td>${employee.department}</td>
						<td>${employee.position}</td>
						<td>${employee.cpemail}</td>
						<td>${employee.mobile}</td>
						<td>${employee.joindate}</td>
					</tr>
					</c:forEach>
				</tr>
			</tbody>
		</table>
	</div>
	
</form>

<div>${pagebar}</div>
