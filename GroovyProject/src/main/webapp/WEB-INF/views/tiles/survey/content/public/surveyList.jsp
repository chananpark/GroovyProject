<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% String ctxPath = request.getContextPath(); %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>

	div#div_surveyList {
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

	div#input_unjoin {
		background-color:#E3F2FD; 
		width: 70px; 
		border: none;
	}
	
	div#input_join {
		background-color:#F9F9F9;
		width: 70px; 
		border: none;"
	}
	

 

</style>

<script type="text/javascript">


	$(document).ready(function(){
		
		// === 설문지제목을 누르면 === //
		$("input#surtitle").click(function(){
			const surno = $("input#surno").val();
			go_survey(surno);
		}); // end of $("input#surtitle").click(function(){ -------------------------
		
		
	}); // end of document.ready(function(){----------------------------


	//>>> 설문지 제목버튼을 누르면 <<<
	function go_survey(surno) {
		
		const frm = document.frm_surveyList;
		frm.action="<%=ctxPath%>/survey/surveyJoin.on";
		frm.method="GET";
		frm.submit();
	}

</script>



<form name="frm_surveyList">
<div id="div_surveyList">

	<div style='margin: 1% 0 3% 1%'>
		<h4>설문리스트</h4>
	</div>
	
	<!-- 제목을 클릭하면 정보를 넘길 수 있도록 hidden으로 값 받아오기 -->
	
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
			<span><input type="button" onclick="go_NotsurveyList()">미참여 &nbsp; </button></span> <%--  value="${empty requestScope.sursubdate}" --%>
			<span><input type="button"onclick="go_OksurveyList()">참여 (2) &nbsp;</button></span>
		</div>
		
		<div class="table table-sm" style='margin: 1% 0 3% 1%' >
			<table style="width: 95%;">
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
					<th>설문기간</th>
					<th>참여여부</th>
					<th>답변제출일</th>
				</thead>
				
				<tbody align="center" class="table ">
				<c:forEach var="survey" items="${requestScope.pageCnt}" varStatus="status"> 
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
						</td>
						<%-- <td><a href="<%= ctxPath%>/survey/surveyJoin.on" style="color:black;">${survey.surtitle}</a></td> --%>
						<td><input type="button" name="surtitle" id="surtitle" value="${survey.surtitle}"  style="background-color: white;"/>
								<!-- onclick="go_survey()" -->
						</td>
						<td>${survey.surstart}~${survey.surend}</td>
						
						<!-- 미참여일 경우 설문조사 페이지로 이동 -->
						<td>
							<!-- 미참여 -->
							<c:if test="${empty survey.sursubdate}">
								<div id="input_unjoin">미참여</div>
							</c:if>
							
							<!-- 참여 -->
							<c:if test="${not empty survey.sursubdate}">
								<div id="input_join">참여</div>
							</c:if>
						</td>  
						<td>${survey.sursubdate}</td>
					</tr>
					</c:forEach>
					
				</tbody>
				
			</table>
		</div>
		
		<div>${pagebar}</div>
	</div>
	
</div>

</form>
