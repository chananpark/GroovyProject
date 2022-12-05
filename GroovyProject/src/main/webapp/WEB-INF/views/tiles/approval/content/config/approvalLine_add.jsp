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

.clicked, .accordion:hover {
	background-color: rgb(226, 230, 234);
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
	font-size: small;
}

.table th {
	background-color: #E3F2FD;
	vertical-align: middle;
	text-align: center;
}

#buttons {
	width: 50%;
	margin: 0 auto;
}

input {
  width: 300px;
  height: 30px;
}

</style>
<script>
$(()=>{
	$('a#approvalLine').css('color','#086BDE');
	$('.configMenu').show();
	
});

/* 결재라인 선택하기 */
const selectApprovalLine = empno => {
	const popupWidth = 800;
	const popupHeight = 500;

	const popupX = (window.screen.width / 2) - (popupWidth / 2);
	const popupY= (window.screen.height / 2) - (popupHeight / 2);
	
	window.open('<%=ctxPath%>/approval/selectApprovalLine.on?type=personal','결재라인 선택','height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
}

/* 자식창에서 넘겨준 데이터를 받아 출력함 */
const receiveMessage = async (e) =>
{
   	const jsonArr = e.data;
   	
	const body = $('#tblBody');
	body.empty();

	// 선택된 사원을 테이블에 표시함
	jsonArr.forEach((emp, index) => {

		var html = "<tr>"
	 			+ "<td class='levelno'>" + emp.levelno + "</td>"
				+ "<td class='department'>" + emp.department + "</td>"
				+ "<td class='position'>" + emp.position + "</td>"
				+ "<input type='hidden' name='fk_approval_empno" + (index+1) + "' value='" + emp.empno + "'></td>"
				+ "<td class='name'>" + emp.name + "</td></tr>";
		
		body.append(html);
		
	});
	
}

window.addEventListener("message", receiveMessage, false);

/* 결재라인 저장하기 */
const saveAprvLine = () => {
	
	// 선택한 결재자가 있는지 검사
	const length = $("#tblBody").find('tr').length;
	if (length == 0){
		swal("결재자가 선택되지 않았습니다.");
		return;
	}
	
	// 이름이 있는지 검사
	if ($("#aprv_line_name").val() == ''){
		swal("결재라인 이름을 입력하세요.");
		return;
	}
		
	const frm = document.aprvLineFrm;
	frm.method = "post";
	frm.action = "<%=ctxPath%>/approval/config/approvalLine/save.on";
	frm.submit();
}
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>환경설정</h4>
</div>

<h5 class='m-4'>결재라인</h5>

<div id='approvalLineContainer' class='m-4'>

	<div class="btn-group my-4">
	  <button type="button" class="btn btn-light" onclick="location.href='<%=ctxPath%>/approval/config/approvalLine.on'">저장된 결재라인</button>
	  <button type="button" class="btn btn-light clicked" onclick="location.href='<%=ctxPath%>/approval/config/approvalLine/add.on'">결재라인 추가</button>
	</div>
	
	<form name="aprvLineFrm">
		<div class='mt-4' id='buttons'>
			<div style='float:left; margin-bottom: 10px'>
				<input type="text" id="aprv_line_name" name="aprv_line_name" placeholder="결재라인 이름을 입력하세요" maxlength=50 required/>
			</div>
			<div style='float:right; margin-bottom: 10px'>
				<button type="button" class="btn btn-sm btn-light" id='selectBtn' onclick="selectApprovalLine(${loginuser.empno})">결재자 선택하기</button>
				<button type="button" class="btn btn-sm ml-2" id='saveBtn' onclick='saveAprvLine()'>저장</button>
			</div>
		</div>
		<input type='hidden' name='fk_empno' value='${loginuser.empno}'/>
		<table class="table mt-4 mx-auto text-center" style="clear:both">
		    <thead>
		      <tr>
		        <th>순서</th>
		        <th>소속</th>
		        <th>직급</th>
		        <th>성명</th>
		      </tr>
		    </thead>
		    <tbody id="tblBody">
		    </tbody>
		</table>
	</form>
</div>
