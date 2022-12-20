<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


<%
	String ctxPath = request.getContextPath();
%> 


<style type="text/css">

.card:hover{
	top: -15px;
}

</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script type="text/javascript">

	$(document).ready(function(){
		
	});// end of $(document).ready(function(){})-------------------
	
	function showChatroom(roomNo) {
		var _width = '400';
	    var _height = '600';
		var _left = Math.ceil(( window.screen.width - _width )/2);
	    var _top = Math.ceil(( window.screen.height - _height )/2); 
		 
		window.open('<%=ctxPath%>/chat/chatroom.on?no='+roomNo, '채팅방', 'width='+ _width +', height='+ _height +', left=' + _left + ', top='+ _top );

	}
	

</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>채팅</h4>
</div>


<div class="row row-cols-1 row-cols-md-3 g-4">
	  <c:forEach var="chatroom" items="${chatroomList}">
		<div class="col mb-3">
	    <div class="card" style="height: 250px; background-color: lavender;" onclick = "showChatroom('${chatroom.chatroom_no}')">
	      <div style= "padding: 5px 10px;"> <i class="fas fa-users"></i> ${chatroom.cnt}
	      <i onclick="change('${chatroom.chatroom_no}')" data-toggle="modal" data-target="#modal_addChatroom" style="float:right" class="fas fa-wrench"></i></div>
	      <div class="card-body text-center" style="line-height:150px">
	      
	        	${chatroom.chatroom_name}
	      </div>
	      <i class="fas fa-door-open"style="float:right; padding:5px" onclick="exit('${chatroom.chatroom_no}')"></i>

	    </div>
	  </div>
	</c:forEach>
</div>
