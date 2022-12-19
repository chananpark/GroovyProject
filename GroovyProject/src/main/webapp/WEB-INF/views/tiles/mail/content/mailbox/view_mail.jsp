<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%> 
<style type="text/css">
.btn_submenu>a{
	color:black;
}
.btn_submenu{
    display: inline-block;
    position: relative;
    vertical-align: middle;

}


#mailToolbar{
    padding: 10px 0;
    border-bottom: solid 1px #ddd;
}
.table-bordered td, .table-bordered th {
    border: none;
}
th{
	text-align: center;
	background-color: #E3F2FD;
}

</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
	});// end of $(document).ready(function(){})-------------------

	function deleteSend(){
   		$.ajax({
			url:"<%= ctxPath%>/mail/deleteCheck.on",
			data:{"mail_no":'${requestScope.mailVO.mail_no}'},
			type:"post",
			dataType:"json",
	        success:function(json){
	        	if(json.n = 1){
	        		swal("삭제 완료", "메일이 삭제되었습니다", "success")
		 	    	.then((value) => {
		    	    	location.href = "<%=ctxPath%>/mail/sendMailBox.on";
		    		});
	        	}
	        	listRefresh();
	        },
	        error: function(request, status, error){
				swal("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
   	}
	function deleteReceieve(){
		$.ajax({
			url:"<%= ctxPath%>/mail/deleteCheck.on",
			data:{"mail_recipient_no":'${requestScope.mailRecipientNo}'},
			type:"post",
			dataType:"json",
	        success:function(json){
	        	if(json.n = 1){
	        		swal("삭제 완료", "메일이 삭제되었습니다.", "success")
		 	    	.then((value) => {
		    	    	location.href = "<%=ctxPath%>/mail/receieveMailBox.on";
		    		});
	        	}
	        	listRefresh();
	        },
	        error: function(request, status, error){
				swal("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
</script>

<h2>메일보기</h2>


<div id="mailToolbar" class="tool_bar">
	<div class="critical">

		
		<button type="button" class="btn btn-outline-dark" onclick="location.href='<%= request.getContextPath()%>/mail/writeMail.on?mailNo=${requestScope.mailVO.mail_no}&type=reply'"><i class="fas fa-reply" ></i> 답장</button>
		
		<button type="button" class="btn btn-outline-dark"
		
		<c:if test="${requestScope.mailVO.fK_sender_address eq sessionScope.loginuser.cpemail}">
			onclick="deleteSend()"
		</c:if>
		<c:if test="${requestScope.mailVO.fK_sender_address ne sessionScope.loginuser.cpemail}">
			onclick="deleteReceieve()"
		</c:if>

		><i class="fas fa-trash-alt"></i> 삭제</button>
		<button type="button" class="btn btn-outline-dark"><i class="fas fa-long-arrow-alt-right"></i> 전달</button>
		<div class="dropdown btn_submenu">
		  <span class="btn btn-outline-dark dropdown-toggle" data-toggle="dropdown">
		  <!-- 아이콘 클릭시 아래것들 나올예정 -->
		  <i class="fas fa-tag"></i>&nbsp태그
		  </span>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="#"><i class="fas fa-tag" style="color:orangered"></i> &nbsp태그이름1</a>
		    <a class="dropdown-item" href="#"><i class="fas fa-tag" style="color:cornflowerblue"></i> &nbsp태그이름2</a>
		    <a class="dropdown-item" href="#"><i class="fas fa-tag" style="color:forestgreen"></i> &nbsp태그이름3</a>
		    
		  </div>
	
		</div>
		
		

		
		

	</div>
	
</div>

<div>

   	   <table id="mail" style="width: 95%;margin-top: 10px;" class="table table-bordered">
   	  		<tr>
				<th style="width: 15%;">받는사람:</th>
				<td>
					<span>${requestScope.mailVO.fK_recipient_address}</span>
				</td>
			</tr>
			<tr>
				<th style="width: 15%;">보낸사람:</th>
				<td>
					<span>${requestScope.mailVO.fK_sender_address}</span>
				</td>
			</tr>
			<tr>
				<th style="width: 15%;">보낸날짜</th>
				<td>
					<fmt:formatDate value="${mailVO.send_time_date}" pattern="yyyy-MM-dd HH:mm:ss" var="sendTime"/>
					<span>${sendTime}</span>
				</td>
			</tr>
			
			<c:if test="${not empty mailVO.filename}">
				<tr>
					<th style="width: 15%;">파일첨부</th>
					<td>
							<c:forEach var="orgFileName" items="${mailVO.orgfilename_array}" varStatus="status">
								<div><a href="<%= request.getContextPath()%>/mail/download.on?mailNo=${requestScope.mailVO.mail_no}&index=${status.index}">${orgFileName}&nbsp&nbsp${mailVO.filesize_array[status.index]} </a></div>
							</c:forEach>
					</td>		
				</tr>
			</c:if>
		
			
			<tr>
				<th style="width: 15%;">제목</th>
				<td>
					<c:if test="${mailVO.sender_important == 0 }">
			      		<i class="fas fa-flag" style="color:darkgray;"></i>
			      	</c:if>
			      	<c:if test="${mailVO.sender_important == 1 }">
			      		<i class="fas fa-flag"></i>
			      	</c:if>
				         ${mailVO.subject}
				         
				    <c:forEach var="tag" items="${requestScope.tagList}" varStatus="status">
								<a href="#"><i class="fas fa-tag" style="color:#${tag.tag_color}"></i></a>
					</c:forEach>     

				</td>
			</tr>
			
			<tr>
				<th style="width: 15%;">내용</th>
				<td>
					${mailVO.contents}
				</td>
			</tr>
			
			
		</table>	
		

  
</div>   	   
