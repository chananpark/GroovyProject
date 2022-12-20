<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<% String ctxPath = request.getContextPath(); %>

<style>
	.hoverShadow {	transition: all 0.5s;	}
	
	.hoverShadow:hover {	box-shadow: 1px 1px 8px #ddd;	}
	
	.hoverShadowText {	transition: all 0.5s;	}
	
	.hoverShadowText:hover {	text-shadow: -1px -1px #ddd;	}
	
	.cals {
		border: none;
		width: 143px;
		font-size: 16pt;
	}
	
	.searchTxt {
		width: 130px;
		height: 25px;
		border-radius: 5px;
		border: solid 1px #bfbfbf;
		margin-bottom: 10px;
	}
	
	.cals:hover {	cursor: pointer;	}

	/* 상단 시작 */
	.table {	display: inline-block;	}
	
	.category {
		display: inline-block;
		background-color: #E3F2FD;
		border-radius: 5px;
		width: 37px;
		height: 20px;
		font-size: 9pt;
		padding-top: 2px;
		text-align: center;		
	}
	
	.category:hover {	cursor: pointer;	}
	
	#title {
		width: 100%; 
		border-bottom: solid 1px #bfbfbf;
		padding-bottom: 10px;
		padding-right: 50px;
		text-align: right;		
	}
	
	.tblnames { width: 10%; padding-left: 10px; }	
	.times { width: 7%;	}	
	.timeShapes { width: 65%; }
	
	div.contents {	margin-top: 10px;	}
	
	/* 중앙 박스 시작 */	
	.infoBoxes {
		display: inline-block;
		background-color: #F9F9F9;
		border-radius: 5px;
	}
	
	#teamInfo {
		width: 25%;
		margin: 40px 20px 0 50px;
		padding: 20px 20px;
		vertical-align: top;
		
	}		
	
	#todayBtn {
		font-size: 9pt;
		text-decoration: none;
		margin-left: 10px;
	}
	
	#todayBtn:hover {
		text-decoration: underline;
		cursor: pointer;
	}
	
	
	.boxes {
		font-size: 10pt;
		margin-top: 5px;
	}
	
	#teamInfoTitle {	border-bottom: solid 1px gray;	}
	
	.tInfo_positions {
		display: inline-block;
		width: 50px;
		text-align: center;
		margin-right: 50px;		
	}
	
	.tInfo_names {
		display: inline-block;
	}
	
	.pplHover:hover {
		background-color: rgba(0, 0, 0, 0.1);
		cursor: pointer;
	}
	
	#personalInfo {
		width: 59%;
		margin: 40px 20px 0 20px;
		padding: 20px 40px;
	}
	
	.pInfo_titles {
		display: inline-block;
		width: 120px;
		margin-right: 250px;
	}
	
	.pInfo_contents {
		display: inline-block;
		width: 200px;
		text-align: right;		
	}
	
	/* 중앙 박스 끝 */	
	
	/* 하단 표 시작 */
	#workTable {	width: 97%;	}
	
	.tbltexts {
		text-align: center;
		padding: 5px 0;
	}
	
	.today{	color: #086BDE;	} /* 표에서 오늘에 해당하는 날짜는 파란색으로 */
	
	.tblBtn { /* 비고 */
		color: #086BDE;
		background-color: #E3F2FD;
		width: 50px;
		height: 25px;
		border-radius: 5px;
		border: none;
		font-size: 10pt;
	}
	
	.fridays{ border-bottom: solid 1px gray;}
	
	.bgcolor { background-color: rgba(0, 0, 0, 0.1); box-shadow: 1px 1px 8px #ddd; }

</style>   

<script>

	$(document).ready(function(){
		
		
		$(function(){
		    $('.cals').datepicker();
		})
		
		$.datepicker.setDefaults({
		  dateFormat: 'yy.mm.dd(D)',
		  prevText: '이전 달',
		  nextText: '다음 달',
		  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		  showMonthAfterYear: true,
		  yearSuffix: '년',
		  beforeShowDay: function(date){
				var day = date.getDay();
				return [(day != 0 && day != 6 && day != 2 && day != 3 && day != 4)];
			}
		});
		
		
		
		const now = new Date();
		const now2 = new Date();
		
		let year = now.getFullYear();
		let month = now.getMonth()+1;
		let date = now.getDate();		
		let day = parseInt(now.getDay());
				
/* 		let start = new Date(now.getFullYear(), now.getMonth(), 1);
		let startdate = start.getDate();
		if(startdate < 10){	startdate = '0'+startdate;	}
		start = start.getFullYear() + "." + (start.getMonth()+1) + "." + startdate + "(" + day_kor(start.getDay()) + ")"; */
		
		
		if(day != 1){ // 오늘이 월요일이 아니라면
			start = new Date(now.setDate( now.getDate()-(day-1) )); // 이번주의 월요일 구하기
			
			let startdate = start.getDate();
			if(startdate < 10){	startdate = '0'+startdate;	}
			
			start = start.getFullYear() + "." + (start.getMonth()+1) + "." + startdate + "(" + day_kor(start.getDay()) + ")";
			// console.log(start);
		}
		else{ // 오늘이 월요일 이라면
			start = year + "." + month + "." + date + "(" + day_kor(day) + ")";
		}
		
		
		let end;
		
		if(day != 5){ // 오늘이 금요일이 아니라면	
			end = new Date(now2.setDate(now2.getDate()+(5-day))); // 이번주의 금요일 구하기
			
			let enddate = end.getDate();
			if(enddate < 10){	enddate = '0'+enddate;	}
			
			end = end.getFullYear() + "." + (end.getMonth()+1) + "." + enddate + "(" + day_kor(end.getDay()) + ")";
			// console.log(endDate);
		}
		else { // 오늘이 금요일 이라면
			end = year + "." + month + "." + date + "(" + day_kor(day) + ")";
		}
		
		$('input#dateStart').val(start);
		$('input#dateEnd').val(end);
		
		$('input#dateStart').datepicker('setDate', start);
		$('input#dateEnd').datepicker('setDate', end);
		
		/*
		$("#prevWeek").click(function(){
			
			
			let startVal = $('input#dateStart').val().substr(0,10);
			let endVal = $('input#dateEnd').val().substr(0,10);
						
			let newStart = new Date(startVal);
			newStart = new Date(newStart.setDate(newStart.getDate()-7));
			
			newStart = newStart.getFullYear() + "." + (newStart.getMonth()+1) + "." + newStart.getDate() + "(" + day_kor(newStart.getDay()) + ")";
			
			
			let newEnd = new Date(endVal);
			newEnd = new Date(newEnd.setDate(newEnd.getDate()-7));
			
			newEnd = newEnd.getFullYear() + "." + (newEnd.getMonth()+1) + "." + newEnd.getDate() + "(" + day_kor(newEnd.getDay()) + ")";
					
			$('input#dateStart').val(newStart);
			$('input#dateEnd').val(newEnd);
			
			$('input#dateStart').datepicker('setDate', newStart);
			$('input#dateEnd').datepicker('setDate', newEnd);
			
			getWeeklyWorkList();
			personalInfoBox();
		}); // end of $("#prevWeek").click() -------------------------
		
		$("#nextWeek").click(function(){
			
			let startVal = $('input#dateStart').val();
			
			if(start != startVal){
				
				startVal = startVal.substr(0,10);
				let endVal = $('input#dateEnd').val().substr(0,10);
									
				let newStart = new Date(startVal);
				newStart = new Date(newStart.setDate(newStart.getDate()+7));
				
				newStart = newStart.getFullYear() + "." + (newStart.getMonth()+1) + "." + newStart.getDate() + "(" + day_kor(newStart.getDay()) + ")";
				
				
				let newEnd = new Date(endVal);
				newEnd = new Date(newEnd.setDate(newEnd.getDate()+7));
				
				newEnd = newEnd.getFullYear() + "." + (newEnd.getMonth()+1) + "." + newEnd.getDate() + "(" + day_kor(newEnd.getDay()) + ")";
						
				$('input#dateStart').val(newStart);
				$('input#dateEnd').val(newEnd);
				
				$('input#dateStart').datepicker('setDate', newStart);
				$('input#dateEnd').datepicker('setDate', newEnd);
				
				getWeeklyWorkList();
				personalInfoBox();
			}
			
		}); // end of $("#prevWeek").click() -------------------------
		*/
		
		
		$("#dateStart").change(function(){
			const empno = $("#personalEmpno").val();
			
			personalInfoBox(empno);			
			getWeeklyWorkList(empno);
			
		});
		
		$("#dateEnd").change(function(){
			const empno = $("#personalEmpno").val();
			
			personalInfoBox(empno);			
			getWeeklyWorkList(empno);
			
			
		});
		
		$("#departments").change(function(){
			
			const department = $("#departments option:selected").val();
			// console.log("department: "+department);
			
			teamInfoBox();
			
		});
		
		const child = $("#boxTeamInfo").children('div:eq(0)');
		console.log(child.attr('id'));
		
		// ================================================================================================== // 
		
		const empno = "${sessionScope.loginuser.empno}";
		
		const bumun = "${sessionScope.loginuser.bumun}";
		const department = "${sessionScope.loginuser.department}";
		// 개인정보 박스 조회
		
		
		
		teamInfoBox();
		personalInfoBox(empno);
		
		getWeeklyWorkList(empno);
			
		
		
		
		
	}); // end of $(document).ready() ===============================================
	
	function day_kor(day){
		switch (day) {
		
		case 1:
			result = "월"	
			break;
		case 2:
			result = "화"
			break;
		case 3:
			result = "수"
			break;
		case 4:
			result = "목"
			break;
		case 5:
			result = "금"
			break;
			
		} // end of switch
		
		return result;
	}
	
	// 팀정보 박스 조회
	function teamInfoBox(){
		
		const empno = "${sessionScope.loginuser.empno}";
		const department = $("#departments option:selected").val();
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getTeamInfoBox.on",
			  data:{"empno":empno,
				    "department":department},
			  dataType:"JSON",
			  success:function(json){				  
				  let html = "";
				  
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  
						  html += "<div id='bg"+item.empno+"' class='pplHover' onclick='goDptPplInfo("+item.empno+")'>"+
									"<span class='boxes tInfo_positions'>"+item.position+"</span>"+
									"<span class='boxes tInfo_names'>"+item.name+"</span>"+
								"</div>";
						  
					  });
					  
					  $("#boxTeamInfo").html(html);
					  
					  $("#bg"+empno).addClass('bgcolor');
				  }
				  else {
					  // console.log('ㅅㅓㅇ공');
				  }
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		
		
	} // end of function teamInfoBox(){} ----------------------------
	
	
	// 개인정보 박스 조회
	function personalInfoBox(empno){		
		
		const dateStart = $("#dateStart").val().substr(0,10);
		const dateEnd = $("#dateEnd").val().substr(0,10);
		
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getPersonalInfoBox.on",
			  data:{"empno":empno,
				    "dateStart":dateStart,
				    "dateEnd":dateEnd},
			  dataType:"JSON",
			  success:function(json){
				  
				  const name = json.PersonalInfoMap.name;
				  const department = json.PersonalInfoMap.department;
				  const position = json.PersonalInfoMap.position;
				  const empimg = json.PersonalInfoMap.empimg;
				  const worksum = json.PersonalInfoMap.worksum;
				  const fk_empno = json.PersonalInfoMap.fk_empno;
				  				  
				  $("#name").text(name);
				  $("#department").text(department);
				  $("#position").text(position);
				  $("#worksum").text(worksum);
				  // console.log("worksum: "+worksum);
				  $("#period").text($("#dateStart").val() + ' ~ ' + $("#dateEnd").val());
				  $("#personalEmpno").val(fk_empno);
				  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		
	} // end of function personalInfoBox(){} -------------------------
	
	
	function getWeeklyWorkList(empno){ // -----------------------------------
		
		const dateStart = $("#dateStart").val().substr(0,10);
		const dateEnd = $("#dateEnd").val().substr(0,10);
		

		// console.log("datestart: "+$("#dateStart").val());
		// console.log("dateend: "+$("#dateEnd").val());
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getWeeklyWorkList.on",
			  data:{"empno":empno,
				    "dateStart":dateStart,
				    "dateEnd":dateEnd},
			  dataType:"JSON",
			  success:function(json){
				  let html = "";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  						  
						  let workstart = item.workstart;					  

						  // console.log("workstart: "+workstart);						  
						  
						  let date = item.workstart.substr(0, 10);
						  let starttime = item.workstart.substr(11, 5);
						  let day = item.workstart.substr(17, 1);
						  
						  if(day == '금'){
							  html += "<tr>"+
								"<td class='fridays' style='padding: 5px 0 5px 10px;'>"+date+"</td>"+
								"<td class='fridays' style='padding: 5px 0;'>"+day+"</td>"+
								"<td class='tbltexts fridays'>"+item.worksum+"</td>"+
								"<td class='tbltexts fridays'>"+starttime+"</td>"+
								"<td class='tbltexts fridays'>"+item.workend+"</td>"+
								"<td class='tbltexts fridays'>01:00</td>"+	
								"<td class='tbltexts fridays'>"+item.extendtime+"</td>"+
								"<td class='fridays' style='padding: 5px 0;'>"+item.dayoff+item.trip+item.tripstart+item.tripend+"</td>"+			
							"</tr>";
							  
						  }
						  else{
							  html += "<tr>"+
								"<td style='padding: 5px 0 5px 10px;'>"+date+"</td>"+
								"<td style='padding: 5px 0;'>"+day+"</td>"+
								"<td class='tbltexts'>"+item.worksum+"</td>"+
								"<td class='tbltexts'>"+starttime+"</td>"+
								"<td class='tbltexts'>"+item.workend+"</td>"+
								"<td class='tbltexts'>01:00</td>"+	
								"<td class='tbltexts'>"+item.extendtime+"</td>"+
								"<td style='padding: 5px 0;'>"+item.dayoff+item.trip+item.tripstart+item.tripend+"</td>"+			
							"</tr>";
							  
						  }
						  
														
					  });					  
					  
					  $("tbody#weeklyWorkList").html(html);
				  }
				  else {
				  }
				  
				  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		});
		
	} // end of function getWeeklyWorkList(){} -------------------------
	
	
	function goDptPplInfo(empno){ // ------------------------------------
		
		// console.log(empno);
		
		$(".pplHover").removeClass('bgcolor');
		$("#bg"+empno).addClass('bgcolor');
		personalInfoBox(empno);
		
		getWeeklyWorkList(empno);
		
		
	} // end of function goDptPplInfo(empno){} --------------------------
	
	

</script>
<div style='margin: 1% 0 5% 1%'>
	<h4>전사 근태조회</h4>
</div>

<div style="font-size: 16pt; text-align: center; margin-bottom: 30px;">
	<span id="prevWeek" class="fas fa-angle-left" style="color: #bfbfbf; font-size: 14pt;"></span>
	<input id="dateStart" class="cals hoverShadowText" type="text" onfocus="this.blur()"/> ~ 
	<input id="dateEnd" class="cals hoverShadowText" type="text" onfocus="this.blur()"/>
	<span id="nextWeek" class="fas fa-angle-right" style="color: #bfbfbf; font-size: 14pt;"></span>
</div>

<div>
	
	<%-- 중앙 박스 시작 --%>
	
	<div style="">
		<div class="infoBoxes" id="teamInfo">
			<div id="titleDepartment">
				<select name='departments' id='departments' class="searchTxt" style="font-size: 10pt; ">
					<c:forEach items="${departList}" var="depart" >
						<option value='${depart.department}'>${depart.department}</option>
					</c:forEach>
				</select>
			</div>
				
			<div id="teamInfoTitle" style="">
				<span class="boxes tInfo_positions">직급</span>
				<span class="boxes tInfo_names">이름</span>
			</div>
			<div id="boxTeamInfo">
			</div>
		</div>
		
		<div class="infoBoxes" id="personalInfo">
			<div id="name" style="font-size: 14pt; margin-bottom: 10px;"></div>
			<input id="personalEmpno" type="hidden" />
			<div>
				<span class="boxes pInfo_titles">부서</span>
				<span id="department" class="boxes pInfo_contents"></span>
			</div>
			<div>
				<span class="boxes pInfo_titles">직급</span>
				<span id="position" class="boxes pInfo_contents"></span>
			</div>
			<div>
				<span class="boxes pInfo_titles">기간</span>
				<span id="period" class="boxes pInfo_contents"></span>
			</div>
			<div>
				<span class="boxes pInfo_titles">누적 근무시간</span>
				<span id="worksum" class="boxes pInfo_contents"></span>
			</div>
			<div>
				<span class="boxes pInfo_titles">예상 근무시간</span>
				<span class="boxes pInfo_contents">40시간</span>
			</div>
			<div>
				<span class="boxes pInfo_titles">최대 근무가능시간</span>
				<span class="boxes pInfo_contents">52시간</span>
			</div>
		</div>
	</div>
	
	<%-- 중앙 박스 끝 --%>
	
	<%-- 하단 테이블 시작 --%>
	<div style="margin: 5% 5%;">
		<table style="font-size: 10pt;" id="workTable">
			<thead>
				<tr style="border-bottom: solid 1px #bfbfbf;">
					<th style="width: 12%; padding-left: 10px; padding: 5px 0 5px 10px;">일자</th>
					<th class="" style="width: 8%; padding: 5px 0;">요일</th>
					<th class="tbltexts" style="width: 8%;">총근무시간</th>
					<th class="tbltexts" style="width: 8%;">출근시간</th>
					<th class="tbltexts" style="width: 8%;">퇴근시간</th>
					<th class="tbltexts" style="width: 8%;">휴게시간</th>
					<th class="tbltexts" style="width: 12%;">연장근무시간</th>
					<th style="padding: 5px 0;">비고</th>
				</tr>
			</thead>
			<tbody id="weeklyWorkList"> 	
											
			</tbody>
		</table>
	</div>
	
	
</div>
