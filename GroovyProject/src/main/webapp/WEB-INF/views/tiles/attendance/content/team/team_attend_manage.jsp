<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<style>

	.hoverShadow {	transition: all 0.5s;	}
	
	.hoverShadow:hover {	box-shadow: 1px 1px 8px #ddd;	}
	
	.hoverShadowText {	transition: all 0.5s;	}
	
	.hoverShadowText:hover {	text-shadow: -1px -1px #ddd;	}
	
	.cals {
		border: none;
		width: 140px;
		font-size: 16pt;
	}
	
	.cals:hover {	cursor: pointer;	}
	
	/* 상단 박스 시작 */	
	#workBox {
		border: solid 1px #bfbfbf;
		width: 80%;
		height: 150px;
		margin: 0 auto;
		padding: 35px 60px;
		border-radius: 5px;
	}
	
	.timeBoxes {
		display: inline-block;
		width: 130px;
		margin-right: 20px;
	}
	
	.timeBoxes_1 {
		font-size: 11pt;
		text-align: center;
		margin-bottom: 15px;
	}
	
	.timeBoxes_2 {
		font-size: 18pt;
		text-align: center;
		color: #086BDE;
	}
	
	#calMonth {
		width: 100px;
		font-size: 16pt;		
		text-align: center;
		border: none;
	} 
	
	#calMonth:hover {	cursor: pointer;	}
	
	/* 상단 박스 끝 */
	
	/* 상세검색 시작 */
	#searchBox {
		width: 90%;
		margin: 0 auto;
		padding: 50px 0;
	}
	
	#searchSelect {
		width: 100px;
		height: 25px;
		border-radius: 5px;
		border: solid 1px #bfbfbf;
		
	}
		
	#searchText {	display: inline-block;	}
	
	.searchTxt {
		width: 130px;
		height: 25px;
		border-radius: 5px;
		border: solid 1px #bfbfbf;
	}
	
	
	.searchBtn {
		border: none;
		border-radius: 5px;
		height: 25px;
	}
	
	#searchCalBox {	display: inline-block;	}
	
	.searchCal {
		width: 100px;
		height: 25px;
		border-radius: 5px;
		border: solid 1px #bfbfbf;
		text-align: center;
	}
	
	/* 상세검색 끝 */
	
	#filter {
		font-size: 10pt; 
		float: right; 
		margin-right: 4%;
	}
	
	#filter:hover {	cursor: pointer;	}
	
	/* 하단 표 시작 */
	#workTable {	width: 97%;	}
	
	#workTable:hover {	cursor: pointer;	}
	
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
	/* 하단 표 끝 */

	/* 모달 */
	#filterModal {		
		
	}
	.modals-fullsize {
    	width: 500px; 
		height: 320px; 
		padding: 5% 0 5% 5%;
    }
    
    .modal { 
 		top : 30%; 
 		z-index: 1050;
	}
	
	.labels {
		font-size: 10pt;
		font-weight: normal;
		position: relative;
		top: -1.5px;
		width: 100px;
	}
	
	.filterBtns {
		width: 80px;
		border: none;
		border-radius: 5px;
		font-size: 11pt;
		height: 30px;
	}
		

</style>

<script> 

	$(document).ready(function(){
		
		$("#searchText").hide();
		
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
		
				
		let start;
		let end;		
		
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
		
		$('input#startTime').val(start);
		$('input#endTime').val(end);
		
		$('input#dateStart').datepicker('setDate', start);
		$('input#dateEnd').datepicker('setDate', end);
		
		
		
		
		
		$("#searchSelect").change(function(){
			const selectVal = $("#searchSelect option:selected").val();
			// console.log(selectVal);
			
			$("#searchText").hide();
				
			if(selectVal == "name"){
				$("#searchText").show();
			}
			else if(selectVal == "date"){
				$("#searchText").hide();
			}			
			
		}); // end of $("#searchSelect").change() --------------------
		
		$("#searchInput").keyup(function(){
			// console.log("ff");
		}); // end of $("#searchInput").keyup() ----------------------
		
		
		/*
		$("#prevMonth").click(function(){ // ------------------------------------
			
			let monthVal = $("#calMonth").val();
			monthVal = new Date(monthVal.substr(0,4), parseInt(monthVal.substr(5,2))-2);
			// console.log(monthVal);
			
			let newMonth;
			if( parseInt(monthVal.getMonth())+1 <10 ){
				newMonth = monthVal.getFullYear()+"-0"+(parseInt(monthVal.getMonth())+1);
			}
			else {
				newMonth = monthVal.getFullYear()+"-"+(parseInt(monthVal.getMonth())+1);
			}
			
			$("#calMonth").val(newMonth);
			
		}); // end of $("#prevMonth").click() -----------------------------------
		
		$("#nextMonth").click(function(){ // ------------------------------------
			let monthVal = $("#calMonth").val();
			if(thisMonth != monthVal){			
				monthVal = new Date(monthVal.substr(0,4), parseInt(monthVal.substr(5,2)));
				// console.log(monthVal);
				
				let newMonth;
				if( parseInt(monthVal.getMonth())+1 <10 ){
					newMonth = monthVal.getFullYear()+"-0"+(parseInt(monthVal.getMonth())+1);
				}
				else {
					newMonth = monthVal.getFullYear()+"-"+(parseInt(monthVal.getMonth())+1);
				}
				
				$("#calMonth").val(newMonth);
			}
		}); // end of $("#nextMonth").click() ------------------------------------
		*/
		
		$("#dateStart").change(function(){ // --------------------------
			const val = $("#dateStart").val();
			$('input#startTime').val(val);
			
			getBoxInfo();			
		}); // end of $("#dateStart").change() -------------------------
		
		$("#dateEnd").change(function(){ // --------------------------
			const val = $("#dateEnd").val();
			$('input#endTime').val(val);
		
			getBoxInfo();			
		}); // end of $("#dateEnd").change() -------------------------
		
		
		getBoxInfo();
		
		const sval = $("#dateStart").val().substr(0,10);
		$('input#filterStartTime').val(sval);
		
		const eval = $("#dateEnd").val().substr(0,10);
		$('input#filterEndTime').val(eval);
		
		$('input#filterDepartment').val("${sessionScope.loginuser.department}");
		
		$("#filterSearchBtn").click(function(){
			
			alert("start: "+ $('input#filterStartTime').val());
			alert("end: "+ $('input#filterEndTime').val());
			alert("de: "+ $('input#filterDepartment').val());
			
			// 폼(form)을 전송(submit)
	        const frm = document.filterSearchFrm;
	        frm.method = "get";
	        frm.action = "<%= ctxPath%>/attend/getTeamSearchList.on";
	        frm.submit();		
			
		});
		
	}); // end of $(document).ready() ===========================================================
	
		
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
	
	
	function getBoxInfo(){ // -----------------------------------------------
		
		const department = "${sessionScope.loginuser.department}";		
		const dateStart = $("#dateStart").val().substr(0,10);
		const dateEnd = $("#dateEnd").val().substr(0,10);
		
		console.log("department: "+department);
		console.log("dateStart: "+dateStart);
		console.log("dateEnd: "+dateEnd);
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getBoxInfo.on",
			  data:{"department":department,
				    "dateStart":dateStart,
				    "dateEnd":dateEnd},
			  dataType:"JSON",
			  success:function(json){
				  
				  const cntstartnochk = json.boxInfoMap.cntstartnochk;
				  const cntendnochk = json.boxInfoMap.cntendnochk;
				  const cntabsent = json.boxInfoMap.cntabsent;
				  const cntdayoff = json.boxInfoMap.cntdayoff;
				  const sumextend = json.boxInfoMap.sumextend;
				  				  
				  $("#cntstartnochk").text(cntstartnochk);
				  $("#cntendnochk").text(cntendnochk);
				  $("#cntabsent").text(cntabsent);
				  $("#cntdayoff").text(cntdayoff);
				  $("#sumextend").text(sumextend);
				  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		
	} // end of function getBoxInfo() ---------------------------------------

</script>

<div style="font-size: 18pt; margin: 40px 0 50px 30px;" >부서 근태관리</div>

<div style="font-size: 18pt; text-align: center; margin-bottom: 20px;">
	<span class="fas fa-angle-left" id="prevMonth" style="color: #bfbfbf; font-size: 14pt;"></span>
	<input id="dateStart" class="cals hoverShadowText" type="text" onfocus="this.blur()"/> ~ 
	<input id="dateEnd" class="cals hoverShadowText" type="text" onfocus="this.blur()"/>
	<span class="fas fa-angle-right" id="nextMonth" style="color: #bfbfbf; font-size: 14pt;"></span>
</div>

<div> <%-- 상단 박스 시작 --%>
	<div id="workBox">     
		<div class="timeBoxes" style="">
			<div class="timeBoxes_1">출근 미체크</div>
			<div id="cntstartnochk" class="timeBoxes_2" style="color: #bfbfbf;"></div>
		</div>
		<div class="timeBoxes"style="margin-right: 40px; padding-right: 30px; border-right: solid 1px #bfbfbf;">
			<div class="timeBoxes_1">퇴근 미체크</div>
			<div id="cntendnochk" class="timeBoxes_2" style="color: #bfbfbf;"></div>
		</div>
		<div class="timeBoxes" style="">
			<div class="timeBoxes_1">무단결근</div>
			<div id="cntabsent" class="timeBoxes_2"></div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">연차</div>
			<div id="cntdayoff" class="timeBoxes_2"></div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">연장근무</div>
			<div id="sumextend" class="timeBoxes_2"></div>
		</div>
	</div>
</div> <%-- 상단 박스 끝 --%>

<div id="searchBox"> <%-- 상세검색 시작 --%>
	<form>
		<span style="font-size: 14pt; margin: 0 10px 10px 0; ">상세검색</span>
		<select name="searchDetail" id="searchSelect" class="hoverShadow">
			<option>전체</option>
			<option value="name">부서원</option>
			<option value="date">날짜</option>
		</select>	
	
		<div id="searchText">		
			<input id="searchInput" class="searchTxt hoverShadow" type="text" placeholder="">
			<button class="searchBtn hoverShadow" type="button"><i class="fas fa-search" style="color:gray;"></i></button>		
		</div>				
	</form>
</div> <%-- 상세검색 끝 --%>



<div style="margin: 5% 5%;"> <%-- 하단 테이블 시작 --%>
	<span style="font-size: 10pt; margin: 0 0 3px 5px; ">44개의 데이터가 있습니다.</span>
	<span id="filter" data-toggle="modal" data-target="#filterModal"><i class="fas fa-bars hoverShadowText"></i>&nbsp;목록 관리</span>
	<div style="clear: both;"></div>
	<table style="font-size: 10pt;" class="table-hover" id="workTable">
		<thead>
			<tr style="border-bottom: solid 1px #bfbfbf; border-top: solid 1px #bfbfbf;">
				<th style="width: 12%; padding-left: 30px;">부서원</th>
				<th class="tbltexts" style="width: 12%;">부서명</th>
				<th class="tbltexts" style="width: 16%;">날짜<i class="fas fa-sort-alt"></i></th>
				<th class="tbltexts" style="width: 12%;">출근</th>
				<th class="tbltexts" style="width: 12%;">퇴근</th>
				<th class="tbltexts" style="width: 10%;">연차</th>
				<th class="tbltexts" style="width: 10%">외근</th>
				<th class="tbltexts" style="width: 10%">연장근무</th>
				<th class="" style="width: 6%;"></th> <%-- 빈칸 --%>
			</tr>
		</thead>
		<tbody> 
			<c:forEach var="teamList" items="${requestScope.teamSearchList}" varStatus="status">
				<tr>
					<td style="padding-left: 30px;">${requestScope.teamSearchList.name}</td>
					<td class="tbltexts" style="">${requestScope.teamSearchList.department}</td>
					<td class="tbltexts" style="">${requestScope.teamSearchList.workdate}</td>
					<td class="tbltexts" style="">${requestScope.teamSearchList.workstart}</td>
					<td class="tbltexts" style="">${requestScope.teamSearchList.workend}</td>
					<td class="tbltexts" style="">${requestScope.teamSearchList.dayoff}</td>		
					<td class="tbltexts" style="">${requestScope.teamSearchList.trip}</td>
					<td class="tbltexts" style="">${requestScope.teamSearchList.extend}</td>	
					<td class="tbltexts" style=""></td> <%-- 빈칸 --%>		
				</tr>					
			</c:forEach>	
		</tbody>
	</table>
	
	<%-- === 페이지바 보여주기 === --%>
	<div align="center" style="width: 70%; margin:20px auto;">
		${requestScope.pageBar}
	</div>
		
</div> <%-- 하단 테이블 끝 --%>



<div class="modal" id="filterModal">
	<div class="modal-dialog">
		<div class="modal-content modals-fullsize">
			<div>				
				<div style="font-size: 14pt; margin-bottom: 15px;">목록 관리</div>
				<form name="filterSearchFrm">
					<div>
						<input id="filterDepartment" name="filterDepartment" type="hidden">
						<input id="filterStartTime" name="filterStartTime" type="hidden">
						<input id="filterEndTime" name="filterEndTime" type="hidden">
						<input id="name" name="filterName" class="searchTxt hoverShadow" type="text" placeholder="부서원명">
						<input type="checkbox" name="filter" id="noStartCheck" value="noStartCheck"><label for="noStartCheck" class="labels">출근 미체크</label>
						<span class="labels">출근(업무)체크가 이루어지지 않은 경우(연차 제외)</span><br>
						<input type="checkbox" name="filter" id="noEndCheck" value="noEndCheck"><label for="noEndCheck" class="labels">퇴근 미체크</label>
						<span class="labels">퇴근(업무종료)체크가 이루어지지 않은 경우(연차 제외)</span><br>
						<input type="checkbox" name="filter" id="absent" value="absent"><label for="absent" class="labels">결근</label>
						<span class="labels">연차 등록 없이 출,퇴근 미체크로 결근처리가 된 경우</span><br>
						<input type="checkbox" name="filter" id="dayoff" value="dayoff"><label for="dayoff" class="labels">연차</label>
						<span class="labels">1일 연차 등 휴가를 사용한 경우</span><br>
						<input type="checkbox" name="filter" id="extend" value="extend"><label for="extend" class="labels">연장근무</label>
						<span class="labels">기본 근무시간(36시간)을 초과하여 업무를 수행한 경우</span><br>
					</div>
				</form>
				<div style="margin: 20px 120px 30px 120px;">
					<button id="filterSearchBtn" class="filterBtns hoverShadow" type="submit" style="background-color: #E3F2FD;">검색</button>
					<button id="filterCancelBtn" class="filterBtns hoverShadow" type="button">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>


