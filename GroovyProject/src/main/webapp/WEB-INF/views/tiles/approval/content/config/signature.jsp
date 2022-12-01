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
	
	// 저장버튼 감추기
	$(".submit").hide();
	
	document.getElementById("attach").addEventListener('change', function(){
		$(".submit").show(); // 저장버튼 표시하기
	});
});

// 서명 업데이트하기
const updateSign = () => {
	
	const frm = document.signatureFrm;
	frm.method = "post";
	frm.action = "<%=ctxPath%>/approval/config/signature/update.on";
	frm.submit();
}

// 이미지 미리보기
function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      document.getElementById('preview').src = e.target.result;
    };
    reader.readAsDataURL(input.files[0]);
  } else {
    document.getElementById('preview').src = "";
  }
}
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>환경설정</h4>
</div>

<h5 class='m-4'>서명 관리</h5>

<div id='signatureContainer' class='m-4'>

	<h6 style='margin: 5% 0'>나의 서명</h6>
	
	<form name="signatureFrm" enctype="multipart/form-data">
		<div class="card text-center mx-auto" style="width: 400px; height: 200px;">
			<img id="preview" style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/sign/${loginuser.signimg}' width="100" />
			<div class="card-body">
				<div class="filebox">
					<label id='updateBtn' for="attach" class="btn">서명 변경하기</label>
					<input type="file" name="attach" id='attach' accept="image/*" onchange="readURL(this);"/>
				</div>
			</div>
		</div>
	
		<div class='text-center m-4 submit'>
			<button type="button" class="btn btn-sm px-4" id='submitBtn' onclick='updateSign()'>저장</button>
		</div>
	
	</form>
</div>