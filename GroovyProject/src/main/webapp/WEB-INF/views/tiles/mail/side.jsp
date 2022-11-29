<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<style>
#writeBtn:hover{
	border: 1px solid #086BDE;
	color: white;
	background-color: #086BDE;
}
</style>
<%-- <link rel="stylesheet" href="/resources/colorPicker/src/colorPick.dark.theme.css"/>

<script src="${ctxPath}/resources/colorPicker/src/colorPick.js"></script> --%>
<script type="text/javascript">
	$(document).ready(function(){
	
	});// ------------------- end of $(document).ready(function(){})

</script>

<!-- A vertical navbar -->
<nav class="navbar bg-light">

  <!-- Links -->
  <ul class="navbar-nav" style="width: 100%">
    <li class="nav-item">
      <h4 class='mb-4'>메일</h4>
    </li>
    <li class="nav-item mb-4">
      <button id="writeBtn" type="button" style='width:100%' class="btn btn-outline-dark" onClick='location.href="<%=ctxPath%>/mail/writeMail.on"'> 메일 쓰기</button>
    </li>

    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/mail/receiveMailBox.on">받은 메일함</a>
    </li>
    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/mail/sendMailBox.on">보낸 메일함</a>
    </li>
    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/mail/importantMailBox.on">중요 메일함</a>
    </li>
    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/approval/requested.on">임시 메일함</a>
    </li>

    <li class="nav-item">
      <a class="nav-link" href="#">태그 메일함</a>
      	<ul id="sidebarTag">
      		<li><a id="tag" class="nav-link" href="<%=ctxPath%>/mail/viewMail.on">(임시) 메일 보기</a></li>
	      	
      	</ul>
    </li>
    <!-- 
    <li><div id ="tagAdd" class="nav-link" onclick="">태그 추가</div></li>
    <li><div class="colorPickSelector"  ></div></li>
     -->

  </ul>
  

</nav>