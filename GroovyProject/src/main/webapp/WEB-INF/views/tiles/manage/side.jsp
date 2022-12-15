<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">


<style>
	.menu {
		margin: 2% 0;
	}

	li:hover, divv#manage_menu:hover {
		cursor: pointer;
	}
	
	div#manage_menu {
		background-color: #086BDE;
		color: white;
	}
	
	#insertBtn:hover{
		border: 1px solid #086BDE;
		color: white;
		background-color: #086BDE;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){ 
		
	   // 사이드 메뉴 닫기
	   $(".subMenus").hide(); 
	   $(".admenu1").hide(); 
	   $(".admenu2").hide(); 
	   
	   // 메뉴 선택시 다른 메뉴 닫기      
	    $(".topMenu").click(function(e) {
	        const target = $(e.target.children[0]);
	        if ($(target).is(":visible")) {
	           $(".subMenus").slideUp("fast");             
	        }
	        else {
	           $(".subMenus").slideUp("fast");
	           $(target).slideToggle("fast");
	        }
	    }); // end of  $(".topMenu").click(function(e) {-------------------
	    	
	    //	console.log("${loginuser.empno}");
	    //	console.log("${loginuser}");
	    
	    
	    $("div#manage_menu").click(function(e){
	    
	    	 const target = $(".admenu1");
		        if ($(target).is(":visible")) {
		           $(".admenu1").slideUp("fast");             
		        }
		        else {
		           $(".admenu1").slideUp("fast");
		           $(target).slideToggle("fast");
		        }
	    	
	    
	    }); // end of  $("ul#manage_menu").click(function(){ --------------
	    
	    });// end of $(document).ready(function(){  -------------------
	    	
	    	
	    	
	    	
</script>




<!-- A vertical navbar -->
<nav class="navbar bg-light">

  <!-- 공용 Links -->
    <!-- 공용 Links -->
  <ul class="navbar-nav" style='width:100%;'>
    <li class="nav-item">
      <h4 class='mb-4'>사원관리</h4>
    </li>
    
      <!-- 관리자 Links -->
     <c:if test="${sessionScope.loginuser != null && loginuser.department ==  '인사총무팀'}">
     <li class="nav-item mb-4">
      	<button id="insertBtn" type="button" style='width:100%;' class="btn btn-outline-dark" onclick="<%=ctxPath%>/manage/admin/registerInfo.on">사원등록</button>
    	</li>
     </c:if> 
     
    
    <li class="menu topMenu nav-item">
      <a class="nav-link" href="<%= ctxPath%>/manage/info/viewInfo.on">사원정보</a>
    </li>
    
    <li class="menu topMenu nav-item" >경조비관리
      <ul class="menu subMenus eachmenu1">
      	<li><a class="nav-link" href="<%= ctxPath%>/manage/celebrate/celebrateList.on">경조비신청목록</a></li>  
      	<li id="celebmenu1" ><a class="nav-link" href="<%= ctxPath%>/manage/celebrate/receiptCelebrate.on">경조비신청</a></li>	 
      </ul> 
    </li>
    
    <li class="menu topMenu nav-item">재직증명서
	  <ul class="menu subMenus eachmenu6">
	      <li id="celebmenu1" > <a class="nav-link" href="<%= ctxPath%>/manage/proof/proofList.on">증명서신청목록</a> </li>	 
	      <li><a class="nav-link" href="<%= ctxPath%>/manage/proof/proofEmployment.on">증명서신청</a></li>  
      </ul> 
     
    </li>
    
     <li class="menu topMenu nav-item">급여관리
      <ul class="menu subMenus eachmenu2">
      	<li><a class="nav-link" href="<%= ctxPath%>/manage/pay/paySearch.on">급여조회</a></li>		
        <li><a class="nav-link" href="<%= ctxPath%>/manage/pay/overtimepaySearch.on">기본외수당조회</a></li>	
      </ul> 
    </li>
    
    <!-- 관리자 Links -->
    <c:if test="${sessionScope.loginuser != null && loginuser.department ==  '인사총무팀'}"> 
	    <div id="manage_menu">인사관리</div>
	    <ul>
		    <li class="menu topMenu admenu1 nav-item subadmenu">▶사원정보
		      <ul class="menu subMenus admenu2 eachmenu3">
		      	<li><a class="nav-link" href="<%= ctxPath%>/manage/admin/searchInfoAdmin.on">사원조회</a></li>		
		        <li><a class="nav-link" href="<%= ctxPath%>/manage/admin/registerInfo.on">사원등록</a></li> 
		      </ul> 
		    </li>
		    
		    <li class="menu topMenu admenu1 nav-item subadmenu">▶경조비관리
		      <ul class="menu subMenus admenu2 eachmenu4">
		        <li><a class="nav-link" href="<%= ctxPath%>/manage/admin/receiptCelebrateStatus.on">경조비신청현황</a></li>  
		        <li><a class="nav-link" href="<%= ctxPath%>/manage/admin/receiptcelebrateList.on">경조비지급목록</a></li>  
		      </ul> 
		    </li>
		    
		    <li class="menu topMenu admenu1 nav-item subadmenu ">
		      <a class="nav-link" href="<%= ctxPath%>/manage/proof/proofEmploymentSearch.on">▶ 재직증명서</a> 
		    </li>
		    
		     <li class="menu topMenu admenu1 nav-item subadmenu">▶급여관리
		       <ul class="menu subMenus admenu2 eachmenu5">
		      	<li><a class="nav-link" href="<%= ctxPath%>/manage/pay/paySearchAdmin.on">급여조회</a></li>		
		      	<li><a class="nav-link" href="<%= ctxPath%>/manage/pay/overtimepaySearchAdmin.on">기본외수당조회</a></li>	
		      	<li><a class="nav-link" href="<%= ctxPath%>/manage/pay/payChart.on">연봉급여차트</a></li>	
		      </ul> 
		    </li>
		    </ul>
    	</c:if>
     </ul> 

</nav>
