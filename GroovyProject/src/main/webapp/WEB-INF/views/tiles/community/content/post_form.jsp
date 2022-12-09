<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath=request.getContextPath(); %>

<style>

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

// 네이버 스마트 에디터용 전역변수
var obj = [];

// 파일 정보를 담아 둘 배열
let fileList = [];

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
			swal("글제목을 입력하세요!")
			.then(function (result) {
				document.getElementById("post_subject").focus(); //포커싱
		      })
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
	    
	    // 폼 제출
	    submitPost();

	});
	
	/* 임시저장 버튼 클릭 시 */
	$("button#saveBtn").click(function(){
		   
		// 에디터에서 textarea에 대입
		obj.getById["post_content"].exec("UPDATE_CONTENTS_FIELD", []);
		
		// 글내용 유효성검사
	    var post_content = $("#post_content").val();

	    if( post_content == ""  || post_content == null || post_content == '&nbsp;' || post_content == '<p>&nbsp;</p>')  {
			swal("글내용을 입력하세요!")
			.then(function (result) {
				obj.getById["post_content"].exec("FOCUS"); //포커싱
		      })
			return;
	    }
	    
	    // 폼 제출
	    savePost();

	});
	
    /* 파일 드래그 & 드롭 */
	// 파일 드롭 영역
	const $drop = document.querySelector(".dropBox");
	
	// 드래그한 파일 객체가 해당 영역에 놓였을 때
	$drop.ondrop = function(e) {
		e.preventDefault();
		e.stopPropagation();
		
		// 드롭된 파일 리스트 가져오기
		const files = Array.from(e.dataTransfer.files);
		
		if(files != null && files != undefined){
		    let tag = "";
		    
	        let length = fileList.length;

		    for(i=0; i<files.length; i++){
		        let f = files[i];

		        // 파일리스트 전역변수에 파일 담기
		        fileList.push(f);
		        
		        let fileName = f.name;
		        let fileSize = f.size / 1024 / 1024;
		        fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
		     	// 파일 정보 표시하기
		        tag += 
		                "<div class='fileList'>" +
		                    "<span class='fileName'>" + fileName + "</span>" +
		                    "<span class='fileSize'>" + fileSize +" MB</span>" +
		                    "<span class='digitFileSize' style='display:none'>" + f.size + "</span>" +
		                    "<span class='removeFile btn small' name='removeFile'>삭제</span>" +
		                "</div>";
		    }
		    $(".dropBox span").hide();
		    $(this).append(tag);
		    $(this).addClass('active');
		}
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
	
	// 파일 삭제 버튼 클릭시
	$(document).on('click','[name=removeFile]', function(){
   	 	const $this = $(this);
   	 	delete_file_name = $this.parent().children('.fileName').text();
   	 	delete_file_size = $this.parent().children('.digitFileSize').text();
   	 	
   	 	for(let i = 0; i < fileList.length; i++) {
   	 		if(fileList[i].name = delete_file_name && delete_file_size == fileList[i].size )  {
   	 			
   	 			fileList.splice(i, 1);
   	 		    i--;
   	 		  }
   	 	}
   	 $(this).parent().remove();
   	 
	});
});

/* 폼 제출하기 */
const submitPost = () => {
	
	// formData 가져오기
	let formData = new FormData($("#postFrm")[0]);
	
	// 첨부파일 formData에 추가하기
	getFiles(formData);
	
	 $.ajax({
	     url : "<%=ctxPath%>/community/addPost.on",
	     data : formData,
	     type:'POST',
	     enctype:'multipart/form-data',
	     processData:false,
	     contentType:false,
	     dataType:'json',
	     cache:false,
	     success:function(json){
	     	if(json.result == true) {
	 	    	swal("등록 완료", "게시글이 작성되었습니다.", "success")
	 	    	.then((value) => {
		    	    	location.href = "<%=ctxPath%>/community/list.on";
		    		});
	     	}
	     	else
	     		swal("등록 실패", "게시글 작성을 실패하였습니다.", "error");
	     },
	     error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
	 });
	
}

// 첨부파일 가져오기
const getFiles = formData => {

	if(fileList.length > 0){
	    fileList.forEach(function(f){
	        formData.append("fileList", f);
	    });
	}
}

// 임시저장
const savePost = () =>{
	// formData 가져오기
	let formData = new FormData($("#postFrm")[0]);
	
	 $.ajax({
	     url : "<%=ctxPath%>/community/savePost.on",
	     data : formData,
	     type:'POST',
	     enctype:'multipart/form-data',
	     processData:false,
	     contentType:false,
	     dataType:'json',
	     cache:false,
	     success:function(json){
	     	if(json.temp_post_no != "" && json.temp_post_no !== undefined) {
	     		swal("저장 완료", "게시글이 임시저장 되었습니다.", "success")
	     		.then((value) => {
	 	    		$("input[name='temp_post_no']").val(json.temp_post_no); // 임시저장 번호 대입
	     		});
	     	}
	     	else
	     		swal("저장 실패", "게시글 임시저장을 실패하였습니다.", "error");
	     },
	     error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
	 });
}

// 임시저장 목록 팝업창 띄우기
const getSavedPost = () => {
	const popupWidth = 800;
	const popupHeight = 500;

	const popupX = (window.screen.width / 2) - (popupWidth / 2);
	const popupY= (window.screen.height / 2) - (popupHeight / 2);
	
	window.open('<%=ctxPath%>/community/getSavedPost.on','임시저장 불러오기','height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
}

// 임시저장 글, 내용 불러오기
const receiveMessage = async (e) =>
{	
   	const json = e.data;
	
   	$("#post_subject").val(json.plain_post_subject);
   	$("#post_content").val(json.plain_post_content);

   	obj.getById["post_content"].exec("LOAD_CONTENTS_FIELD");
	
}

window.addEventListener("message", receiveMessage, false);


</script>


<div class='container'>
	<div class='my-4'>
		<h4>커뮤니티</h4>
	</div>

	<form id="postFrm">
		<!-- 임시저장번호 --><input type="hidden" name="temp_post_no" value=""/>
		<h5 class='text-left mb-3' style="margin-top: 80px">제목</h5>
		<input type="text" name="post_subject" id="post_subject" placeholder='제목을 입력하세요' style='width: 100%; font-size: small;' />
	
		<div class='mb-3' style='margin-top: 30px'>
			<h5 style='display: inline-block;'>내용</h5>
			<button id='saveBtn' type="button" class="btn btn-sm btn-light" style='float: right'>임시저장</button>
			<button id='getSavedPostBtn' type="button" class="btn btn-sm btn-light mr-2" style='float: right' onclick="getSavedPost()">임시저장 불러오기</button>
		</div>
		<textarea style="width: 100%; height: 612px;" name="post_content" id="post_content" placeholder='내용을 입력하세요'></textarea>
	
		<div class="filebox">
			<div class="dropBox mt-2">
				<span style='font-size: small'>이곳에 파일을 드롭해주세요.</span>
			</div>
		</div>
	</form>
	
	<div style="margin: 20px; text-align: center;">
		<button type="button" id='cancelBtn' class='btn btn-secondary rounded' onclick="javascript:history.back()">취소</button>
		<button type="button" class='btn rounded ml-2' id="submitBtn">확인</button>
	</div>
</div>