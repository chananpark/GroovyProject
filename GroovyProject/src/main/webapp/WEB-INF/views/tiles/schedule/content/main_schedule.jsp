<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>   
    
<link href='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.css' rel='stylesheet' />
    
<style type="text/css">

	/* ========== full calendar css 시작 ========== */
	.fc-header-toolbar {
		height: 30px;
	}
	
	a, a:hover, .fc-daygrid {
	    color: #000;
	    text-decoration: none;
	    background-color: transparent;
	    cursor: pointer;
	} 
	
	/* 일요일 날짜 빨간색 */
	.fc-day-sun a {
	  color: red;
	  text-decoration: none;
	}
	
	/* 토요일 날짜 파란색 */
	.fc-day-sat a {
	  color: blue;
	  text-decoration: none;
	}
	
	/* 상단 버튼 css 시작 */
	.fc .fc-button-primary {
		background-color: #086BDE;
	    border-color: #086BDE;
	}
	
	.fc .fc-button {
		background-color: #f9f9f9 ;
	    border-color: #f9f9f9 ;
	    color: black;
	}
	
	.fc .fc-button-primary:hover {
		background-color: #086BDE !important;
	    border-color: #086BDE !important;
	}
	
	.fc .fc-button-active {
		background-color: #086BDE !important;
	    border-color: #086BDE !important;
	    font-weight: bold;
	}
	
	/* 오늘 버튼 */
	#calendar > div.fc-header-toolbar.fc-toolbar.fc-toolbar-ltr > div:nth-child(1) > button {
		background-color: #f9f9f9 ;
	    border-color: #f9f9f9 ;
	    color: black !important;
	    opacity: 1 !important; 
	}
	
	/* 오늘 버튼 */
	#calendar > div.fc-header-toolbar.fc-toolbar.fc-toolbar-ltr > div:nth-child(1) > button:hover {
		background-color: #086BDE !important;
	    border-color: #086BDE !important;
	    color: white !important;
	    opacity: 1 !important; 
	    cursor: pointer !important;
	}
	/* 상단 버튼 css 끝 */
	
	/* today 배경색 */
	.fc .fc-daygrid-day.fc-day-today {
		background-color: #E3F2FD !important;
		font-weight: bold !important;
	}
	
	/* 헤더 */
	.fc .fc-col-header  {
		background-color: #f9f9f9 ;
	}
	/* ========== full calendar css 끝 ========== */
	
	ul{
		list-style: none;
	}
	
	.hide{display:none;}

	/* 검색 시작 */
	input[type=text], select, textarea {
	  width: 100%; /* Full width */
	  padding: 9px; /* Some padding */ 
	  border: 1px solid #ccc; /* Gray border */
	  border-radius: 4px; /* Rounded borders */
	  box-sizing: border-box; /* Make sure that padding and width stays in place */
	  margin-top: 5px; /* Add a top margin */
	  resize: vertical; /* Allow the user to vertically resize the textarea (not horizontally) */
	  vertical-align: middle;
	}
	/* 검색 끝 */

	
</style>    
    
<!-- full calendar에 관련된 script -->
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.js'></script>
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/ko.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    
<script type="text/javascript">

	$(document).ready(function(){
		
		// 검색할 때 필요한 datepicker
		// 모든 datepicker에 대한 공통 옵션 설정
	    $.datepicker.setDefaults({
	         dateFormat: 'yy-mm-dd'  // Input Display Format 변경
	        ,showOtherMonths: true   // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
	        ,showMonthAfterYear:true // 년도 먼저 나오고, 뒤에 월 표시
	        ,changeYear: true        // 콤보박스에서 년 선택 가능
	        ,changeMonth: true       // 콤보박스에서 월 선택 가능                
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트             
	    });
		
	    // input 을 datepicker로 선언
	    $("input#fromDate").datepicker();                    
	    $("input#toDate").datepicker();
	    	    
	    // From의 초기값을 한달전 날짜로 설정
	    $('input#fromDate').datepicker('setDate', '-1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	    
	    // To의 초기값을 오늘 날짜로 설정
		 $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
		
	    // To의 초기값을 한달후 날짜로 설정
//	    $('input#toDate').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
		
		
		// ==== 풀캘린더와 관련된 소스코드 시작(화면이 로드되면 캘린더 전체 화면 보이게 해줌) ==== //
		var calendarEl = document.getElementById('calendar');
		
		var calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',
	        locale: 'ko',
	        selectable: true,
	   //     nowIndicator: true,
		    editable: false,
		    headerToolbar: {
		    	  left: 'prev,next today',
		          center: 'title',
		          right: 'dayGridMonth dayGridWeek dayGridDay'
		      //    right: 'dayGridMonth timeGridWeek timeGridDay'
			},
		    dayMaxEventRows: true, // for all non-TimeGrid views
		    views: {
		    	timeGrid: {
		        	dayMaxEventRows: 3 // adjust to 6 only for timeGridWeek/timeGridDay
		      	}
		    },
			
			// ===================== DB 와 연동하는 법 시작 ===================== //
			    
			// ===================== DB 와 연동하는 법 끝 ===================== //
		    
		    
		    
			// 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
		    dateClick: function(info) {
		    	// alert('클릭한 Date: ' + info.dateStr); // 클릭한 Date: 2021-11-20
	      		$(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
	      	    info.dayEl.style.backgroundColor = '#086BDE'; // 클릭한 날짜의 배경색 지정하기
	      	    $("form > input[name=chooseDate]").val(info.dateStr);
	      	    
	      	    var frm = document.dateFrm;
	      	    frm.action="<%= ctxPath%>/schedule/insertSchedule.on";
	      	    frm.submit();
			}, // end of dateClick: function(info)
      	  

      	  
      	  
      	  
		}); // end of var calendar = new FullCalendar.Calendar(calendarEl,
		
		calendar.render();  // 풀캘린더 보여주기
		
		
		
		
		
		
		
		
		
		
		
		
		// 검색버튼 클릭 이벤트 클릭하면 나타나기
		// menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $("#search_btn").click(function(){
            var submenu = $(this).parent().parent().find("#detail_search");
 
            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
		

	
	
	
	
	
	
	
	
	
	}); // end of ready


	// ===== function declaration =====
		
	// 일정 검색하는 메소드
	function search_schedule( ){
		
		location.href="<%=ctxPath %>/schedule/searchSchedule.on";
		
	} // end of function search_schedule
	
	
</script>
    
<div>
    
<!--     <div style="display: flex;">
    	<div><h2 style="font-weight: bold;" class="mt-2">일정관리</h2></div>
		<button id="search_btn" class="mt-2 bg-white text-end" style="margin-left: 83%; border: none;"><i class="fas fa-search text-secondary fa-2x"></i></button> 
	</div>
	 -->
	<div style='margin: 1% 0 5% 1%; display: flex;'>
		<h4 class="mt-2">일정</h4>
		<button id="search_btn" class="bg-white text-end ml-3" style="border: none; color:#ccc;"><i class="fas fa-search fa-1x"></i></button> 
	</div>
	
	<div class="hide" id="detail_search" style="width:90%; margin-left: 5%;">

		<table style="width:100%;">
			<tr style="vertical-align: middle;">
				<th><label class="mr-5" for="select_search" style="font-weight: bold; font-size: 12pt;">검색분류</label></th>
				<td>
					<select name="select_search">
						<option>일정명 및 일정내용</option>
						<option>일정명</option>
						<option>일정내용</option>
						<option>공유자</option>
					</select>
				</td>
			</tr>
			<tr style="vertical-align: middle;">
				<th><label class="mr-5" for="search_word" style="font-weight: bold; font-size: 12pt;">검색어</label></th>
				<td>
					<input type="text" id="search_word" name="search_word" placeholder="검색어를 입력하세요." style="width: 90%;">
					<button class="btn bg-light mt-1" style="width: 9%; height: 44px;" onclick="search_schedule();">검색</button>
				</td>
			</tr>
			<tr style="vertical-align: middle;">
				<th><label class="mr-5" for="search_date" style="font-weight: bold; font-size: 12pt;">검색기간</label></th>
				<td>
					<input type="text" id="fromDate" name="startdate" style="width:48.1%;" readonly="readonly">
					&nbsp;&nbsp;-&nbsp;&nbsp;  
		            <input type="text" id="toDate" name="enddate" style="width:48.1%;" readonly="readonly">
				</td>
			</tr>
		</table>
		
	</div>
	
	<%-- 풀캘린더가 보여지는 엘리먼트  --%>
	<div id="calendar" style="margin: 100px 20px 50px 0;" ></div>




</div>    


<%-- === 마우스로 클릭한 날짜의 일정 등록을 위한 폼 === --%>     
<form name="dateFrm">
	<input type="hidden" name="chooseDate" />	
</form>	

