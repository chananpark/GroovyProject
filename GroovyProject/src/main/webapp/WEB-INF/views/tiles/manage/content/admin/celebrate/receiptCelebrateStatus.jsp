<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
		width: 6%;
		display: inline-block;
		margin: 1% 0;
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
	<h5 class='mx-4'>경조비신청현황</h5>
	<table class="table table-bordered table-sm mx-4 ">
		<thead>
			<tr>
				<th>No</th>
				<th>신청번호</th>
				<th>사원번호</th>
				<th>사원명</th>
				<th>경조구분</th>
				<th>경조금액</th>
				<th>결재상태</th>
				<th>신청일</th>
			</tr>
		</thead>
		<tbody >
			<tr class="text-center border">
				<td>1</td>
				<td>223</td>
				<td>p234234</td>
				<td>김민수</td>
				<td>생일상여금</td>
				<td>200,000</td>
				<td>
					<select style="width: 95%;" class="text-center border">
						<option>미승인</option>
						<option>승인(완료)</option>
					</select>
				</td>
				<td>2022-11-12</td>
			</tr>
		</tbody>
	</table>
	</div>
	
	<%-- 정보수정 페이지에서 보이는 버튼 --%>
	<div align="right" style="margin: 3% 0;">
		<button id="btn_update" style="color: white; background-color:#086BDE; border: none; width: 80px;">저장</button>
	</div>
</div>
</form>

