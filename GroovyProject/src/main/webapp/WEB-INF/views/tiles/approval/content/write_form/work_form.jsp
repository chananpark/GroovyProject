<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String ctxPath=request.getContextPath(); %>

<style>
.table {
	font-size: small;
}

.card-header {
	background-color: #E3F2FD;
}

.table th {
	background-color: #E3F2FD;
	vertical-align: middle;
	text-align: center;
}

.workFrmContainer .btn {
	font-size: 9pt !important;
	padding: 2px 7px !important;
}

.draftInfo,
.approvalLineInfo {
	display: inline-block;
}

.draftInfo {
	float: left;
}

.approvalLineInfo, .apvLineBtn, .pmBtn {
	float: right;
}

#fileButtons {
	display: flex;
}

.filebox input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

#setLineBtn {
	background-color: #086BDE;
	color: white;
	font-size: small;
	float: left;
}

#fileRemoveBtn, #resetLineBtn {
	border: 1px solid gray;
	color: gray;
}

#fileRemoveBtn:hover, #resetLineBtn:hover {
	background-color: gray;
	color: white;
}

#fileAttachBtn, #getLineBtn {
	border: 1px solid #086BDE;
	color: #086BDE;
}

#fileAttachBtn:hover, #getLineBtn:hover {
	background-color: #086BDE;
	color: white
}

#setLineBtn:hover {
	background-color: #E3F2FD;
	color: #086BDE;
	font-size: small;
}

.dropBox {
	background-color: #eee;
	min-height: 50px;
	min-height: 50px;
	overflow:auto;
}

.dropBox.active {
	background-color: #E3F2FD;
}
</style>

<script>

// 네이버 스마트 에디터용 전역변수
var obj = [];

// 파일 정보를 담아 둘 배열
let fileList = [];

$(() => {

	/* 네이버 스마트 에디터  프레임생성 */
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: obj,
		elPlaceHolder: "content",
		sSkinURI: "<%=ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
		htParams: {
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar: true,
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer: true,
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger: true,
		}
	});
	

	/* 확인 버튼 클릭 */
	$("button#writeBtn").click(function(){
		   
		// 에디터에서 textarea에 대입
		obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		
		// 글제목 유효성 검사
		checkSubjectValidity();
		
		// 글내용 유효성검사 및 시큐어 코드
		checkContentValidity();
		secureContent();
		
		// 의견 및 긴급 여부 체크 모달 띄우기
		$("#myModal").modal();

	});
	
	/* 파일 드래그 & 드롭 */
	const $drop = document.querySelector(".dropBox");
	const $title = document.querySelector(".dropBox span");

	// 드래그한 파일 객체가 해당 영역에 놓였을 때
	$drop.ondrop = (e) => {
		e.preventDefault();
		e.stopPropagation();
	
		// 드롭된 파일 리스트 가져오기
		const files = Array.from(e.dataTransfer.files);
	  
		// 파일 리스트 띄우기
		$title.innerHTML = files.map(file => file.name).join("<br>");	
	  
		// 파일리스트 전역변수에 파일 담기
		fileList = files.map(el => el.name);
	}

	$drop.ondragover = (e) => {
		e.preventDefault();
		e.stopPropagation();
	}
	
	// 드래그한 파일이 최초로 진입했을 때
	$drop.ondragenter = (e) => {
		e.preventDefault();
		e.stopPropagation();
		$drop.classList.add("active");
	}

	// 드래그한 파일이 영역을 벗어났을 때
	$drop.ondragleave = (e) => {
		e.preventDefault();
		e.stopPropagation();
		$drop.classList.remove("active");
	}
	
});
/* 결재라인 행 추가 */

/* 결재라인 행 삭제 */

/* 결재라인 비우기 */

/* 글제목 유효성 검사 */
const checkSubjectValidity = () => {
	const subject = $("input#subject").val().trim();
	if(subject == "") {
		swal("글제목을 입력하세요!");
	   	return;
	}
}

/* 폼 제출하기 */
const submitDraft = () => {
	
    let formData = new FormData($("#fileForm")[0]);
    if(fileList.length > 0){
        fileList.forEach(function(f){
            formData.append("fileList", f);
        });
    } 
/* 	
	
	$.ajax({
		  url:"",
		  data:queryString, 
		  type:"POST",
		  dataType:"JSON",
		  success:function(json){
			  
		  },
		  error: function(request, status, error){
			  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  }); */
	  
	swal("등록 완료", "기안이 상신되었습니다.", "success");
	
}

/* 결재라인 불러오기 */
const getMyApprovalLine = () => {
	// 저장된 결재라인 불러오기
	
	// 모달창 띄우기
	$("#myApprovalLineModal").modal();
}


/* 모달에서 선택된 결재라인 적용하기 */
const applyApprovalLine = () => {
	console.log('');
}

/* 결재라인 선택하기 */
const setApprovalLine = empId => {
	const popupWidth = 500;
	const popupHeight = 400;

	const popupX = (window.screen.width / 2) - (popupWidth / 2);
	const popupY= (window.screen.height / 2) - (popupHeight / 2);
	
	window.open('<%=ctxPath%>/approval/setApprovalLine.on','결제라인 선택','height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
}
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>기안문서 작성</h4>
</div>


<div class="container workFrmContainer">
	
	<!-- 문서 작성  폼 -->
	<!-- <form name="writeFrm" enctype="multipart/form-data"> -->
		<div class="card">
			<div class="card-header py-3" align="center">
				<h3>
					<strong>업 무 품 의</strong>
				</h3>

			</div>
			<div class="card-body text-center p-4">
				<!-- 문서정보 -->
				<div class='draftInfo' style='width: 20%'>
					<h5 class='text-left my-4'>문서정보</h5>
					<table class='table table-sm table-bordered text-left'>
						<tr>
							<th>기안자</th>
							<td>박찬안</td>
						</tr>
						<tr>
							<th>소속</th>
							<td>개발팀</td>
						</tr>
						<tr>
							<th>기안일</th>
							<td>2022-11-15(수)</td>
						</tr>
						<tr>
							<th>문서번호</th>
							<td></td>
						</tr>
					</table>
				</div>
				<!-- 결재라인 -->
				<div class='approvalLineInfo' style='width: 60%'>
				
					<h5 class='my-4' style='display: inline-block; float: left'>결재라인</h5>
					<button id='setLineBtn' type="button" class="btn btn-sm ml-2 my-4" onclick='setApprovalLine()'>선택하기</button>
					<button type="button" class="btn btn-sm btn-light pmBtn my-4 ml-2">+</button>
					<button type="button" class="btn btn-sm btn-light pmBtn my-4 ml-3 ">-</button>
					<button id='resetLineBtn' type="button" class="btn btn-sm apvLineBtn ml-2 my-4">비우기</button>
					<button id='getLineBtn' type="button" class="btn btn-sm apvLineBtn my-4" onclick='getMyApprovalLine()'>불러오기</button>
					
					<table class='mr-4 table table-sm table-bordered text-left' id='approvalLine'>
						<tr>
							<th>순서</th>
							<th>소속</th>
							<th>직급</th>
							<th>성명</th>
						</tr>
						<tr>
							<td>1</td>
							<td>개발팀</td>
							<td>책임</td>
							<td>김개발</td>
						</tr>
						<tr>
							<td>2</td>
							<td>개발팀</td>
							<td>팀장</td>
							<td>윤팀장</td>
						</tr>
						<tr>
							<td>3</td>
							<td>IT부문</td>
							<td>부문장</td>
							<td>장최고</td>
						</tr>
					</table>
				</div>
				<!-- 결재라인 끝 -->
				
				<div style="clear: both; height: 30px; padding-top: 8px; margin-bottom: 30px;">
					<hr>
				</div>

				<!-- 기안내용 -->
				<h5 class='text-left mb-3'>제목</h5>
				<input type="text" name="subject" id="subject" placeholder='제목을 입력하세요'
					style='width: 100%; font-size: small;' />

				<div class='mb-3' style='margin-top: 30px; display: flex'>
					<h5 style='display: inline-block;'>내용</h5>
					<button id='saveBtn' type="button" class="btn btn-sm btn-light" style='display: inline-block; margin-left: auto;'>임시저장</button>
				</div>
				<textarea style="width: 100%; height: 612px;" name="content" id="content" placeholder='내용을 입력하세요'></textarea>
				<!-- 기안내용 끝 -->
				
				<!-- 파일첨부 -->
				<div class="filebox">
					<div id='fileButtons' class='mt-2'>
						<label id='fileAttachBtn' for="attach" class="btn btn-sm mr-2">파일첨부</label>
						<label><button id='fileRemoveBtn' type="button"
								class="btn btn-sm">파일삭제</button></label> <input type="file"
							id="attach" name="attach" multiple>
					</div>
					<div class="dropBox">
						<span style='font-size: small'>이곳에 파일을 드롭해주세요.</span>
					</div>
				</div>
				<!-- 파일첨부 끝 -->

				<div style="margin: 20px;">
					<button type="button" class="btn btn-secondary btn-sm mr-3" id="writeBtn">확인</button>
					<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
				</div>
				
				<!-- 결재의견 및 긴급여부 체크 모달 -->
				<div class="modal text-left" id="myModal">
					<div class="modal-dialog modal-dialog-centered ">
						<div class="modal-content">
			
							<!-- Modal Header -->
							<div class="modal-header">
								<h5 class="modal-title">결재 상신</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
			
							<!-- Modal body -->
							<div class="modal-body">
								<h6 class='text-secondary'>기안의견</h6>
								<textarea name="draftComment" placeholder="기안의견을 입력해주세요(선택)" style='width: 100%; min-height: 150px'></textarea>
								<h6 class='text-secondary mt-4'>긴급문서</h6>
								<input type="checkbox" id='urgentDraft' name='urgentDraft' value='urgent'/><label for='urgentDraft'>긴급(결재자의 대기문서 가장 상단에 표시됩니다.)</label>
							</div>
			
							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" id='calcelBtn' class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="button" id='submitBtn' class="btn" data-dismiss="modal" onclick='submitDraft()'>상신</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 결재의견 및 긴급여부 체크 모달 끝 -->
			</div>
		</div>
	<!-- </form> -->
	<!-- 폼 끝 -->
</div>

<!-- 저장된 결재라인 불러오기 모달 -->
<div class="modal text-left" id="myApprovalLineModal">
	<div class="modal-dialog modal-dialog-centered ">
		<div class="modal-content">

			<!-- Modal Header -->
	<div class="modal-header">
		<h5 class="modal-title">결재라인 불러오기</h5>
		<button type="button" class="close" data-dismiss="modal">&times;</button>
	</div>

	<!-- Modal body -->
	<div class="modal-body">
		<table class='table' id='approveLineTable'>
			<thead class="thead-light">
		      <tr>
		        <th>선택</th>
		        <th>결재라인명</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		        <td><input type="radio"/></td>
		        <td>기본 결재라인</td>
		      </tr>
		      <tr>
		        <td><input type="radio"/></td>
		        <td>간략 결재라인</td>
		      </tr>
		    </tbody>
		</table>
	</div>

	<!-- Modal footer -->
	<div class="modal-footer">
		<button type="button" id='lineCalcelBtn' class="btn btn-secondary" data-dismiss="modal">취소</button>
		<button type="button" id='lineOkBtn' class="btn" data-dismiss="modal" onclick='applyApprovalLine()'>확인</button>
			</div>
		</div>
	</div>
</div>
<!-- 저장된 결재라인 불러오기 모달 끝 -->