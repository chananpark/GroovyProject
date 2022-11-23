<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>	
<style>
.accordion {
	background-color: white;
	color: #444;
	cursor: pointer;
	padding: 18px;
	width: 100%;
	border: none;
	border-bottom: 1px solid #bfbfbf;
	text-align: left;
	outline: none;
	font-size: 15px;
	transition: 0.4s;
}

.active, .accordion:hover {
	background-color: #F9F9F9;
}

.panel {
	padding: 0 18px;
	display: none;
	background-color: white;
	overflow: hidden;
}

#saveBtn {
	background-color: #086BDE;
	color: white;
}

#approvalLineContainer {
	font-size: small;
}

.table {
	width: 50%;
}

</style>
<script>
$(()=>{
	$('a#approvalLine').css('color','#086BDE');
	$('.configMenu').show();
	
});

const setApprovalLine = empno => {
	const popupWidth = 800;
	const popupHeight = 400;

	const popupX = (window.screen.width / 2) - (popupWidth / 2);
	const popupY= (window.screen.height / 2) - (popupHeight / 2);
	
	window.open('<%=ctxPath%>/approval/setApprovalLine.on?'+empno,'결제라인 선택','height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
}
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>환경설정</h4>
</div>

<h5 class='m-4'>결재라인</h5>

<div id='approvalLineContainer' class='m-4'>

	<div class="btn-group my-4">
	  <button type="button" class="btn btn-light" onclick="location.href='<%=ctxPath%>/approval/config/approvalLine.on'">저장된 결재라인</button>
	  <button type="button" class="btn btn-light activd" onclick="location.href='<%=ctxPath%>/approval/config/approvalLine/add.on'">결재라인 추가</button>
	</div>
	
	<div class='mt-4'>
		<span>결재라인 수정 후 반드시 저장버튼을 클릭해주세요.</span>
		<button type="button" class="btn btn-sm" id='saveBtn'>저장</button>
		<button type="button" class="btn btn-sm" id='selectBtn' onclick="setApprovalLine(${loginuser.empno})">결재자 선택하기</button>
	</div>
	
	<table class="table mt-4">
	    <thead>
	      <tr>
	        <th>순서</th>
	        <th>소속</th>
	        <th>직급</th>
	        <th>성명</th>
	      </tr>
	    </thead>
	    <tbody>
	    </tbody>
	  </table>
</div>
