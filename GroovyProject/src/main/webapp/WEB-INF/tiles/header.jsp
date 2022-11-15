<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<style>

</style>

<nav class="navbar navbar-expand-sm">

  <ul class="navbar-nav headerNavbar">
  	<li class="nav-item">
      <a style="padding: 0" class="nav-link" href="#"><img src='<%=ctxPath%>/resources/images/logo/groovy_loco.png' width="100"/></a>
    </li>
    <li class="nav-item">
    	<div class="nav-link text-dark" onClick='location.href="#"'>
    		<div><i class="fas fa-home"></i></div>
    		<div style="text-align: center;">홈</div>
    	</div>
      <!-- <a class="nav-link text-dark" href="#"><i class="fas fa-home"></i>홈</a> -->
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-envelope"></i>메일</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-sitemap"></i>조직도</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-business-time"></i>근태관리</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-stamp"></i>전자결재</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-id-card-alt"></i>사원관리</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="far fa-calendar-alt"></i>일정관리</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-bookmark"></i>자원예약</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-bullhorn"></i>공지사항</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-chalkboard-teacher"></i>자유게시판</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-chart-pie"></i>설문조사</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#"><i class="fas fa-comments"></i>채팅</a>
    </li>
  </ul>

</nav>