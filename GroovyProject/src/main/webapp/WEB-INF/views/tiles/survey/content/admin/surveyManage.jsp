<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% String ctxPath = request.getContextPath(); %>

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
				<tr>
					<td>
						<!-- 설문조사가 진행중인경우 -->
						<input id="situation1" type="text" name="" value="진행중" readonly/>
						<!-- 설문조사가 종료된경우-->
						<!-- <input id="situation2" type="text" name="" value="종료" readonly/> -->
						<!-- 설문조사가 제작중인 경우-->
						<!-- <input id="situation3" type="text" name="" value="종료" readonly/> -->
					</td>
					
					<td><a href="<%= ctxPath%>/survey/surveyManageView.on" style="color:black;">구성원만족도 조사</a></td>
					<td>2022-11-27</td>
					<td>전직원</td>
					<td>
						<span id="joinCnt">12/50</span>
					</td>  
				</tr>
				
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
				
				<div id="pagebar"></div>
			
			
			</table>
		</div>
	</div>
	
</div>

</form>
