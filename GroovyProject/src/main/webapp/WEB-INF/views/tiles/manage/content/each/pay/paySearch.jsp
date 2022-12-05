<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
		
		$('.eachmenu2').show();
		
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
		<div style="margin-left: 82%;" class="pt-1">
			<input type="text"style="width: 120px; border:solid 1px #cccccc;" name="searchWord"/>
			<button class="btn btn-sm" style="background-color: #086BDE; color:white; width: 60px;font-size:14px;"><i class="fas fa-search"></i>검색</button>
		</div>
	</div>
	

	
	<div class="mt-5">
		<h5 class='mx-4'>급여목록</h5>
		<table class="table table-bordered table-sm mx-4 ">
			<thead>
				<tr>
					<th>사원번호</th>
					<th>사원명</th>
					<th>부문</th>
					<th>부서</th>
					<th>직급</th>
					<th>지급총액</th>
					<th>공제총액</th>
					<th>실지급액</th>
					<th>지급일</th>
				</tr>
			</thead>
			<tbody  onclick="go_detailInfo">
				<c:forEach  var="emp" items="${requestScope.payList}" varStatus="status">
					<tr class="text-center border" id="list">
						<td>${emp.fk_empno}</td>
						<td>${emp.name}</td>
						<td>${emp.bumun}</td>
						<td>${emp.department}</td>
						<td>${emp.position}</td>
						<td><fmt:formatNumber value="${emp.salary}" pattern="#,###" /></td>
						<td><fmt:formatNumber value="${emp.annualpay}" pattern="#,###" /></td>
						<td><fmt:formatNumber value="${emp.overtimepay}" pattern="#,###" /></td>
						<td>${emp.paymentdate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div>${pagebar}</div>
	
	<div class="mt-5" id="detailPay">
		<h5 class='mx-4'>급여상세</h5>
		<table class="table table-bordered table-sm mx-4 ">
			<thead>
				<tr >
					<th>No</th>
					<th colspan='2'>지급항목</th>
					<th colspan='2'>공제항목</th>
				</tr>
			</thead>
			<tbody>
					<tr class="text-center border" >
						<td>1</td>
						<td>기본급</td>
						<td><fmt:formatNumber value="${emp.salary}" pattern="#,###" id="salary"/></td>
						<td>소득세</td>
						<td><input type="text" name=""><fmt:formatNumber value="${emp.salary}" pattern="#,###" id="tax" /></input></td>
					</tr>
					<tr class="text-center border" >
						<td>2</td>
						<td>초과근무수당</td>
						<td><input type="text" name=""/></td>
						<td>국민연금</td>
						<td><input type="text" name=""/></td>
					</tr>
					<tr class="text-center border" >
						<td>3</td>
						<td>연차수당</td>
						<td><input type="text" name=""/></td>
						<td>고용보험</td>
						<td><input type="text" name=""/></td>
					</tr>
			</tbody>
			<tfoot>
				<tr>
				<th>합계</th>
				<th>지급총액</th>
				<td><input type="text" name=""/></td>
				<th>공제총액</th>
				<td><input type="text" name=""/></td>
				</tr>
			</tfoot>
		</table>
		
		<div align="right">
			<span>
				<button class="btn btn-sm" id="btn_excel">엑셀파일</button>
				<button class="btn btn-sm" id="btn_pay"  onclick="go_payDetail" data-toggle="modal" data-target="#go_payDetail">급여명세서</button>
			</span>
		</div>
	</div>
</div>
</form>


<%-- 급여상세 모달창 --%>
<div class="modal" id="go_payDetail" style="font-size: 12px;">
   <div class="modal-dialog" >
      <div class="modal-content modals-fullsize">
      
         <div class='modal-body px-3'>
 		<button class="btn btn-sm float-right" style="background-color:#086BDE; color:white;" onclick="javascript:self.close();">닫기</button>        
          <div align="center" style="padding: 2%; margin: 8% auto;">
                  
         <h4 class="float-center mb-5">급여명세서</h4>
         
         
         <table class="table table-bordered table-sm">
	         <tbody>
	         <tr>
	         	<th>신청번호</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th>사원번호</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	         <tr>
	         	<th>부서명</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th>사원명</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	         </tbody>
         </table>
         
         <h6 class="float-left mt-5">지급 및 공제내역</h6>
         <table class="table table-bordered table-sm mt-5" >
         	<thead>
         		<tr>
         			<th></th>
         			<th>지급항목</th>
         			<th>금액(원)</th>
         			<th></th>
         			<th>공제항목</th>
         			<th>금액(원)</th>
         		</tr>
         	</thead>
	         <tbody>
	         <tr>
	         	<th rowspan="4">지급내역</th>
	         	<th>기본급</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th rowspan="4">지급내역</th>
	         	<th>소득세</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	         <tr>
	         	<th>초과근무수당</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th>국민연금</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	          <tr>
	         	<th>연차수당</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th>고용보험</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	         
	         </tbody>
         </table>
         
         <table class="table table-bordered table-sm mt-5">
         	<tbody>
	         	<tr>
	         		<th>초과근무 시간수</th>
	         		<th>연차 시간수</th>
	         		<th>총합계</th>
	         	</tr>
	         	<tr>
	         		<td><input type="text" name=""/></td>
	         		<td><input type="text" name=""/></td>
	         		<td><input type="text" name=""/></td>
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



