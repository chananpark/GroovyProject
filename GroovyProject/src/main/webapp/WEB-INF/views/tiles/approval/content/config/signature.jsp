<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<style>
#updateBtn {
	background-color: #E3F2FD;
	width: 90%;
	margin: auto;
	font-size: small;
}

img {
	display: block;
	margin: 0px auto;
}

#submitBtn {
	background-color: #086BDE;
	color: white;
	border: 1px solid #086BDE;
}

.filebox input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}
</style>

<script>
$(()=>{
	$('a#signature').css('color','#086BDE');
	$('.configMenu').show();
	
	/* 이미지 미리보기 */
	$(document).on("change", "input#attach", function(e){
		
	});
});
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>환경설정</h4>
</div>

<h5 class='m-4'>서명 관리</h5>

<div id='signatureContainer' class='m-4'>

	<h6 style='margin: 5% 0'>나의 서명</h6>
	
	<form name="signatureFrm" enctype="multipart/form-data">
		<div class="card text-center mx-auto" style="width: 400px; height: 200px;">
			<img class='mt-4' src='<%=ctxPath%>/resources/images/signature_pororo.png' width="100"/>
			<div class="card-body">
				<div class="filebox">
					<label id='updateBtn' for="attach" class="btn">서명 변경하기</label>
					<input type="file" name="attach" id='attach' accept="image/*" />
					
				</div>

			</div>
		</div>
	
		<div class='text-center m-4'>
			<button type="button" class="btn btn-sm btn-dark mr-2 px-4" id='cancelBtn'>취소</button>
			<button type="button" class="btn btn-sm px-4" id='submitBtn'>저장</button>
		</div>
	
	</form>
</div>