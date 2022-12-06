<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />

<style type="text/css">
.btn_submenu>a{
	color:black;
}
.btn_submenu{
    display: inline-block;
    position: relative;
    vertical-align: middle;
}
.tool_bar .optional {
    float: right;
    margin: 5px 24px 0 0;
    position: inherit;
}

#mailToolbar{
    padding: 0;

}

.toolflag{
	color:inherit !important;
}

.table td, .table th {
    padding: 0.75rem;
    vertical-align: top;
    border-top: 1px solid #dee2e6;
}



</style>
<script type="text/javascript">
	$(document).ready(function(){

		
		
		$("div#displayList").hide();
		
		$(document).on('click','#mailLAllCheck_btn', function(){
			if($("#mailLAllCheck").is(":checked")){
				$("input:checkbox[id='mailLAllCheck']").prop("checked", false);
	        }else{
	        	$("input:checkbox[id='mailLAllCheck']").prop("checked", true);
	        }
		});
		
		
		// 검색 엔터
		$("input#searchWord").keyup(function(e){
			if(e.keyCode == 13) {
				// 검색어에 엔터를 했을 경우
				goSearch();
			}
		});
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if( ${not empty requestScope.paraMap} ) {
			$("select#searchType").val("${requestScope.paraMap.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.searchWord}");
		}

		
	});
	
	function goSearch() {
		const frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/mail/sendMailBox.on";
		frm.submit();
	}// end of function goSearch()--------------------
	

	
	function listRefresh(){ // 체크박스 유지용
		var formData = new FormData();
		var param = window.location.search;
		console.log("param"+param);
		
		// 원래 체크박스 기억
		var mailCheck = document.querySelectorAll('input[name="mailCheck"]:checked');
		console.log(mailCheck);
		if(mailCheck.length > 0){
		result="";
		mailCheck.forEach((el) => {
			result += el.value;
			result += ',';
		});
		 var checkbox = result.slice(0, -1);
		 console.log("checkbox"+checkbox);
		// 체크한 것들 번호 가져가서 , 로 이어지는 문자열로 변환
		}
		
		$.ajax({
			url:"<%= ctxPath%>/mail/sendMailBoxAjax.on"+param,
			type:"get",
			dataType:"json",
	        success:function(json){
	        	if(json.html != "" && json.html != null){
	        		/* console.log("html : " + json.html); */
	        		$("div#mailTable").html(json.html);
	        		
	        		$("div#papagebar").html(json.papagebar);
	        		
	        		
	        		if(checkbox != null){
	        			const checkbox_arr = checkbox.split(',');
		        		console.log(checkbox_arr);
		        		checkbox_arr.forEach((el) => {
		        			$("input:checkbox[value='"+el+"']").prop("checked", true); // 체크유지
		        		});
	        		}
	        		
	        	}

	        	
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}


	function importantCheckSelect(){
	
		var mailCheck = document.querySelectorAll('input[name="mailCheck"]:checked');
		console.log(mailCheck);
		if(mailCheck.length > 0){
		result="";
		mailCheck.forEach((el) => {
			result += el.value;
			result += ',';
		});
		 result = result.slice(0, -1);
		 console.log(result);
		// 체크한 것들 번호 가져가서 , 로 이어지는 문자열로 변환
		 importantCheck(result);  
		}
		else{
			alert("체크박스를 선택해주세요.");
		}
	}
	
   	function importantCheck(mail_no){
		$.ajax({
			url:"<%= ctxPath%>/organization/orgImportantCheck.on",
			data:{"mail_no":mail_no},
			type:"post",
			dataType:"json",
	        success:function(json){
	        	if(json.n > 0){
	        		alert(json.n+ "개 중요 클릭");
	        	}
	        	listRefresh();
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
   	


   	


	

   	
   	
</script>

<div style="margin: 1% 0 5% 1%;">
	<h4>보낸 메일</h4>
</div>



<div style="width:100%">
	<div id="mail_box"style="width:50%; float:left;padding-right: 24px; border-right: 2px solid darkgray;">
		<div id="mailToolbar" class="tool_bar" style="width:100%">
			<div class="critical">
				
				<button id="mailLAllCheck_btn" type="button" class="btn btn-outline-dark toolbtn">
					<input type="checkbox" id="mailLAllCheck" value="off" style="vertical-align:middle;"/>&nbsp전체선택
			    
			    </button>
			    <button type="button" class="btn btn-outline-dark toolbtn" onclick="importantCheckSelect()">
					<i class="fas fa-flag toolflag"></i>
				</button>
			    
				<button type="button" class="btn btn-outline-dark toolbtn" onclick="replySelect()"><i class="fas fa-reply"></i> 답장</button>
		
		
			
		
				
				
				
		
			</div>
			
		</div>
		<div id ="mailTable" style="margin-top: 10px;">
			<table class="table">
		
			
			    
				   <thead>
				   		<th>
				   		</th>
				   		<th>부서</th>
				   		<th>직급</th>
				   		<th>이름</th>
				   		<th>이메일</th>
				   </thead>
					    <tr onclick = 'goMail(${mailVO.mail_no})'>
					  	  <td class="mail_list_option" onclick="event.stopPropagation()">
					      	<i id="flag${mailVO.mail_no}" class="fas fa-flag" style="color:darkgray;" onclick="importantCheck(${mailVO.mail_no})"></i>
					      </td>
					      <td class = "mail_list_sender" >
								부서 이름
					      </td>
					      <td class = "mail_list_subject">
					     		직급 이름
					      </td>
				   		  <td>
				   		  	이름
				   		  </td>
				   		  <td>
				   		  이메일
				   		  </td>
					    </tr>
			  	
			</table>
		</div>
		
		
		
		
		
		
		<div id = "papagebar">
		${pagebar}
		</div>
		
		
	
	    <form name="searchFrm" style="margin-top: 20px;">
	        <select name="searchType" id="searchType" style="height: 26px;">
	           <option value="subject">부문명</option>
	           <option value="FK_Recipient_address">팀명</option> 
	           <option value="FK_Recipient_address">직원명</option>
	        </select>
	        <input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off"/>
	        <input type="text" style="display: none;" /> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
	        
	        <button type="button" style="float:right" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
	    </form>
	    
	
	    <div id="displayList" style="border:solid 1px gray; border-top:0px; height:100px; margin-left:75px; margin-top:-1px; overflow:auto;">
		</div>
	</div>
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

	<div style="width:45%; float:right;">
		ffsafsaasf
	</div>
	
	
</div>


