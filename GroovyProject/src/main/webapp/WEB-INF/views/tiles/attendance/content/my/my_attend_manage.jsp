<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>  

<style>

	.hoverShadow {
		transition: all 0.5s;
	}
	
	.hoverShadow:hover {
		box-shadow: 1px 1px 8px #ddd;
		cursor: pointer;
	}
	
	.hoverShadowText {
		transition: all 0.5s;
	}
	
	.hoverShadowText:hover {
		text-shadow: -1px -1px #ddd;
		cursor: pointer;
	}
	
	.cals {
		border: none;
		width: 140px;
		font-size: 16pt;
	}
	
	.cals:hover {
		cursor: pointer;
	}
	
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
		/* border: solid 1px pink; */
		width: 90px;
		margin-right: 15px;
		margin-top: 15px;
		padding-right: 20px;
	}
	
	.timeBoxes_1 {
		font-size: 11pt;
		text-align: center;
	}
	
	.timeBoxes_2 {
		color: #086BDE;
		font-size: 18pt;
		text-align: center;
	}
	
	.timeBoxes_3 {
		font-size: 9pt;
		text-align: center;
		margin-bottom: 5px;
	}
		
	/* 박스 끝 */
	
	/* 테이블 시작 */	
	.table-hover:hover {
		cursor: pointer;
	}
	
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
	
	.showMore:hover {
		text-decoration: underline;
	}
	
	.trash {
		color: gray; 
		text-align: left;
	}
	
	/* 테이블 끝 */

</style>   

<script src="https://kit.fontawesome.com/48fed31cce.js" crossorigin="anonymous"></script>
<script>

	$(document).ready(function(){
			
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
			}
		
		}); // end of $("#dateEnd").change() ---------------------------------------
		
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
		  yearSuffix: '년'
		});
		
	});
	
	
	
	
</script>

<div style="font-size: 18pt; margin: 40px 0 50px 30px;" >근태 관리</div>

<div style="font-size: 16pt; text-align: center; margin-bottom: 30px;">
	<span class="glyphicon glyphicon-menu-left hoverShadowText" style="color: #bfbfbf; font-size: 14pt;"></span>
	<input id="dateStart" class="cals hoverShadowText" type="text" value="2022.11.07(월)" onfocus="this.blur()"/> ~ 
	<input id="dateEnd" class="cals hoverShadowText" type="text" value="2022.11.13(금)" onfocus="this.blur()"/>
	<span class="glyphicon glyphicon-menu-right hoverShadowText" style="color: #bfbfbf; font-size: 14pt;"></span>
</div>



<div>
	<div id="workBox">
		<div class="timeBoxes" style="border-right: solid 1px #bfbfbf; width: 170px;">
			<div class="timeBoxes_1" style="padding-bottom: 5px;">누적 근무시간</div>
			<div class="timeBoxes_3"></div>
			<div class="timeBoxes_2">9h 20m 52s</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">사용연차</div>
			<div class="timeBoxes_3">(개)</div>
			<div class="timeBoxes_2">1</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">외근</div>
			<div class="timeBoxes_3">(시간)</div>
			<div class="timeBoxes_2">3</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">휴일근무</div>
			<div class="timeBoxes_3">(시간)</div>
			<div class="timeBoxes_2"">1.5</div>
		</div>
		<div class="timeBoxes" style="border-right: solid 1px #bfbfbf;">
			<div class="timeBoxes_1">연장근무</div>
			<div class="timeBoxes_3">(시간)</div>
			<div class="timeBoxes_2">1.5</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">발생연차</div>
			<div class="timeBoxes_3">(개)</div>
			<div class="timeBoxes_2" style="color: #b3b3b3;">0</div>
		</div>
		<div class="timeBoxes">
			<div class="timeBoxes_1">잔여연차</div>
			<div class="timeBoxes_3">(개)</div>
			<div class="timeBoxes_2" style="color: #b3b3b3;">0</div>
		</div>
	</div>
</div>


<div id="requestInfo" class="widths" style="">
	<div class="titles">&nbsp;신청내역 (전체)</div>
	<hr>
	<div>
		<table class="table-hover" style="width: 100%;" id="requestTbl">
			<thead>
				<tr style="height: 30px; border-bottom: solid 1px #f2f2f2;">
					<th style="width:13%; padding: 0 0 10px 30px;">이름</th>
					<th style="width:13%; padding-bottom: 10px;">부서명</th>
					<th style="width:13%; padding-bottom: 10px;">종류</th>
					<th style="padding-bottom: 10px;">사용기간</th>
					<th style="width:10%; padding-bottom: 10px;">사용내역</th>
					<th style="width:20%; padding-bottom: 10px;">상세</th>
					<th style="width:5%; padding-bottom: 10px;"></th>
				</tr>
			</thead>
			<tbody> 				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">김상후</td>
					<td style="text-align: left;">경영지원</td>
					<td style="text-align: left;">연차</td>
					<td style="text-align: left;">2022-01-01 ~ 2023-06-11</td>
					<td style="text-align: left;">1(일)</td>
					<td style="text-align: left;"></td>		
					<td style="text-align: left;"><i class="fas fa-trash-alt hoverShadowText trash"></i></td>				
				</tr>
								
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">김상후</td>
					<td style="text-align: left;">경영지원</td>
					<td style="text-align: left;">외근</td>
					<td style="text-align: left;">2022-01-08 16:00 ~ 19:00</td>
					<td style="text-align: left;">3(시간)</td>
					<td style="text-align: left;"></td>
					<td style="text-align: left;"><i class="fas fa-trash-alt hoverShadowText trash"></i></td>							
				</tr>
											
			</tbody>
		</table>
	</div>
	<div class="showMore hoverShadowText">더보기</div>
</div>


<div id="usedInfo" class="widths">
	<div class="titles">&nbsp;사용내역 (전체)</div>
	<hr>
	<div>
		<table style="width: 100%;" id="requestTbl">
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
			<tbody> 				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">김상후</td>
					<td style="text-align: left;">경영지원</td>
					<td style="text-align: left;">연차</td>
					<td style="text-align: left;">2022-01-01 ~ 2023-06-11</td>
					<td style="text-align: left;">1(일)</td>
					<td style="text-align: left;"></td>						
				</tr>
								
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">김상후</td>
					<td style="text-align: left;">경영지원</td>
					<td style="text-align: left;">외근</td>
					<td style="text-align: left;">2022-01-08 16:00 ~ 19:00</td>
					<td style="text-align: left;">3(시간)</td>
					<td style="text-align: left;"></td>						
				</tr>
											
			</tbody>
		</table>
	</div>
	<div class="showMore hoverShadowText">더보기</div>
</div>


<div id="annualLeaveInfo" class="widths">
	<div class="titles">&nbsp;연차 생성내역</div>
	<hr>
	<div>
		<table style="width: 100%;" id="requestTbl">
			<thead>
				<tr style="height: 30px; border-bottom: solid 1px #f2f2f2;">
					<th style="width:17%; padding: 0 0 10px 30px;">등록일</th>
					<th style="width:17%; padding-bottom: 10px;">사용기간</th>
					<th style="width:25%; padding-bottom: 10px;">발생일수</th>
					<th style="padding-bottom: 10px;">상세</th>
				</tr>
			</thead>
			<tbody> 				
				<tr style="height: 30px; padding-top: 10px;">
					<td style="text-align: left; padding-left: 30px;">2022-01-01</td>
					<td style="text-align: left;">2022-12-31</td>
					<td style="text-align: left;">1</td>
					<td style="text-align: left;"></td>				
				</tr>											
			</tbody>
		</table>
	</div>
	<div class="showMore hoverShadowText">더보기</div>
</div>



