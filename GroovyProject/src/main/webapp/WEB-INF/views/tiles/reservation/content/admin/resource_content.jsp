<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	.input_width {
	  width: 100%; /* Full width */
	  padding: 8px; /* Some padding */ 
	  border: 1px solid #ccc; /* Gray border */
	  border-radius: 4px; /* Rounded borders */
	  box-sizing: border-box; /* Make sure that padding and width stays in place */
	  margin-top: 5px; /* Add a top margin */
	  resize: vertical; /* Allow the user to vertically resize the textarea (not horizontally) */
	  vertical-align: middle;
	}
	
	.input_style {
	  padding: 8px; /* Some padding */ 
	  border: 1px solid #ccc; /* Gray border */
	  border-radius: 4px; /* Rounded borders */
	  box-sizing: border-box; /* Make sure that padding and width stays in place */
	  margin-top: 5px; /* Add a top margin */
	  resize: vertical; /* Allow the user to vertically resize the textarea (not horizontally) */
	  vertical-align: middle;
	}
	
	.checkbox_color {
	  accent-color: #086BDE;
	}
	
	#color {
		border: 1px solid #ccc; /* Gray border */
		border-radius: 4px; /* Rounded borders */
		box-sizing: border-box; /* Make sure that padding and width stays in place */
		margin-top: 5px; /* Add a top margin */
		resize: vertical; /* Allow the user to vertically resize the textarea (not horizontally) */
		vertical-align: middle;
		height: 40px;
		width: 100px;
		background-color: white;
	}

	
	.insert_sche_title {
		font-weight: bold; 
		font-size: 12pt;
	}
	
	.insert_sche_tr {
		vertical-align: middle; 
		height: 70px;
	}
	
	.ui-autocomplete {
		max-height: 150px;
		overflow-y: auto;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		<%-- === #167. 스마트에디터 구현 시작 === --%>
		//전역변수
    	var obj = [];
	       
    	//스마트에디터 프레임생성
       	nhn.husky.EZCreator.createInIFrame({
        	oAppRef: obj,
           	elPlaceHolder: "lgcategcontent",
           	sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
           	htParams : {
            	// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
               	bUseToolbar : true,            
               	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
               	bUseVerticalResizer : true,    
               	// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
               	bUseModeChanger : true,
               	// 페이지 나가기 알림 지우기
               	fOnBeforeUnload : function() {}
         	}
		});
       	<%-- === 스마트 에디터 구현 끝 === --%>
		
     	// 자원 안내 수정 완료 버튼
		$("#register").click(function(){
		
			<%-- === 스마트 에디터 구현 시작 === --%>
			// id가 content인 textarea에 에디터에서 대입
			obj.getById["lgcategcontent"].exec("UPDATE_CONTENTS_FIELD", []);
			<%-- === 스마트 에디터 구현 끝 === --%>
			
			<%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 시작 === --%>
	       	var contentval = $("textarea#lgcategcontent").val();
	                
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
	        // alert(contentval);
	        //   <p>             </p>
	           
	        contentval = contentval.substring(contentval.indexOf("<p>")+3); 	// "             </p>"
	        contentval = contentval.substring(0, contentval.indexOf("</p>"));	// "             "
	                    
	        if(contentval.trim().length == 0) {
	       		swal("예약 안내를 입력하세요.");
	            return;
	        }
	        <%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 끝 === --%>
	        
			var frm = document.resourceContentFrm;
		    frm.method="POST";
		    frm.action="<%= ctxPath%>/reservation/admin/endEditResourceContent.on";
		    frm.submit();
			
		});
			
	}); // end of ready
	

	// ===== function declaration =====
		
	
</script>



	
<div style='margin: 1% 0 5% 1%; display: flex;'>
	<h4>${requestScope.lvo.lgcatgoname} 예약 안내 수정</h4>
</div>


<div class="" id="resourceContent" style="width:95%; margin-left: 2.5%;">

	<form name="resourceContentFrm">
		<textarea style="width: 100%; height: 612px;" name="lgcategcontent" id="lgcategcontent">${requestScope.lvo.lgcategcontent}</textarea>
		<input type="hidden" value="${sessionScope.loginuser.empno}" name="empno"/>
		<input type="hidden" value="${requestScope.listgobackURL_reserv}" name="listgobackURL_reserv"/>
		<input type="hidden" value="${requestScope.lvo.lgcatgono}" name="lgcatgono"/>
	</form>
	
	<div style="float:right;" class="mr-2 mt-4">
		<button class="btn bg-light mr-2" onclick="javascript:location.href='<%= ctxPath%>${requestScope.listgobackURL_reserv}'">취소</button> <%-- url 기억하기 만들어주기 --%>
		<button class="btn" id="register" style="background-color: #086BDE; color:white;">수정</button>
	</div>
	
</div>
	
	



