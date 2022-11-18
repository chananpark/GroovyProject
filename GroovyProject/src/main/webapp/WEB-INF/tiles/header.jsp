<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	.header_width {
		width: 80px;
		border-radius: 5px;
		margin-left: 3px;
	}

	.header_hover:hover {
		cursor:pointer;
		background-color: #E3F2FD;
	}
	
	/* 프로필 드롭다운 */
	.dropdown {
	  position: relative;
	  display: inline-block;
	}
	
	.dropdown-content {
	  display: none;
	  position: absolute;
	  background-color: #f9f9f9;
	  min-width: 100px;
	  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	  z-index: 1;
	  border-radius: 10px; 
	}
	
	.dropdown-content a {
	  color: black;
	  padding: 12px 16px;
	  text-decoration: none;
	  display: block;
	}
	
	.dropdown-content a:hover {background-color: #ddd;}

	.dropdown:hover .dropdown-content {display: block;}
	
	.activeHeaderMenu {
		color: #086BDE !important;
		background-color: #E3F2FD;
	}
</style>

<script>
$(()=>{
	
	const pathName = window.location.pathname;
	const ctxPath = '<%=ctxPath%>';
	let menuName = pathName.substring(ctxPath.length+1);
	const index = menuName.indexOf("/");
	menuName = menuName.substring(0,index);
	
	$('div#'+menuName).addClass('activeHeaderMenu');
	
});
</script>

<nav class="navbar navbar-expand-sm">

  <ul class="navbar-nav headerNavbar">
  	<li class="nav-item mt-1 ">
         <div style="padding: 0; margin-right: 100px; cursor:pointer;" class="nav-link" onClick='location.href="<%=ctxPath%>/index.on"'>
            <img src='<%=ctxPath%>/resources/images/logo/groovy_loco_edit.png' width="150"/>
       </div>
    </li>
    
    <li class="nav-item"  >
       <div class="nav-link text-dark header_hover header_width" onClick='location.href="<%=ctxPath%>/index.on"'>
          <div class="text-center"><i class="fas fa-home fa-lg"></i></div>
          <div style="text-align: center;">홈</div>
       </div>
    </li>
    <li class="nav-item" >
      	<div id='mail' class="nav-link text-dark  header_hover header_width" onClick='location.href="<%=ctxPath%>/mail/receiveMailBox.on"'>
    		<div class="text-center"><i class="fas fa-envelope fa-lg"></i></div>
    		<div style="text-align: center;">메일</div>
   		</div>
    </li>
    <li class="nav-item">
    	<div id='' class="nav-link text-dark  header_hover header_width" onClick='location.href="#"'>
    		<div class="text-center"><i class="fas fa-sitemap fa-lg"></i></div>
    		<div style="text-align: center;">조직도</div>
   		</div>
    </li>
    <li class="nav-item">
      	<div id='attend' class="nav-link text-dark  header_hover header_width" onClick='location.href="<%=ctxPath%>/attend/myAttend.on"'>
    		<div class="text-center"><i class="fas fa-business-time fa-lg"></i></div>
    		<div style="text-align: center;">근태관리</div>
   		</div>
    </li>
    <li class="nav-item">
      	<div id='approval' class="nav-link text-dark  header_hover header_width" onClick='location.href="<%=ctxPath%>/approval/home.on"'>
    		<div class="text-center"><i class="fas fa-stamp fa-lg"></i></div>
    		<div style="text-align: center;">전자결재</div>
   		</div>
    </li>
    <li class="nav-item">
      	<div id='manage' class="nav-link text-dark  header_hover header_width" onClick='location.href="<%=ctxPath%>/manage/info/viewInfo.on"'>
    		<div class="text-center"><i class="fas fa-id-card-alt fa-lg"></i></div>
    		<div style="text-align: center;">사원관리</div>
   		</div>
    </li>
    <li class="nav-item">
      	<div id='schedule' class="nav-link text-dark  header_hover header_width" onClick='location.href="<%=ctxPath%>/schedule/schedule.on"'>
    		<div class="text-center"><i class="far fa-calendar-alt fa-lg"></i></div>
    		<div style="text-align: center;">일정관리</div>
   		</div>
    </li>
    <li class="nav-item">
      	<div id='' class="nav-link text-dark  header_hover header_width" onClick='location.href="#"'>
    		<div class="text-center"><i class="fas fa-bookmark fa-lg"></i></div>
    		<div style="text-align: center;">자원예약</div>
   		</div>
    </li>
    <li class="nav-item">
      	<div id='' class="nav-link text-dark  header_hover header_width" onClick='location.href="#"'>
    		<div class="text-center"><i class="fas fa-bullhorn fa-lg"></i></div>
    		<div style="text-align: center;">공지사항</div>
   		</div>
    </li>
    <li class="nav-item">
      	<div id='' class="nav-link text-dark  header_hover header_width" onClick='location.href="#"'>
    		<div class="text-center"><i class="fas fa-chalkboard-teacher fa-lg"></i></div>
    		<div style="text-align: center;">커뮤니티</div>
   		</div>
    </li>
    <li class="nav-item">
      	<div id='' class="nav-link text-dark  header_hover header_width" onClick='location.href="#"'>
    		<div class="text-center"><i class="fas fa-chart-pie fa-lg"></i></div>
    		<div style="text-align: center;">설문조사</div>
   		</div>
    </li>
    <li class="nav-item">
      	<div id='' class="nav-link text-dark  header_hover header_width" onClick='location.href="#"'>
    		<div class="text-center"><i class="fas fa-comments fa-lg"></i></div>
    		<div style="text-align: center;">채팅</div>
   		</div>
    </li>
    
    <%-- 프로필 이미지 --%>
    <li class="nav-item" style="margin-left: 13%;">
      	<div class="nav-link dropdown" onClick='location.href="#"'>
    		<div class="dropbtn">
    			<img style="border-radius: 50%; height:50px; width: 50px;" src="<%=ctxPath %>/resources/images/test/cat_ex.PNG" />
   			</div>
   			<div class="dropdown-content">
			    <a href="#">프로필</a>
			    <a href="<%= ctxPath%>/login.on">로그아웃</a>
			</div>
   		</div>
    </li>
    
  
  </ul>
  
</nav>
