<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String ctxPath = request.getContextPath(); %>
<style>

.table {
	font-size: small;
}

.table th {
	background-color: #E3F2FD;
	vertical-align: middle;
	text-align: center;
}

.approvalLineInfo .table td, .approvalLineInfo .table th{
	text-align: center;
	width: auto;
}

.approvalLineInfo table td {
	font-size: small;
	width: 100px !important;
}
.approvalLineInfo table th {
	font-size: small;
	width: 30px !important;
}

.draftInfo,
.approvalLineInfo {
	display: inline-block;
}

.draftInfo {
	float: left;
}

.approvalLineInfo {
	float: right;
}

.approvalLineInfo  tr:nth-child(3) > td {
	height: 100px;
	width: 100px;
	border-bottom-style: none;
}

.approvalLineInfo  tr:nth-child(4) > td {
	border-top-style: none;
}

#attachContainer p{
	padding: 1%;
	margin: 0;
	font-size: small;
	text-align: left;
}

#fileInfo {
	background-color: #E3F2FD;
}

#fileName {
	
}

.commentTable {
	width: 100%;
	margin: 0 auto;
}

.commentTable td {
	text-align: left;
}

.commentTable td#date {
	text-align: right;
	width: 200px;
}

.commentTable td#profile {
	width: 150px;
}

.card-header {
	background-color: #E3F2FD;
}

a {
	color: black;
}
</style>

<script>

const avoList = new Array();
let obj;

<c:forEach items="${draftMap.avoList}" var="avo">
	obj = new Object();
	obj.fk_approval_empno = "${avo['fk_approval_empno']}";
	obj.levelno = "${avo['levelno']}";
	obj.approval_status = "${avo['approval_status']}";
	
	avoList.push(obj);
</c:forEach>

// 내 결재단계 및 결재상태가 담긴 배열
const myApprovalInfo = avoList.filter(el => el.fk_approval_empno == "${loginuser.empno}");

// 내 앞 결재자의 정보가 담긴 배열
const priorApprovalInfo = avoList.filter(el => (el.levelno - 1) == myApprovalInfo.levelno);

// 내 다음 결재자의 정보가 담긴 배열
const nextApprovalInfo = avoList.filter(el => (el.levelno + 1) == myApprovalInfo.levelno);

$(()=>{
	
	// 내가 결재라인에 없거나 내가 이미 결재했을때는 결재의견 작성란, 승인|반려|대결 버튼 감추기
	if (myApprovalInfo.length == 0 || myApprovalInfo.approval_status != 0) {
		$("#myComment").hide();
		$(".myApprovalBtn").hide();
		$(".proxyApprovalBtn").hide();
	}	

	// 결재라인에 내가 있고, 결재상태가 0이며, 나보다 앞 결재자의 결재상태가 1이거나 내가 첫번째 결재자일 때만 표시
	else if (myApprovalInfo.levelno == 1 && priorApprovalInfo.approval_status == 1) {
		$("#myComment").show();
		$(".myApprovalBtn").show();
	}
	
	// 결재라인에 내가 있고, 결재상태가1이며, 나보다 다음 결재자의 결재상태가 0일 때만 대결 버튼 표시
	if (myApprovalInfo.approval_status == 1 && nextApprovalInfo.approval_status == 0) {
		$(".myApprovalBtn").show();
	}
	
	// 상신 취소 버튼 감추기
	$("#cancelDraftBtn").hide();
	
	//  내가 작성한 기안이고 아직 결재가 시작되지 않았을 때만 보임 
	let statusArr = avoList.map(el => Number(el.approval_status));
	let status =  statusArr.reduce(function add(sum, currentVal) {
		  return sum + currentVal;
	}, 0);
	
	if (${draftMap.dvo.fk_draft_empno} == ${loginuser.empno} && status == 0 )
		$("#cancelDraftBtn").show();
	
	// 승인 혹은 반려 버튼 클릭시 이벤트
	$(".myApprovalBtn").click((e)=>{
		const target = $(e.target);
		const approval_status = target.attr('id');
		updateApproval(approval_status);
	});
});

// 결재 처리하기
const updateApproval = approval_status => {
	
	let formData = new FormData($("approvalFrm")[0]);
	
	// 문서번호
	formData.append("fk_draft_no", "${draftMap.dvo.draft_no}");

	// 자신의 사원번호
	formData.append("fk_approval_empno", "${loginuser.empno}");
	
	// 자신의 결재단계
	formData.append("levelno", myApprovalInfo[0].levelno);
	
	// 처리 종류(승인 or 반려)
	formData.append("approval_status", approval_status);
	
	// 폼 전송하기
    $.ajax({
        url : "<%=ctxPath%>/approval/updateMyApproval.on",
        data : formData,
        type:'POST',
        processData:false,
        contentType:false,
        dataType:'json',
        cache:false,
        success:function(json){
        	if(json.result == true) {
    	    	swal("처리 완료", "기안을 처리하였습니다.", "success")
    	    	.then((value) => {
	    	    	location.href = "<%=ctxPath%>/approval/requested.on";
   	    		});
        	}
        	else
        		swal("처리 실패", "처리에 실패하였습니다.", "error");
        },
        error: function(request, status, error){
		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
    });
}

const proxyApproval = () => {
	let formData = new FormData($("approvalFrm")[0]);
	
	// 문서번호
	formData.append("fk_draft_no", "${draftMap.dvo.draft_no}");

	// 자신의 사원번호
	formData.append("fk_approval_empno", "${loginuser.empno}");
	
	// 자신의 결재단계
	formData.append("levelno", (Number(myApprovalInfo[0].levelno)+1));
	
	// 결재의견
	formData.set("approval_comment", "${loginuser.name}에 의해 대결 처리되었습니다.");
	
	// 폼 전송하기
    $.ajax({
        url : "<%=ctxPath%>/approval/updateApprovalProxy.on",
        data : formData,
        type:'POST',
        processData:false,
        contentType:false,
        dataType:'json',
        cache:false,
        success:function(json){
        	if(json.result == true) {
    	    	swal("처리 완료", "대결 처리하였습니다.", "success")
    	    	.then((value) => {
	    	    	location.href = "<%=ctxPath%>/approval/requested.on";
   	    		});
        	}
        	else
        		swal("처리 실패", "대결 처리에 실패하였습니다.", "error");
        },
        error: function(request, status, error){
		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
    });
}
</script>

<div class="container">
	
	<div id="cancelDraftBtn">
		<button type='button' class='btn btn-lg'><i class="far fa-window-close"></i> 상신 취소</button>
		<span style='color: gray; font-size: small'>상신 취소 시 임시저장함에 저장됩니다.</span>
	</div>
	
	<div class="card">
	<c:if test="${not empty draftMap}">
		<div class="card-header py-3" align="center">
			<h3>
				<strong>업 무 품 의</strong>
			</h3>
			
		</div>
		<div class="card-body text-center p-4">
			<!-- 문서정보 -->
			<div class='draftInfo' style='width: 35%'>
				<h5 class='text-left my-4'>문서정보</h5>
				<table class='table table-bordered text-left'>
					<tr>
						<th>기안자</th>
						<td>${draftMap.dvo.draft_emp_name}</td>
					</tr>
					<tr>
						<th>소속</th>
						<td>${draftMap.dvo.draft_department}</td>
					</tr>
					<tr>
						<th>기안일</th>
						<td>${fn:substring(draftMap.dvo.draft_date,0,10)}</td>
					</tr>
					<tr>
						<th>문서번호</th>
						<td>${draftMap.dvo.draft_no}</td>
					</tr>
				</table>
			</div>
			
			<!-- 결재라인 -->
			<div class='approvalLineInfo' style='width: 40%'>
				<h5 class='text-left my-4'>결재라인</h5>
				<table class='mr-4 table table-sm table-bordered text-left'>
					<tr>
						<th rowspan='5' style='font-size: medium; vertical-align: middle;'>결<br>재<br>선</th>
					</tr>
					<tr>
					<c:forEach items="${draftMap.avoList}" var="avo" varStatus="sts">
						<td>${avo.position}</td>
					</c:forEach>
					</tr>
					<tr>
					<c:forEach items="${draftMap.avoList}" var="avo">
						<td>
						<c:if test="${avo.approval_status == 1 }">
						<img src='<%=ctxPath%>/resources/images/${avo.signimg}' width="100"/>
						</c:if>
						</td>
					</c:forEach>
					</tr>
					<tr>
					<c:forEach items="${draftMap.avoList}" var="avo">
						<td>${avo.name}</td>
					</c:forEach>
					</tr>
					<tr>
					<c:forEach items="${draftMap.avoList}" var="avo">
						<td>${fn:substring(avo.approval_date,0,10)}</td>
					</c:forEach>
					</tr>
				</table>
			</div>
			<!-- 결재라인 끝 -->
			
			<div style="clear:both; padding-top: 8px; margin-bottom: 30px;">
			</div>
			
			<!-- 문서내용 -->
			<table class='mr-4 table table-sm table-bordered text-left'>
				<tr>
					<th class='p-2' style='width: 20%'>제목</th>
					<td class='p-2'>${draftMap.dvo.draft_subject}</td>
				</tr>
				<tr>
					<td colspan='2' class='p-4'>
						<p>${draftMap.dvo.draft_content}</p>
					</td>
				</tr>
			</table>
			<!-- 문서내용 끝 -->
			
			<!-- 첨부파일 -->
			<c:if test="${not empty dfvoList}">
			<table class='mr-4 table table-sm table-bordered text-left'>
				<tr>
					<th class='p-2 text-left'><i class="fas fa-paperclip"></i> 첨부파일 ${fn:length(dfvoList)}개</th>
				</tr>
				<c:forEach items="${dfvoList}" var="file">
				<tr>
					<td class='p-2'><a href=#>${file.originalfilename} (${file.filesize}Byte)</a></td>
				</tr>
				</c:forEach>
			</table>
			</c:if>
			<!-- 첨부파일 끝 -->
			
			<div style="clear:both; padding-top: 8px; margin-bottom: 30px;">
			</div>
			
			<!-- 기안의견 -->
			<h5 class='text-left my-4'>기안의견</h5>
			<div class='card'>
				<div class='card-body'>
					<table class='commentTable'>
					<c:if test="${not empty draftMap.dvo.draft_comment}">
						<tr>
							<td class='profile' rowspan='2'><img style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/profile/${draftMap.dvo.empimg}' width="100" /></td>
							<td style='text-align:left'><h6>${draftMap.dvo.draft_emp_name}&nbsp;${draftMap.dvo.position}</h6></td>
							<td id='date'><span style='color: #b3b3b3'>${draftMap.dvo.draft_date}</span></td>
						</tr>
						<tr>
							<td style='text-align:left'>${draftMap.dvo.draft_comment}</td>
						</tr>
					</c:if>
					<c:if test="${empty draftMap.dvo.draft_comment}">
					<span style='text-align:left'>기안 의견이 없습니다.</span>
					</c:if>
					</table>
				</div>
			</div>
			<!-- 기안의견 끝 -->

			<!-- 결재의견 -->
			<h5 class='text-left my-4'>결재의견</h5>
			<div class='card'>
				<div class='card-body'>
					<table class='commentTable'>
					<c:forEach items="${draftMap.avoList}" var="avo">
						<c:if test="${not empty avo.approval_comment}">
							<tr>
								<td class='profile' rowspan='2'><img style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/profile/${avo.empimg}' width="100" /></td>
								<td><h6>${avo.name}&nbsp;${avo.position}</h6></td>
								<td id='date'><span style='color: #b3b3b3'>${avo.approval_date}</span></td>
							</tr>
							<tr>
								<td>${avo.approval_comment}</td>
							</tr>
						</c:if>
					</c:forEach>
					</table>
					
					<form id="approvalFrm">
						<table class='commentTable mt-4' id='myComment'>
							<tr>
								<td id='profile' rowspan='2'><img style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/default_profile.png' width="100" /></td>
								<td rowspan='2'><input type='text' id='approval_comment' name='approval_comment' placeholder='결재의견을 입력해주세요(선택)' style='width: 70%'/></td>
							</tr>
						</table>
					</form>
					
				</div>
			</div>
			<!-- 결재의견 끝 -->
			
			<!-- 결재버튼 -->
			<div class='mt-4 text-left' id="processBtns">
				<button type='button' class='btn btn-lg myApprovalBtn' id='1'><i class="fas fa-pen-nib"></i> 승인</button>
				<button type='button' class='btn btn-lg myApprovalBtn' id='2'><i class="fas fa-undo"></i> 반려</button>
				<button type='button' class='btn btn-lg proxyApprovalBtn' onclick='proxyApproval()'><i class="fas fa-arrow-right"></i> 대결</button>
			</div>
		</div>
	</c:if>
	<c:if test="${empty draftMap}">
	해당하는 문서가 없습니다.
	</c:if>
	</div>
</div>
