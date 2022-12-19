<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<style>
	.hoverShadow {	transition: all 0.5s;	}
	
	.hoverShadow:hover {	box-shadow: 1px 1px 8px #ddd;	}
	
	.hoverShadowText {	transition: all 0.5s;	}
	
	.hoverShadowText:hover {	text-shadow: -1px -1px #ddd;	}
	
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
		width: 160px;
		margin-right: 15px;
		margin-top: 10px;
		padding-right: 20px;
	}
	
	.timeBoxes_1 {
		font-size: 11pt;
		text-align: center;
		margin-bottom: 8px;
	}
	
	.timeBoxes_2 {
		color: #086BDE;
		font-size: 18pt;
		text-align: center;
	}
	
	#workModalBtn {
		color: gray;
		height: 27px;
		font-size: 10pt;	
		margin: 0 0 0 1060px;		
	}	
	
	#workModalBtn:hover {		
		text-decoration: underline;
		cursor: pointer;
	}
	
	.cals {
		border: none;
		width: 140px;
		font-size: 16pt;
	}
	
	#calMonth {
		width: 100px;
		font-size: 16pt;		
		text-align: center;
	}
	
	/* 박스 끝 */
	
	/* 테이블 시작 */
	.tables { font-size: 10pt; }	
	
	.widths {
		width: 90%; 
		margin: 0 auto;
		padding-top: 20px;
	}
	
	.weeks {	margin: 20px 0 0 10px;	}
	
	.table-hover {	cursor: pointer;	}
	/* 테이블 끝 */
	
	/* 모달 */
	.font11 { font-size: 11pt;}
	.modalSizeSmall {
    	width: 500px;
    	height: 400px;
    }
    
    .modalSizeBig {
    	width: 500px;
    	height: 630px;
    }
    
    .modalSmall { 
 		top : 20%;
 		z-index: 1050;
	}
	
	.modalBig {
		top : 5%;
 		z-index: 1050;
	}
	
	#modalBox {
		width: 90%;
		margin: 0 auto;		
	}
	
	.modalmargins {	margin: 5px 0 20px 0;	}
	
	.modalSelects {
		width: 100%;
		height: 30px;
		border-radius: 5px;
		border: solid 1px #bfbfbf;
		font-size: 10pt;
	}
		
	.modalBtns {
		width: 80px;
		border: none;
		border-radius: 5px;
		font-size: 10pt;
		height: 30px;
	}
	
	#extraInfo{
		margin-top: 20px;
	}
	
	
	

</style>   


<script>
	$(document).ready(function(){ // ==============================
	
		
		
		$("#extraInfo").hide();
		$("#dayoffInfo").hide();
		
		const now = new Date();	

		// alert( weekNumOfMonth(now));
		
		
		const year = now.getFullYear();
		const month = now.getMonth()+1;
		const thisMonth = year+"-"+month;
		$("#calMonth").val(thisMonth);
		
		$("#workSelect").change(function(){ // -------------------------
			/* $("#modalForm")[0].reset(); */
			const selectVal = $("#workSelect option:selected").val();
			// console.log(selectVal);
			
							
			if(selectVal != "dayoff"){	// 신청할 사유가 연차 이외의 것이라면 모달 크기를 늘려줌		
				$("#workModal").addClass("modalBig").removeClass("modalSmall");
				$("#modalSize").addClass("modalSizeBig").removeClass("modalSizeSmall");
				
				$("#extraInfo").show();
				$("#dayoffInfo").hide();
			}
			else {	// 신청할 사유가 연차라면 모달 크기를 줄여줌	
				$("#extraInfo").hide();				
				$("#dayoffInfo").show();
				$("#workModal").addClass("modalSmall").removeClass("modalBig");
				$("#modalSize").addClass("modalSizeSmall").removeClass("modalSizeBig");
			}
			
		}); // end of $("#searchSelect").change() -----------------------
		
		
		$('#dateSelect').datepicker({
				  dateFormat: 'yy-mm-dd',
				  prevText: '이전 달',
				  nextText: '다음 달',
				  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
				  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
				  showMonthAfterYear: true,
				  yearSuffix: '년'
				  
		});		
		
		$('#startDateSelect').datepicker({
			  dateFormat: 'yy-mm-dd',
			  prevText: '이전 달',
			  nextText: '다음 달',
			  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			  showMonthAfterYear: true,
			  yearSuffix: '년'
			  
		});
		
		
		
		$('input#dateSelect').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
				
		$('input#startDateSelect').datepicker('setDate', 'today');
		
		
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
			
			getMyAttendStatusList();
			
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
			
			getMyAttendStatusList();
			
		}); // end of $("#nextMonth").click() ------------------------------------
		
		
		$("#okModalBtn").click(function(){
			
			// 폼(form)을 전송(submit)
	        const frm = document.modalForm;
	        frm.method = "POST";
	        frm.action = "<%= ctxPath%>/requestAttendance.on";
	        frm.submit();			
			
		});
		
		getMyAttendStatusList();		
		getWeeklyWorkTimes();		
		getMonthlyWorkTimes();
		
		
		
	}); // end of $(document).ready() =============================
		
	function toggle(e){	
		const id = 'table_'+e;
		$('#'+id).slideToggle("fast");
	}
	
	
		
	
	function modalClose(){
		$('#workModal').modal('hide');
	}
	
	
	 
	function getMyAttendStatusList(){
		
		const calMonthVal = $("#calMonth").val();
		const empno = "${sessionScope.loginuser.empno}";	
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/myAttendStatusList.on",
			  data:{"empno":empno,
				    "calMonthVal":calMonthVal},
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  html += "<div id='week1' class='widths'>"+
					"<div onclick='toggle(\"week1\")' class='weeks'>"+
					"<span class='fas fa-angle-down' style='font-size: 10pt;'></span>"+
					"&nbsp;1 주차"+
				"</div>"+
				"<hr>"+
				"<div id='table_week1'>"+
					"<table style='width: 100%;' class='table-hover tables'>"+
						"<thead>"+
							"<tr style='height: 30px; border-bottom: solid 1px #f2f2f2;'>"+
								"<th style='width:13%; padding: 0 0 10px 30px;'>일자</th>"+
								"<th style='width:13%; padding-bottom: 10px;'>업무시작</th>"+
								"<th style='width:13%; padding-bottom: 10px;'>업무종료</th>"+
								"<th style='width:13%; padding-bottom: 10px;'>총근무시간</th>"+
								"<th style='padding-bottom: 10px;'>근무시간 상세</th>"+
								"<th style='width:20%; padding-bottom: 10px;'>비고</th>"+
							"</tr>"+
						"</thead>"+
						"<tbody>";
					  
					  
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  
						  let startTime = new Date(item.workdate);
						  let endTime = new Date(item.workend);
						  						  
						  
						  html += "<tr style='height: 30px; padding-top: 10px;'>"+
										"<td style='text-align: left; padding-left: 30px;'>"+item.workdate+"</td>"+
										"<td style='text-align: left;'>"+item.workstart+"</td>"+
										"<td style='text-align: left;'>"+item.workend+"</td>"+
										"<td style='text-align: left;'>"+item.worktime+"</td>"+
										"<td style='text-align: left;'>기본 "+item.worktime+" / 연장  "+item.extendstart+" / 외근 "+item.triptime+" </td>"+
										"<td style='text-align: left;'>"+item.dayoff+"</td>"+					
									"</tr>";
						// console.log(index);
						
						if(index == 4){
							html += "</tbody>"+
								"</table>"+
							"</div>"+
						"</div>"+
						"<div id='week2' class='widths'>"+
							"<div onclick='toggle(\"week2\")' class='weeks'>"+
								"<span class='fas fa-angle-down' style='font-size: 10pt;'></span>"+
								"&nbsp;2 주차"+
							"</div>"+
							"<hr>"+
							"<div id='table_week2'>"+
								"<table style='width: 100%;' class='table-hover tables' >"+
									"<thead>"+
										"<tr style='height: 30px; border-bottom: solid 1px #f2f2f2;'>"+
											"<th style='width:13%; padding: 0 0 10px 30px;'>일자</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>업무시작</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>업무종료</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>총근무시간</th>"+
											"<th style='padding-bottom: 10px;'>근무시간 상세</th>"+
											"<th style='width:20%; padding-bottom: 10px;'>비고</th>"+
										"</tr>"+
									"</thead>"+
									"<tbody>";
						}
						
						if(index == 9){
							html += "</tbody>"+
								"</table>"+
							"</div>"+	
						"</div>"+	
						"<div id='week3' class='widths'>"+
							"<div onclick='toggle(\"week3\")' class='weeks'>"+
								"<span class='fas fa-angle-down' style='font-size: 10pt;'></span>"+
								"&nbsp;3 주차"+
							"</div>"+
							"<hr>"+
							"<div id='table_week3'>"+
								"<table style='width: 100%;' class='table-hover tables' >"+
									"<thead>"+
										"<tr style='height: 30px; border-bottom: solid 1px #f2f2f2;'>"+
											"<th style='width:13%; padding: 0 0 10px 30px;'>일자</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>업무시작</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>업무종료</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>총근무시간</th>"+
											"<th style='padding-bottom: 10px;'>근무시간 상세</th>"+
											"<th style='width:20%; padding-bottom: 10px;'>비고</th>"+
										"</tr>"+
									"</thead>"+
									"<tbody>";
						}
						
						if(index == 14){
							html += "</tbody>"+
								"</table>"+
							"</div>"+	
						"</div>"+	
						"<div id='week4' class='widths'>"+
							"<div onclick='toggle(\"week4\")' class='weeks'>"+
								"<span class='fas fa-angle-down' style='font-size: 10pt;'></span>"+
								"&nbsp;4 주차"+
							"</div>"+
							"<hr>"+
							"<div id='table_week4'>"+
								"<table style='width: 100%;' class='table-hover tables' >"+
									"<thead>"+
										"<tr style='height: 30px; border-bottom: solid 1px #f2f2f2;'>"+
											"<th style='width:13%; padding: 0 0 10px 30px;'>일자</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>업무시작</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>업무종료</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>총근무시간</th>"+
											"<th style='padding-bottom: 10px;'>근무시간 상세</th>"+
											"<th style='width:20%; padding-bottom: 10px;'>비고</th>"+
										"</tr>"+
									"</thead>"+
									"<tbody>";
						}
						
						if(index == 19){
								html += "</tbody>"+
								"</table>"+
							"</div>"+	
						"</div>"+	
						"<div id='week5' class='widths'>"+
							"<div onclick='toggle(\"week5\")' class='weeks'>"+
								"<span class='fas fa-angle-down' style='font-size: 10pt;'></span>"+
								"&nbsp;5 주차"+
							"</div>"+
							"<hr>"+
							"<div id='table_week5'>"+
								"<table style='width: 100%;' class='table-hover tables' >"+
									"<thead>"+
										"<tr style='height: 30px; border-bottom: solid 1px #f2f2f2;'>"+
											"<th style='width:13%; padding: 0 0 10px 30px;'>일자</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>업무시작</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>업무종료</th>"+
											"<th style='width:13%; padding-bottom: 10px;'>총근무시간</th>"+
											"<th style='padding-bottom: 10px;'>근무시간 상세</th>"+
											"<th style='width:20%; padding-bottom: 10px;'>비고</th>"+
										"</tr>"+
									"</thead>"+
									"<tbody>";
						}
						
					  });
					  
					  html += "</tbody></table></div></div>";
					  
					  
					  $("#weekList").html(html);
					  
					  $("#table_week1").hide();
					  $("#table_week2").hide();
						$("#table_week3").hide();
						$("#table_week4").hide();
						$("#table_week5").hide();
						
						const today = new Date();
						  weekOpen(today);
						
				  }
				  else {
				  }
				  
				  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		});
		
	} // end of function getMyAttendStatusList(){} -------------------------------------------
	
	
	
	// 내 근태조회 상단 박스에 이번주 근무시간 얻어오기
	function getWeeklyWorkTimes(){
		
		const empno = "${sessionScope.loginuser.empno}";
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getWeeklyWorkTimes.on",
			  data:{"empno":empno},
			  dataType:"JSON",
			  success:function(json){
				  const weeklywork = json.weeklyworkTimesMap.weeklywork;
				  const remainwork = json.weeklyworkTimesMap.remainwork;
				  const weeklyextend = json.weeklyworkTimesMap.weeklyextend;
				  
				  // console.log(weeklywork + " " + remainwork + " " + weeklyextend);
				  
				  $("#weeklywork").text(weeklywork);
				  $("#remainwork").text(remainwork);
				  $("#weeklyextend").text(weeklyextend);
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		
	} // end of function getWeeklyWorkTimes() -----------------------------------------------
	
	
	
	// 내 근태조회 상단 박스에 이번달 근무시간 얻어오기
	function getMonthlyWorkTimes(){
		
		const empno = "${sessionScope.loginuser.empno}";
		
		$.ajax({
			  url:"<%=ctxPath%>/attend/getMonthlyWorkTimes.on",
			  data:{"empno":empno},
			  dataType:"JSON",
			  success:function(json){
				  const monthlywork = json.monthlyworkTimesMap.monthlywork;
				  const monthlyextend = json.monthlyworkTimesMap.monthlyextend;
				  
				  // console.log(monthlywork + " " + monthlyextend);
				  
				  $("#monthlywork").text(monthlywork);
				  $("#monthlyextend").text(monthlyextend);
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		
	} // end of function getMonthlyWorkTimes() -----------------------------------------------
	
	// 오늘이 이번달의 몇번째 주인지 구하기	
	function weekNumOfMonth(date){
		var WEEK_KOR = ["1", "2", "3", "4", "5"];
		var THURSDAY_NUM = 4;	// 첫째주의 기준은 목요일(4)이다. (https://info.singident.com/60)
		// console.log(date);

		var firstDate = new Date(date.getFullYear(), date.getMonth(), 1);
		var firstDayOfWeek = firstDate.getDay();

		var firstThursday = 1 + THURSDAY_NUM - firstDayOfWeek;	// 첫째주 목요일
		if(firstThursday <= 0){
			firstThursday = firstThursday + 7;	// 한주는 7일
		}
		var untilDateOfFirstWeek = firstThursday-7+3;	// 월요일기준으로 계산 (월요일부터 한주의 시작)
		var weekNum = Math.ceil((date.getDate()-untilDateOfFirstWeek) / 7) - 1;

		if(weekNum < 0){	// 첫째주 이하일 경우 전월 마지막주 계산
			var lastDateOfMonth = new Date(date.getFullYear(), date.getMonth(), 0);
		 	var result = Util.Date.weekNumOfMonth(lastDateOfMonth);
		 	return result;
		}

		return WEEK_KOR[weekNum];
	}
	
	function weekOpen(date){
		const weekNo = weekNumOfMonth(date);
		// alert(weekNo);	
		
		const now = new Date();	
		
		const year = now.getFullYear();
		const month = now.getMonth()+1;
		
		const compairDate = now.getFullYear() + "-" + (now.getMonth()+1) ;
		if($("#calMonth").val() == compairDate){
			
			switch (weekNo) {
			case "1":
				$("#table_week1").show();
				break;
				
			case "2":
				$("#table_week2").show();
				break;
				
			case "3":
				$("#table_week3").show();
				break;
		
			case "4":
				$("#table_week4").show();
				break;
				
			case "5":
				$("#table_week5").show();	
				break;

			}
			
		}
		else{
			$("#table_week1").show();
			$("#table_week2").show();
			$("#table_week3").show();
			$("#table_week4").show();
			$("#table_week5").show();
		}
	
		
		
	}
		
		
	

</script> 
    
<div style="font-size: 18pt; margin: 40px 0 50px 30px;" >근태 조회</div>

<div style="font-size: 18pt; text-align: center;">
	<a class="fas fa-angle-left" id="prevMonth" style="color: #bfbfbf; font-size: 14pt;"></a>
	<input id="calMonth" class="cals hoverShadowText" type="text" value="" onfocus="this.blur()"/>
	<a class="fas fa-angle-right" id="nextMonth" style="color: #bfbfbf; font-size: 14pt;"></a>
</div>



<div style="">	
	<div id="workModalBtn" data-toggle="modal" data-target="#workModal"><i class="fas fa-edit"></i>&nbsp;근태 신청</div>
	
	<div id="workBox">
		<div class="timeBoxes" style="border-right: solid 1px #bfbfbf;">
			<div class="timeBoxes_1">이번주<br>누적근무시간</div>
			<div class="timeBoxes_2" id="weeklywork">0</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">이번주<br>잔여근무시간</div>
			<div class="timeBoxes_2" id="remainwork">0</div>
		</div>
		<div class="timeBoxes" style="border-right: solid 1px #bfbfbf;">
			<div class="timeBoxes_1">이번주<br>초과근무시간</div>
			<div class="timeBoxes_2" id="weeklyextend">0</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">이번달<br>누적근무시간</div>
			<div class="timeBoxes_2" id="monthlywork" style="color: #b3b3b3;">0</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">이번달<br>연장근무시간</div>
			<div class="timeBoxes_2" id="monthlyextend" style="color: #b3b3b3;">0</div>
		</div>
	</div>
</div>

<div id="weekList">




</div>


<div class="modal modalSmall" id="workModal">
	<div class="modal-dialog">
		<div class="modal-content modalSizeSmall" id="modalSize">
			<div class='modal-body'>
				<div id="modalBox">
					<form name="modalForm" id="modalForm">
						<input name="empno" type="hidden" value="${sessionScope.loginuser.empno}">
						<div style="margin: 10px 0 30px 0; font-size: 14pt;">근태신청</div>
						<div style="margin-bottom: 20px;">신청인: ${sessionScope.loginuser.name}</div>
						<div>
							<div class="font11">종류</div>
							<select name="attend_index" id="workSelect" class="hoverShadow modalSelects modalmargins">
								<option>종류를 선택해주세요</option>
								<option value="dayoff">연차</option>
								<option value="trip">외근</option>								
								<option value="extend">연장근무</option>
							</select>								
							<div class="font11">사용날짜</div>
								<i class="far fa-calendar-alt" style="color: gray;"></i>
								<input id="startDateSelect" name="usedate" class="modalSelects hoverShadow" style="width: 160px; margin-right: 20px;" type="text">		
							<div>					
						</div>
						<div id="dayoffInfo" style="margin-top: 15px;">
							<span style="font-size: 10pt;">잔여: </span>
							<span style="font-size: 11pt; font-weight: bold; color: #086BDE;">${sessionScope.loginuser.annualcnt}일</span>
							<div style="font-size: 10pt;">사용 후: ${sessionScope.loginuser.annualcnt}일</div>
						</div>
							
						</div>
						<div id="extraInfo">
							<div style="display: inline-block;">		
								<div class="font11">시작시간</div>		
								<select name="startTime1" id="startTime1" class="hoverShadow modalSelects modalmargins" style="width: 50px; display: inline-block;">
									<c:forEach var="i" begin="7" end="23">	
										<c:if test="${i < 10}"><option value="0${i}">0${i}</option></c:if>
										<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>									
									</c:forEach>
								</select>					
								<span style="font-size: 14pt;">:</span>
								<select name="startTime2" id="startTime2" class="hoverShadow modalSelects modalmargins" style="width: 50px; display: inline-block;">
									<c:forEach var="i" begin="0" end="55" step="5">	
										<c:if test="${i < 10}"><option value="0${i}">0${i}</option></c:if>
										<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>							
									</c:forEach>
								</select>								
							</div>
							<div style="display: inline-block; margin-left: 100px;">
								<div class="font11">종료시간</div>								
								<select name="endTime1" id="endTime1" class="hoverShadow modalSelects modalmargins" style="width: 50px; display: inline-block;">
									<c:forEach var="i" begin="7" end="23">	
										<c:if test="${i < 10}"><option value="0${i}">0${i}</option></c:if>
										<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>									
									</c:forEach>
								</select>					
								<span style="font-size: 14pt;">:</span>
								<select name="endTime2" id="endTime2" class="hoverShadow modalSelects modalmargins" style="width: 50px; display: inline-block;">
									<c:forEach var="i" begin="0" end="55" step="5">	
										<c:if test="${i < 10}"><option value="0${i}">0${i}</option></c:if>
										<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>							
									</c:forEach>
								</select>	
							</div>
							<div class="font11">장소</div>
							<input name="place" class="modalSelects modalmargins hoverShadow" type="text" placeholder="외근인 경우에만 입력하세요.">
							<div class="font11">사유(선택)</div>
							<input name="reason" class="modalSelects modalmargins hoverShadow"  style="height: 60px;" type="text" placeholder="">						
						</div>
						<div style="margin: 30px 0 0 120px;">
							<button type="submit" class="modalBtns hoverShadow" id="okModalBtn" style="background-color: #E3F2FD;">확인</button>
							<button type="reset" class="modalBtns hoverShadow" id="cancelModalBtn" onclick="modalClose()">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

