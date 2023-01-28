<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>

<link rel = "stylesheet" href = "<%=ctxPath%>/resources/css/draft_detail_style.css">

<script>

//전체 결재자 리스트
const avoList = JSON.parse('${avoList}');

//내 결재정보
const myApprovalInfo = avoList.filter(el => el.fk_approval_empno == "${loginuser.empno}")[0];

//내 앞 결재자의 정보
let priorApprovalInfo;

//내 다음 결재자의 정보
let nextApprovalInfo;

if (myApprovalInfo != null) {
	priorApprovalInfo = avoList.filter(el => (Number(myApprovalInfo.levelno) - 1) == el.levelno)[0];
	nextApprovalInfo = avoList.filter(el => (Number(myApprovalInfo.levelno) + 1) == el.levelno)[0];
}


$(()=>{
	// 버튼 및 결재의견 작성칸 감추기
	$("#myComment").hide();
	$(".myApprovalBtn").hide();
	$(".proxyApprovalBtn").hide();
	
	// 내가 결재라인에 있을때
	if (myApprovalInfo != null) {
		
		// 내 결재상태가 0이며, 내가 첫번째 결재자일 때 혹은 나보다 앞 결재자의 결재상태가 1일때만 결재의견 작성란, 승인|반려 버튼 표시
		if (myApprovalInfo.approval_status == 0) {
			if (myApprovalInfo.levelno == 1 || (priorApprovalInfo !== undefined && priorApprovalInfo.approval_status == 1)) {
				$("#myComment").show();
				$(".myApprovalBtn").show();
			}
		}
		// 내 결재상태가1이며, 나보다 다음 결재자의 결재상태가 0일 때만 대결 버튼 표시
		if (myApprovalInfo.approval_status == 1 && nextApprovalInfo !== undefined && nextApprovalInfo.approval_status == 0) {
			$(".proxyApprovalBtn").show();
		}
	}		
	
	// 상신 취소 버튼 감추기
	$("#cancelDraftDiv").hide();
	
	//  내가 작성한 기안이고 아직 결재가 시작되지 않았을 때만 보임 
	let statusArr = avoList.map(el => Number(el.approval_status));
	let status =  statusArr.reduce(function add(sum, currentVal) {
		  return sum + currentVal;
	}, 0);
	
	if (${draftMap.dvo.fk_draft_empno} == ${loginuser.empno} && status == 0)
		$("#cancelDraftDiv").show();
	
	// 승인 혹은 반려 버튼 클릭시 이벤트
	$(".myApprovalBtn").click((e)=>{
		const target = $(e.target);
		const approval_status = target.attr('id');
		updateApproval(approval_status);
	});
	
	// 대결 버튼 클릭시 이벤트
	$(".proxyApprovalBtn").click((e)=>{
		const target = $(e.target);
		updateApprovalProxy();
	});
});

//결재 처리하기
const updateApproval = approval_status => {
	
	let formData = new FormData($("#approvalFrm")[0]);
	
	// 문서번호
	formData.append("fk_draft_no", "${draftMap.dvo.draft_no}");

	// 자신의 결재단계
	formData.append("levelno", myApprovalInfo.levelno);
	
	// 처리 종류(승인 or 반려)
	formData.append("approval_status", approval_status);
	
	// 폼 전송하기
	$.ajax({
	    url : "<%=ctxPath%>/approval/updateApproval.on",
	    data : formData,
	    type:'POST',
	    processData:false,
	    contentType:false,
	    dataType:'json',
	    cache:false,
	    success:function(json){
	    	if(json.result == true) {
	    		// 소켓
           		if(socket){
           			let result = '결재';
           			if (approval_status == 2)
           				result = '반려';
        			let socketMsg = "전자결재,"+ "${draftMap.dvo.fk_draft_empno}," + "${loginuser.name} 님이 나의 기안 [${draftMap.dvo.draft_subject}] 을 <b>" + result + "</b>하였습니다.," + "<%=ctxPath%>/approval/draftDetail.on?draft_no=${draftMap.dvo.draft_no}&fk_draft_type_no=${draftMap.dvo.fk_draft_type_no}";
        			console.log(socketMsg);
        			socket.send(socketMsg);
           		}
	    		
		    	swal("처리 완료", "기안을 처리하였습니다.", "success")
		    	.then((value) => {
		    		location.href = "<%=ctxPath%>/approval/draftDetail.on?draft_no=${draftMap.dvo.draft_no}&fk_draft_type_no=${draftMap.dvo.fk_draft_type_no}";
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


// 대결 처리하기
const updateApprovalProxy = () => {
	
	let formData = new FormData($("#approvalFrm")[0]);
	
	// 문서번호
	formData.append("fk_draft_no", "${draftMap.dvo.draft_no}");

	// 자신의 결재단계
	formData.append("levelno", myApprovalInfo.levelno);
	
	// 결재의견
	formData.set("approval_comment", "${loginuser.name}에 의해 대결 처리되었습니다.");
	
	// 처리 종류
	formData.append("approval_status", 1);
	
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
	    		// 소켓
           		if(socket){
        			let socketMsg = "전자결재,"+ "${draftMap.dvo.fk_draft_empno}," + "${loginuser.name} 님이 나의 기안 [${draftMap.dvo.draft_subject}] 을 <b>대결</b>하였습니다.," + "<%=ctxPath%>/approval/draftDetail.on?draft_no=${draftMap.dvo.draft_no}&fk_draft_type_no=${draftMap.dvo.fk_draft_type_no}";
        			console.log(socketMsg);
        			socket.send(socketMsg);
           		}
		    	swal("대결 완료", "기안을 대결 처리하였습니다.", "success")
		    	.then((value) => {
	    	    	location.href = "<%=ctxPath%>/approval/draftDetail.on?draft_no=${draftMap.dvo.draft_no}&fk_draft_type_no=${draftMap.dvo.fk_draft_type_no}";
	    		});
	    	}
	    	else
	    		swal("대결 실패", "대결 처리 실패하였습니다.", "error");
	    },
	    error: function(request, status, error){
		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
}

//목록보기 버튼 클릭
const showList = () => {
	
	// approvalBackUrl 스토리지에서 꺼내기
	const approvalBackUrl = sessionStorage.getItem("approvalBackUrl");
	
	if (approvalBackUrl != null && approvalBackUrl != "" && approvalBackUrl !== undefined){
		location.href=approvalBackUrl;
		sessionStorage.removeItem("approvalBackUrl");		
	}
	else
		location.href="javascript:history.go(-1)";
}

//상신 취소
const cancelDraft = () => {
	location.href = "<%=ctxPath%>/approval/cancel.on?draft_no=" + '${draftMap.dvo.draft_no}' + "&fk_draft_type_no=" + '${draftMap.dvo.fk_draft_type_no}';
}
</script>

<div class="container">
	
	<div id='cancelDraftDiv'>
		<button type='button' id='cancelDraftBtn' class='btn btn-lg' onclick="cancelDraft()"><i class="far fa-window-close"></i> 상신 취소</button>
		<span style='color: gray; font-size: small'>상신 취소 시 임시저장함에 저장됩니다.</span>
	</div>
	
	<div class="card">
	<c:if test="${not empty draftMap}">
		<div class="card-header py-3" align="center">
			<h3>
				<strong>출 장 보 고 서</strong>
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
			<div class='approvalLineInfo' style='width:45%'>
				<h5 class='text-left my-4'>결재정보</h5>
				<table class='mr-4 table table-sm table-bordered text-left' style="width:auto">
					<tr>
						<th rowspan='5' style='font-size: medium; vertical-align: middle; width: 30px'>결<br>재<br>선</th>
					</tr>
					<tr class='in position'>
					</tr>
					<tr class='in approval_status'>
					</tr>
					<tr class='in name'>
					</tr>
					<tr class='in approval_date'>
					</tr>
				</table>
			</div>
			<script>
				const internalList = JSON.parse('${internalList}');
				const externalList = JSON.parse('${externalList}');
				
				let html = "";
				internalList.forEach(el => {
					html = "<td>" + el.position + "</td>";
					$("tr.in.position").append(html);
					
					let approval_status = "";
					if (el.approval_status == 1)
						approval_status = "<img src='<%=ctxPath%>/resources/images/sign/"+el.signimg+"' width='100'/>";
					else if (el.approval_status == 2) 
						approval_status = "<h3 class='text-danger'>반려</h3>";

					html = "<td>"+approval_status+"</td>";					
					$("tr.in.approval_status").append(html);
					
					html = "<td>" + el.name + "</td>";
					$("tr.in.name").append(html);
					
					let approval_date = el.approval_date || "미결재";
					html = "<td>" + approval_date.substring(0,10) + "</td>";
					$("tr.in.approval_date").append(html);
				});
				
			</script>
			<!-- 수신처 -->
			<c:if test="${externalList != '[]'}">
			<div class='approvalLineInfo' style='clear:both; width:45%'>
				<table class='mr-4 table table-sm table-bordered text-left' style="width:auto">
					<tr>
						<th rowspan='5' style='font-size: medium; vertical-align: middle; width: 30px'>수<br>신</th>
					</tr>
					<tr class='position ex'>
					</tr>
					<tr class='approval_status ex'>
					</tr>
					<tr class='name ex'>
					</tr>
					<tr class='approval_date ex'>
					</tr>
				</table>
			</div>
			</c:if>
			<script>
				html = "";
				externalList.forEach(el => {
					html = "<td>" + el.position + "</td>";
					$("tr.ex.position").append(html);
					
					let approval_status = "";
					if (el.approval_status == 1)
						approval_status = "<img src='<%=ctxPath%>/resources/images/"+el.signimg+"' width='100'/>";
					else if (el.approval_status == 2) 
						approval_status = "<h3 class='text-danger'>반려</h3>";

					html = "<td>"+approval_status+"</td>";					
					$("tr.ex.approval_status").append(html);
					
					html = "<td>" + el.name + "</td>";
					$("tr.ex.name").append(html);
					
					let approval_date = el.approval_date || "미결재";
					html = "<td>" + approval_date.substring(0,10) + "</td>";
					$("tr.ex.approval_date").append(html);
				});
				
			</script>
			<!-- 결재라인 끝 -->
			
			<div style="clear:both; padding-top: 8px; margin-bottom: 30px;">
			</div>
			
			<!-- 문서내용 -->
			<table class='table table-sm table-bordered text-left' id='draftTable'>
				<tr>
					<th>제목</th>
					<td>${draftMap.dvo.draft_subject}</td>
				</tr>
				<tr>
					<th>출장목적</th>
					<td>${draftMap.brvo.trip_purpose}</td>
				</tr>
				<tr>
					<th>출장기간</th>
					<td>
						${fn:substring(draftMap.brvo.trip_start_date,0,10)} ~ 
						${fn:substring(draftMap.brvo.trip_end_date,0,10)}
					</td>
				</tr>
				<tr>
					<th>출장지역</th>
					<td>${draftMap.brvo.trip_location}</td>
				</tr>
				<tr>
					<th>출장결과</th>
					<td>${draftMap.dvo.draft_content}</td>
				</tr>
			</table>
			<!-- 문서내용 끝 -->
			
			<!-- 첨부파일 -->
			<c:if test="${not empty draftMap.dfvoList}">
			<table class='mr-4 table table-sm table-bordered text-left'>
				<tr>
					<th class='p-2 text-left'><i class="fas fa-paperclip"></i> 첨부파일 ${fn:length(draftMap.dfvoList)}개</th>
				</tr>
				<c:forEach items="${draftMap.dfvoList}" var="file">
				<tr>
					<td class='p-2'>
					<a href="<%=ctxPath%>/approval/download.on?draft_file_no=${file.draft_file_no}">${file.originalFilename} (${file.filesize}Byte)</a>
					</td>
				</tr>
				</c:forEach>
			</table>
			</c:if>
			<!-- 첨부파일 끝 -->
			<button type="button" id="showListBtn" class="btn-secondary listView rounded" onclick="showList()">목록보기</button>
			
			<div style="clear:both; padding-top: 8px; margin-bottom: 30px;">
			</div>
			
			<!-- 기안의견 -->
			<h5 class='text-left my-4'>기안의견</h5>
			<div class='card'>
				<div class='card-body'>
					<table class='commentTable'>
					<c:if test="${not empty draftMap.dvo.draft_comment}">
						<tr>
							<c:if test="${empty draftMap.dvo.empimg}">
								<td class='profile' rowspan='2'>
									<div class="profile_css" id="profile_bg" style="display: inline-block;">
										${fn:substring(draftMap.dvo.draft_emp_name,0,1)}
									</div>
								</td>
							</c:if>
							<c:if test="${not empty draftMap.dvo.empimg}">
								<td class='profile' rowspan='2'><img style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/profile/${draftMap.dvo.empimg}' width="100" height="100"/></td>
							</c:if>
							<td style='text-align:left'><h6>${draftMap.dvo.draft_emp_name}&nbsp;${draftMap.dvo.position}</h6></td>
							<td id='date'><span style='color: #b3b3b3'>${draftMap.dvo.draft_date}</span></td>
						</tr>
						<tr>
							<td style='width: 700px'>${draftMap.dvo.draft_comment}</td>
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
					<c:set var="length" value="${fn:length(draftMap.avoList)}"></c:set>
						<c:if test="${not empty avo.approval_comment}">
							<tr>
								<c:if test="${empty avo.empimg}">
									<td class='profile' rowspan='2'>
										<div class="profile_css" id="profile_bg" style="display: inline-block;">
											${fn:substring(draftMap.dvo.draft_emp_name,0,1)}
										</div>
									</td>
								</c:if>
								<c:if test="${not empty avo.empimg}">
									<td class='profile' rowspan='2'><img style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/profile/${avo.empimg}' width="100" height="100"/></td>
								</c:if>
								<td><h6>${avo.name}&nbsp;${avo.position}</h6></td>
								<td id='date'><span style='color: #b3b3b3'>${avo.approval_date}</span></td>
							</tr>
							<tr>
								<td style='width: 700px'>${avo.approval_comment}</td>
							</tr>
						</c:if>
						<c:if test="${empty avo.approval_comment}">
							<c:set var="emptyCnt" value="${emptyCnt + 1}"></c:set>
							<c:if test="${emptyCnt eq length}">
								<span style='text-align:left'>결재 의견이 없습니다.</span>
							</c:if>
						</c:if>
					</c:forEach>
					</table>
					
					<form id="approvalFrm">
						<table class='commentTable mt-4' id='myComment'>
							<tr>
								<td id='profile' rowspan='2'><img style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/profile/${loginuser.empimg}' width="100" /></td>
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
				<button type='button' class='btn btn-lg proxyApprovalBtn' id='3'><i class="fas fa-arrow-right"></i> 대결</button>
			</div>
		</div>
		</c:if>
		<c:if test="${empty draftMap}">
		해당하는 문서가 없습니다.
		</c:if>
	</div>
</div>
