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
  <ul class="navbar-nav">
    <li class="nav-item">
      <h4 class='mb-4'>전자결재</h4>
    </li>
    <li class="nav-item mb-4">
      <button id="writeBtn" type="button" style='width:100%' class="btn btn-outline-dark">기안문서 작성</button>
    </li>
    <li class="nav-item">
      <a id="home" class="nav-link" href="<%=ctxPath%>/approval.on">홈</a>
    </li>
    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/approval/requested.on">결재하기</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">개인 문서함</a>
      	<ul>
      		<li><a id="sentList" class="nav-link" href="<%=ctxPath%>/approval/personal/sent.on">상신함</a></li>
      		<li><a id="processedList" class="nav-link" href="<%=ctxPath%>/approval/personal/processed.on">결재함</a></li>
      		<li><a id="savedList" class="nav-link" href="<%=ctxPath%>/approval/personal/saved.on">임시저장함</a></li>
      	</ul>
    </li>
    <li class="nav-item">
      <a id="teamList" class="nav-link" href="<%=ctxPath%>/approval/team.on">팀 문서함</a>
    </li>
    <li class="nav-item">
      <a id="config" class="nav-link" href="<%=ctxPath%>/approval/config.on">환경설정</a>
    </li>
  </ul>

</nav>