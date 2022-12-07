<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<% String ctxPath = request.getContextPath(); %>   

    
<style>

	div#div_paychart {
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

	
</style>

<script>

	$(document).ready(function(){
		
		$('.subadmenu').show();
		$('.eachmenu5').show();
		

 	  	$("select#searchType").change(function(e){   // select태그는 change이다!
 		   func_choice($(this).val());
 		   // $(this).val() 은 "" 또는 "deptname" 또는 "gender" 또는 "genderHireYear" 또는 "deptnameGender" 이다.
 	   }); // end of $("select#searchType").change(function(e){
 	   
 		   
 		// !!! 중요) 문서가 로드 되면 '부서별 인원통계'페이지가 보이도록한다.!!!
 		 $("select#searchType").val("deptPay").trigger("change");
		 		   
		 		   
		    
		    
		
		
	}); // end of $(document).ready(function(){
		
	

</script>






<div id="div_paychart">
	
	<div style='margin: 1% 0 5% 1%'>
		<h4>급여관리</h4>
	</div>
	
	<div class="mt-5">
		<h5 class='mx-4'>연봉급여차트</h5>
			<form name="searchFrm" class="float-right">
				<select name="searchType" id="searchType" style="width: 150px; border: none;">
					<option value="">통계선택하세요</option>
					<option value="deptPay">부서별 급여통계</option>
					<option value="genderHireYear">성별 급여통계 통계</option>
				</select>
			</form>
		<div>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		</div>
		
	</div>
	
</div>	
