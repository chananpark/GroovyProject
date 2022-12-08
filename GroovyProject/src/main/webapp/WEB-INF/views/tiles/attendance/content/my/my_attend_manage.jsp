<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>  

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
	
	#workBox {
		border: solid 1px #bfbfbf;
		width: 80%;
		height: 150px;
		margin: 0 auto;
		padding-left: 30px;
		padding-top: 20px;
		border-radius: 5px;
	}
	
	.timeBoxes {
		display: inline-block;
		width: 110px;
		margin-right: 30px;
		margin-top: 15px;
		padding-right: 30px;
	}
	
	.timeBoxes_1 {
		font-size: 11pt;
		text-align: center;		
		margin-bottom: 10px;
	}
	
	.timeBoxes_2 {
		color: #086BDE;
		font-size: 18pt;
		text-align: center;
	}
	
	.dates { width: 140px; font-size: 15pt;}
	
		
	/* 박스 끝 */
	
	/* 테이블 시작 */	
	.table-hover:hover {	cursor: pointer;	}
	
	.tables { font-size: 10pt; }
	
	.widths {
		width: 90%; 
		margin: 0 auto;
		padding-top: 50px;
	}
	
	.titles {
		margin: 20px 0 0 10px;
		font-size: 12pt;
	}
	
	.showMore {
		font-size: 9pt;
		text-decoration: underline;
		text-align: center;
		margin: 20px 0;
	}
	
	.showMore:hover {	text-decoration: underline;	}
	
	.trash {
		color: gray; 
		text-align: left;
	}
	
	/* 테이블 끝 */

</style>   

<script src="https://kit.fontawesome.com/48fed31cce.js" crossorigin="anonymous"></script>
<script>

	$(document).ready(function(){
		
		
			
		$("#dateStart").change(function(){
		
			getRequestList();			
			getUsedAttendList();			
			getBoxAttend();
			
		}); // end of $("#dateStart").change() ---------------------------------------
		
		$("#dateEnd").change(function(){ // ---------------------------------------
			let startVal = $("#dateStart").val();
			let endVal = $("#dateEnd").val();
			startVal = startVal.substr(0,4)+startVal.substr(5,2)+startVal.substr(8,2);
			endVal = endVal.substr(0,4)+endVal.substr(5,2)+endVal.substr(8,2);
			// console.log(startVal);
			
			if(startVal > endVal){
				alert("검색 종료일이 검색 시작일보다 빠를 수 없습니다.");
				$('#dateEnd').datepicker({
				    format : "yyyy-mm-dd",
				    // endDate : "infinity",
				    autoclose : true, 
				    todayHighlight :true,  // 오늘을 표시해줄지. default 가 false
				}).datepicker("setDate", new Date());
				
				return;
			}
			
			getRequestList();
			
			getUsedAttendList();
			
			getBoxAttend();
		
		}); // end of $("#dateEnd").change() ---------------------------------------
		
		$(function(){
		    $('.cals').datepicker();
		})
		
		$.datepicker.setDefaults({
		  dateFormat: 'yy.mm.dd(D)',
		  maxDate: 30,
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
				return [(day != 0 && day != 6)];
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
		
		$('input#dateStart').datepicker('setDate', start);
		$('input#dateEnd').datepicker('setDate', end);
		
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
			
			getRequestList();			
			getUsedAttendList();			
			getBoxAttend();
			
		}); // end of $("#prevWeek").click() -------------------------
		
		$("#nextWeek").click(function(){
			
			let startVal = $('input#dateStart').val().substr(0,10);
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
			
			getRequestList();			
			getUsedAttendList();			
			getBoxAttend();
		}); // end of $("#prevWeek").click() -------------------------
		
		getRequestList();		
		getUsedAttendList();		
		getBoxAttend();
		
	}); // end of $(document).ready() ==============================================
	
	
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
	
	
	function getBoxAttend(){
		
		const empno = "${sessionScope.loginuser.empno}";
		
		const dateStart = $("#dateStart").val().substr(0,10);
		const dateEnd = $("#dateEnd").val().substr(0,10);
		
		console.log(dateStart);
		console.log(dateEnd);
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getBoxAttend.on",
			  data:{"empno":empno,
				  	"dateStart":dateStart,
				    "dateEnd":dateEnd},
			  dataType:"JSON",
			  success:function(json){
				  const worktime = json.boxAttendMap.worktime;
				  const triptime = json.boxAttendMap.triptime;
				  const extendtime = json.boxAttendMap.extendtime;
				  const dayoffcnt = json.boxAttendMap.dayoffcnt;
				  
				  
				  $("#worktime").text(worktime);
				  $("#triptime").text(triptime);
				  $("#extendtime").text(extendtime);
				  $("#dayoffcnt").text(dayoffcnt);
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		
	}
	
	
	// 근태 신청내역 조회
	function getRequestList(){ // -----------------------------------------------
		
		const dateStart = $("#dateStart").val().substr(0,10);
		const dateEnd = $("#dateEnd").val().substr(0,10);
		
		const empno = "${sessionScope.loginuser.empno}";	
		const name = "${sessionScope.loginuser.name}";
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getRequestList.on",
			  data:{"empno":empno,
				    "dateStart":dateStart,
				    "dateEnd":dateEnd},
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  
						  let attend_index = item.attend_index;
						  
						  switch (attend_index) {
							
							case 'dayoff':
								attend_index = "연차"	
								break;
							case 'trip':
								attend_index = "외근"
								break;
							case 'extend':
								attend_index = "연장근무"
								break;								
							} // end of switch
						  
										  
						  html += "<tr style='height: 30px; padding-top: 10px;'>"+
									"<td style='text-align: left; padding-left: 30px;'>"+name+"</td>"+
									"<td style='text-align: left;'>경영지원</td>"+
									"<td style='text-align: left;'>"+attend_index+"</td>";
									
									if(attend_index == "연차"){
										html += "<td style='text-align: left;'>"+item.starttime.substr(0,10)+"</td>";
									}
									else{
										html += "<td style='text-align: left;'>"+item.starttime+" ~ "+item.endtime+"</td>";
									}
									
								html += "<td style='text-align: left;'>"+item.registerdate+"</td>"+
									"<td style='text-align: left;'>"+item.place+"</td>"+
									"<td style='text-align: left;'><i class='fas fa-trash-alt hoverShadowText trash' onclick='deleteRequest("+item.requestid+")'></i></td>"+
								  "</tr>";
														
					  });					  
					  
					  $("tbody#requestList").html(html);
				  }
				  else {
				  }
				  
				  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		});
		
	} // end of function getRequestList() ---------------------------------------
	
	
	
	
	// 근태 사용내역 조회
	function getUsedAttendList(){ // -----------------------------------------------
		
		const dateStart = $("#dateStart").val().substr(0,10);
		const dateEnd = $("#dateEnd").val().substr(0,10);
		
		const empno = "${sessionScope.loginuser.empno}";	
		const name = "${sessionScope.loginuser.name}";
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getUsedAttendList.on",
			  data:{"empno":empno,
				    "dateStart":dateStart,
				    "dateEnd":dateEnd},
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  
						  let attend_index = item.attend_index;
						  
						  switch (attend_index) {
							
							case 'dayoff':
								attend_index = "연차"	
								break;
							case 'trip':
								attend_index = "외근"
								break;
							case 'extend':
								attend_index = "연장근무"
								break;								
							} // end of switch
						  
										  
						  html += "<tr style='height: 30px; padding-top: 10px;'>"+
									"<td style='text-align: left; padding-left: 30px;'>"+name+"</td>"+
									"<td style='text-align: left;'>경영지원</td>"+
									"<td style='text-align: left;'>"+attend_index+"</td>"+
									"<td style='text-align: left;'>"+item.starttime+" ~ "+item.endtime+"</td>"+
									"<td style='text-align: left;'>"+item.registerdate+"</td>"+
									"<td style='text-align: left;'>"+item.place+"</td>"+
									"<td style='text-align: left;'><input class='requestid' type='hidden' value='"+item.requestid+"' /><i class='fas fa-trash-alt hoverShadowText trash'></i></td>"+		
								  "</tr>";
														
					  });					  
					  
					  $("tbody#usedAttendList").html(html);
				  }
				  else {
				  }
				  
				  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		});
		
	} // end of function getRequestList() ---------------------------------------
	
	
	function deleteRequest(requestid){
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/deleteRequest.on",
			  data:{"requestid":requestid},
			  dataType:"JSON",
			  success:function(json){
					  
					  alert("신청이 취소되었습니다.");
					  location.reload();
				
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		
	}
	
</script>

<div style="font-size: 18pt; margin: 40px 0 50px 30px;" >근태 관리</div>

<div style="font-size: 16pt; text-align: center; margin-bottom: 30px;">
	<span id="prevWeek" class="fas fa-angle-left hoverShadowText" style="color: #bfbfbf; font-size: 14pt;"></span>
	<input id="dateStart" class="dates cals hoverShadowText" type="text" onfocus="this.blur()"/> ~ 
	<input id="dateEnd" class="dates cals hoverShadowText" type="text" onfocus="this.blur()"/>
	<span id="nextWeek" class="fas fa-angle-right hoverShadowText" style="color: #bfbfbf; font-size: 14pt;"></span>
</div>



<div>
	<div id="workBox">
		<div class="timeBoxes" style="border-right: solid 1px #bfbfbf; width: 170px;">
			<div class="timeBoxes_1" style="padding-bottom: 5px;">누적 근무시간</div>
			<div class="timeBoxes_2" id="worktime">0</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">사용연차</div>
			<div class="timeBoxes_2" id="dayoffcnt">0</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">외근</div>
			<div class="timeBoxes_2" id="triptime">0</div>
		</div>
		<div class="timeBoxes" style="border-right: solid 1px #bfbfbf;">
			<div class="timeBoxes_1">연장근무</div>
			<div class="timeBoxes_2" id="extendtime">0</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">발생연차</div>
			<div class="timeBoxes_2" style="color: #b3b3b3;">0</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">잔여연차</div>
			<div class="timeBoxes_2" style="color: #b3b3b3;">0</div>
		</div>
	</div>
</div>


<div id="requestInfo" class="widths" style="">
	<div class="titles">&nbsp;신청내역</div>
	<hr>
	<div>
		<table class="table-hover tables" style="width: 100%;" id="requestTbl">
			<thead>
				<tr style="height: 30px; border-bottom: solid 1px #f2f2f2;">
					<th style="width:13%; padding: 0 0 10px 30px;">이름</th>
					<th style="width:13%; padding-bottom: 10px;">부서명</th>
					<th style="width:13%; padding-bottom: 10px;">종류</th>
					<th style="padding-bottom: 10px;">사용기간</th>
					<th style="width:10%; padding-bottom: 10px;">신청일자</th>
					<th style="width:20%; padding-bottom: 10px;">상세</th>
					<th style="width:5%; padding-bottom: 10px;"></th>
				</tr>
			</thead>
			<tbody id="requestList"> 												
			</tbody>
		</table>
	</div>
	<%-- <div class="showMore hoverShadowText">더보기</div>  --%>
</div>


<div id="usedInfo" class="widths">
	<div class="titles">&nbsp;사용내역</div>
	<hr>
	<div>
		<table class="tables" style="width: 100%;" id="requestTbl">
			<thead>
				<tr style="height: 30px; border-bottom: solid 1px #f2f2f2;">
					<th style="width:13%; padding: 0 0 10px 30px;">이름</th>
					<th style="width:13%; padding-bottom: 10px;">부서명</th>
					<th style="width:13%; padding-bottom: 10px;">종류</th>
					<th style="padding-bottom: 10px;">사용기간</th>
					<th style="width:10%; padding-bottom: 10px;">사용내역</th>
					<th style="width:25%; padding-bottom: 10px;">상세</th>
				</tr>
			</thead>
			<tbody id="usedAttendList"> 											
			</tbody>
		</table>
	</div>
	<%-- <div class="showMore hoverShadowText">더보기</div> --%>
</div>

<div id="dayoffInfo" class="widths">
	<div class="titles">&nbsp;연차 생성내역</div>
	<hr>
	<div>
		<table class="tables" style="width: 100%;" id="requestTbl">
			<thead>
				<tr style="height: 30px; border-bottom: solid 1px #f2f2f2;">
					<th style="width:13%; padding: 0 0 10px 30px;">이름</th>
					<th style="width:13%; padding-bottom: 10px;">부서명</th>
					<th style="width:13%; padding-bottom: 10px;">생성일</th>
					<th style="padding-bottom: 10px;">사용가능기간</th>
					<th style="width:25%; padding-bottom: 10px;">상세</th>
				</tr>
			</thead>
			<tbody id="usedAttendList"> 											
			</tbody>
		</table>
	</div>
	<%-- <div class="showMore hoverShadowText">더보기</div> --%>
</div>




