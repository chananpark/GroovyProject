<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    

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
		width: 150px;
		margin-right: 15px;
		margin-top: 15px;
		padding-right: 20px;
	}
	
	.timeBoxes_1 {
		font-size: 11pt;
		text-align: center;
		margin-bottom: 15px;
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
		padding-top: 50px;
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
	
	

</style>   


<script>
	$(document).ready(function(){ // ==============================
	
		$("#table_week2").hide();
		$("#table_week3").hide();
		$("#table_week4").hide();
		$("#table_week5").hide();
		
		$("#extraInfo").hide();
		$("#dayoffInfo").hide();
		
		const now = new Date();		
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
				  maxDate: 0,
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
		
		
	}); // end of $(document).ready() =============================
		
	function toggle(e){	
		const id = 'table_'+e;
		$('#'+id).slideToggle("fast");
	}
	
	
		
	
	function modalClose(){
		$('#workModal').modal('hide');
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
			<div class="timeBoxes_1">이번주 누적</div>
			<div class="timeBoxes_2">9h 20m 52s</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">이번주 초과</div>
			<div class="timeBoxes_2">9h 20m 52s</div>
		</div>
		<div class="timeBoxes" style="border-right: solid 1px #bfbfbf;">
			<div class="timeBoxes_1">이번주 잔여</div>
			<div class="timeBoxes_2">9h 20m 52s</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">이번달 누적</div>
			<div class="timeBoxes_2" style="color: #b3b3b3;">9h 20m 52s</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">이번달 연장</div>
			<div class="timeBoxes_2" style="color: #b3b3b3;">9h 20m 52s</div>
		</div>
	</div>
</div>


<div id="week1" class="widths">
	<div onclick="toggle('week1')" class="weeks">
		<span class="fas fa-angle-down" style="font-size: 10pt;"></span>
		&nbsp;1 주차
	</div>
	<hr>
	<div id="table_week1">
		<table style="width: 100%;" class="table-hover tables">
			<thead>
				<tr style="height: 30px; border-bottom: solid 1px #f2f2f2;">
					<th style="width:13%; padding: 0 0 10px 30px;">일자</th>
					<th style="width:13%; padding-bottom: 10px;">업무시작</th>
					<th style="width:13%; padding-bottom: 10px;">업무종료</th>
					<th style="width:13%; padding-bottom: 10px;">총근무시간</th>
					<th style="padding-bottom: 10px;">근무시간 상세</th>
					<th style="width:20%; padding-bottom: 10px;">승인요청내역</th>
				</tr>
			</thead>
			<tbody> 				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">07 월</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">5h 0m 0s</td>
					<td style="text-align: left;">기본 5h 0m 0s/ 연장 5h 0m 0s/야간 5h 0m 0s</td>
					<td style="text-align: left;"></td>						
				</tr>
								
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">08 화</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">5h 0m 0s</td>
					<td style="text-align: left;">기본 5h 0m 0s/ 연장 5h 0m 0s/야간 5h 0m 0s</td>
					<td style="text-align: left;"></td>						
				</tr>
				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">09 수</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">5h 0m 0s</td>
					<td style="text-align: left;">기본 5h 0m 0s/ 연장 5h 0m 0s/야간 5h 0m 0s</td>
					<td style="text-align: left;"></td>						
				</tr>
				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">10 목</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">5h 0m 0s</td>
					<td style="text-align: left;">기본 5h 0m 0s/ 연장 5h 0m 0s/야간 5h 0m 0s</td>
					<td style="text-align: left;"></td>						
				</tr>
				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">11 금</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">5h 0m 0s</td>
					<td style="text-align: left;">기본 5h 0m 0s/ 연장 5h 0m 0s/야간 5h 0m 0s</td>
					<td style="text-align: left;"></td>						
				</tr>	
				
								
			</tbody>
		</table>
	</div>


</div>

<div id="week2" class="widths">
	<div onclick="toggle('week2')" class="weeks">
		<span class="fas fa-angle-down" style="font-size: 10pt;"></span>
		&nbsp;2 주차
	</div>
	<hr>
	<div id="table_week2">
		<table style="width: 100%;" class="table-hover tables" >
			<thead>
				<tr style="height: 30px; border-bottom: solid 1px #f2f2f2;">
					<th style="width:13%; padding: 0 0 10px 30px;">일자</th>
					<th style="width:13%; padding-bottom: 10px;">업무시작</th>
					<th style="width:13%; padding-bottom: 10px;">업무종료</th>
					<th style="width:13%; padding-bottom: 10px;">총근무시간</th>
					<th style="padding-bottom: 10px;">근무시간 상세</th>
					<th style="width:20%; padding-bottom: 10px;">승인요청내역</th>
				</tr>
			</thead>
			<tbody> 				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">07 월</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">5h 0m 0s</td>
					<td style="text-align: left;">기본 5h 0m 0s/ 연장 5h 0m 0s/야간 5h 0m 0s</td>
					<td style="text-align: left;"></td>						
				</tr>	
								
			</tbody>
		</table>
	</div>

</div>

<div id="week3" class="widths">
	<div onclick="toggle('week3')" class="weeks">
		<span class="fas fa-angle-down" style="font-size: 10pt;"></span>
		&nbsp;3 주차
	</div>
	<hr>
	<div id="table_week3">
		<table style="width: 100%;" class="table-hover tables">
			<thead>
				<tr style="height: 30px; border-bottom: solid 1px #f2f2f2;">
					<th style="width:13%; padding: 0 0 10px 30px;">일자</th>
					<th style="width:13%; padding-bottom: 10px;">업무시작</th>
					<th style="width:13%; padding-bottom: 10px;">업무종료</th>
					<th style="width:13%; padding-bottom: 10px;">총근무시간</th>
					<th style="padding-bottom: 10px;">근무시간 상세</th>
					<th style="width:20%; padding-bottom: 10px;">승인요청내역</th>
				</tr>
			</thead>
			<tbody> 				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">07 월</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">5h 0m 0s</td>
					<td style="text-align: left;">기본 5h 0m 0s/ 연장 5h 0m 0s/야간 5h 0m 0s</td>
					<td style="text-align: left;"></td>						
				</tr>	
								
			</tbody>
		</table>
	</div>

</div>

<div id="week4" class="widths">
	<div onclick="toggle('week4')" class="weeks" >
		<span class="fas fa-angle-down" style="font-size: 10pt;"></span>
		&nbsp;4 주차
	</div>
	<hr>
	<div>
		<table style="width: 100%;" id="table_week4" class="table-hover tables">
			<thead>
				<tr style="height: 30px; border-bottom: solid 1px #f2f2f2;">
					<th style="width:13%; padding: 0 0 10px 30px;">일자</th>
					<th style="width:13%; padding-bottom: 10px;">업무시작</th>
					<th style="width:13%; padding-bottom: 10px;">업무종료</th>
					<th style="width:13%; padding-bottom: 10px;">총근무시간</th>
					<th style="padding-bottom: 10px;">근무시간 상세</th>
					<th style="width:20%; padding-bottom: 10px;">승인요청내역</th>
				</tr>
			</thead>
			<tbody> 				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">07 월</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">5h 0m 0s</td>
					<td style="text-align: left;">기본 5h 0m 0s/ 연장 5h 0m 0s/야간 5h 0m 0s</td>
					<td style="text-align: left;"></td>						
				</tr>	
								
			</tbody>
		</table>
	</div>

</div>

<div id="week5" class="widths">
	<div onclick="toggle('week5')" class="weeks" >
		<span class="fas fa-angle-down" style="font-size: 10pt;"></span>
		&nbsp;5 주차
	</div>
	<hr>
	<div>
		<table style="width: 100%;" id="table_week5" class="table-hover tables">
			<thead>
				<tr style="height: 30px;">
					<th style="width:13%; padding: 0 0 10px 30px;">일자</th>
					<th style="width:13%; padding-bottom: 10px;">업무시작</th>
					<th style="width:13%; padding-bottom: 10px;">업무종료</th>
					<th style="width:13%; padding-bottom: 10px;">총근무시간</th>
					<th style="text-align:center; padding-bottom: 10px;">근무시간 상세</th>
					<th style="width:20%; padding-bottom: 10px;">승인요청내역</th>
				</tr>
			</thead>
			<tbody> 				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">07 월</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">12:00:00</td>
					<td style="text-align: left;">5h 0m 0s</td>
					<td style="text-align: left;">기본 5h 0m 0s/ 연장 5h 0m 0s/야간 5h 0m 0s</td>
					<td style="text-align: left;"></td>						
				</tr>	
								
			</tbody>
		</table>
	</div>

</div>



<div class="modal modalSmall" id="workModal">
	<div class="modal-dialog">
		<div class="modal-content modalSizeSmall" id="modalSize">
			<div class='modal-body'>
				<div id="modalBox">
					<form name="modalForm" id="modalForm">
						<div style="margin: 10px 0 30px 0; font-size: 14pt;">근태신청</div>
						<div style="margin-bottom: 20px;">신청인: 김혜원</div>
						<div>
							<div class="font11">날짜</div>
							<input id="dateSelect" class="modalSelects modalmargins hoverShadow" type="text" placeholder="">
							<div class="font11">종류</div>
							<select name="workSelect" id="workSelect" class="hoverShadow modalSelects modalmargins">
								<option>종류를 선택해주세요</option>
								<option value="out">외근</option>
								<option value="dayoff">연차</option>
								<option value="extend">연장근무</option>
							</select>
						</div>
						<div id="dayoffInfo">
							<div><span style="font-size: 10pt;">잔여: </span><span style="font-size: 11pt; font-weight: bold; color: #086BDE;">3일</span></div>
							<div style="font-size: 10pt;">사용 후: 2일</div>
						</div>
						<div id="extraInfo">
							<div style="display: inline-block; margin-right: 80px;">
								<div class="font11">시작시간</div>
								<input class="modalSelects modalmargins hoverShadow" style="width: 50px;" type="text" placeholder="">
								<span style="font-size: 14pt;">:</span>
								<input class="modalSelects hoverShadow" style="width: 50px;" type="text" placeholder="">
							</div>
							<div style="display: inline-block;">
								<div class="font11">종료시간</div>
								<input class="modalSelects modalmargins hoverShadow" style="width: 50px;" type="text" placeholder="">
								<span style="font-size: 14pt;">:</span>
								<input class="modalSelects hoverShadow" style="width: 50px;" type="text" placeholder="">
							</div>
							<div class="font11">장소</div>
							<input class="modalSelects modalmargins hoverShadow" type="text" placeholder="">
							<div class="font11">사유(선택)</div>
							<input class="modalSelects modalmargins hoverShadow"  style="height: 60px;" type="text" placeholder="">						
						</div>
						<div style="margin: 30px 0 0 120px;">
							<button type="button" class="modalBtns hoverShadow" id="okModalBtn" style="background-color: #E3F2FD;">확인</button>
							<button type="reset" class="modalBtns hoverShadow" id="cancelModalBtn" onclick="modalClose()">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

