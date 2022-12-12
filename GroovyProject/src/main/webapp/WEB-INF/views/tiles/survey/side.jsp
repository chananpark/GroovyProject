<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	/* .menu {
		margin: 2% 0;
	}
 */
	li:hover {
		cursor: pointer;
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
	 
	 });
	    
	    
	// >>> 설문작성 버튼을 누르면 <<<     
	function surveyWriting() {
		location.href="<%=ctxPath %>/survey/surveyWriting.on";
	  }

</script>




<!-- A vertical navbar -->
<nav class="navbar bg-light">

  <!-- 공용 Links -->
  <ul class="navbar-nav" style='width:100%;'>
   
	    <li class="nav-item">
	      <h4 class='mb-4'>설문조사</h4>
	    </li>
	    
	    <!-- 관리자 Links -->
     <c:if test="${sessionScope.loginuser != null && loginuser.department ==  '인사총무팀'}">
     <li class="nav-item mb-4">
      	<button id="insertBtn" type="button" style='width:100%;' class="btn btn-outline-dark" onclick="surveyWriting();">설문작성</button>
    	</li>
     </c:if> 
    <li class="menu topMenu nav-item">
      <a class="nav-link" href="<%= ctxPath%>/survey/surveyList.on">설문리스트</a>
    </li>
    
    <!-- 관리자 Links -->
    <c:if test="${sessionScope.loginuser != null && loginuser.department ==  '인사총무팀'}">
		  <%--  
		   <li class="menu topMenu nav-item">
		      <a class="nav-link" href="<%= ctxPath%>/survey/surveyWriting.on">설문작성</a>
		    </li> 
		    --%>
	    
	    <li class="menu topMenu nav-item">
	      <a class="nav-link" href="<%= ctxPath%>/survey/surveyManage.on">설문관리</a>
	    </li>
     </c:if> 
     </ul> 

</nav>
