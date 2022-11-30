<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
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
	
	var acc = document.getElementsByClassName("accordion");
	var i;

	for (i = 0; i < acc.length; i++) {
	  acc[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    if (panel.style.display === "block") {
	      panel.style.display = "none";
	    } else {
	      panel.style.display = "block";
	    }
	    getAprvLine(this.id);
	  });
	}
});

/* 결재라인 선택하기 */
const selectApprovalLine = empno => {
	const popupWidth = 800;
	const popupHeight = 500;

	const popupX = (window.screen.width / 2) - (popupWidth / 2);
	const popupY= (window.screen.height / 2) - (popupHeight / 2);
	
	window.open('<%=ctxPath%>/approval/selectApprovalLine.on?type=official','결재라인 선택','height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
}

/* 자식창에서 넘겨준 데이터를 받아 출력함 */
const receiveMessage = async (e) =>
{
   	const jsonArr = e.data;
   	
	const body = $('#tblBody');

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
	const frm = document.aprvLineFrm;
	frm.method = "post";
	frm.action = "<%=ctxPath%>/approval/admin/approvalLine/.on";
	frm.submit();
}

// 결재라인 불러오기
const getAprvLine = (official_aprv_line_no) => {
	
    $.ajax({
        url : "<%=ctxPath%>/approval/admin/getOneOfficialAprvLine.on",
        type:'GET',
        data: {'official_aprv_line_no': official_aprv_line_no},
        dataType:'json',
        cache:false,
        success : function(json){
			const aprvTblBody = $("#body"+official_aprv_line_no);
			aprvTblBody.empty();
        	
			json.forEach((emp, index) => {

				var html = "<tr>"
			 			+ "<td class='levelno'>" + (index+1) + "</td>"
						+ "<td class='department'>" + emp.department + "</td>"
						+ "<td class='position'>" + emp.position + "</td>"
						+ "<input type='hidden' name='fk_approval_empno' value='" + emp.empno + "'></td>"
						+ "<td class='name'>" + emp.name + "</td></tr>";
					
				aprvTblBody.append(html);
			});
		},
        error: function(request, status, error){
		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
    });
}
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>환경설정</h4>
</div>

<h5 class='m-4'>공통 결재라인 설정</h5>

<div id='approvalLineContainer' class='m-4'>

	<c:forEach items="${officialAprvList}" var="item">
		<button class="accordion" id='${item.official_aprv_line_no}'> <i class="fas fa-chevron-down mr-2"></i>${item.draft_type}</button>
		<div class='panel'>
			<div class='approvalLine mb-4'>
				<div class='my-4'>
					<button type="button" class="btn btn-sm" id='editBtn'>수정</button>
					<span class='ml-2'>결재라인 수정 후 반드시 저장버튼을 클릭해주세요.</span>
					<button type="button" class="btn btn-sm" id='saveBtn'>저장</button>
				</div>
	
			</div>
			<table class="table">
				<thead>
					<tr>
						<th>순서</th>
						<th>소속</th>
						<th>직급</th>
						<th>성명</th>
					</tr>
				</thead>
				<tbody id='body${item.official_aprv_line_no}'>
				</tbody>
			</table>
		</div>
	</c:forEach>
</div>
