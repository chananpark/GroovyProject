<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style>

	.hoverShadow {
		transition: all 0.5s;
	}
	
	.hoverShadow:hover {
		box-shadow: 1px 1px 8px #ddd;
	}
	
	.hoverShadowText {
		transition: all 0.5s;
	}
	
	.hoverShadowText:hover {
		text-shadow: -1px -1px #ddd;
	}

	/* 표 시작 */
	.widths {
		width: 90%; 
		margin: 0 auto;
		padding-top: 50px;
	}
	
	.table {
		display: inline-block;
		/* border: solid 1px gray; */
	}
	
	.category {
		display: inline-block;
		background-color: #E3F2FD;
		/* border: solid 1px gray; */
		border-radius: 5px;
		width: 37px;
		height: 20px;
		font-size: 9pt;
		padding-top: 2px;
		text-align: center;		
	}
	
	.category:hover {
		cursor: pointer;
	}
	
	#title {
		width: 100%; 
		border-bottom: solid 1px gray;
		
	}
	
	.names { width: 10%; padding-left: 10px; }	
	.times { width: 7%;	}	
	.timeShapes { width: 65%; }
	
	div.contents {
		margin-top: 10px;		
	}
	
	


</style>   

<script>

</script>

<div style="font-size: 18pt; margin: 40px 0 50px 30px;" >전사 근태조회</div>

<div style="font-size: 16pt; text-align: center; margin-bottom: 30px;">
	<span class="glyphicon glyphicon-menu-left" style="color: #bfbfbf; font-size: 14pt;"></span>
	2022.11.07(월)
	<span class="glyphicon glyphicon-menu-right" style="color: #bfbfbf; font-size: 14pt;"></span>
</div>

<div class="widths" style="border-bottom: solid 1px #bfbfbf; margin-bottom: 10px;">
	<div id="title">
		<span class="table names">이름</span>
		<span class="table times">근무시간</span>
		<span class="table times">출근시간</span>
		<span class="table times">퇴근시간</span>
		<span class="table timeShapes" style="width: 50%;">시간</span>
		<a class="category">오늘</a>
		<a class="category">일</a>
		<a class="category" href="<%= ctxPath%>/attend/team_status_weekly.on">주</a>
		<a class="category">월</a>
	</div>
	<div class="contents">
		<span class="table names">김상후</span>
		<span class="table times">07:00</span>
		<span class="table times">10:00</span>
		<span class="table times">17:00</span>
		<span class="table timeShapes" style="margin-left: 38px; background-color: #E3F2FD; width: 38px;">&nbsp;</span>
		
		<%-- width: 38px; --%>
	</div>
	<div class="contents">
		<span class="table names">김혜원</span>
		<span class="table times">07:00</span>
		<span class="table times">10:00</span>
		<span class="table times">17:00</span>
		<span class="table timeShapes" style="margin-left: 114px; background-color: #E3F2FD; width: 304px;">&nbsp;</span>
		
		<%-- width: 38px; --%>
	</div>
	<div class="contents">
		<span class="table names">김원티드</span>
		<span class="table times">07:00</span>
		<span class="table times">10:00</span>
		<span class="table times">17:00</span>
		<span class="table timeShapes" style="margin-left: 152px; background-color: #E3F2FD; width: 190px;">&nbsp;</span>
		
		<%-- width: 38px; --%>
	</div>
</div>
<div style="margin-left: 428px;">
	07시&nbsp;&nbsp;&nbsp;08시&nbsp;&nbsp;&nbsp;09시&nbsp;&nbsp;&nbsp;10시&nbsp;&nbsp;&nbsp;11시&nbsp;&nbsp;&nbsp;
	12시&nbsp;&nbsp;&nbsp;13시&nbsp;&nbsp;&nbsp;14시&nbsp;&nbsp;&nbsp;15시&nbsp;&nbsp;&nbsp;16시&nbsp;&nbsp;&nbsp;
	17시&nbsp;&nbsp;&nbsp;18시&nbsp;&nbsp;&nbsp;19시&nbsp;&nbsp;&nbsp;20시&nbsp;&nbsp;&nbsp;21시&nbsp;&nbsp;&nbsp;
	22시&nbsp;&nbsp;&nbsp;23시&nbsp;&nbsp;&nbsp;24시
</div>
