<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath=request.getContextPath(); %>

<style>

.filebox input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

.dropBox {
	background-color: #eee;
	min-height: 50px;
	min-height: 50px;
	overflow:auto;
	font-size: small;
	text-align: center;
	vertical-align: middle;
}

.dropBox.active {
	background-color: #E3F2FD;
}

button {
	border-style: none;
}

#submitBtn, #getSavedPostBtn {
	color: white;
	background-color: #086BDE;
}

#submitBtn, #cancelBtn {
	font-size: small;
}

</style>

<script>

//네이버 스마트 에디터용 전역변수
var obj = [];

$(() => {

	/* 네이버 스마트 에디터  프레임생성 */
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: obj,
		elPlaceHolder: "post_content",
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
	
	/* 확인 버튼 클릭 시 */
	$("button#submitBtn").click(function(){
		   
		// 에디터에서 textarea에 대입
		obj.getById["post_content"].exec("UPDATE_CONTENTS_FIELD", []);
		
		// 글제목 유효성 검사
		const post_subject = $("input#post_subject").val().trim();
		if(post_subject == "") {
			swal("글제목을 입력하세요!");
    		return;
		}
		
		// 글내용 유효성검사
	    var post_content = $("#post_content").val();

	    if( post_content == ""  || post_content == null || post_content == '&nbsp;' || post_content == '<p>&nbsp;</p>')  {
			swal("글내용을 입력하세요!")
			.then(function (result) {
				obj.getById["post_content"].exec("FOCUS"); //포커싱
		      })
			return;
	    }
		
		// 의견 및 긴급 여부 체크 모달 띄우기
		$("#myModal").modal();

	});
});
</script>


<div class='container'>
	<div class='my-4'>
		<h4>커뮤니티</h4>
	</div>

	<h5 class='text-left mb-3' style="margin-top: 80px">제목</h5>
	<input type="text" name="post_subject" id="post_subject" placeholder='제목을 입력하세요' style='width: 100%; font-size: small;' />

	<div class='mb-3' style='margin-top: 30px'>
		<h5 style='display: inline-block;'>내용</h5>
		<button id='saveBtn' type="button" class="btn btn-sm btn-light" style='float: right'>임시저장</button>
		<button id='getSavedPostBtn' type="button" class="btn btn-sm btn-light mr-2" style='float: right'>임시저장 불러오기</button>
	</div>
	<textarea style="width: 100%; height: 612px;" name="post_content" id="post_content" placeholder='내용을 입력하세요'></textarea>

	<div class="filebox">
		<div class="dropBox mt-2">
			<span style='font-size: small'>이곳에 파일을 드롭해주세요.</span>
		</div>
	</div>
	
	<div style="margin: 20px; text-align: center;">
		<button type="button" id='cancelBtn' class='btn btn-secondary rounded' onclick="javascript:history.back()">취소</button>
		<button type="button" class='btn rounded ml-2' id="submitBtn">확인</button>
	</div>
</div>