<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>

	div#div_surveyManageList {
		padding: 5% 2%;
		width: 95%;
	}
	button {
		border: none;
		background-color: white;
	}
	
	input {
		border: none;
		background-color: white;
	}
	

	div#situation1 {
		background-color:#086BDE;
		width: 50px;
		border: none;
		color: white;
	}
	
	
	div#situation2{
		background-color: #F9F9F9;
		width: 50px;
		border: none
	}
	div#situation3{
		background-color:#E3F2FD;
		width: 70px;
		border: none
	}
	

 

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
	}); // end of 
	

</script>



<form name="frm_surveyManageList">
<div id="div_surveyManageList">

	<div style='margin: 1% 0 3% 1%'>
		<h4>설문관리</h4>
	</div>

	<div align="right">
		<span>
			<select name="searchType" style="width: 100px; border:none;">
				<option value="1">설문제목</option>
				<option value="2">설문기간</option>
			</select>
			<input type="text" name="searchWord" style="width: 120px; border:solid 1px #cccccc;" />
			<button class="btn btn-sm" style="background-color: #086BDE; color:white; width: 60px;font-size:14px;"><i class="fas fa-search"></i>검색</button>
		</span>
	</div>

	<div class="m-4">
		<div  style='margin: 1% 0 3% 1%'>
			<span style="color:#086BDE"><input type="button" name="" value="전체  (${requestScope.listCnt})"/></span>
			<span><input type="button" onclick="go_NotsurveyList()">미참여 &nbsp; </button></span> <%--  value="${empty requestScope.surjoindate}" --%>
			<span><input type="button"onclick="go_OksurveyList()">참여 (2) &nbsp;</button></span>
		</div>
		
		<div class="table table-sm" style="margin: 1% 0 3% 1%;" >
			<table style="width: 100%;" >
			  <colgroup align="center">
			  	<col width=10%>
	            <col width=10%>
	            <col width=35%>
	            <col width=25%>
	            <col width=10%>
	            <col width=10%>
	        </colgroup>
	        
				<thead align="center">
					<th>NO</th>
					<th>상태</th>
					<th>설문제목</th>
					<th>설문생성일</th>
					<th>대상</th>
					<th>응답수</th>
				</thead>
				
				<tbody align="center">
				<c:forEach var="survey" items="${requestScope.surveyManageList}" varStatus="status">
				<tr>
					<td><input type="hidden" name="surno" id="surno" value="${survey.surno}"/>${survey.surno}</td>
					<td>
						<!-- 설문조사가 진행중인경우 -->
						<c:if test="${survey.surstart <= survey.surend}">
							<div id="situation1">진행중</div>
						</c:if>
						
						<!-- 설문조사가 종료된경우-->
						<c:if test="${survey.surend < sysdate}">
							<div id="situation2">종료</div>
						</c:if>
						<!-- 설문조사가 제작중인 경우-->
						<!-- <div id="situation3" type="text" name="" value="종료" readonly/> -->
					</td>
					
					<td><a name="surtitle" id="surtitle" href="<%=ctxPath%>/survey/surveyManageView.on?surno=${survey.surno}" style="color: black;">${survey.surtitle}</a>
					<td>${survey.surcreatedate}</td>
					<td>
						<c:choose>
							<c:when  test="${survey.surtarget == 1}">
								전직원
							</c:when>
							<c:otherwise>
								선택대상
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<span id="joinCnt">${requestScope.joinempcnt}/${requestScope.empCnt}</span>
					</td>  
				</tr>
				</c:forEach>
			<%-- 	
				<tr>
					<td><div style="background-color: #F9F9F9; width: 70px; border: none;"><span style="width: 200px;">종료</span></div></td>
					<td>내부직원 브랜드 조사</td>
					<td>2022-10-12</td>
					<td>전직원</td>
					<td><span>48/50</span></td>   
				</tr>
				
				<tr>
					<td><input id="situation3" value="제작중"/></td>
					<td>직원 MBTI 조사</td>
					<td>2022-12-04</td>
					<td>기획팀</td>
					<td></td>   
				</tr>
			--%>	
				
				</tbody>
			</table>
			
			<div class="mt-5">${pagebar}</div>
		</div>
	</div>
	
</div>

</form>
