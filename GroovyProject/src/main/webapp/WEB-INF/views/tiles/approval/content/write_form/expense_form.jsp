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

.expenseFrmContainer .btn {
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

let submitFlag;

$(() => {

	/* 확인 버튼 클릭 시 */
	$("button#writeBtn").click(function () {

		// 글제목 유효성 검사
		checkSubjectValidity();

		// 글내용 유효성검사 및 시큐어 코드
		checkContentValidity();
		secureContent();

		// 의견 및 긴급 여부 체크 모달 띄우기
		$("#myModal").modal();

	});

	/* 파일 첨부시 첨부된 파일 이름 써주기 */
	var fileTarget = $('input#attach');

	fileTarget.on('change', function () {  // 값이 변경되면
		if (window.FileReader) {  // modern browser
			var filename = $(this)[0].files[0].name;
		}
		else {  // old IE
			var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
		}
		// 추출한 파일명 삽입
		$('.upload-name').val(filename);
	});

});
/* 결재라인 행 추가 */

/* 결재라인 행 삭제 */

/* 결재라인 비우기 */

/* 글제목 유효성 검사 */
const checkSubjectValidity = () => {
	const subject = $("input#subject").val().trim();
	if (subject == "") {
		swal("글제목을 입력하세요!");
		return;
	}
}

/* 폼 제출하기 */
const submitDraft = () => {

	/* 	const queryString = $("form[name='writeFrm']").serialize();
		
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

	swal("Good job!", "기안이 상신되었습니다.", "success");

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
const setApprovalLine = empno => {
	const popupWidth = 500;
	const popupHeight = 400;

	const popupX = (window.screen.width / 2) - (popupWidth / 2);
	const popupY= (window.screen.height / 2) - (popupHeight / 2);
	
	window.open('<%=ctxPath%>/approval/setApprovalLine.on?'+empno,'결제라인 선택','height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
}
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>기안문서 작성</h4>
</div>


<div class="container expenseFrmContainer">

	<!-- 문서 작성  폼 -->
	<form name="writeFrm" enctype="multipart/form-data">
		<div class="card">
			<div class="card-header py-3" align="center">
				<h3>
					<strong>지 출 결 의 서</strong>
				</h3>

			</div>
			<div class="card-body text-center p-4">
				<!-- 문서정보 -->
				<div class='draftInfo' style='width: 20%; display:inline-block;'>
					<table>
						<tr>
							<td>
								<h5 class='text-left my-4'>문서정보</h5>
							</td>
						</tr>
					</table>
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
				<!-- 문서정보 끝 -->
				
				<!-- 결재라인 -->
				<div class='approvalLineInfo' style='width: 60%; display:inline-block;'>
				
					<h5 class='my-4' style='display: inline-block; float: left'>결재라인</h5>
					<button id='setLineBtn' type="button" class="btn btn-sm ml-2 my-4" onclick='setApprovalLine(${loginuser.empno})'>선택하기</button>
					<button id='resetLineBtn' type="button" class="btn btn-sm apvLineBtn ml-2 my-4">비우기</button>
					<button id='getLineBtn' type="button" class="btn btn-sm apvLineBtn my-4" onclick='getMyApprovalLine()'>불러오기</button>
					
					<table class='mr-4 table table-sm table-bordered text-left'>
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
				
				<!-- 구분선 -->
				<div style="clear: both; height: 30px; padding-top: 8px; margin-bottom: 30px;">
					<hr>
				</div>

				<!-- 제목 및 지출사유 -->
				<table class='table table-sm table-bordered text-left' id='draftTable'>
					<tr>
						<th>제목</th>
						<td><input type="text" name="subject" id="subject" placeholder='제목을 입력하세요'
								style='width: 100%; font-size: small;' /></td>
					</tr>
					<tr>
						<th>지출사유</th>
						<td><textarea style="width: 100%; height: 100px;" name="content" id="content"
								placeholder='내용을 입력하세요'></textarea></td>
					</tr>
				</table>
				<!-- 제목 및 지출사유 끝 -->
				
				<!-- 추가삭제버튼 -->
				<div style="clear: both; padding-top: 5px; display: flex">
					<button id='saveBtn' type="button" class="btn btn-sm btn-light mb-3" style='display: inline-block; margin-right: auto'>임시저장</button>
					<button type="button" class="btn btn-sm btn-light ml-auto mr-2 mb-3" style='display: inline-block;'>-</button>
					<button type="button" class="btn btn-sm btn-light mr-2 mb-3" style='display: inline-block;'>+</button>
				</div>
				
				<!-- 지출내역 표 -->
				<table class='table table-sm table-bordered'>
					<thead>
						<tr>
							<th><span style="font-size: 9pt;"> 일자 </span></th>
							<th><span style="font-size: 9pt;"> 분류 </span></th>
							<th><span style="font-size: 9pt;"> 사용 내역 </span></th>
							<th><span style="font-size: 9pt;"> 금액 </span></th>
							<th><span style="font-size: 9pt;"> 비고 </span></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><span style="font-size: 9pt;"><input type="date"></span></td>
							<td><span style="font-size: 9pt;">
									<select name="job">
									    <option value="">직업선택</option>
									    <option value="학생">학생</option>
									    <option value="회사원">회사원</option>
									    <option value="기타">기타</option>
									</select>
								</span></td>
							<td><span style="font-size: 9pt;"><input type='text'/></span></td>
							<td><span style="font-size: 9pt;"><input type='number'/></span></td>
							<td><span style="font-size: 9pt;"><input type='text'/></span></td>
						</tr>
						<tr>
							<th colspan="3">합계</th>
							<td colspan='2'></td>
						</tr>
					</tbody>
				</table>
				<!-- 지출내역 표 끝 -->
				
				<!-- 구분선 -->
				<div style="clear: both; height: 30px; padding-top: 8px; margin-bottom: 30px;">
					<hr>
				</div>
				
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
								<textarea name="draftComment" placeholder="기안의견을 입력해주세요(선택)"
									style='width: 100%; min-height: 150px'></textarea>
								<h6 class='text-secondary mt-4'>긴급문서</h6>
								<input type="checkbox" id='urgentDraft' name='urgentDraft'
									value='urgent' /><label for='urgentDraft'>긴급(결재자의 대기문서 가장 상단에
									표시됩니다.)</label>
							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" id='calcelBtn' class="btn btn-secondary"
									data-dismiss="modal">취소</button>
								<button type="button" id='submitBtn' class="btn" data-dismiss="modal"
									onclick='submitDraft()'>상신</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 결재의견 및 긴급여부 체크 모달 끝 -->
			</div>
		</div>
	</form>
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
					<thead>
						<tr>
							<th>선택</th>
							<th>결재라인명</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="radio" /></td>
							<td>기본 결재라인</td>
						</tr>
						<tr>
							<td><input type="radio" /></td>
							<td>간략 결재라인</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id='lineCalcelBtn' class="btn btn-secondary"
					data-dismiss="modal">취소</button>
				<button type="button" id='lineOkBtn' class="btn" data-dismiss="modal"
					onclick='applyApprovalLine()'>확인</button>
			</div>
		</div>
	</div>
</div>