<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<style>
	.menu {
		margin: 2% 0;
	}

	li:hover {
		cursor: pointer;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){ 
		
	   // 사이드 메뉴 닫기
	   $(".subMenus").hide(); 
	   
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
	    	
	    	
	    	
	}); // end of $(".topMenu").click(function(e) { ---------------------

</script>




<!-- A vertical navbar -->
<nav class="navbar bg-light">

  <!-- 공용 Links -->
  <ul class="menus navbar-nav text-left " style='width:100%'>
    <li class="nav-item">
      <h1 >사원관리</h1>
    </li>
    
    
    <li class="menu topMenu nav-item">
      <a class="nav-link" href="<%= ctxPath%>/manage/info/viewInfo.on">사원정보</a>
    </li>
    
    <li class="menu topMenu nav-item" >경조비관리
      <ul class="menu subMenus eachmenu1">
      	<li id="celebmenu1" ><a class="nav-link" href="<%= ctxPath%>/manage/celebrate/receiptCelebrate.on">경조비신청</a></li>	 
        <li><a class="nav-link" href="<%= ctxPath%>/manage/celebrate/searchReceiptCelebrate.on">경조비신청조회</a></li>  
      </ul> 
    </li>
    
    <li class="menu topMenu nav-item">
      <a class="nav-link" href="<%= ctxPath%>/manage/proof/proofEmployment.on">재직증명서</a> 
    </li>
    
     <li class="menu topMenu nav-item">급여관리
      <ul class="menu subMenus eachmenu2">
      	<li><a class="nav-link" href="<%= ctxPath%>/manage/pay/paySearch.on">급여조회</a></li>		
        <li><a class="nav-link" href="<%= ctxPath%>/manage/pay/overtimepaySearch.on">기본외수당조회</a></li>	
      </ul> 
    </li>
    
    
    <!-- 관리자 Links -->
    <li class="menu topMenu nav-item">사원정보
      <ul class="menu subMenus eachmenu3">
      	<li><a class="nav-link" href="<%= ctxPath%>/manage/admin/searchInfoAdmin.on">사원조회</a></li>		
        <li><a class="nav-link" href="<%= ctxPath%>/manage/admin/registerInfo.on">사원등록</a></li> 
      </ul> 
    </li>
    
    <li class="menu topMenu nav-item">경조비관리
      <ul class="menu subMenus eachmenu4">
        <li><a class="nav-link" href="<%= ctxPath%>/manage/admin/receiptCelebrateStatus.on">경조비신청현황</a></li>  
        <li><a class="nav-link" href="<%= ctxPath%>/manage/admin/receiptcelebrateList.on">경조비지급목록</a></li>  
      </ul> 
    </li>
    
    <li class="menu topMenu nav-item">
      <a class="nav-link" href="<%= ctxPath%>/manage/proof/proofEmploymentSearch.on">재직증명서</a> 
    </li>
    
     <li class="menu topMenu nav-item">급여관리
       <ul class="menu subMenus eachmenu5">
      	<li><a class="nav-link" href="<%= ctxPath%>/manage/pay/paySearchAdmin.on">급여조회</a></li>		
      	<li><a class="nav-link" href="<%= ctxPath%>/manage/pay/overtimepaySearchAdmin.on">기본외수당조회</a></li>	
      	<li><a class="nav-link" href="<%= ctxPath%>/manage/pay/payChart.on">연봉급여차트</a></li>	
      </ul> 
    </li>
    
  </ul>

</nav>
