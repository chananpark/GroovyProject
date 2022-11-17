<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style>

	.hoverShadow {	transition: all 0.5s;	}
	
	.hoverShadow:hover {	box-shadow: 1px 1px 8px #ddd;	}
	
	.hoverShadowText {	transition: all 0.5s;	}
	
	.hoverShadowText:hover {	text-shadow: -1px -1px #ddd;	}

	/* 표 시작 */
	
	.widths {
		width: 90%; 
		margin: 0 auto;
		padding-top: 50px;
	}
	
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
		color: black;
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
	
	.category:hover {	cursor: pointer;	}
	
	#title {
		width: 100%; 
		border-bottom: solid 1px #bfbfbf;
		padding-bottom: 10px;
		padding-right: 50px;
		text-align: right;		
	}
	
	.names { width: 10%; padding-left: 10px; }	
	.times { width: 7%;	}	
	.timeShapes { width: 65%; }
	
	div.contents {	margin-top: 10px;	}
	
	#datepick {
		border: none;
		width: 140px;
		font-size: 16pt;
	}
	


</style>   


<script>

	$(document).ready(function(){
		
		$('#datepick').datepicker({
			  dateFormat: 'yy.mm.dd(D)',
			  maxDate: 0,
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
		
		$('input#datepick').datepicker('setDate', 'today');
		
		
		let val;
		$("#datepick").change(function(){
			val = $("#datepick").val();
			$('input#datepick').datepicker('setDate', val);
			// console.log(val);
		});
		
		$("#prevday").click(function(){
			let originVal = $('input#datepick').val().substr(0,10);
			
			let newVal = new Date(originVal);
			
			if( newVal.getDay() == 1 ){ // 금요일이면 => 주말 패스
				newVal = new Date(newVal.setDate(newVal.getDate()-3));
			}
			else{ // 금요일이 아니라면 => 하루 더하기
				newVal = new Date(newVal.setDate(newVal.getDate()-1));
			}
			
			newVal = newVal.getFullYear() + "." + (newVal.getMonth()+1) + "." + newVal.getDate() + "(" + day_kor(newVal.getDay()) + ")";
			
			$('input#datepick').val(newVal);
			
			$('input#datepick').datepicker('setDate', newVal);
		});
		
		$("#nextday").click(function(){
			let originVal = $('input#datepick').val().substr(0,10);
			
			let newVal = new Date(originVal);
			
			if( newVal.getDay() == 5 ){ // 금요일이면 => 주말 패스
				newVal = new Date(newVal.setDate(newVal.getDate()+3));
			}
			else{ // 금요일이 아니라면 => 하루 더하기
				newVal = new Date(newVal.setDate(newVal.getDate()+1));
			}
			// console.log(newVal);
			newVal = newVal.getFullYear() + "." + (newVal.getMonth()+1) + "." + newVal.getDate() + "(" + day_kor(newVal.getDay()) + ")";
			
			$('input#datepick').val(newVal);
			
			$('input#datepick').datepicker('setDate', newVal);
		});
		
	}); // end of $(document).ready() ==========================================
	
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
	

</script>

<div style="font-size: 18pt; margin: 40px 0 50px 30px; " >부서 근태조회</div>

<div style="font-size: 16pt; text-align: center; margin-bottom: 30px;">
	<span id="prevday" class="glyphicon glyphicon-menu-left hoverShadowText" style="color: #bfbfbf; font-size: 14pt;"></span>
	<input id="datepick" class="datepick hoverShadow" type="text" onfocus="this.blur()">
	<span id="nextday" class="glyphicon glyphicon-menu-right hoverShadowText" style="color: #bfbfbf; font-size: 14pt;"></span>
</div>
<div id="title">		
	<span id="todayBtn">오늘</span>
	<a class="category hoverShadow" style="background-color: #086BDE; color: white;" href="<%= ctxPath%>/attend/teamStatusDaily.on">일</a>
	<a class="category hoverShadow" href="<%= ctxPath%>/attend/teamStatusWeekly.on">주</a>
	<a class="category hoverShadow" href="<%= ctxPath%>/attend/teamStatusMonthly.on">월</a>
</div>
<div class="widths" style="border-bottom: solid 1px #bfbfbf; margin-bottom: 10px;">
	
	<div style="border-bottom: solid 1px #bfbfbf;">
		<span class="table names">이름</span>
		<span class="table times">근무시간</span>
		<span class="table times">출근시간</span>
		<span class="table times">퇴근시간</span>
		<span class="table timeShapes" style="width: 50%;">시간</span>
	</div>
	<div class="contents">
		<span class="table names"><img src="<%=ctxPath %>/resources/images/test/jaeseok.jpg" style="width:35px; border-radius: 50%; border: solid 1px gray;"/>
								    재석이</span>
		<span class="table times">07:00</span>
		<span class="table times">10:00</span>
		<span class="table times">17:00</span>
		<span class="table timeShapes" style="margin-left: 38px; background-color: #E3F2FD; width: 38px;">&nbsp;</span>
		
		<%-- width: 38px; --%>
	</div>
	<div class="contents">
		<span class="table names"><img src="<%=ctxPath %>/resources/images/logo/logo.png" style="width:35px; border-radius: 50%; border: solid 1px gray;"/>
								    김혜원</span>
		<span class="table times">07:00</span>
		<span class="table times">10:00</span>
		<span class="table times">17:00</span>
		<span class="table timeShapes" style="margin-left: 114px; background-color: #E3F2FD; width: 304px;">&nbsp;</span>
		
		<%-- width: 38px; --%>
	</div>
	<div class="contents">
		<span class="table names"><img src="<%=ctxPath %>/resources/images/logo/logo.png" style="width:35px; border-radius: 50%; border: solid 1px gray;"/>
								    김원티드</span>
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
	

