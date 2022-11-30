<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>   



    
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
		width: 7%;
		display: inline-block;
		margin: 1% 0;
	}
	
	input[type="date"] {
	cursor: pointer;
	}
	
	input {
		border: none;
	}
	
	button#btn_excel {
		background-color: #cccccc;
	}
	
	button#btn_pay {
		background-color: #086BDE;
		color: white;
	}

	 /* === 모달 CSS === */
	
    .modal-dialog.modals-fullsize_viewDetailinfo {
	    width: 800px;
	    min-height: 10%;
    }
    
    .modals-fullsize {
    	width:800px;
    	min-height: 1000px;
    }
    
    
    .modal-content.modals-fullsize {
	    height: auto;
	    min-height:50%;
	    border-radius: 0;
    }
    
    #go_payDetail{
	    position: fixed;
	    left: -10%;
		top: 10%;
 	}
</style>

<script>

	$(document).ready(function(){
		
		$('.subadmenu').show();
		$('.eachmenu5').show();
		
		$("div#detailPay").hide();
		
		 $("tr#list> td").click(function(){
			 
			 $("div#detailPay").show();
			 
			 
		 }); // end of  $("tbody.list > tr> td").click(function(){---------------------
		
		
	}); // end of $(document).ready(function(){
		
		
	// >>> Function Declartion<<<	
	// >>> 해당 회원을 클릭하면<<< 
	function go_detailInfo(){
		
	
	
	} // end of function go_detailInfo(){
		

</script>






<form name="frm_celebSearch">
<div id="div_celebSearch">
	
	<div style='margin: 1% 0 3% 1%'>
		<h4>급여관리</h4>
	</div>
	
	<div class='mx-4'  style="background-color:#e3f2fd; width: 100%; height: 45px;">
		<div style="margin-left: 73%;" class="pt-1">
			<span>
				<select style="width: 100px; border:solid 1px #cccccc;" name="searchType"> 
					<option> ====== </option>
					<option value="1">추가근무수당</option>
					<option value="2">연차근무수당</option>
				</select> 
			</span>
			<input type="text"style="width: 120px; border:solid 1px #cccccc;" name="searchWord"/>
			<button class="btn btn-sm" style="background-color: #086BDE; color:white; width: 60px;font-size:14px;"><i class="fas fa-search"></i>검색</button>
		</div>
	</div>

	

	
	<div class="mt-5">
		<h5 class='mx-4'>기본외수당 목록</h5>
		<table class="table table-bordered table-sm mx-4 ">
			<thead>
				<tr>
					<th>No</th>
					<th>지급기준일</th>
					<th>사원번호</th>
					<th>사원명</th>
					<th>부서</th>
					<th>지급총액</th>
					<th>공제급액</th>
					<th>실지급액</th>
				</tr>
			</thead>
			<tbody  onclick="go_detailInfo">
				<tr class="text-center border" id="list">
					<td>1</td>
					<td>223</td>
					<td>명절상여금</td>
					<td>김민수</td>
					<td>200,000</td>
					<td>완료</td>
					<td>2022-11-12</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	
	<div class="mt-5" id="detailPay">
		<h5 class='mx-4'>기본외수당 상세목록</h5>
		<table class="table table-bordered table-sm mx-4 ">
			<thead>
				<tr>
				<th>NO</th>
				<th>지급기준일</th>
				<th>수당구분</th>
				<th>지급액</th>
				</tr>
			</thead>
			<tbody>
				<tr class="text-center border" >
					<td>1</td>
					<td>2022.11.12</td>
					<td><input type="text" name=""/>초과근무수당</td>
					<td><input type="text" name=""/>20,000</td>
				</tr>
			</tbody>
			
		</table>
		
	</div>
</div>
</form>

