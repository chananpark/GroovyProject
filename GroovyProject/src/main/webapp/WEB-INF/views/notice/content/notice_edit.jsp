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
	//네이버 스마트 에디터용 전역변수
	var obj = [];	
	// 파일 정보를 담아 둘 배열
	let fileList = [];
	
	$(document).ready(function(){
		
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
	   	 
		}); // end of $(document).on('click','[name=removeFile]') ------------------
		
		// 기존 첨부파일 조회
		getExistingFiles();
		
		
		
		/* 확인 버튼 클릭 시 */
		$("button#submitBtn").click(function(){
			   
			// 에디터에서 textarea에 대입
			obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			
			// 글제목 유효성 검사
			const subject = $("input#subject").val().trim();
			if(subject == "") {
				swal("글제목을 입력하세요!")
				.then(function (result) {
					document.getElementById("subject").focus(); //포커싱
			      })
				return;
			}
			
			// 글내용 유효성검사
		    var content = $("#content").val();

		    if( content == ""  || content == null || content == '&nbsp;' || content == '<p>&nbsp;</p>')  {
				swal("글내용을 입력하세요!")
				.then(function (result) {
					obj.getById["content"].exec("FOCUS"); //포커싱
			      })
				return;
		    }
		    
		    // 폼 제출
		    submitPost();

		}); // end of $("button#submitBtn").click() ------------------------------
		
		
		
	}); // end of $(document).ready() =====================================================



	// 기존 첨부파일 조회 
	function getExistingFiles(){
		
		$.ajax({
			url : "<%=ctxPath%>/notice/getNoticeFiles.on",
			data : {"seq": "${noticevo.seq}"},
			dataType:'json',
			cache:false,
			success:function(jsonArr){
				
				let html = "";
				
				// 첨부파일이 있을 경우			
				if(jsonArr.length > 0) {
					jsonArr.forEach(el => {
						html += "<div>"+el.originalfilename+"<button type='button' class='ml-2' onclick='deleteFile("+el.notice_file_seq+")'>삭제</button></div>"
					});
				}
				$("#attachedFiles").html(html);
	     	},
		     error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		 });
		
	}
	
	// 새로 첨부된 파일 가져오기
	function getNewFiles(formData){
		
		if(fileList.length > 0){
		    fileList.forEach(function(f){
		        formData.append("fileList", f);
		    });
		}
		
	}
	
	// 폼 제출
    function submitPost(){
		
    	// formData 가져오기
    	let formData = new FormData($("#noticeFrm")[0]);
    	
    	// 첨부파일 formData에 추가하기
    	getNewFiles(formData);
    	
    	 $.ajax({
    	     url : "<%=ctxPath%>/notice/editEnd.on",
    	     data : formData,
    	     type:'POST',
    	     enctype:'multipart/form-data',
    	     processData:false,
    	     contentType:false,
    	     dataType:'json',
    	     cache:false,
    	     success:function(json){
    	     	if(json.result == true) {
    	 	    	swal("수정 완료", "게시글이 수정되었습니다.", "success")
    	 	    	.then((value) => {
    		    	    	location.href="<%=ctxPath%>/notice/detail.on?seq=${noticevo.seq}";
    		    		});
    	     	}
    	     	else
    	     		swal("수정 실패", "게시글 수정을 실패하였습니다.", "error");
    	     },
    	     error: function(request, status, error){
    			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    			}
    	 });
		
	}
	
	function deleteFile(notice_file_seq){
		
		$.ajax({
		     url : "<%=ctxPath%>/notice/deleteFile.on",
		     data : {"notice_file_seq": notice_file_seq},
		     type:'POST',
		     dataType:'json',
		     cache:false,
		     success:function(json){
		     	if(json.result == true) {
		     		// 첨부파일 다시 조회
		     		getExistingFiles();
		     	}
		     	else
		     		swal("등록 실패", "게시글 작성을 실패하였습니다.", "error");
		     },
		     error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		 });
		
	}
	
</script>   



    
<div class='container'>
	<div class='my-4'>
		<h4>공지사항</h4>
	</div>

	<form id="noticeFrm">
		<input type="hidden" name="seq" value="${noticevo.seq}"/>
		<h5 class='text-left mb-3' style="margin-top: 80px">제목</h5>
		<input type="text" name="subject" id="subject" placeholder='제목을 입력하세요' style='width: 100%; 
		font-size: small;' value="${noticevo.subject}"/>
	
		<div class='mb-3' style='margin-top: 30px'>
			<h5 style='display: inline-block;'>내용</h5>
			<button id='saveBtn' type="button" class="btn btn-sm btn-light" style='float: right'>임시저장</button>
			<button id='getSavedPostBtn' type="button" class="btn btn-sm btn-light mr-2" style='float: right'>임시저장 불러오기</button>
		</div>
		<textarea style="width: 100%; height: 612px;" name="content" id="content" placeholder='내용을 입력하세요'>
		${noticevo.content}</textarea>
		
		<div class='card'>
			<div class='card-header small'>첨부된 파일</div>
			<div class='card-body small' id='attachedFiles'>
				
			</div>
		</div>
	
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