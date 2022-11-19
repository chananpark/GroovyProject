<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<style>

	* {font-family: 'Pretendard', sans-serif; !important}
	
	.menuBlue {	color: #086BDE;	}
	
	.hoverShadow {	transition: all 0.5s;	}
	
	.hoverShadow:hover {	box-shadow: 1px 1px 10px #ddd;	}
	
	.hoverShadowText {
		transition: all 0.5s;
		text-decoration-line: none;
		color: black;
	}
	
	.hoverShadowText:hover {
		text-shadow: -1px -1px #ddd;
		text-decoration-line: none;
		color: black;
	}
	
   
	#attendBox{
		width: 200px;
		height: 300px;
		margin: 0 0 30px 30px;		
	}
	
	#nowTime{
		font-size: 22pt;	
		color: #666666;
	}
	
	.attTime{	font-size: 10pt;	}
	
	.attTimeRight{	float: right;	}
	
	.onOff {
		border: solid 1px #086BDE;
		color: #086BDE;
		background-color: white;
		border-radius: 30px;
		height: 30px;
		width: 87px;
		font-size: 10pt;
	}
	
	.onOff:hover {
		background-color: #086BDE;
		color: white;
	}
	
	#attSelectBtn {
		border: solid 1px #086BDE;
		color: #086BDE;
		background-color: white;
		border-radius: 30px;
		height: 30px;
		width: 178px;
		margin-top: 7px;
		font-size: 10pt;
	}
	
	#attSelectBtn:hover {
		background-color: #086BDE;
		color: white;
	}
	
	#attSelectBox {
		z-index: 2;
		border: solid 1px #086BDE;
		color: #086BDE;
		background-color: (255, 255, 255, 1);
		border-radius: 10px;
		height: 150px;
		width: 152px;
		font-size: 10pt;
	}
	
	.selectContent {
		padding-top: 5px;
		height: 30px;
		color: #666666;
		text-align: center;
		display: block;
		
	}
	
	.selectContent:hover {
		background-color: #ddd;
		color: black;
		text-decoration: none;
		cursor: pointer;
	}
	
	.menus:hover {	cursor: pointer;	}
	.menu {	list-style: none;	}
	
	.topMenu {
		font-size: 12.5pt;
		margin-top: 20px;
		margin-bottom: 5px;		
	}
	
	.subMenus {	font-size: 11.5pt;	}
		
	#menuBox {	z-index: 1;	} /* div 겹치는거 때문에 함 */
	
	.nav-link { padding-top: 5px; !important	}
   
</style>

<script>

	$(document).ready(function(){ // ======================================
		
		nowDate(); // 현재 날짜를 얻어와서 보여주는 함수
		clock();   // 현재 날짜를 얻어와서 초단위로 업데이트하여 보여주는 함수
		
		$(".subMenus").hide(); // 사이드 메뉴 닫기(기본)
		
		// 클릭한 메뉴 파란표시하기 시작 --------------
		const submenuId = "${requestScope.submenuId}"; 
		// console.log(submenuId);
				
		$("#"+submenuId).css("color","#086BDE");
		let parent = $("#"+submenuId).parents().eq(1);
		parent = parent.attr('id');
		// console.log(parent);
		$("#"+parent).show();
		// 클릭한 메뉴 파란표시하기 끝   --------------
		
					
		$("#attSelectBox").hide();
		
		$("#attSelectBtn").click(function(){
			
			const attSelectBox = $("#attSelectBox")
			
			if(attSelectBox.is(":visible")){
				attSelectBox.slideUp("fast");
				document.getElementById("attSelectComp").className = "fas fa-caret-down";
			}
			else{
				attSelectBox.slideToggle("fast");
				document.getElementById("attSelectComp").className = "fas fa-caret-up";
			}
		});
		
				
				
		// 메뉴 선택시 다른 메뉴 닫기		
		$(".topMenu").click(function(e) {
		    const target = $(e.target.children[0]).attr('id');
		    // console.log(target);
		    if ($("#"+target).is(":visible")) {
		    	$(".subMenus").slideUp("fast");		    	
		    }
		    else {
		    	$(".subMenus").slideUp("fast");
		    	$("#"+target).slideToggle("fast");
		    }
		    
		}); // end of $(".topMenu").click() -------------------------------
		
		
		
		
	}); // end of $(document).ready(function(){} ==========================
		
	// 근무상태 이외의 곳을 클릭했을 때 근무상태 div 닫기
	$(document).on('click', function(e) { // ------------------------------
	    const attSelectBtn = $("#attSelectBtn");
	    const attSelectBox = $("#attSelectBox");
	    
	    if (!$(e.target).closest(attSelectBtn).length) {
	    	attSelectBox.hide();
	    }
	}); // end of $(document).on('click') ----------------------------------
		
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

<div id="attendBox" style="padding: 20px 0; width: 80%;" >
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

<div id="menuBox" style="">
	<ul class="menus">
		<li class="menu topMenu" id="topMenu1">근태 관리
			<ul class="menu subMenus" id="subMenu1">
				<li class="nav-link" style="margin-top: 7px;"><a href="<%= ctxPath%>/attend/myAttend.on" class="hoverShadowText" id="my1">내 근태 조회</a></li>
				<li class="nav-link"><a href="<%= ctxPath%>/attend/myManage.on" class="hoverShadowText" id="my2">내 근태 관리</a></li>
			</ul>
		</li>
		
		<li class="menu topMenu" id="topMenu2">경영 지원
			<ul class="menu subMenus" id="subMenu2">
				<li style="margin-top: 7px;"><a href="<%= ctxPath%>/attend/teamStatusDaily.on" class="hoverShadowText" id="team1">부서 근태 조회</a></li>
				<li class=""><a href="<%= ctxPath%>/attend/teamManage.on" class="hoverShadowText" id="team2">부서 근태 관리</a></li>
			</ul>
		</li>
		
		<li class="menu topMenu" id="topMenu3">전사 근태관리
			<ul class="menu subMenus" id="subMenu3">
				<li style="margin-top: 7px;"><a href="<%= ctxPath%>/attend/allStatus.on" class="hoverShadowText" id="all1" >전사 근태 조회</a></li>
				<li class=""><a href="<%= ctxPath%>/attend/allManage.on" class="hoverShadowText" id="all2">전사 근태 관리</a></li>
			</ul>
		</li>
	</ul>
</div>