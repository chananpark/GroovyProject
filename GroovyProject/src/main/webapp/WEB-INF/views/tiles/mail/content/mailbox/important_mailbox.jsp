<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
		
		// 사이드바에 태그 추가해주기
		var sidebarTag = ``;
		<c:forEach var="tagVO" items="${requestScope.tagList}" varStatus="status">   		
			
			sidebarTag += `<li><a id="tag" class="nav-link" href="<%=ctxPath%>/approval/personal/sent.on"><i class="fas fa-tag" style="color:#${tagVO.tag_color};"></i>${tagVO.tag_name}</a></li>`;
			

		</c:forEach>
		$("#sidebarTag").html(sidebarTag);
		
	});
	
	function goSearch() {
		const frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/mail/receiveMailBox.on";
		frm.submit();
	}// end of function goSearch()--------------------
</script>

<div style="margin: 1% 0 5% 1%">
	<h4>중요 메일</h4>
</div>
<div id="mailToolbar" class="tool_bar">
	<div class="critical">
		
		<button id="mailLAllCheck_btn" type="button" class="btn btn-outline-dark toolbtn">
			<input type="checkbox" id="mailLAllCheck" value="off" style="vertical-align:middle;">&nbsp전체선택
	    
	    </button>
	    <button type="button" class="btn btn-outline-dark toolbtn">
			<i class="fas fa-flag toolflag"></i>
		</button>
	    
		<button type="button" class="btn btn-outline-dark toolbtn"><i class="fas fa-reply"></i> 답장</button>
		<div class="dropdown btn_submenu">
		  <span class="btn btn-outline-dark dropdown-toggle btn-sm toolbtn" data-toggle="dropdown">
		  <!-- 아이콘 클릭시 아래것들 나올예정 -->
		  </span>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="#">답장</a>
		    <a class="dropdown-item" href="#">전체답장</a>
		  </div>

		</div>
		<button type="button" class="btn btn-outline-dark toolbtn"><i class="fas fa-trash-alt"></i> 삭제</button>
		<button type="button" class="btn btn-outline-dark toolbtn"><i class="fas fa-long-arrow-alt-right"></i> 전달</button>
		<div class="dropdown btn_submenu">
		  <span class="btn btn-outline-dark dropdown-toggle toolbtn" data-toggle="dropdown">
		  <!-- 아이콘 클릭시 아래것들 나올예정 -->
		  <i class="fas fa-tag"></i>&nbsp태그
		  </span>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp태그이름1</a>
		    <a class="dropdown-item" href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp태그이름2</a>
		    <a class="dropdown-item" href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp태그이름3</a>
		    
		  </div>
	
		</div>
		<button type="button" class="btn btn-outline-dark toolbtn"><i class="far fa-envelope-open"></i> 읽음</button>

		

		
		

	</div>
	
</div>



<div id="mail_box">
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
				    	 	
				    	 	<td colspan="4" style="background-color:#F9F9F9; font-size: small;padding: 0.3rem 0.75rem;">${sendTimeDDT}<td>
			    	 	</tr>
			    	</c:if>
			    </c:if> 
			    <tr>
			  	  <td class="mail_list_option">
			      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
			      	<i class="fas fa-flag"></i>
			      	<!-- 색조정 or 다른 아이콘 -->
			      	<i class="far fa-envelope"></i>
			      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
			      </td>
			      <td class = "mail_list_sender" >${mailVO.fK_sender_address}</td>
			
			      <td class = "mail_list_subject">
			      	<c:forEach var="tagVO" items="${requestScope.tagList}" varStatus="status">   		
	
			      		<c:forEach var="tag_mail_no" items="${tagVO.mail_no_list}" varStatus="status">
			      			<c:if test="${mailVO.mail_no == tag_mail_no}">
			      				<a href="#"><i class="fas fa-tag" style="color:#${tagVO.tag_color};"></i> &nbsp</a>
			      			</c:if>
			      	
			      		</c:forEach>
			      	</c:forEach>
			      	<c:if test="${sessionScope.loginuser.cpemail eq mailVO.fK_sender_address}">
			      	<!-- 내가 보낸 메일 중에서  -->
			      		<c:if test="${sessionScope.loginuser.cpemail eq fK_recipient_address_individual}">
			      			<!-- 받는 사람이 나인 경우 -->
			      			[내게쓴메일]
			      		</c:if>
			      		<c:if test="${sessionScope.loginuser.cpemail ne fK_recipient_address_individual}">
			      			<!-- 받는 사람이 내가 아닌 경우 경우 -->
			      			[보낸메일함]
			      		</c:if>
			      	</c:if>
			      	<!-- 받은 메일은 전부 받은메일 처리 -->
			      	<c:if test="${sessionScope.loginuser.cpemail ne mailVO.fK_sender_address}"><!-- 내가 보내지 않은 메일들 -->
			      		<c:if test="${sessionScope.loginuser.cpemail eq mailVO.fK_recipient_address_individual}">[받은메일함]</c:if>
			      	</c:if>
			   		
			   
				  ${mailVO.subject}  [임시노출 번호${mailVO.mail_no}] [임시노출 수신번호${mailVO.mail_recipient_no}]     
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
	${pagebar}
	

    <form name="searchFrm" style="margin-top: 20px;">
        <select name="searchType" id="searchType" style="height: 26px;">
           <option value="subject">메일제목</option>
           <option value="FK_Sender_address">보낸사람</option> <!-- 여기만 바꿔가면서 재활용 -->
        </select>
        <input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" />
        <input type="text" style="display: none;" /> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
        
        <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
    </form>
    

    <div id="displayList" style="border:solid 1px gray; border-top:0px; height:100px; margin-left:75px; margin-top:-1px; overflow:auto;">
	</div>
</div>


