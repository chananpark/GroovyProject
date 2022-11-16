<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />

<%
	String ctxPath = request.getContextPath();
%> 
<style type="text/css">

.tool_bar .optional {
    float: right;
    margin: 5px 24px 0 0;
    position: inherit;
}
.toolbarDropdown{ /* 툴바 드랍다운 사이즈 조정 */
    height: 22px;
    margin: 0;
    padding: 0px 8px 0px 5px;
}
#mailToolbar{
	padding: 10px 0;
	border-bottom: solid 1px #ddd;
}
#dropzone{
	min-height: 200px;
	border: dashed 2px gray;
}
.bottomLine{
	border: none;
    border-bottom: 1px solid #ddd;
}
.ymd{
	text-align: center;
    width: 110px;
}
th{
	text-align: center;

}
td{
	background-color: #fff;
}
.email-ids{
    padding: 1px 5px;
    margin: 1px 5px;
    background-color: #E3F2FD;
}
.removeAddress{
	margin: 0 5px;
}
.filebox label {
  margin: 0;
  vertical-align: middle;

}

 .filebox input[type="file"] {  /* 파일 필드 숨기기 */
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip:rect(0,0,0,0);
  border: 0;
} 


</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
var fileNo = 0;
var formData = new FormData();
	$(document).ready(function(){
		var formArray = {};  //파일을 담을 객체 key, value 형태로 파일을 담든다.
		var fileList = new Object();
		
		
		
		
		
		
		$('#datepicker').datepicker(); // datepicker
		
		$("#datepicker").datepicker({
           dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
           ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
       });                    
       
       //초기값을 오늘 날짜로 설정해줘야 합니다.
       $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	
	
	
		
		
		<%-- === 스마트 에디터 구현 시작 === --%>
		//전역변수
	    var obj = [];
	    
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
	    <%-- === 스마트 에디터 구현 끝 === --%>
	    
		// 글쓰기 버튼
		$("button#btnWrite").click(function(){
			
			<%-- === 스마트 에디터 구현 시작 === --%>
			// id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		    <%-- === 스마트 에디터 구현 끝 === --%>
			
			// 글제목 유효성 검사
			const subject = $("input#subject").val().trim();
			if(subject == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
		<%--	
			// 글내용 유효성 검사(스마트 에디터 사용 안 할 경우)
			const content = $("textarea#content").val().trim();
			if(content == "") {
				alert("글내용을 입력하세요!!");
				return;
			}
		--%>	
		
		<%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 시작 === --%>
		    var contentval = $("textarea#content").val();
		        
		 // 글내용 유효성 검사 하기 
         // alert(contentval); // content에  공백만 여러개를 입력하여 쓰기할 경우 알아보는것.
         // <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 이라고 나온다.
         
            contentval = contentval.replace(/&nbsp;/gi, ""); // 공백을 "" 으로 변환
         /*    
		         대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
		     ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
		                  그리고 뒤의 gi는 다음을 의미합니다.
		
		 	 g : 전체 모든 문자열을 변경 global
		 	 i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
		*/ 
      //   alert(contentval);
      //   <p>             </p>
         
           contentval = contentval.substring(contentval.indexOf("<p>")+3);   // "             </p>"
           contentval = contentval.substring(0, contentval.indexOf("</p>")); // "             "
                  
           if(contentval.trim().length == 0) {
        	   alert("글내용을 입력하세요!!");
               return;
           }
		 <%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 끝 === --%>
		
		   // 글암호 유효성 검사
		   const pw = $("input#pw").val().trim();
		   if(pw == "") {
			  alert("글암호를 입력하세요!!");
			  return;
		   }
			
		   // 폼(form)을 전송(submit)
		   const frm = document.addFrm;
		   frm.method = "POST";
		   frm.action = "<%= ctxPath%>/mailAdd.action";
		   frm.submit();
		});
		
		
		// 받는사람 입력후 스페이스바나 엔터 누르면 한 단위로 묶기
		$("#receieveName").keydown(function(e){
			if(e.keyCode == 13 || e.keyCode == 32){
				var getValue = $(this).val();
				console.log("getValue: "+getValue);
				
				if(getValue.trim()!= null && getValue.trim() != ""){
					$("#receiver").append('<span class="rounded-pill email-ids" name="email-container">'
							+ getValue + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span></span>');
					$("#receieveName").val("")
				}
				
			}
			
			
		});
		
		$("#selfMail").change(function(){
	        if($("#selfMail").is(":checked")){
	        	$("#receiver").append('<span class="rounded-pill email-ids myMail" name="email-container">'
						+ '내이메일' + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span></span>');
				
	        }else{
	        	$(".myMail").remove();
	        }
	    });
		
		$(document).on('click','[name=removeAddress]', function(){
			$(this).parent().remove();
			if($(this).parent().hasClass("myMail")){
				$("input:checkbox[id='selfMail']").prop("checked", false);
			}
		});
		
		// 파일 다중 선택시 리스트로 받아와서 처리하기
		$('#ex_file').change(function(e) {
		    fileList = $(this)[0].files;  //파일 대상이 리스트 형태로 넘어온다.
		    addFile(fileList);
		});
		
		
		

	    
		
		// 파일 드래그 드랍 시작
		var obj = $("#dropzone");

	     obj.on('dragenter', function (e) {
	          e.stopPropagation();
	          e.preventDefault();
	          $(this).css('border', '2px solid #5272A0');
	     });

	     obj.on('dragleave', function (e) {
	          e.stopPropagation();
	          e.preventDefault();
	          $(this).css('border', '2px dotted #8296C2');
	     });

	     obj.on('dragover', function (e) {
	          e.stopPropagation();
	          e.preventDefault();
	     });

	     obj.on('drop', function (e) {
	          e.preventDefault();
	          $(this).css('border', '2px dotted #8296C2');
	          var fileList = e.originalEvent.dataTransfer.files
	          console.log(fileList);
	          
	          addFile(fileList);
	          
	     });
	  // 파일 드래그 드랍 끝
		// 파일 삭제버튼 클릭시
	     $(document).on('click','[name=removeFile]', function(){
	    	 	console.log(this);
	    	 	console.log($(this).attr('no'));
	    	 	no = $(this).attr('no');
	    	 	
	    	 	formData.delete('file'+no);
	    	 	
	    	 // FormData의 값 확인
	    	 	/* for (var pair of formData.entries()) {
	    	 	  console.log(pair[0]+ ', ' + pair[1]);
	    	 	  console.log(pair[1])
	    	 	} */
	    	 
				$(this).parent().parent().remove();
				uploadFileCheck();
			});
	  
	  
	  // 버튼 누르면 해당 기능 나오도록
	  $('#reservationTimeCheck').click(function(){
		  $('#reservationTime').toggle();
	  });
	  
	  $('#passwordCheck').click(function(){
		  $('#password').toggle();
	  });
	  
	  $('#reservationTime').hide();

	  $('#password').hide();
	  
	  // 눈 아이콘 클릭시 비밀번호 보이도록
	  $('.fa-eye').on('click',function(){
	        $('input#pwd').toggleClass('active');
	        if($('input#pwd').hasClass('active')){
	            $(this).attr('class',"fa fa-eye-slash fa-lg")
	            $('input#pwd').attr('type',"text");
	        }else{
	            $(this).attr('class',"fa fa-eye fa-lg")
	            $('input#pwd').attr('type','password');
	        }
	    });

	  
	  
	});// end of $(document).ready(function(){})-------------------

	function setUnitString (nByte) {
 		var nImageSize;
 		var sUnit;
 		
 		if(nByte < 0 ){
 			nByte = 0;
 		}
 		
 		if( nByte < 1024) {
 			nImageSize = Number(nByte);
 			sUnit = 'B';
 			return nImageSize + sUnit;
 		} else if( nByte > (1024*1024)) {
 			nImageSize = Number(parseInt((nByte || 0), 10) / (1024*1024));
 			sUnit = 'MB';
 			return nImageSize.toFixed(2) + sUnit;
 		} else {
 			nImageSize = Number(parseInt((nByte || 0), 10) / 1024);
 			sUnit = 'KB';
 			return nImageSize.toFixed(0) + sUnit;
 		}
     }
	
	function addFile(fileList){
		for(var i=0;i < fileList.length;i++){
	        var file = fileList[i];
	        
	        formData.append('file'+fileNo, file);  //파일을 더해준다.
	        
	        console.log(file);
	        
	        fileSize = setUnitString(file.size);
	        $('#dropzone').append('<div class="uploadFile" style="display:flow-root"><span style="float:left">'+file.name+'</span><span style="float:right">'+fileSize+'<span class = "removeFile" name="removeFile" no="'+fileNo+'"><i class="far fa-window-close"></i></span></span></div>');
	        
	        
	        console.log(formData.get('file'+fileNo));
	        fileNo++;
	        uploadFileCheck();
	    }
	}
	
	function uploadFileCheck(){
		if($('.uploadFile').length){
			$('#dropzoneMessage').hide();
		}
		else{
			/* $('#dropzoneMessage').show(); */// 왜안먹지
			jQuery('#dropzoneMessage').show();
		}
	}
	
</script>



<!-- <div id="body" style="background-color:#F9F9F9"> -->
<h2>메일쓰기</h2>
	<div id="mailToolbar" class="tool_bar">
		<div class="toolbarButton">
			
			<button type="button" class="btn btn-outline-dark"><i class="far fa-paper-plane"></i> 보내기</button>
			<button type="button" class="btn btn-outline-dark"><i class="fas fa-archive"></i> 임시저장</button>
			<button type="button" class="btn btn-outline-dark"><i class="fas fa-archive"></i> 다시쓰기</button>
	
		</div>
		
	</div>
	<div>
	 		<form name="addFrm" enctype="multipart/form-data">
		   	   <table style="width: 95%; margin-top:10px" class="table table-bordered">
		   	  		<tr>
						<th style="width: 15%; background-color: #E3F2FD;">받는사람 <br>
						나에게 쓰기<input type="checkbox" id="selfMail" style="margin-left: 3px;"></th>
						<td ><span id="receiver"></span>
							<input class="bottomLine" id="receieveName" type="text" name="receieveName" value="받는사람"/>
	
						</td>
					</tr>
					<tr>
						<th style="width: 15%; background-color: #E3F2FD;">보내는사람</th>
						<td>
							<input class="bottomLine" type="text" name="name" value="보내는사람" readonly />
						</td>
					</tr>
					
					<tr>
						<th  style="width: 15%; background-color: #E3F2FD; 	vertical-align: middle;">파일첨부</th>
						<td>
							<div class="filebox">
							  <label class="btn btn-outline-secondary" for="ex_file">업로드</label>
							  <input type="file" id="ex_file" multiple> 
							</div>
							
						</td>
			
					</tr>
					<tr>
						<th  style="width: 15%; background-color: #E3F2FD;"></th>
						<td>
							<div id="dropzone">
							  	
							  	<div id = "dropzoneMessage"style="text-align:center; padding:85px;" ><i class="fas fa-paperclip"></i>여기에 첨부 파일을 끌어 오세요</div>
								
							</div>
						</td>
					</tr>
					
					<tr>
						<th style="width: 15%; background-color: #E3F2FD;">제목</th>
						<td>
						       <input class="bottomLine" type="text" name="subject" id="subject" size="100" />
						</td>
					</tr>
					
					<tr>
						<th style="width: 15%; background-color: #E3F2FD;">내용</th>
						<td>
							<textarea style="width: 100%; height: 612px;" name="content" id="content"></textarea>
						</td>
					</tr>
					
					<!-- 예약메일 누르면 노출되도록 -->
					<tr id="reservationTime">
						<th style="width: 15%; background-color: #E3F2FD;">예약시간</th>
						<td>
							날짜<input class="bottomLine ymd" type="text" name="datepicker" id="datepicker" />   
							<input class="bottomLine" type="number" min="0" max="23" name="hour" id="hour" style="width:40px;text-align:center;"/>시
							<input class="bottomLine" type="number" min="0" max="59" name="minute" id="minute" style="width:40px;text-align:center;"/>분
						</td>
					</tr>
					
					<!-- 보안 메일 누르면 노출되도록 -->
					<tr id="password">
						<th style="width: 15%; background-color: #E3F2FD;">글암호</th>
						<td>
							<input class="bottomLine" type="password" name="pwd" id="pwd" /> 
							<i class="fa fa-eye fa-lg"></i>
						</td>
					</tr>
				</table>	
				
	
	   
	   	   </form>
	</div>   	   
	<div id = "buttonField">
		<button id="reservationTimeCheck" type="button" class="btn btn-dark">예약메일</button>
		<button id="passwordCheck" type="button" class="btn btn-dark">보안메일</button>
		<span id="sendMailCheckBox" style="float:right;">
		<input type="checkbox" id="saveSendMail" value="off" style="vertical-align:middle; ">보낸메일함 저장
		</span>
	</div>
<!-- </div> -->