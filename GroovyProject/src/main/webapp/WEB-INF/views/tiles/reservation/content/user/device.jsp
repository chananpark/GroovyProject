<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	
	.time_hover:hover {
		background-color: #E3F2FD;
	}

	.date_style {
	  padding: 5px; /* Some padding */ 
	  border: 1px solid #ccc; /* Gray border */
	  border-radius: 4px; /* Rounded borders */
	  box-sizing: border-box; /* Make sure that padding and width stays in place */
	  margin-top: 5px; /* Add a top margin */
	  resize: vertical; /* Allow the user to vertically resize the textarea (not horizontally) */
	  vertical-align: middle;
	  font-size: 13pt;
	}
	
	.reservation_title {
		margin-bottom: 20px;
		display: flex;
	}
	
	.reservation_title_item {
		align-self: center;
	}


</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		// 첫창에서 오늘 날짜 선택하게 만들기
		var today_date = new Date().toISOString().substring(0, 10);
	    $("input#reservStartDate").val(today_date);

	    // insertReservation 에 넣어줄 변수인 클릭한 날짜 잡아오기
	   	var selectDate = $("input#reservStartDate").val();
	    
	    $("input#reservStartDate").change(function(){
	    	selectDate = $("input#reservStartDate").val();
	    });
	    
	    // 타임테이블 만들기 시작
	    var table_timeList = "<td>&nbsp;&nbsp;</td>";
	    
	    for(i=0; i<24; i++) {
	    	if(i<10) {
	    		table_timeList +=  "<td>"+'0'+i+"</td>";
	    	} else {
	    		table_timeList +=  "<td>"+i+"</td>";
	    	}
	    }; // end of for
		    
		$("tr#table_timeList").html(table_timeList);    
	    
	    // ----- 반복문 시작
	    var three_meeting = "<td>3층 대회의실</td>";
	    
	    for(i=0; i<24; i++) { 
	    	if(i<10) {
		    	three_meeting +=  "<td class='time_hover' onclick='insertReservation("+selectDate+", 0"+i+");' value='0"+i+"')>&nbsp;&nbsp;</td>";
	    	} else {
		    	three_meeting +=  "<td class='time_hover' onclick='insertReservation();' value='"+i+"')>&nbsp;&nbsp;</td>";
	    	}
	    }; // end of for
		    
		$("tr#three_meeting").html(three_meeting);    
	    
		var five_meeting1 = "<td>5층 소회의실1</td>";
		    
			for(i=0; i<24; i++) {
				five_meeting1 +=  "<td class='time_hover'>&nbsp;&nbsp;</td>";
	   	}; // end of for
		    
		$("tr#five_meeting1").html(five_meeting1);    
	    
		var five_meeting2 = "<td>5층 소회의실2</td>";
		    
			for(i=0; i<24; i++) {
				five_meeting2 +=  "<td class='time_hover'>&nbsp;&nbsp;</td>";
		    }; // end of for
			    
		$("tr#five_meeting2").html(five_meeting2);    
	    // ----- 반복문 끝
	    
	    // 타임테이블 만들기 끝
	    
	    
	    
	    
	    
	}); // end of ready


	
	
</script>



<div style='margin: 1% 0 5% 1%; display: flex;'>
	<h4 class="mt-2">기기 예약</h4>
</div>

<div class="hide" id="detail_search" style="width:95%; margin: 0 auto;">
	<div class="jumbotron">
	    <div class="container">
			현재 사용 가능한 기기는 노트북1, 노트북2, 빔프로젝터1 입니다.
			<br><br>
	        ※ 기기 예약 관련 문의는 인사총무팀 시설담당 이시설(내선번호 : 111)으로 연락바랍니다.
	    </div>
	</div>
	
		
	<%-- 오늘 날짜 선택 --%>
	<div class="reservation_title">
		<span class="reservation_title_item mr-3" style="font-size: 15pt;" >예약일자</span>
		<span class="reservation_title_item mb-1">
			<input class="date_style" type="date" id="reservStartDate"/>
		</span>
	</div>

	<%-- 시간 선택 --%>
	<table class="table" style="border-left: none !important; border-right: none;">
		<tr id="table_timeList"></tr>
		<tr id="three_meeting"></tr>
		<tr id="five_meeting1"></tr>
		<tr id="five_meeting2"></tr>
		<tr id="five_meeting3"></tr>
	
	</table>
	
</div>


<%-- === 마우스로 클릭한 날짜의 예약을 위한 폼 === --%>   
<form name="reservFrm">
	<input type="hidden" name="chooseDate" />	
</form>	



