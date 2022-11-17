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

</style>   

<script>

	$(document).ready(function(){
		
		$(function(){
		    $('.cals').datepicker();
		})
		
		$.datepicker.setDefaults({
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
			
			start = start.getFullYear() + "." + (start.getMonth()+1) + "." + start.getDate() + "(" + day_kor(start.getDay()) + ")";
			// console.log(start);
		}
		else{ // 오늘이 월요일 이라면
			start = year + "." + month + "." + date + "(" + day_kor(day) + ")";
		}
		
		if(day != 5){ // 오늘이 금요일이 아니라면			
			end = new Date(now2.setDate(now2.getDate()+(5-day))); // 이번주의 금요일 구하기
			
			end = end.getFullYear() + "." + (end.getMonth()+1) + "." + end.getDate() + "(" + day_kor(end.getDay()) + ")";
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
		}); // end of $("#prevWeek").click() -------------------------
		
		$("#nextWeek").click(function(){
			
			let startVal = $('input#dateStart').val().substr(0,10);
			let endVal = $('input#dateEnd').val().substr(0,10);
					
			// const end1 = parseInt(end.substr(0,7).split(".").join(""));    // if(end1 != end2) 비교용
			// const end2 = parseInt(endVal.substr(0,7).split(".").join("")); // if(end1 != end2) 비교용
			
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
			
			
		}); // end of $("#prevWeek").click() -------------------------
		
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

</script>

<div style="font-size: 18pt; margin: 40px 0 50px 30px;" >부서 근태조회</div>

<div style="font-size: 16pt; text-align: center; margin-bottom: 30px;">
	<span id="prevWeek" class="glyphicon glyphicon-menu-left" style="color: #bfbfbf; font-size: 14pt;"></span>
	<input id="dateStart" class="cals hoverShadowText" type="text" onfocus="this.blur()"/> ~ 
	<input id="dateEnd" class="cals hoverShadowText" type="text" onfocus="this.blur()"/>
	<span id="nextWeek" class="glyphicon glyphicon-menu-right" style="color: #bfbfbf; font-size: 14pt;"></span>
</div>

<div>
	<div id="title">
		<span id="todayBtn">오늘</span>
		<a class="category hoverShadow" href="<%= ctxPath%>/attend/teamStatusDaily.on">일</a>
		<a class="category hoverShadow" style="background-color: #086BDE; color: white;" href="<%= ctxPath%>/attend/teamStatusWeekly.on">주</a>
		<a class="category hoverShadow" href="<%= ctxPath%>/attend/teamStatusMonthly.on">월</a>
	</div>
	
	<%-- 중앙 박스 시작 --%>
	
	<div style="">
		<div class="infoBoxes" id="teamInfo">
			<div style="font-size: 14pt; margin-bottom: 10px;">경영지원</div>
			<div id="teamInfoTitle" style="">
				<span class="boxes tInfo_positions">직급</span>
				<span class="boxes tInfo_names">이름</span>
			</div>
			<div class="pplHover">
				<span class="boxes tInfo_positions">책임</span>
				<span class="boxes tInfo_names">김혜원</span>
			</div>
			<div class="pplHover">
				<span class="boxes tInfo_positions">선임</span>
				<span class="boxes tInfo_names">김원티드</span>
			</div>
		</div>
		
		<div class="infoBoxes" id="personalInfo">
			<div style="font-size: 14pt; margin-bottom: 10px;">김혜원</div>
			<div>
				<span class="boxes pInfo_titles">부서</span>
				<span class="boxes pInfo_contents">경영지원</span>
			</div>
			<div>
				<span class="boxes pInfo_titles">직급</span>
				<span class="boxes pInfo_contents">책임</span>
			</div>
			<div>
				<span class="boxes pInfo_titles">기간</span>
				<span class="boxes pInfo_contents">2022-11-07(월)~2022-11-11(금)</span>
			</div>
			<div>
				<span class="boxes pInfo_titles">누적 근무시간</span>
				<span class="boxes pInfo_contents">5h 30m</span>
			</div>
			<div>
				<span class="boxes pInfo_titles">예상 근무시간</span>
				<span class="boxes pInfo_contents">36시간</span>
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
		<table style="" id="workTable">
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
			<tbody> 				
				<tr style="">
					<td style="padding: 5px 0 5px 10px;">2022.11.07</td>
					<td class="" style="padding: 5px 0;">월</td>
					<td class="tbltexts" style="">05:00</td>
					<td class="tbltexts" style="">10:00</td>
					<td class="tbltexts" style="">15:00</td>
					<td class="tbltexts" style="">01:00</td>		
					<td class="tbltexts" style="">0분</td>
					<td style="padding: 5px 0;"></td>				
				</tr>
				
				<tr style="">
					<td style="padding: 5px 0 5px 10px;">2022.11.07</td>
					<td class="" style="padding: 5px 0;">화</td>
					<td class="tbltexts" style="">05:00</td>
					<td class="tbltexts" style="">10:00</td>
					<td class="tbltexts" style="">15:00</td>
					<td class="tbltexts" style="">01:00</td>		
					<td class="tbltexts" style="">0분</td>
					<td style="padding: 5px 0;"></td>				
				</tr>
				
				<tr style="">
					<td class="today" style="padding: 5px 0 5px 10px;">2022.11.07</td>
					<td class="today" style="padding: 5px 0;">수(오늘)</td>
					<td class="tbltexts" style="">05:00</td>
					<td class="tbltexts" style="">10:00</td>
					<td class="tbltexts" style="">15:00</td>
					<td class="tbltexts" style="">01:00</td>		
					<td class="tbltexts" style="">0분</td>
					<td style="padding: 5px 0;"></td>				
				</tr>
				
				<tr style="">
					<td style="padding: 5px 0 5px 10px;">2022.11.07</td>
					<td class="" style="padding: 5px 0;">목</td>
					<td class="tbltexts" style="">05:00</td>
					<td class="tbltexts" style="">10:00</td>
					<td class="tbltexts" style="">15:00</td>
					<td class="tbltexts" style="">01:00</td>		
					<td class="tbltexts" style="">0분</td>
					<td style="padding: 5px 0;"><button class="tblBtn">연차</button></td>				
				</tr>
				
				<tr style="">
					<td style="padding: 5px 0 5px 10px;">2022.11.07</td>
					<td class="" style="padding: 5px 0;">금</td>
					<td class="tbltexts" style="">05:00</td>
					<td class="tbltexts" style="">10:00</td>
					<td class="tbltexts" style="">15:00</td>
					<td class="tbltexts" style="">01:00</td>		
					<td class="tbltexts" style="">0분</td>
					<td style="padding: 5px 0;"></td>				
				</tr>
											
			</tbody>
		</table>
	</div>
	
	
</div>
