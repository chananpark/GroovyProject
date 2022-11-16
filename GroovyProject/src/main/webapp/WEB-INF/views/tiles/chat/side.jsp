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

<!-- A vertical navbar -->
<nav class="navbar bg-light">

  <!-- Links -->
  <ul class="navbar-nav" style="width: 100%">
    <li class="nav-item">
      <h4 class='mb-4'>채팅</h4>
    </li>
    <li class="nav-item mb-4">
      <button id="writeBtn" type="button" style='width:100%' class="btn btn-outline-dark" onClick='location.href="<%=ctxPath%>/mail/writeMail.on"'> 채팅방 <br>개설하기 </button>
    </li>

    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/mail/receiveMailBox.on">받은 메일함</a>
    </li>
    
  </ul>

</nav>