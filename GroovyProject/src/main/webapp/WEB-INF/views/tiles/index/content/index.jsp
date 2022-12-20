<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
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
	
	#index_atten .attTime{		}
	
	#index_atten .attTimeRight{	float: right;	}
	
	#index_atten .onOff {
		border: solid 1px #086BDE;
		color: #086BDE;
		background-color: white;
		border-radius: 30px;
		height: 30px;
		width: 75px;
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
		height: 100px;
		width: 152px;
	}
	
	#index_atten .selectContent {
		height: 20px;
		color: #666666;
		text-align: center;
		display: block;
		font-size: 10pt;
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
		margin-top: 20px;
		margin-bottom: 5px;		
	}
	
	#index_atten .subMenus {		}
		
	#index_atten #menuBox {	z-index: 1;	} /* div 겹치는거 때문에 함 */
	/* 출퇴근css 끝 */
	
	#indexSchedule .scheduletr:hover {
		cursor: pointer;
	}
	
	

</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 날씨 위젯 자동 새로고침
		setTimeout(function(){window.location.reload(1)},3000000);
		
		// 출근 시작
		nowDate(); // 현재 날짜를 얻어와서 보여주는 함수
		clock();   // 현재 날짜를 얻어와서 초단위로 업데이트하여 보여주는 함수
		
		$("#index_atten #attSelectBox").hide();
		
		$("#index_atten #attSelectBtn").click(function(){
			
			const attSelectBox = $("#index_atten #attSelectBox")
			
			if(attSelectBox.is(":visible")){
				attSelectBox.slideUp("fast");
				document.getElementById("attSelectComp").className = "fas fa-caret-down";
			} 
			else{
				attSelectBox.slideToggle("fast");
				document.getElementById("attSelectComp").className = "fas fa-caret-up";
			}
		});
		
		// 출근끝
		
		// 오늘 생일 직원 사번 배열
		var birthEmpno = [];

		<c:forEach items="${birthMem}" var="mem">
			birthEmpno.push("${mem.empno}");
		</c:forEach>
		
		// 오늘 생일 직원 클릭시 팝오버
	    $.fn.popover.Constructor.Default.whiteList.table = [];
	    $.fn.popover.Constructor.Default.whiteList.tr = [];
	    $.fn.popover.Constructor.Default.whiteList.td = [];
	    $.fn.popover.Constructor.Default.whiteList.div = [];
	    $.fn.popover.Constructor.Default.whiteList.tbody = [];
	    $.fn.popover.Constructor.Default.whiteList.thead = [];
	    
	    birthEmpno.forEach(el=>{
			$('#popover'+el).popover({
				content: $('#myPopoverContent'+el).html(),
				html: true
			});
	    });
	    
	    
	 // 출근하기
		$("#goStartWorkBtn").click(function(){ // -------------------------
			
			const empno = "${sessionScope.loginuser.empno}";	
			
			$.ajax({
				  url:"<%=ctxPath%>/attend/goStartWork.on",
				  data:{"empno":empno},
				  type:"POST",
				  dataType:"JSON",
				  success:function(json){
					  getWorkTimes();
					  getSideWeeklyWorkTimes();
				  },
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			});			
			
		}); // end of $("#goStartWorkBtn").click() --------------------------
		
		// 퇴근하기
		$("#goEndWorkBtn").click(function(){ // -------------------------
			
			const empno = "${sessionScope.loginuser.empno}";			
			
			$.ajax({
				  url:"<%=ctxPath%>/attend/goEndWork.on",
				  data:{"empno":empno},
				  type:"POST",
				  dataType:"JSON",
				  success:function(json){
					  getWorkTimes();
					  getSideWeeklyWorkTimes();
				  },
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			  });			
			
		}); // end of $("#goStartWorkBtn").click() --------------------------
	    
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
		
		$("#index_atten #nowDate").text(nowDate);	
		
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
		
		$("#index_atten #nowTime").text(nowTime);		
		
	} // end of function nowTime(){} ----------------------------------
	
	function clock(){
		// 현재 날짜를 얻어와서 초단위로 업데이트하는 함수
		
		nowTime(); // 현재 시간을 얻어오는 함수
		setInterval(nowTime, 1000); // 현재 시간을 얻어오는 함수 nowTime()을 초단위로 업데이트
		
	} // end of function clock(){} ------------------------------------
	
	function workStatus(e){
		// console.log(e);		
		
		$("#index_atten #attSelectBtn").html(e + "&nbsp;<span id='attSelectComp' class='glyphicon glyphicon-menu-down'></span>");
		$("#index_atten #attSelectBox").hide();
		
	}
	
	function goMail(mailno, mailRecipientNo){
		// 패스워드 체크
		$.ajax({
			url:"<%= ctxPath%>/mail/getPwd.on",
			type:"post",
			data:{"mail_no":mailno},
	        success:function(pwd){
	        	if(pwd != "" && pwd != null){
	        		swal("비밀 메일입니다. 암호를 입력해주세요", {
	  				  content: "input",
	  				})
	  				.then((value) => {
	  				  if(value == pwd){
	  					location.href="<%=ctxPath%>/mail/viewMail.on?mailNo="+mailno+"&mailRecipientNo"+mailRecipientNo;
	  				  }
	  				  else{
	  					  swal("잘못된 암호입니다. 다시 확인해주세요");
	  				  }
	  				});
	        	}
	        	else{
	        		location.href="<%=ctxPath%>/mail/viewMail.on?mailNo="+mailno+"&mailRecipientNo"+mailRecipientNo;
	    		}

	        	
	        },
	        error: function(request, status, error){
				swal("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
		
	}
	
	
	
	// 주간근무시간 얻어오기
	function getSideWeeklyWorkTimes() { // -----------------------------------------
		
		const empno = "${sessionScope.loginuser.empno}";
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getSideWeeklyWorkTimes.on",
			  data:{"empno":empno},
			  dataType:"JSON",
			  success:function(json){
				  
				  const weeklywork = json.weeklyworkTimesMap.weeklywork;
				  
				  $("#sideWeeklywork").text(weeklywork);
				  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		
	} // end of function getWorkTimes() ----------------------------------
	
	
	function getWorkTimes() { // -----------------------------------------
		
		const empno = "${sessionScope.loginuser.empno}";
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getWorkTimes.on",
			  data:{"empno":empno},
			  dataType:"JSON",
			  success:function(json){
				  
				  const workStartTime = json.workTimeMap.workstart;
				  const workEndTime = json.workTimeMap.workend;
				  const weeklyTime = json.workTimeMap.weeklyTime;
				  
				  // console.log("workStartTime: "+ workStartTime);
				  // console.log("workEndTime: "+ workEndTime);
				  // console.log("weeklyTime: "+ weeklyTime);
				  
				  $("#workStartTime").text(workStartTime);
				  $("#workEndTime").text(workEndTime);
				  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		
	} // end of function getWorkTimes() ----------------------------------

</script>


<%-- 상단 --%>
<div style="margin: 0 auto; width:95%;">
	<h4 class="mt-3 mb-3">😀${loginuser.name} 회원님, 좋은 하루 보내세요!</h4>
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
					<c:if test="${mailList != null}">
					<table class="table table-hover">
						<thead>
							<tr class=" bold">
								<th class="col-2 border-top-0">보낸사람</th>
								<th class="col-7 border-top-0">제목</th>
								<th class="col-3 border-top-0">날짜</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${mailList}" var="mail">
						<fmt:formatDate value="${mail.send_time_date}" pattern="yyyy-MM-dd" var="sendTimeDD"/>
				        <fmt:formatDate value="${mail.send_time_date}" pattern="HH:mm:ss" var="sendTimeToday"/>
				        <fmt:formatDate value="${mail.send_time_date}" pattern="yyyy-MM-dd HH:mm:ss" var="sendTimeNotToday"/>
				        
							<tr onclick="goMail('${mail.mail_no}','${mail.mail_recipient_no}')" style="cursor:pointer">
								<td>${mail.fK_sender_address}</td>
								<td>${mail.subject}</td>
								<c:if test="${sendTimeDD == today}">
						      		<td class = "mail_list_time">오늘 ${sendTimeToday}</td>
						      	</c:if>
						        <c:if test="${sendTimeDD != today}">
							      	<td class = "mail_list_time">${sendTimeNotToday}</td>
						      	</c:if>	
							</tr>
						</c:forEach>
						
							
						</tbody>
					</table>
					</c:if>
					<c:if test="${mailList == null}">
						
							받은 메일이 없습니다.

						
						</c:if>	
				</div>
			</div>
			
			<%-- 전자결재 --%>
			<div class="card mb-3 shadow">
				<div class="card-header bg-white index_card_header" onClick='location.href="<%=ctxPath%>/approval/home.on"'>전자결재</div>
				<div class="card-body ">
					결재해야할 문서가 <span style="color:#086BDE; font-weight: bold;">${requestedDraftCnt}건</span>있습니다.
					<button class="btn mb-1 ml-2" style="float:right" onClick='location.href="<%=ctxPath%>/approval/requested.on"'>>> 결재하기</button>
				</div>
			</div>
			
			<%-- 날씨 --%>
			<div class="card mb-3 shadow" style="clear:both">
				<div class="card-header bg-white index_card_header">날씨</div>
				<div class="card-body ">
					<iframe width="100%" height="230" src="https://forecast.io/embed/#lat=37.5857&lon=126.877&color=#086BDE&name=그루비&color=&font=arial&units=si" frameborder="0"></iframe>
				
				</div>
			</div>
			
			<%-- 이달의 생일 --%>
			<div id="birthday_card" class="card mb-3 shadow">
				<div class="card-header bg-white index_card_header">이달의 생일</div>
				<div class="card-body pl-5" style="display:flex; flex-wrap: wrap; justify-content: flex-start;">
					<c:forEach items="${birthMem}" var="mem">
					<div class="card mr-4 mb-2 pop"  data-toggle="popover" id='popover${mem.empno}' title="사원 정보">
						<c:if test="${empty mem.empimg}">
							<img src="<%= ctxPath %>/resources/images/test/profile_icon.png" alt="Avatar" style="width:100%">
						</c:if>
						<c:if test="${not empty mem.empimg}">
							<img src="<%= ctxPath %>/resources/images/profile/${mem.empimg}" alt="Avatar" style="width:100%; border-radius: 50%">
						</c:if>
					 	<div class="container">
					    	<h5>${mem.name}</h5>
					    	<p>${mem.department}</p>
					  	</div>
					</div>
					<div id="myPopoverContent${mem.empno}" style="display: none;">
						<table class='table table-borderless'>
						    <tr>
						        <td>이름: ${mem.name}</td>
						    </tr>
						    <tr>
						        <td>직급: ${mem.position}</td>
						    </tr>
						    <tr>
						        <td>소속: ${mem.bumun}&nbsp;${mem.department}</td>
						    </tr>
						    <tr>
						    	<td>메일: ${mem.cpemail}</td>
						    </tr>
						    <tr>
						    	<td>핸드폰: ${mem.mobile}</td>
						    </tr>
						</table>		
					</div>
					</c:forEach>
				</div>
				
			</div>
			
		</div>
		
		<%-- 오른쪽 card --%>
		<div style="width:35%;">
		
			<%-- 출퇴근 --%>
			<div class="card mb-3 shadow mt-3" id="index_atten">
				<div class="card-header bg-white index_card_header" onClick='location.href="<%=ctxPath%>/attend/myAttend.on"'>출/퇴근</div>
				<div class="card-body " style="height: 200px;">
					<div style="margin:0 auto;">
						<div id="attendBox" style="display:flex; width: 400px;">
							<div>
								<div id="nowDate"></div>
								<div id="nowTime"></div>
								
								<div>
									<span class="attTime">출근시간</span>
									<span class="attTime attTimeRight" id="workStartTime">-</span>
								</div>
								<div>
									<span class="attTime">퇴근시간</span>
									<span class="attTime attTimeRight" id="workEndTime">-</span>
								</div>
								<div>
									<span class="attTime pr-1">누적근무시간<span style="font-size: 8pt;">(주간)</span></span>
									<span class="attTime attTimeRight" id="sideWeeklywork" >0h 0m </span>
								</div>
							</div>
							<hr>
							<div>
								<div id="workSelectBox">
									<button type="button" class="onOff hoverShadow" id="goStartWorkBtn">출근하기</button>
									<button type="button" class="onOff hoverShadow" id="goEndWorkBtn">퇴근하기</button>
									<button style="display: block;" type="button" id="attSelectBtn" class="hoverShadow">근무상태 <span id="attSelectComp" class="fas fa-caret-down"></span></button>
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
			</div>
			
			<%-- 달력/일정 --%>
			<div id="indexSchedule" class="card mb-3 shadow">
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
							<c:if test="${empty requestScope.scheduleList}">
								<tr>
									<td style="text-align: center;" colspan="12">오늘의 일정이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty requestScope.scheduleList}">
								<c:forEach var="map" items="${requestScope.scheduleList}">
									<tr onclick="location.href='<%= ctxPath %>/schedule/viewSchedule.on?scheduleno=${map.scheduleno}'" class="scheduletr">
										<td><div style="border-radius: 50%; background-color: ${map.color}; width: 25px; height: 25px;"></div></td>
										<td>${map.startdate}</td>
										<td>${map.subject}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					
				</div>
			</div>
		
			<%-- 명언 --%>
			<div class="card mb-3 shadow">
				<div class="card-header bg-white index_card_header">오늘의 명언</div>
				<div class="card-body">${proverb}</div>
			</div>
			
		</div>
		
	</div>
</div>
