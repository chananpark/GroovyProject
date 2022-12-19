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
	span{
		vertical-align: middle;
	}
	
	 /* === 모달 CSS === */
	
    .modal-dialog.modals-fullsize_viewDetailinfo {
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
    
    #viewDetailinfo{
	    position: fixed;
		left: -5%;
		top: 5%;
 	}
</style>

<script>

	$(document).ready(function(){
		
		 $('.eachmenu1').show();
		
		
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
		<div class="pt-2">
			<span class="mx-5 my-3 ">신청일자 <input type="date" style="border:solid 1px #cccccc;"/>  ~  <input type="date" style="border:solid 1px #cccccc;"/></span>
			<span class="float-right">
			<span >
				<select style="width: 100px; border:solid 1px #cccccc;">
					<option value="">명절상여금</option>
					<option>생일상여금</option>
					<option>휴가비</option>
				</select> 
			</span>
			<input type="text"style="width: 120px; border:solid 1px #cccccc;"/>
			<button class="btn btn-sm mr-3" style="background-color: #086BDE; color:white;"><i class="fas fa-search"></i>검색</button>
			</span>
		</div>
	</div>

	
	<div class="mt-5">
	<h5 class='mx-4'>경조비신청목록</h5>
	<table class="table table-bordered table-sm mx-4 ">
		<thead>
			<tr>
				<th>No</th>
				<th>신청번호</th>
				<th>경조구분</th>
				<th>대상자</th>
				<th>경조금액</th>
				<th>전자결재상태</th>
				<th>신청일</th>
			</tr>
		</thead>
		<tbody  onclick="go_detailInfo" data-toggle="modal" data-target="#viewDetailinfo">
			<tr text-center border>
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
</div>
</form>


<div class="modal" id="viewDetailinfo" >
   <div class="modal-dialog" >
      <div class="modal-content modals-fullsize">
      
         <div class='modal-body px-3'>
 		<button class="btn btn-sm float-right" style="background-color:#086BDE; color:white;">닫기</button>        
          <div align="center" style="padding: 2%; margin: 8% auto;">
                  
         <h4 class="float-center mb-5">경조비 신청내역</h4>
         
         
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
         
         <table class="table table-bordered table-sm mt-5">
	         <tbody>
	         <tr>
	         	<th>신청일자</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th>은행</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	         <tr>
	         	<th>예금주</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th>계좌번호</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	          <tr>
	         	<th>경조구분</th>
	         	<td><input type="text" style="border: none;"/></td>
	         	<th>금액</th>
	         	<td><input type="text" style="border: none;"/></td>
	         </tr>
	         </tbody>
         </table>
         </div>
         </div>
       </div>
    </div>
 </div>



