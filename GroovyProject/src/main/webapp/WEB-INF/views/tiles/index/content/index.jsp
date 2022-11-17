<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	.index_card_header {
		color: #086BDE;
		font-weight: bold;
		cursor: pointer;
	}

	/* 이달의 생일 직원 */
	#birthday_card .card {
	  transition: 0.3s;
	  border-radius: 5px; /* 5px rounded corners */
	  width:17%;
	}
	
	/* Add rounded corners to the top left and the top right corner of the image */
	#birthday_card img {
	  border-radius: 5px 5px 0 0;
	}
	
	#birthday_card .container {
	  padding: 10px 16px;
	}
	
	#birthday_card .card:hover {
	  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
	  cursor: pointer;
	}


	/* 출퇴근 css */
	#index_atten .menuBlue {	color: #086BDE;	}
	
	#index_atten .hoverShadow {	transition: all 0.5s;	}
	
	#index_atten .hoverShadow:hover {	box-shadow: 1px 1px 10px #ddd;	}
	
	#index_atten .hoverShadowText {
		transition: all 0.5s;
		text-decoration-line: none;
		color: black;
	}
	
	#index_atten .hoverShadowText:hover {
		text-shadow: -1px -1px #ddd;
		text-decoration-line: none;
		color: black;
	}
	
   
	#index_atten #attendBox{
		width: 200px;
		height: 300px;
		margin: 0 0 30px 30px;		
	}
	
	#index_atten #nowTime{
		font-size: 22pt;	
		color: #666666;
	}
	
	#index_atten .attTime{	font-size: 10pt;	}
	
	#index_atten .attTimeRight{	float: right;	}
	
	#index_atten .onOff {
		border: solid 1px #086BDE;
		color: #086BDE;
		background-color: white;
		border-radius: 30px;
		height: 30px;
		width: 75px;
		font-size: 10pt;
	}
	
	#index_atten .onOff:hover {
		background-color: #086BDE;
		color: white;
	}
	
	#index_atten #attSelectBtn {
		border: solid 1px #086BDE;
		color: #086BDE;
		background-color: white;
		border-radius: 30px;
		height: 30px;
		width: 152px;
		margin-top: 7px;
		font-size: 10pt;
	}
	
	#index_atten #attSelectBtn:hover {
		background-color: #086BDE;
		color: white;
	}
	
	#index_atten #attSelectBox {
		z-index: 2;
		border: solid 1px #086BDE;
		color: #086BDE;
		background-color: (255, 255, 255, 1);
		border-radius: 10px;
		height: 150px;
		width: 152px;
	}
	
	#index_atten .selectContent {
		padding-top: 5px;
		height: 30px;
		color: #666666;
		text-align: center;
		display: block;
		
	}
	
	#index_atten .selectContent:hover {
		background-color: #ddd;
		color: black;
		text-decoration: none;
		cursor: pointer;
	}
	
	#index_atten .menus:hover {	cursor: pointer;	}
	#index_atten .menu {	list-style: none;	}
	
	#index_atten .topMenu {
		font-size: 12.5pt;
		margin-top: 20px;
		margin-bottom: 5px;		
	}
	
	#index_atten .subMenus {	font-size: 11.5pt;	}
		
	#index_atten #menuBox {	z-index: 1;	} /* div 겹치는거 때문에 함 */
	/* 출퇴근css 끝 */
	
	

</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 날씨 위젯 자동 새로고침
		setTimeout(function(){window.location.reload(1)},3000000);
		
		// 출근 시작
		nowDate(); // 현재 날짜를 얻어와서 보여주는 함수
		clock();   // 현재 날짜를 얻어와서 초단위로 업데이트하여 보여주는 함수
		
		$("#attSelectBox").hide();
		
		$("#attSelectBtn").click(function(){
			
			const attSelectBox = $("#attSelectBox")
			
			if(attSelectBox.is(":visible")){
				attSelectBox.slideUp("fast");
				document.getElementById("attSelectComp").className = "glyphicon glyphicon-menu-down";
			}
			else{
				attSelectBox.slideToggle("fast");
				document.getElementById("attSelectComp").className = "glyphicon glyphicon-menu-up";
			}
		});
		
		// 출근끝
		
	}); // end of ready
	

	// function declaration
	
	function nowDate(){ 
		// 현재 날짜를 얻어와서 보여주는 함수
		
		const now = new Date();
		
		const year = now.getFullYear();
		const month = now.getMonth()+1;
		const date = now.getDate();		
		let day = now.getDay();
		
		switch (day) {
		case 0:
			day = "일"
			break;
		case 1:
			day = "월"	
			break;
		case 2:
			day = "화"
			break;
		case 3:
			day = "수"
			break;
		case 4:
			day = "목"
			break;
		case 5:
			day = "금"
			break;
		case 6:
			day = "토"
			break;
			
		} // end of switch
		
		const nowDate = year + "-" + month + "-" + date + "(" + day + ")";
		
		$("#nowDate").text(nowDate);	
		
	} // end of function nowDate(){} ---------------------------------
	
	function nowTime(){
		// 현재 시간을 얻어오는 함수
		
		const now = new Date();
			
		let hours = now.getHours();
		let min = now.getMinutes();
		let sec = now.getSeconds();
		
		if(hours < 10){
			hours = "0" + hours;
		}
		
		if(min < 10){
			min = "0" + min;
		}
		
		if(sec < 10){
			sec = "0" + sec;
		}
		
		const nowTime = hours + ":" + min + ":" + sec;
		
		$("#nowTime").text(nowTime);		
		
	} // end of function nowTime(){} ----------------------------------
	
	function clock(){
		// 현재 날짜를 얻어와서 초단위로 업데이트하는 함수
		
		nowTime(); // 현재 시간을 얻어오는 함수
		setInterval(nowTime, 1000); // 현재 시간을 얻어오는 함수 nowTime()을 초단위로 업데이트
		
	} // end of function clock(){} ------------------------------------
	
	function workStatus(e){
		// console.log(e);		
		
		$("#attSelectBtn").html(e + "&nbsp;<span id='attSelectComp' class='glyphicon glyphicon-menu-down'></span>");
		$("#attSelectBox").hide();
		
	}
	

</script>


<%-- 상단 --%>
<div style="margin: 0 auto; width:95%;">
	<h4 class="mt-3 mb-3">😀그루비 회원님, 좋은 하루 보내세요!</h4>
</div>

<%-- 하단 card 영역 --%>	
<div  style="width:100%; background-color: #f9f9f9;">
	
	<div style="margin: 0 auto; width:97%; display:flex; justify-content: space-around; ">
	
		<%-- 왼쪽 card --%>
		<div style="width:60%;">
		
			<%-- 메일 --%>
			<div class="card mb-3 shadow mt-3">
				<div class="card-header bg-white index_card_header" onClick='location.href="<%=ctxPath%>/mail/receiveMailBox.on"'>메일</div>
				<div class="card-body ">
					<table class="table table-hover">
						<thead>
							<tr class=" bold">
								<th class="col-2 border-top-0">보낸사람</th>
								<th class="col-7 border-top-0">제목</th>
								<th class="col-3 border-top-0">날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>박찬안</td>
								<td>그루비팀 회식은</td>
								<td>2022.11.16 11:23:21</td>
							</tr>
							<tr>
								<td>김민수</td>
								<td>2022년 12월 21일입니다.</td>
								<td>2022.11.16 11:23:21</td>
							</tr>
							<tr>
								<td>김진석</td>
								<td>다들 빠지지 마시고</td>
								<td>2022.11.16 11:23:21</td>
							</tr>
							<tr>
								<td>김혜원</td>
								<td>꼭 참석해주세요.</td>
								<td>2022.11.16 11:23:21</td>
							</tr>
							<tr>
								<td>손여진</td>
								<td>남은 기간도 화이팅입니다.(•̀ᴗ•́)و ̑̑</td>
								<td>2022.11.16 11:23:21</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			<%-- 전자결재 --%>
			<div class="card mb-3 shadow">
				<div class="card-header bg-white index_card_header" onClick='location.href="<%=ctxPath%>/approval/home.on"'>전자결재</div>
				<div class="card-body ">
					결재해야할 문서가 <span style="color:#086BDE; font-weight: bold;">7건</span>있습니다.
					<button class="btn mb-1 ml-2"  onClick='location.href="<%=ctxPath%>/approval/requested.on"'>>> 결재하기</button>
				</div>
			</div>
			
			<%-- 날씨 --%>
			<div class="card mb-3 shadow">
				<div class="card-header bg-white index_card_header">날씨</div>
				<div class="card-body ">
					<iframe width="100%" height="230" src="https://forecast.io/embed/#lat=37.5857&lon=126.877&color=#086BDE&name=그루비&color=&font=arial&units=si" frameborder="0"></iframe>
				
				</div>
			</div>
			
			<%-- 이달의 생일 --%>
			<div id="birthday_card" class="card mb-3 shadow">
				<div class="card-header bg-white index_card_header">이달의 생일</div>
				<div class="card-body pl-5" style="display:flex; flex-wrap: wrap; justify-content: flex-start;">
				
					<div class="card mr-4 mb-2">
						<img src="<%= ctxPath %>/resources/images/test/profile_icon.png" alt="Avatar" style="width:100%">
					 	<div class="container">
					    	<h5>박찬안</h5>
					    	<p>개발팀</p>
					  	</div>
					</div>
					
					<div class="card mr-4 mb-2">
						<img src="<%= ctxPath %>/resources/images/test/profile_icon.png" alt="Avatar" style="width:100%">
					 	<div class="container">
					    	<h5>김민수</h5>
					    	<p>개발팀</p>
					  	</div>
					</div>
					
					<div class="card mr-4 mb-2">
						<img src="<%= ctxPath %>/resources/images/test/profile_icon.png" alt="Avatar" style="width:100%">
					 	<div class="container">
					    	<h5>김진석</h5>
					    	<p>개발팀</p>
					  	</div>
					</div>
										
					<div class="card mr-4 mb-2">
						<img src="<%= ctxPath %>/resources/images/test/profile_icon.png" alt="Avatar" style="width:100%">
					 	<div class="container">
					    	<h5>김혜원</h5>
					    	<p>개발팀</p>
					  	</div>
					</div>
					
					<div class="card mr-4 mb-2">
						<img src="<%= ctxPath %>/resources/images/test/profile_icon.png" alt="Avatar" style="width:100%">
					 	<div class="container">
					    	<h5>손여진</h5>
					    	<p>개발팀</p>
					  	</div>
					</div>
					
				</div>
				
			</div>
			
		</div>
		
		<%-- 오른쪽 card --%>
		<div style="width:35%;">
		
			<%-- 출퇴근 --%>
			<div class="card mb-3 shadow mt-3" id="index_atten">
				<div class="card-header bg-white index_card_header" onClick='location.href="<%=ctxPath%>/attend/myAttend.on"'>출/퇴근</div>
				<div class="card-body ">
					<div style="margin:0 auto;">
						<div id="attendBox" style="margin:0 auto;">
							<div id="nowDate"></div>
							<div id="nowTime"></div>
							
							<div>
								<span class="attTime">출근시간</span>
								<span class="attTime attTimeRight">10:00:00</span>
							</div>
							<div>
								<span class="attTime">퇴근시간</span>
								<span class="attTime attTimeRight">10:00:00</span>
							</div>
							<div>
								<span class="attTime">누적근무시간<span style="font-size: 8pt;">(주간)</span></span>
								<span class="attTime attTimeRight">9h 20m 52s</span>
							</div>
							<hr>
							<div id="workSelectBox">
								<button type="button" class="onOff hoverShadow" id="">출근하기</button>
								<button type="button" class="onOff hoverShadow" id="">퇴근하기</button>
								<button style="display: block;" type="button" id="attSelectBtn" class="hoverShadow">근무상태 <span id="attSelectComp" class="glyphicon glyphicon-menu-down"></span></button>
								<div id="attSelectBox">
									<div class="selectContent" style="border-top-left-radius: 9px; border-top-right-radius: 9px;" onclick="workStatus('업무')">업무</div>
									<div class="selectContent" onclick="workStatus('업무종료')">업무종료</div>
									<div class="selectContent" onclick="workStatus('출장')">출장</div>
									<div class="selectContent" onclick="workStatus('복귀')">복귀</div>
									<div class="selectContent" style="border-bottom-left-radius: 9px; border-bottom-right-radius: 9px;" onclick="workStatus('연장근무')">연장근무</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<%-- 달력/일정 --%>
			<div class="card mb-3 shadow">
				<div class="card-header bg-white index_card_header" onClick='location.href="<%=ctxPath%>/schedule/schedule.on"'>오늘의 일정</div>
				<div class="card-body ">
				
					<table class="table table-hover">
						<thead>
							<tr class=" bold">
								<th class="col-2 border-top-0"></th>
								<th class="col-5 border-top-0">일자</th>
								<th class="col-5 border-top-0">일정명</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><div style="border-radius: 50%; background-color: #64DB56; width: 25px; height: 25px;"></div></td>
								<td>2022.11.16 09:00:00</td>
								<td>외부미팅</td>
							</tr>
							<tr>
								<td><div style="border-radius: 50%; background-color: #EFF93A; width: 25px; height: 25px;"></div></td>
								<td>2022.11.16 15:00:00</td>
								<td>팀회의</td>
							</tr>
						</tbody>
					</table>
					
				</div>
			</div>
		
			<%-- 명언 --%>
			<div class="card mb-3 shadow">
				<div class="card-header bg-white index_card_header">오늘의 명언</div>
				<div class="card-body ">직업에서 행복을 찾아라. 아니면 행복이 무엇인지 절대 모를 것이다. - 엘버트 허버드</div>
			</div>
			
		</div>
		
	</div>
</div>
