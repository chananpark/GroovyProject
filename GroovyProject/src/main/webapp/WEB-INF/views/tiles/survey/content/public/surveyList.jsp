<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% String ctxPath = request.getContextPath(); %>

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



</script>



<form name="frm_surveyList">
<div id="div_surveyList">

	<div style='margin: 1% 0 3% 1%'>
		<h4>설문리스트</h4>
	</div>

	<div  style='margin: 1% 0 3% 1%'>
		<span style="color:#086BDE ">전체 (3) &nbsp;</span>
		<span><button onclick="go_NotsurveyList()">미참여 (1) &nbsp; </button></span>
		<span><button onclick="go_OksurveyList()">참여 (2) &nbsp;</button></span>
	</div>
	
	<div class="table table-sm" style='margin: 1% 0 3% 1%' >
		<table style="width: 95%;">
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
				<th>설문기간</th>
				<th>참여여부</th>
				<th>답변제출일</th>
			</thead>
			
			<tbody align="center">
			<tr>
				<td>
					<!-- 설문조사가 진행중인경우 -->
					<div id="situation1">진행중</div>
					<!-- 설문조사가 종료된경우-->
					<!-- <div id="situation2">종료</div> -->
				</td>
				<td><a href="<%= ctxPath%>/survey/surveyJoin.on" style="color:black;">구성원만족도 조사</a></td>
				<td>2022-11-27 ~ 2022-12-10</td>
				
				<!-- 미참여일 경우 설문조사 페이지로 이동 -->
				<td>
					<!-- 미참여 -->
					<div id="input_unjoin">미참여</div>
					<!-- 참여 -->
					<!-- <div id="input_join">참여</div> -->
				</td>  
				<td></td>
			</tr>
			
			<tr>
				<td><div style="background-color: #F9F9F9; width: 70px; border: none;"><span style="width: 200px;">종료</span></div></td>
				<td>내부직원 브랜드 조사</td>
				<td>2022-11-27 ~ 2022-12-10</td>
				<!-- 참여일경우 내가 체크한 목록 보여주기 -->
				<td><button onclick="go_surveyResult()" style="background-color:#F9F9F9; width: 70px; border: none;"><span style="font-size: 14px;">참여</span></button></td>   <!-- 미참여일 경우 배경색 하늘색, 참여한 경우 파란색에 글씨  흰색 -->
				<td>2022-11-29</td>
			</tr>
			
			</tbody>
			
			<div id="pagebar"></div>
		</table>
	</div>
	
	
	
	
	
	
</div>

</form>
