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

	//전역변수
	let obj = [];
	
	// 파일 정보를 담아 둘 배열
	let fileList = [];

	$(document).ready(function(){ // =========================================================
		
		<%-- 스마트에디터 구현 --%>
		
	       
		//스마트에디터 프레임생성
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: obj,
			elPlaceHolder: "content",
			sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,            
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,    
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,
			}
		});	
		
		// 글쓰기 버튼
		$("button#submitBtn").click(function(){
			
			
         
			<%-- === 스마트 에디터 구현 시작 === --%>
			// id가 content인 textarea에 에디터에서 대입
			obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			<%-- === 스마트 에디터 구현 끝 === --%>

			// 글제목 유효성 검사
			const subject = $("#subject").val().trim();
			if(subject == "") {
				alert("글제목을 입력하세요!!");
				return;
			}

			<%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 시작 === --%>
			let contentval = $("textarea#content").val();
			contentval = contentval.replace(/&nbsp;/gi, "");
			contentval = contentval.substring(contentval.indexOf("<p>")+3);
            contentval = contentval.substring(0, contentval.indexOf("</p>"));
            
            if(contentval.trim().length == 0) {
	        	alert("글내용을 입력하세요!!");
	        	return;
	        }		
  
			<%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 끝 === --%>

			submitPost();
			 
		});
		
		
		/* 파일 드래그 & 드롭 */
		// 파일 드롭 영역
		const $drop = document.querySelector(".dropBox");
		
		// 드래그한 파일 객체가 해당 영역에 놓였을 때
		$drop.ondrop = function(e) {
			e.preventDefault();  // 태그 고유의 속성(동작) 중단
			e.stopPropagation(); // 이벤트가 상위 엘리먼트에 전달되지 않게 막아줌
			
			// 드롭된 파일 리스트 가져오기
			const files = Array.from(e.dataTransfer.files); // dataTransfer : 드래그 앤 드롭 이벤트를 위한 모든 이벤트 리스너 메소드(event listener method)는 DataTransfer 객체를 반환
			
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
	
		
		
	}); // end of $(document).ready() ======================================================
	
	
	function getFiles(formData){

		if(fileList.length > 0){
		    fileList.forEach(function(f){
		        formData.append("fileList", f);
		    });
		}
	}
	
	
	function submitPost(){ // ------------------------------------------------------
		
		// formData 가져오기
		let formData = new FormData($("#noticeFrm")[0]);
		
		// 첨부파일 formData에 추가하기
		getFiles(formData);
		
		$.ajax({
		     url : "<%=ctxPath%>/notice/writeEnd.on",
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
			    	    	location.href = "<%=ctxPath%>/notice/list.on";
			    		});
		     	}
		     	else
		     		swal("등록 실패", "게시글 작성을 실패하였습니다.", "error");
		     },
		     error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		 });
		
	} // end of function submitPost(){} -----------------------------------------

</script>


<div class='container'>
	<div class='my-4'>
		<h4>공지사항</h4>
	</div>

	<form id="noticeFrm">
	
		<h5 class='text-left mb-3' style="margin-top: 80px">제목</h5>
		<%-- == 답변글쓰기인 경우 == --%> 
        <c:if test='${not empty requestScope.fk_seq}'> 
	       <input type="text" name="subject" id="subject" style='width: 100%; font-size: small;' value="Re: ${requestScope.subject}" readonly /> 
	    </c:if>
	    <%-- == 원글쓰기인 경우 == --%>
        <c:if test='${empty requestScope.fk_seq}'>
	       <input type="text" name="subject" id="subject" placeholder='제목을 입력하세요' style='width: 100%; font-size: small;' />
	    </c:if>
			
		<div class='mb-3' style='margin-top: 30px'>
			<h5 style='display: inline-block;'>내용</h5>
			<button id='saveBtn' type="button" class="btn btn-sm btn-light" style='float: right'>임시저장</button>
			<button id='getSavedPostBtn' type="button" class="btn btn-sm btn-light mr-2" style='float: right'>임시저장 불러오기</button>
		</div>
		<textarea style="width: 100%; height: 612px;" name="content" id="content" placeholder='내용을 입력하세요'></textarea>
	
		<div class="filebox">
			<div class="dropBox mt-2">
				<span style='font-size: small'>이곳에 파일을 드롭해주세요.</span>				
			</div>
		</div>
		
		<%-- === 답변글쓰기 추가 시작 === --%>
		<input type="hidden" name="fk_seq"  value="${requestScope.fk_seq}" />
		<input type="hidden" name="groupno" value="${requestScope.groupno}" />
		<input type="hidden" name="depthno" value="${requestScope.depthno}" />
		<%-- === 답변글쓰기 추가 끝 === --%>
        
	</form>
	
	<div style="margin: 20px; text-align: center;">
		<button type="button" id='cancelBtn' class='btn btn-secondary rounded' onclick="javascript:history.back()">취소</button>
		<button type="button" class='btn rounded ml-2' id="submitBtn">확인</button>
	</div>
</div>