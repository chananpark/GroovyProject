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
	}
	

	input#situation1 {
		background-color:#086BDE;
		width: 70px;
		border: none;
		color: white;
	}
	
	
	input#situation2{
		background-color: #F9F9F9;
		width: 70px;
		border: none
	}
	
	input#situation3{
		background-color:#E3F2FD;
		width: 70px;
		border: none
	}
	

 

</style>

<script type="text/javascript">



</script>



<form name="frm_surveyManageList">
<div id="div_surveyManageList">

	<div style='margin: 1% 0 3% 1%'>
		<h4>설문관리</h4>
	</div>

	<div class="m-4">
		<div style='margin: 1% 0 3% 1%'>
			<span style="color:#086BDE ">전체 (3) &nbsp;</span>
			<span><button onclick="go_NotsurveyList()">진행중(1) &nbsp; </button></span>
			<span><button onclick="go_OksurveyList()">종료 (1) &nbsp;</button></span>
			<span><button onclick="go_OksurveyList()">제작중(1) &nbsp;</button></span>
		</div>
		
		<div class="table table-sm" style="margin: 1% 0 3% 1%;" >
			<table style="width: 100%;">
			  <colgroup align="center">
	            <col width=10%>
	            <col width=35%>
	            <col width=25%>
	            <col width=10%>
	            <col width=20%>
	        </colgroup>
	        
				<thead align="center">
					<th>상태</th>
					<th>설문제목</th>
					<th>설문생성일</th>
					<th>대상</th>
					<th>응답수</th>
				</thead>
				
				<tbody align="center">
				<c:forEach var="survey" items="${requestScope.pageCnt}" varStatus="status">
				<tr>
					<td>
						<input type="hidden" name="surno" id="surno" value="${survey.surno}"/>${survey.surno}
						<!-- 설문조사가 진행중인경우 -->
						<c:if test="${survey.surstart <= survey.surend}">
							<div id="situation1">진행중</div>
						</c:if>
						
						<!-- 설문조사가 종료된경우-->
						<c:if test="${survey.surend < sysdate}">
							<div id="situation2">종료</div>
						</c:if>
						<!-- 설문조사가 제작중인 경우-->
						<!-- <input id="situation3" type="text" name="" value="종료" readonly/> -->
					</td>
					
					<td><input type="button" name="surtitle" id="surtitle" value="${survey.surtitle}"  style="background-color: white;"/>
					<td>${survey.surcreatedate}</td>
					<td>
						<c:if test="${survey.surtarget == 0}">
							전직원
						</c:if>
						<c:if test="${survey.surtarget == 1}">
							
						</c:if>
						
						
					</td>
					<td>
						<span id="joinCnt">${requestScope.joinempcnt}/${requestScope.listCnt}</span>
					</td>  
				</tr>
				</c:forEach>
				
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
				
				
				</tbody>
				
				<div id="pagebar">${pagebar}</div>
			
			
			</table>
		</div>
	</div>
	
</div>

</form>
