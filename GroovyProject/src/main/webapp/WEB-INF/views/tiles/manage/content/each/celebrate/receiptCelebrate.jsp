<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>   
    
<style>

	div#div_celebApply {
		padding: 5% 2%;
		width: 95%;
	}
	
	button{
		border: none;
		wid
	}

	th {
	font-weight: bold;
	background-color: #e3f2fd; 
	width: 20%;
	text-align: center;
	}
	
	input,select {
		width:80%;
	}
	
	input[type="date"] {
		cursor: pointer;
	}
	
	input[type="date"]::before {
		content: attr(data-placeholder);
		width: 100%;
	}
	
	input[type="date"]:valid::before {
		display: none;
	}
	input[data-placeholder]::before {
		color: red;
	}
	
	#celebmenu1 {
		color: #086BDE;
	}

</style>


<script type="text/javascript">
	
	
	$(document).ready(function(){
		
		 $('.eachmenu1').show();
		 
		
	}); // end of $(document).ready(function(){-----------------------


</script>


<form name="frm_celebApply">
<div id="div_celebApply">
	
	
<div style='margin: 1% 0 5% 1%'>
	<h4>경조비관리</h4>
</div>	
	<h5 class='m-4'>경조비신청</h5>
	
	<%-- 경조구분만 선택가능. 옵션을 누르면 금액은 자동으로 들어오게 해야함.--%>
	
	<table class="table table-bordered m-4 my-3" >
		<tr>
			<th>신청번호</th>
			<td><input type="text" id="" name="" /></td>
			<th><span style="color:red;">*</span>사원번호</th>
			<td><input type="text" id="name" name="name" /></td>
		</tr>
		<tr>
			<th>부서명</th>
			<td><input type="text" id="" name="" /></td>
			<th><span style="color:red;">*</span>사원명</th>
			<td><input type="text" id="name" name="name" /></td>
		</tr>
		<tr>
			<th><span style="color:red;">*</span>신청일자</th>
			<td><input type="date" id="" name="" data-placeholder="해당 년도를 선택하세요"/></td>
			<th><span style="color:red;">*</span>경조구분</th>
			<td><select id="" name="">
				<option></option>
				<option>명절상여금</option>
				<option>생일상여금</option>
				<option>휴가비</option>
				</select>
			</td>
		</tr>
		<tr>
			<th><span style="color:red;">*</span>신청금액</th>
			<td><input type="text" id="" name="" /></td>
			<th><span style="color:red;">*</span>계좌번호</th>
			<td><input type="text" id="" name="" /></td>
		</tr>
		<tr>
			<th>은행</th>
			<td><input type="text" id="" name="" /></td>
			<th><span style="color:red;">*</span>예금주</th>
			<td><input type="text" id="" name="" /></td>
		</tr>
		
	</table>
	<div class="float-right">
		<button style="background-color:##F9F9F9" class="btn-sm">재작성</button>
		<button style="background-color:##F9F9F9" class="btn-sm">삭제</button> <%-- 담당자가 '완료'하지 않은 상태라면 삭제가능  --%>
		<button style="color: white; background-color:#086BDE" class="btn-sm">저장</button> <%-- 상여금을 받을 수 있을때만 저장이 가능하다 --%>
	</div>
	
</div>
</form>







