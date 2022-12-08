<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />

<%
	String ctxPath = request.getContextPath();
	System.out.print("ctxPath"+ctxPath);
%> 

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="now" class="java.util.Date" />


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
.non-email-ids{
	padding: 1px 5px;
    margin: 1px 5px;
    background-color: lightcoral;
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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
var fileNo = 0;

var total_fileList = [];
var recipient_addressList = [];
var fileSizeList = [];
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
	    var editor = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: editor,
	        elPlaceHolder: "contents",
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

			// id가 content인 textarea에 에디터에서 대입
	        editor.getById['contents'].exec("UPDATE_CONTENTS_FIELD", []);
	
			
			// 받는 사람 이메일 검사
			if($("span.rounded-pill").length ==0 ){
				// 받는사람이 존재하지 않음
				swal('발송 실패!', '메일을 보낼 대상을 선택해주세요.', 'warning')
				return false;
			}
			
			if($("span.rounded-pill").hasClass("non-email-ids") === true ) {
			// class가 존재함.
				swal('발송 실패!', '메일을 보낼 수 없는 대상이 포함되어 있습니다.', 'warning')
				return false;
				

			}
			var recipient_address = "";
			for(let i = 0; i < recipient_addressList.length; i++) {
    	 		
				recipient_address += recipient_addressList[i]+",";
    	 		  
    	 	}
			recipient_address = recipient_address.slice(0, -1);
			// console.log(recipient_address);
			
			
			// 글제목 유효성 검사
			const subject = $("input#subject").val().trim();
			if(subject == "") {
				swal('발송 실패!', '글 제목을 입력하세요.', 'warning')
			
				return;
			} 
		
		
 			// 글내용 유효성 검사
		    var contentval = $("textarea#contents").val();
		    console.log("contentval"+contentval);
		        

            contentval = contentval.replace(/&nbsp;/gi, " "); // 공백을 " " 으로 변환
               
           if(contentval.trim().length == 0) {
        	   swal('발송 실패!', '글 내용을 입력하세요.', 'warning')
               return;
           }
           console.log("contentval2"+contentval);
           // 시간 검사
           var date = "";
           var hour = "";
           var minute = "";
           var send_time = "";
		   if($('#reservationTime').is(':visible')){
				
			   date = $("input#datepicker").val();
			   // 11/28/2022
			   
			   var sttDt = date.split("/");
			   var sttYear = sttDt[2];
			   var sttMonth = sttDt[0];
			   var sttDay = sttDt[1];
			   
			   
	           var stthour = $("input#hour").val();
	           var sttminute = $("input#minute").val();	
	           
	           var reservation_date = new Date(sttYear, sttMonth, sttDay, stthour, sttminute);    

	           
	           
		        // 현재시간 
		        var now = new Date();
		        var year = now.getFullYear();     // 연도
		        var month = now.getMonth()+1;     // 월(+1해줘야됨)                             
		        var day = now.getDate();          // 일
		        var hours = now.getHours();       // 현재 시간
		        var minutes = now.getMinutes();   // 현재 분
		        
		        now_date = new Date(year, month, day, hours, minutes);
		        
		        console.log("now_date"+now_date);
		        console.log("reservation_date"+reservation_date);
		        
		        if(now_date>reservation_date){
		        	// 지금 시점보다 이전으로 예약을 하면
		        	swal('발송 실패!', "현 시각 이전으로 예약메일을 전송할 순 없습니다.", 'warning')
		        	
		        	return false;
		        }
		        
		        send_time =date+" "+hour+":"+minute;
	         
	           
			  
		   }
		   
		   // 암호 검사
           var pwd = "";

		   if($('#password').is(':visible')){
			   console.log($("input#pwd").val());		

			   pwd = $("input#pwd").val();
		   }
		   
		   // 파일 사이즈리스트 
		   var fileSizeStr = "";
		   for(let i = 0; i < fileSizeList.length; i++) {
    	 		
			   fileSizeStr += fileSizeList[i]+",";
    	 		  
    	 	}
		   fileSizeStr = fileSizeStr.slice(0, -1);
		  	

		   // 폼(form)을 전송(submit)
		   var formData = new FormData();
		   if(total_fileList.length > 0){
			   total_fileList.forEach(function(f){
	                formData.append("fileList", f);
	            });
	        } 
		   formData.append("contents",contentval);
		   formData.append("subject",subject);
		   formData.append("recipient_address",recipient_address);
		   // 시간
		   formData.append("date",date);
		   formData.append("hour",hour);
		   formData.append("minute",minute);
		   formData.append("send_time",send_time);
		   // 비밀번호
		   formData.append("password",pwd);
		   // 
		   formData.append("fileSize",fileSizeStr);
           
           console.log(date);		
		   console.log(hour);
		   console.log(minute);
			

		  
		   $.ajax({
	            url : '<%= ctxPath%>/addMail.on',
	            data : formData,
	            type:'POST',
	            enctype:'multipart/form-data',
	            processData:false,
	            contentType:false,
	            dataType:'json',
	            cache:false,
	            success:function(json){
	            	if(json.n == 1){
	            		swal('메일발송에 성공하였습니다.', "버튼을 누르면 보낸 메일함으로 이동합니다.", 'success')
	            		location.href = "<%=ctxPath%>/mail/sendMailBox.on";
	            	}
	            	if(n==0){
	            		swal('메일발송이 실패하셨습니다.', "이 상태가 지속되면 지원팀에 문의해주세요.", 'warning')
	            		return false;
	            	}
	            	if(n==-1){
	            		swal('메일발송이 실패하셨습니다.', "파일 업로드 진행중 문제가 발생하였습니다.", 'warning')
	            		return false;
	            	}
	            	
	            },error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            } 
	        }); 
		   
		   
		   
		   
		});
		
		// 이메일 자동완성
		var emailList = ${requestScope.mailList}
		
		$("#receieveName").autocomplete({
			source : emailList
		});
		// 답장이면 보낸이 이메일 추가
		if('${requestScope.replyList}' != null){
				<c:forEach var="reply" items="${requestScope.replyList}" varStatus="status">
				var emailStartIdx = '${reply}'.indexOf("<")+2;
				var emailEndIdx = '${reply}'.indexOf(">")-1;
				var emailOnly = '${reply}'.substring(emailStartIdx, emailEndIdx);
				
				for(let i = 0; i < recipient_addressList.length; i++) {
	    	 		if(recipient_addressList[i] == emailOnly )  {
	    	 			swal('중복된 이메일입니다', "다른 이메일을 선택해주세요.", 'warning')
	    	 			$("input#receieveName").val('');
	    	 			return false;
	    	 		  }
	    	 	}
				
				
				$("#receieveName").val("");
				
				
				
				if(emailOnly == '${sessionScope.loginuser.cpemail}'){
					$("#receiver").append(`<span class="rounded-pill email-ids myMail" name="email-container">`
							 + '${sessionScope.loginuser.department } '+ '${sessionScope.loginuser.position } '+ '${sessionScope.loginuser.name}'
							 + '&lt;'+'${sessionScope.loginuser.cpemail}' +'&gt;'
							 + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span></span>');
					$("#selfMail").prop("checked", true);
				}
				else{
					$("#receiver").append('<span class="rounded-pill email-ids" name="email-container">'
							+ ${reply} + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span></span>');
				}
				recipient_addressList.push(emailOnly);

			</c:forEach>
			
		}
		
		
		// 받는사람 입력후 스페이스바나 엔터 누르면 한 단위로 묶기
		$("#receieveName").keydown(function(e){
			if(e.keyCode == 13 || e.keyCode == 32){
				var getValue = $(this).val();
				console.log("getValue: "+getValue);
				
				for(let i = 0; i < emailList.length; i++) {
	    	 		if(emailList[i] == getValue )  {
	    	 			// 가져온 리스트 안의값이라면 
	    	 			inList = true;
	    	 			break;
	    	 		  }
	    	 	}

				var emailStartIdx = getValue.indexOf("<")+2;
				var emailEndIdx = getValue.indexOf(">")-1;
				var emailOnly = getValue.substring(emailStartIdx, emailEndIdx);
				// 이미 가져온 값인지 비교
				for(let i = 0; i < recipient_addressList.length; i++) {
	    	 		if(recipient_addressList[i] == emailOnly )  {
	    	 			swal('중복된 이메일입니다', "다른 이메일을 선택해주세요.", 'warning')
	    	 			$("input#receieveName").val('');
	    	 			return false;
	    	 		  }
	    	 	}
				console.log("emailOnly"+emailOnly)
				
				if(inList == true){
					if(emailOnly == '${sessionScope.loginuser.cpemail}'){
						$("#receiver").append(`<span class="rounded-pill email-ids myMail" name="email-container">`
								 + '${sessionScope.loginuser.department } '+ '${sessionScope.loginuser.position } '+ '${sessionScope.loginuser.name}'
								 + '&lt;'+'${sessionScope.loginuser.cpemail}' +'&gt;'
								 + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span></span>');
						$("#selfMail").prop("checked", true);
					}
					else{
						$("#receiver").append('<span class="rounded-pill email-ids" name="email-container">'
								+ ${reply} + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span></span>');
					}
				}
				else{
					$("#receiver").append('<span class="rounded-pill non-email-ids" name="email-container">'
							+ getValue + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span></span>');
					$("#receieveName").val("");
					
				}
				
				
				
				recipient_addressList.push(emailOnly);
				if(emailOnly == '${sessionScope.loginuser.cpemail}'){
					$("#selfMail").prop("checked", true);
				}
			}
			
			
		});
		
		$("#selfMail").change(function(){
	        if($("#selfMail").is(":checked")){
	        	
	        	
	        	for(let i = 0; i < recipient_addressList.length; i++) {
	    	 		if(recipient_addressList[i] == '${sessionScope.loginuser.cpemail}' )  {
	    	 			swal('중복된 이메일입니다', "다른 이메일을 선택해주세요.", 'warning')
	    	 			$("input#receieveName").val('');
	    	 			$("#selfMail").prop("checked", false);
	    	 			return false;
	    	 		  }
	    	 	}
	        	
	        	$("#receiver").append(`<span class="rounded-pill email-ids myMail" name="email-container">`
	        						 + '${sessionScope.loginuser.department } '+ '${sessionScope.loginuser.position } '+ '${sessionScope.loginuser.name}'
	        						 + '&lt;'+'${sessionScope.loginuser.cpemail}' +'&gt;'
	        						 + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span></span>');
	        	
	        	
	        	recipient_addressList.push('${sessionScope.loginuser.cpemail}');
	        	
	        }else{
	        	for(let i = 0; i < recipient_addressList.length; i++) {
	    	 		if(recipient_addressList[i] == '${sessionScope.loginuser.cpemail}' )  {
	    	 			recipient_addressList.splice(i, 1);
	    	 		    i--;
	    	 		  }
	    	 	}
	        	$(".myMail").remove();
	        }
	    });
		
		// 주소 삭제버튼 클릭
		$(document).on('click','[name=removeAddress]', function(){
			$(this).parent().remove();
			if($(this).parent().hasClass("myMail")){
				$("input:checkbox[id='selfMail']").prop("checked", false);
			}
			var emailStartIdx = $(this).parent().text().indexOf("<")+2;
			var emailEndIdx = $(this).parent().text().indexOf(">")-1;
			var delete_address = $(this).parent().text().substring(emailStartIdx, emailEndIdx);
			
			for(let i = 0; i < recipient_addressList.length; i++) {
    	 		if(recipient_addressList[i] == delete_address )  {
    	 			recipient_addressList.splice(i, 1);
    	 		    i--;
    	 		  }
    	 	}
			console.log(recipient_addressList);
			
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
	    	 	console.log($(this).attr('file_name'));
	    	 	delete_file_name =$(this).attr('file_name');
	    	 	console.log($(this).attr('file_size'));
	    	 	delete_file_size =$(this).attr('file_size');
	    	 	
	    	 	for(let i = 0; i < total_fileList.length; i++) {
	    	 		if(total_fileList[i].name = delete_file_name && delete_file_size == total_fileList[i].size)  {
	    	 			total_fileList.splice(i, 1);
	    	 			fileSizeList.splice(i, 1);
	    	 		    i--;
	    	 		  }
	    	 	}
	    	 	

	    	 	console.log(total_fileList);
	    	 	
	    	 // FormData의 값 확인
	    	 /*
	    	 	 for (var pair of formData.entries()) {
	    	 	  console.log(pair[0]+ ', ' + pair[1]);
	    	 	  console.log(pair[1])
	    	 	} 
	    	 */
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
	        total_fileList.push(file);
	        console.log(total_fileList);
	        
	        fileSize = setUnitString(file.size);
	        fileSizeList.push(fileSize);
	        
	        $('#dropzone').append('<div class="uploadFile" style="display:flow-root"><span style="float:left">'+file.name+'</span><span style="float:right">'+fileSize+'<span class = "removeFile" name="removeFile" file_size="'+file.size+'"file_name="'+file.name+'"><i class="far fa-window-close"></i></span></span></div>');
	        
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
			
			<button id="btnWrite" type="button" class="btn btn-outline-dark"><i class="far fa-paper-plane"></i> 보내기</button>
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
							<input class="bottomLine" id="receieveName" type="text" name="receieveName" placeholder="받는사람"/>
	
						</td>
					</tr>
					<tr>
						<th style="width: 15%; background-color: #E3F2FD;">보내는사람</th>
						<td>
							<input class="bottomLine" type="text" name="name" value="${sessionScope.loginuser.cpemail }" readonly />
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
							<textarea style="width: 100%; height: 612px;" name="contents" id="contents">
								
								<c:if test="${requestScope.type == 'reply'}">
									<p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p>
									<p>------------------------------------ original message ------------------------------------</p>
										${mailVO.contents}
									<p>------------------------------------------------------------------------------------------</p>	
								</c:if>
								
							</textarea>
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