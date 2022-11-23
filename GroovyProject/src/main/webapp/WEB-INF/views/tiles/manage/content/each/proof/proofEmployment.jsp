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
		
	
		// === 용도 선택여부=== //
		$("button#btn_submit").click(function(e){
			
			$("select#issueuse").change(function(e){  
				
				const $option = $("#issueuse option:selected").val();

				if($option == "") {
					alert("용도를 선택해주세요");
				}
		
			});
			func_subProofEnd();
			
		
		}); // $("select[name='issueuse']").change(function(){  
		
			
			
			
	}); // end of $(document).ready(function(){ ------------------------------
		
<%-- 	
		
	// function Declartion // 
	// === 증명서신청=== //
	function subProof(){
		
		const frm = document.frm_proofEmp;
		frm.action = "<%= ctxPath%>/manage/proof/proofEmployment.on";
		frm.method="POST";
		frm.submit();
	}
	 --%>
	// >>> 증명서 신청처리 결과 <<< //
	function func_subProofEnd(){
	
		const queryString = $("form[name='frm_proofEmp']").serialize();
		
		$.ajax({
			url:"<%= ctxPath%>/manage/proof/proofEmploymentEnd.on ",
			data:queryString, 
			dataType:"json",
			success:function(json){
				
				if(json.n != 1) {
					alert("재직증명서 신청 실패하였습니다.");
				}
				
				alert("재직증명서 성공 실패하였습니다.");
				return "/manage/proof/proofEmploymentEnd.tiles";
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	      }	
		
		}); // end of $.ajax({ ------------------
	
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
			<th><span style="color: red;">*</span>회사명</th>
			<td><input type="text" value="(주)그루비"/></td>
			<th><span style="color: red;">*</span>성명</th>
			<td><input type="text" name="name" value="${loginuser.name}"/></td>
			<th><span style="color: red;">* </span>신청일자</th>
			<td><input type="text" name="issuedate" value="sysdate"/></td>
		</tr>
		<tr>
			<th>부서</th>
			<td><input type="text" name="bumun" value="${loginuser.bumun}"/></td>
			<th>부서</th>
			<td><input type="text" name="department" value="${loginuser.department}"/></td>
			<th>직급</th>
			<td><input type="text" name="position" value="${loginuser.position}"/></td>
		</tr>
		
		<tr>
			<th><span style="color: red;">* </span>사원번호</th>
			<td><input type="text" name="empno"value="${loginuser.empno}"/></td>
			<th>용도</th>
			<td> 
				<select name="issueuse" id="issueuse" onchange="" style="border: solid 1px #cccccc;">
					<option> 용도를 선택해주세요 </option>
					<option value="1">은행제출용</option>
					<option value="2">공공기관제출용</option>
				</select>
			</td>
		</tr>
		</c:if>
	</table>
	<div align="right">
		<button id="btn_submit" style="color: white; background-color:#086BDE;  font-size: 14px;" class="btn" onclick="subProof">신청</button>
		<button id="btn_view" style="color: white; background-color:#086BDE; font-size: 14px;" class="btn" onclick="viewDetailProof" data-toggle="modal" data-target="#viewDetailProof">증명서보기</button>
	</div>
	</div>
</div>
</form>


<%-- 재직증명서 상세보기 모달창 --%>
<div class="modal" id="viewDetailProof" >
   <div class="modal-dialog" >
      <div class="modal-content modals-fullsize">
      
         <div class='modal-body px-3'>
 		<button class="btn btn-sm float-right" style="background-color:#086BDE; color:white;">닫기</button>        
          <div align="center" style="padding: 2%; margin: 8% auto;">
                  
         <h4 class="float-center mb-5">재직증명서</h4>
         
         <table class="table table-bordered table-sm">
         	<thead>
         		<tr><th colspan='4'>인적사항</th></tr>
         	</thead>
	         <tbody class="font">
	         <tr>
	         	<th>성명</th>
	         	<td><input type="text" style="border: none;" name=""/></td>
	         	<th>주민번호</th>
	         	<td><input type="text" style="border: none; name="" /></td>
	         </tr>
	         <tr>
	         	<th>연락처</th>
	         	<td><input type="text" style="border: none; name="" /></td>
	         	<th>주소 </th>
	         	<td><input type="text" style="border: none; name="" /></td>
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
		         	<td><input type="text" style="border: none; name="" /></td>
		         	<th>대표자 </th>
		         	<td><input type="text" style="border: none; name="" /></td>
		         </tr>
		        <tr>
		         	<th>근무부서</th>
		         	<td><input type="text" style="border: none; name="" /></td>
		         	<th>입사일 </th>
		         	<td><input type="text" style="border: none; name="" /></td>
		         </tr>
		          <tr>
		         	<th>직급</th>
		         	<td><input type="text" style="border: none;"/></td>
		         	<th>재직기간</th>
		         	<td><input type="text" style="border: none;"/></td>
		         </tr>
		         <tr>
		         	<th>사용용도</th>
		         	<td><input type="text" style="border: none;"/></td>
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

	


