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

#editBtn {
	background-color: #E3F2FD;
}

#editBtn:hover {
	background-color: #cfe9fc;
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

#approvalLineContainer input {
  width: 300px;
  height: 30px;
}

</style>
<script>
$(()=>{
	$('a#officialApprovalLine').css('color','#086BDE');
	$('.adminMenu').show();
	
	$('.save').hide(); // 저장버튼 감추기
	
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
	    if (this.classList.contains('official'))
	   		getAprvLine(this.id);
	    
	  });
	}
});

/* 결재라인 삭제하기 */
const delAprvLine = (official_aprv_line_no, draft_type_no) => {
	
	swal({
		  title: "이 결재라인을 삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
		    // 삭제
			$.ajax({
			      url : "<%=ctxPath%>/approval/admin/delOfficialAprvLine.on",
			      type:'POST',
			      data: {'official_aprv_line_no': official_aprv_line_no,
			    	  	'draft_type_no': draft_type_no},
			      dataType:'json',
			      cache:false,
			      success : function(json){
			    	  if(json.result == true) {
					      	swal('결재라인이 삭제되었습니다.').then(function (data) {
					      	location.href="javascript:history.go(0);";
					      	});
						}
			    	  else{
			    		  swal('오류로 인해 결재라인 삭제를 실패하였습니다. 다시 시도해주세요.');
			    	  }
					},
			      error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
			  });
			
		  } else {
		    swal("삭제가 취소되었습니다.");
		  }
		});
}

/* 결재라인 추가하기 */
const setOfficialLine = (draft_type_no) => {
	
	swal({
		  title: "이 양식에 공통 결재라인을 추가하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
		    // 삭제
			$.ajax({
			      url : "<%=ctxPath%>/approval/admin/setOfficialLine.on",
			      type:'POST',
			      data: {'draft_type_no': draft_type_no},
			      dataType:'json',
			      cache:false,
			      success : function(json){
			    	  if(json.result == true) {
			    		  swal("이 양식에 공통 결재라인이 기본값으로 추가되었습니다. \r\n 수정을 통해 설정해주세요.")
							.then(function (result) {
								location.href="javascript:history.go(0);";
			  		      });
						}
			    	  else{
			    		  swal('오류로 인해 공통 결재라인 추가를 실패하였습니다. 다시 시도해주세요.');
			    	  	}
					},
			      error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
			  });
			
		  } else {
		    swal("공통 결재라인 추가를 취소하였습니다.");
		  }
		});
}

/* 결재라인 수정하기(결재자 새로 선택하기) */
const selectApprovalLine = (official_aprv_line_no) => {
	
	$('.save'+official_aprv_line_no).show(); // 저장버튼 표시
	
	// 세션스토리지에 해당 결재라인 번호 저장
	sessionStorage.setItem("official_aprv_line_no", official_aprv_line_no);
	
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
   	
    const no = sessionStorage.getItem("official_aprv_line_no")
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
const saveAprvLine = (official_aprv_line_no) => {
	
	// 선택한 결재자가 있는지 검사
	const body = $('#body'+ official_aprv_line_no);
	
	const length = body.find('tr').length;
	if (length == 0){
		swal("결재자가 선택되지 않았습니다.");
		return;
	}
	
	const frm = $("#aprvLineFrm"+official_aprv_line_no)[0];
	frm.method = "post";
	frm.action = "<%=ctxPath%>/approval/admin/approvalLine/save.on";
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
						+ "<input type='hidden' name='fk_approval_empno" + (index+1) + "' value='" + emp.empno + "'></td>"
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
		<button class="accordion official" id='${item.official_aprv_line_no}'> <i class="fas fa-chevron-down mr-2"></i>${item.draft_type}</button>
		<div class='panel'>
			<div class='approvalLine mb-4'>
				<div class='my-4'>
					<button type="button" class="btn btn-sm" id='editBtn' onclick='selectApprovalLine(${item.official_aprv_line_no})'>수정</button>
					<button type="button" class="del${item.official_aprv_line_no} btn btn-sm btn-secondary" id='delBtn' 
					onclick='delAprvLine(${item.official_aprv_line_no}, ${item.draft_type_no})'>삭제</button>
					<span class='save save${item.official_aprv_line_no} ml-2'>결재라인 수정 후 반드시 저장버튼을 클릭해주세요.</span>
					<button type="button" class="save save${item.official_aprv_line_no} btn btn-sm" id='saveBtn' onclick='saveAprvLine(${item.official_aprv_line_no})'>저장</button>
				</div>
	
			</div>
			<form id="aprvLineFrm${item.official_aprv_line_no}">
				<input type='hidden' name='official_aprv_line_no' value='${item.official_aprv_line_no}'>
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
			</form>
		</div>
	</c:forEach>

	<c:forEach items="${noOfficialAprvList}" var="item">
		<button class="accordion" id='${item.draft_type_no}'> <i class="fas fa-chevron-down mr-2"></i>${item.draft_type}</button>
		<div class='panel'>
			<div class='approvalLine mb-4'>
				<div class='my-4'>
					<button type="button" class="btn btn-sm" id='editBtn' onclick='setOfficialLine(${item.draft_type_no})'>공통 결재라인 추가</button>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
