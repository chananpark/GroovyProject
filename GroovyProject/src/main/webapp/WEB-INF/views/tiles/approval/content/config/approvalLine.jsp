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

.clicked, .accordion:hover {
	background-color: rgb(226, 230, 234);
}

.panel {
	padding: 0 18px;
	display: none;
	background-color: white;
	overflow: hidden;
}

#editBtn {
	background-color: #E3F2FD;
}

#editBtn:hover {
	background-color: #cfe9fc;
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
	
	$('.save').hide(); // 저장버튼 감추기

	// 아코디언
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

/* 결재라인 불러오기 */
const getAprvLine = (aprv_line_no) => {
	
    $.ajax({
        url : "<%=ctxPath%>/approval/admin/getOneAprvLine.on",
        type:'GET',
        data: {'aprv_line_no': aprv_line_no},
        dataType:'json',
        cache:false,
        success : function(json){
			const aprvTblBody = $("#body"+aprv_line_no);
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

/* 결재라인 삭제하기 */
const deleteAprvLine = (aprv_line_no) => {
	swal({
		  title: "이 결재라인을 삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
		    // 삭제
    		const frm = $("#aprvLineFrm"+aprv_line_no)[0];
			frm.method = "post";
			frm.action = "<%=ctxPath%>/approval/config/approvalLine/del.on";
			frm.submit();
			
		  } else {
		    swal("삭제가 취소되었습니다.");
		  }
		});
}

/* 결재라인 수정하기(결재자 새로 선택하기) */
const selectApprovalLine = (aprv_line_no) => {
	
	$('.save'+aprv_line_no).show(); // 저장버튼 표시하기
	
	// 세션스토리지에 해당 결재라인 번호 저장
	sessionStorage.setItem("aprv_line_no", aprv_line_no);
	
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
   	
    const no = sessionStorage.getItem("aprv_line_no")
	const body = $('#body'+no);

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
const saveAprvLine = (aprv_line_no) => {
	
	// 선택한 결재자가 있는지 검사
	const body = $('#body'+ aprv_line_no);
	
	const length = body.find('tr').length;
	if (length == 0){
		swal("결재자가 선택되지 않았습니다.");
		return;
	}
	
	const frm = $("#aprvLineFrm"+aprv_line_no)[0];
	frm.method = "post";
	frm.action = "<%=ctxPath%>/approval/config/approvalLine/edit.on";
	frm.submit();
	
	$('.save'+aprv_line_no).hide(); // 저장버튼 감추기
}
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>환경설정</h4>
</div>

<h5 class='m-4'>결재라인</h5>

<div id='approvalLineContainer' class='m-4'>

	<div class="btn-group my-4">
	  <button type="button" class="btn btn-light clicked" onclick="location.href='<%=ctxPath%>/approval/config/approvalLine.on'">저장된 결재라인</button>
	  <button type="button" class="btn btn-light" onclick="location.href='<%=ctxPath%>/approval/config/approvalLine/add.on'">결재라인 추가</button>
	</div>
	
	<c:forEach items="${aprvLineList}" var="item">
		<button class="accordion" id='${item.aprv_line_no}'> <i class="fas fa-chevron-down mr-2"></i>${item.aprv_line_name}</button>
		<div class='panel'>
			<div class='approvalLine mb-4'>
				<div class='my-4'>
					<button type="button" class="btn btn-sm" id='editBtn' onclick='selectApprovalLine(${item.aprv_line_no})'>수정</button>
					<button type="button" class="btn btn-sm btn-dark" id='deleteBtn' onclick='deleteAprvLine(${item.aprv_line_no})'>삭제</button>
					<span class='save save${item.aprv_line_no}' style="margin-left: 150px;">결재라인 수정 후 반드시 저장버튼을 클릭해주세요.</span>
					<button type="button" class="btn btn-sm ml-2 save save${item.aprv_line_no}" id='saveBtn' onclick='saveAprvLine(${item.aprv_line_no})'>저장</button>
				</div>
	
			</div>
			<form id="aprvLineFrm${item.aprv_line_no}">
			<input type='hidden' name='aprv_line_no' value='${item.aprv_line_no}'/>
				<table class="table">
					<thead>
						<tr>
							<th>순서</th>
							<th>소속</th>
							<th>직급</th>
							<th>성명</th>
						</tr>
					</thead>
					<tbody id='body${item.aprv_line_no}'>
					</tbody>
				</table>
			</form>
		</div>
	</c:forEach>
</div>
