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
	
	input {
		border: none;
	}
	 /* === 모달 CSS === */
	
    .modal-dialog.modals-fullsize_viewDetailProof {
	    width: 800px;
	    height: 50%;
    }
    
    .modals-fullsize {
    	width:800px;
    	height: 1000px;
    }
    
    
    .modal-content.modals-fullsize {
	    height: auto;
	    min-height:50%;
	    border-radius: 0;
    }
    

</style>

<script>

	$(document).ready(function(){
		
		 $('.eachmenu6').show();
		 
		 
		// === 용도 선택여부=== //
		$("button#btn_submit").click(function(e){
			func_subProof();
		}); // $("select[name='issueuse']").change(function(){  
		
	}); // end of $(document).ready(function(){ ------------------------------
		
	
		
	// function Declartion // 
	// === 증명서신청=== //
	function func_subProof(){
		
		// === 용도 선택여부=== //
		$("select#issueuse").change(function(e){  
			
			const $option = $("#issueuse option:selected").val();

			if($option == "") {
				alert("용도를 선택해주세요");
			}
		});
		
		
		const frm = document.frm_proofEmp;
		frm.action = "<%= ctxPath%>/manage/proof/proofEmployment.on";
		frm.method="POST";
		frm.submit();
	}
		

</script>




<form name="frm_proofEmp">
<div id="div_proofEmp">
	
	<div style='margin: 1% 0 5% 1%'>
		<h4>재직증명서</h4>
	</div>
	
	<h5 class='mx-4'>증명서 신청</h5>
	
	<div class=" mx-4">
	<table class="table table-bordered table-sm">
	<c:if test="${ not empty sessionScope.loginuser }">
		<tr>
			<th>회사명</th>
			<td><input type="text" value="(주)그루비"/></td>
			<th>성명</th>
			<td><input type="text" name="name" value="${loginuser.name}"/></td>
			<th>직급</th>
			<td><input type="text" name="position" value="${loginuser.position}"/></td>
		</tr>
		<tr>
			<th>부문</th>
			<td><input type="text" name="bumun" value="${loginuser.bumun}"/></td>
			<th>부서</th>
			<td><input type="text" name="department" value="${loginuser.department}"/></td>
			<th></th>
			<td><input type="text" name="" /></td>
		</tr>
		
		<tr>
			<th><span style="color: red;">*</span>용도</th>
			<td> 
				<select name="issueuse" id="issueuse" onchange="" style="border: solid 1px #cccccc;">
					<option> 용도를 선택해주세요 </option>
					<option value="1">은행제출용</option>
					<option value="2">공공기관제출용</option>
				</select>
			</td>
			<th>사원번호</th>
			<td><input type="text" name="fk_empno" value="${loginuser.empno}"/></td>
			<th></th>
			<td><input type="text" name="" /></td>
		</tr>
		</c:if>
	</table>
	<div align="right">
		<button id="btn_submit" style="color: white; background-color:#086BDE;  font-size: 14px;" class="btn" onclick="func_subProof">신청</button>
	</div>
	</div>
</div>
</form>
