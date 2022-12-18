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
td.mail_list_option{
	width:80px;

}
td.mail_list_sender{
	width:150px;
}
td.mail_list_time {
    width: 300px;
    text-align: end;
}
#mail_box{
	margin-top:10px;
}
tr:hover{
	background-color: #E3F2FD;
	cursor: pointer;
}
i.fa-flag{
	color:#086BDE ;
	margin-left:1px;
}


.toolbtn{
	border-color: #ddd;
}
.toolbtn:hover {
    color: #fff !important;
    background-color: #086BDE ;
    border-color: #086BDE ;
}
.toolbtn:active {
    color: #fff;
    background-color: #086BDE !important;
    border-color: #086BDE !important;
}
.toolbtn:focus {
    box-shadow: none !important;
}
.textCut {
    text-overflow: ellipsis;
    white-space: nowrap;
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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
	toastr.options = { // toastr 옵션
		  "closeButton": false,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": true,
		  "positionClass": "toast-top-center",
		  "preventDuplicates": false,
		  "onclick": null,
		  "showDuration": "300",
		  "hideDuration": "1000",
		  "timeOut": "2000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		}
	$(document).ready(function(){

		listRefresh();


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
	
	function goMail(mailno){
		// 패스워드 체크
		$.ajax({
			url:"<%= ctxPath%>/mail/getPwd.on",
			type:"post",
			data:{"mail_no":mailno},
	        success:function(pwd){
	        	if(pwd != "" && pwd != null){
	        		swal("비밀 메일입니다. 암호를 입력해주세요.", {
	  				  content: "input",
	  				})
	  				.then((value) => {
	  				  if(value == pwd){
	  					  location.href="<%=ctxPath%>/mail/viewMail.on?mailNo="+ mailno ;
	  				  }
	  				  else{
	  					  swal("잘못된 암호입니다. 다시 확인해주세요.");
	  				  }
	  				});
	        	}
	        	else{
	    			 location.href="<%=ctxPath%>/mail/viewMail.on?mailNo="+ mailno ; 
	    		}

	        	
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	

	
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
	        		
	        		$("#tagOption").html(json.taghtml);
	        		
	        		
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
	
		
		var mailCheck = $('input[name="mailCheck"]:checked');
		console.log(mailCheck);
		if(mailCheck.length > 0){
		result="";
		mailCheck.each(function(index, item){
			result += $(item).attr("value");
			console.log($(item).attr("value"));
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
   		console.log("mail_no"+mail_no);
		$.ajax({
			url:"<%= ctxPath%>/mail/importantCheck.on",
			data:{"mail_no":mail_no},
			type:"post",
			dataType:"json",
	        success:function(json){

	        	listRefresh();
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
   	
   	function deleteCheckSelect(){
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
		 deleteCheck(result);  
		}
		else{
			alert("체크박스를 선택해주세요.");
		}
   	}
   	
   	function deleteCheck(mail_no){
   		$.ajax({
			url:"<%= ctxPath%>/mail/deleteCheck.on",
			data:{"mail_no":mail_no},
			type:"post",
			dataType:"json",
	        success:function(json){
	        	if(json.n > 0){
	        		alert(json.n+ "개 삭제");
	        	}
	        	listRefresh();
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
   	}
   	
   	function tagCheckSelect(tagColor, tagName){
   		
   		var mailCheck = $('input[name="mailCheck"]:checked');
		console.log(mailCheck);
		if(mailCheck.length > 0){
		result="";
		mailCheck.each(function(index, item){
			result += $(item).attr("value");
			console.log($(item).attr("value"));
			result += ',';
			
		});
		 result = result.slice(0, -1);
		 console.log(result);
		// 체크한 것들 번호 가져가서 , 로 이어지는 문자열로 변환
		 tagCheck(result,tagColor, tagName);  
		}
		else{
			alert("체크박스를 선택해주세요.")
		}
	}
   	
   	function tagCheck(mail_no, tagColor, tagName){
		$.ajax({
			url:"<%= ctxPath%>/mail/tagCheck.on",
			data:{"mail_no":mail_no,
				  "tagColor":tagColor,
				  "tagName":tagName},
			type:"post",
			dataType:"json",
	        success:function(json){
	        	if(json.n > 0){
	        		alert(json.n+ "개 태그가 설정되었습니다.");
	        	}
	        	listRefresh(); 
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
   	
	function replySelect(){
   		
		var mailCheck = $('input[name="mailCheck"]:checked');
		console.log(mailCheck);
		if(mailCheck.length == 1){
			result="";
			mailCheck.each(function(index, item){
				result += $(item).attr("value");			
			});
			console.log(result);
		 	location.href="<%=ctxPath%>/mail/writeMail.on?mailNo="+ result+ "&type=reply";
		}
		else{
			alert("체크박스를 하나만 선택해주세요.");
		}
	}
	
	
	function passSelect(){
   		
		var mailCheck = $('input[name="mailCheck"]:checked');
		console.log(mailCheck);
		if(mailCheck.length == 1){
			result="";
			mailCheck.each(function(index, item){
				result += $(item).attr("value");			
			});
			console.log(result);
		 	location.href="<%=ctxPath%>/mail/writeMail.on?mailNo="+ result+ "&type=pass";
		}
		else{
			alert("체크박스를 하나만 선택해주세요.");
		}
	}
	
	function goAddTag(){
		let tag_color = $("#tag_color").val().substring(1);
		
		let tag_name = $("#tag_name").val();
		console.log("tag_color"+tag_color);
		
		var mailCheck = $('input[name="mailCheck"]:checked');
		console.log(mailCheck);
		if(mailCheck.length > 0){
		fk_mail_no="";
		mailCheck.each(function(index, item){
			fk_mail_no += $(item).attr("value");
			console.log($(item).attr("value"));
			fk_mail_no += ',';
			
		});
		fk_mail_no = fk_mail_no.slice(0, -1);
		console.log("fk_mail_no"+fk_mail_no);
		// 체크한 것들 번호 가져가서 , 로 이어지는 문자열로 변환
		
		$.ajax({
			url:"<%= ctxPath%>/mail/tagAdd.on",
			data:{"tag_color":tag_color,
				  "tag_name":tag_name,
				  "fk_mail_no":fk_mail_no},
			type:"post",
			dataType:"json",
	        success:function(json){
	        	if(json.n > 0){
	        		Command: toastr["success"]("선택한 게시글에 새로운 태그가 적용되었습니다.")
	    
	        		$('#modal_addTag').modal('hide');
	
	        	}
	        	listRefresh(); 
	        	sideTag();
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});

		}
		else{
			toastr["warning"]("체크박스를 선택해주세요")
		}
		
		
	}
	
	function deleteTag(tag_color,tag_name){
		event.stopPropagation();
		
		swal({
			icon: 'warning',
			title: '태그 삭제',
			text : "정말 "+tag_name+" 태그를  모두 삭제하시겠습니까?",
			buttons: ["취소" , "삭제"]
		})
		.then(function(){
			console.log("tag_color"+tag_color);
			console.log("tag_name"+tag_name);
			$.ajax({
				url:"<%= ctxPath%>/mail/tagDelete.on",
				data:{"tag_color":tag_color,
					  "tag_name":tag_name},
				type:"post",
				dataType:"json",
		        success:function(json){
		        	if(json.n > 0){
		
		        		toastr["success"](tag_name+'태그 '+json.n+'개가 전부 삭제되었습니다.');
		     
		        	}
		        	listRefresh(); 
		        	sideTag();
		        },
		        error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
	        
	  
	        
		})
	}
	
	

		
		
		

	
	

   	
   	
</script>

<div style="margin: 1% 0 5% 1%;">
	<h4>보낸 메일</h4>
</div>
<div id="mailToolbar" class="tool_bar">
	<div class="critical">
		
		<button id="mailLAllCheck_btn" type="button" class="btn btn-outline-dark toolbtn">
			<input type="checkbox" id="mailLAllCheck" value="off" style="vertical-align:middle;"/>&nbsp전체선택
	    
	    </button>
	    <button type="button" class="btn btn-outline-dark toolbtn" onclick="importantCheckSelect()">
			<i class="fas fa-flag toolflag"></i>
		</button>
	    
		<button type="button" class="btn btn-outline-dark toolbtn" onclick="replySelect()"><i class="fas fa-reply"></i> 답장</button>

		<button type="button" class="btn btn-outline-dark toolbtn" onclick="deleteCheckSelect()"><i class="fas fa-trash-alt"></i> 삭제</button>
		<button type="button" class="btn btn-outline-dark toolbtn" onclick="passSelect()"><i class="fas fa-long-arrow-alt-right"></i> 전달</button>
		<div class="dropdown btn_submenu">
		  <span class="btn btn-outline-dark dropdown-toggle toolbtn" data-toggle="dropdown">
		  <!-- 아이콘 클릭시 아래것들 나올예정 -->
		  <i class="fas fa-tag"></i>&nbsp태그
		  </span>
		  <div id="tagOption" class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		  <%--  <c:forEach var="tagVO" items="${requestScope.tagListSide}" varStatus="status">   		
     	  		<a class="dropdown-item" href="#" onclick="tagCheckSelect('${tagVO.tag_color}','${tagVO.tag_name}')"><i class="fas fa-tag" style="color:#${tagVO.tag_color}" ></i> 
	     	  	&nbsp${tagVO.tag_name}
	     	    <i style="float:right" class="fas fa-minus-circle" onclick="deleteTag('${tagVO.tag_color}','${tagVO.tag_name}');"></i></a>		
      	 	</c:forEach>
   	 		<a class="dropdown-item" href="#" data-toggle="modal" data-target="#modal_addTag"><i class="fas fa-tag"></i>&nbsp태그 추가</a>
		     --%>

		    
		  </div>
	
		</div>

		
		
		

	</div>
	
</div>



<div id="mail_box">
	<div id ="mailTable">
	<%-- 
		<table class="table">
	
		
		    
			    <c:forEach var="mailVO" items="${requestScope.mailList}" varStatus="status">
			    	<fmt:formatDate value="${mailVO.send_time_date}" pattern="yyyy-MM-dd" var="sendTimeDD"/>
			        <fmt:formatDate value="${mailVO.send_time_date}" pattern="HH:mm:ss" var="sendTimeToday"/>
			        <fmt:formatDate value="${mailVO.send_time_date}" pattern="yyyy-MM-dd HH:mm:ss" var="sendTimeNotToday"/>
			        
			    	
			    	<c:if test="${status.index ne 0}">
				    	<fmt:formatDate value="${mailList[status.index-1].send_time_date}" pattern="yyyy-MM-dd" var="sendTimeBefore"/>
				    	
				    	<c:if test="${sendTimeBefore != sendTimeDD}">
				    	<fmt:formatDate value="${mailVO.send_time_date}" pattern="yyyy년 MM월dd일" var="sendTimeDDT"/>
					    	<tr>
					    	 	
					    	 	<td colspan="4" style="background-color:#F9F9F9; font-size: small;padding: 0.3rem 0.75rem;">${sendTimeDDT}</td>
				    	 	</tr>
				    	</c:if>
				    </c:if> 
				    <tr onclick = 'goMail(${mailVO.mail_no})'>
				  	  <td class="mail_list_option" onclick="event.stopPropagation()">
				      	<input type="checkbox" id="mailLCheck" name="mailCheck" value="${mailVO.mail_no}" style="vertical-align:middle">
				      	<c:if test="${mailVO.sender_important == 0 }">
				      	<i id="flag${mailVO.mail_no}" class="fas fa-flag" style="color:darkgray;" onclick="importantCheck(${mailVO.mail_no})"></i>
				      	</c:if>
				      	<c:if test="${mailVO.sender_important == 1 }">
				      	<i id="flag${mailVO.mail_no}" class="fas fa-flag" onclick="importantCheck(${mailVO.mail_no})"></i>
				      	</c:if>
	
				      </td>
				      <td class = "mail_list_sender" >
					      <c:choose>
						        <c:when test="${fn:length(mailVO.fK_recipient_address) gt 25}">
							        <c:out value="${fn:substring(mailVO.fK_recipient_address, 0, 23)}...">
							        </c:out>
						        </c:when>
						        <c:otherwise>
							        <c:out value="${mailVO.fK_recipient_address}">
							        </c:out>
						        </c:otherwise>
						  </c:choose>
				      </td>
				
				      <td class = "mail_list_subject">
				      	<c:forEach var="tagVO" items="${requestScope.tagList}" varStatus="status2">   		
			      			<c:if test="${mailVO.mail_no == tagVO.fk_mail_no}">
			      				<a href="#"><i class="fas fa-tag" style="color:#${tagVO.tag_color};"></i> &nbsp</a>
			      			</c:if>
			      			
				      	</c:forEach>
				   
					      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
				      	${mailVO.subject}[임시노출 번호${mailVO.mail_no}]
				      </td>
			   
				      	<c:if test="${sendTimeDD == today}">
				      		<td class = "mail_list_time">오늘 ${sendTimeToday}</td>
				      	</c:if>
				        <c:if test="${sendTimeDD != today}">
					      	<td class = "mail_list_time">${sendTimeNotToday}</td>
				      	</c:if>	
				      	
				    </tr>
			    </c:forEach>
		   
		   
		
		  	
		</table>
		 --%>
	</div>
	<div id = "papagebar">
	${pagebar}
	</div>
	
	

    <form name="searchFrm" style="margin-top: 20px;">
        <select name="searchType" id="searchType" style="height: 26px;">
           <option value="subject">메일제목</option>
           <option value="FK_Recipient_address">받은사람</option> <!-- 여기만 바꿔가면서 재활용 -->
        </select>
        <input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" />
        <input type="text" style="display: none;" /> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
        
        <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
    </form>
    

</div>







