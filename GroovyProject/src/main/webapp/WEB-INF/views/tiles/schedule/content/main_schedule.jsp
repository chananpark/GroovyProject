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
	
	.fc-event-title {
		color: black;
	}
	
	.fc-event-time {
		color: black;
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
	
	.search_title {
		font-weight: bold; 
		font-size: 12pt;
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
	    $('input#fromDate').datepicker('setDate', '-15D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	    
	    // To의 초기값을 오늘 날짜로 설정
		 $('input#toDate').datepicker('setDate', '+15D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
		
		 
		////////////////////////////////////////////////////////////////////////////////////////////////
		// === 전사일정 체크박스 전체 선택/전체 해제 === //
		$("input:checkbox[id=allComCal]").click(function(){
			var bool = $(this).prop("checked");
			$("input:checkbox[name=com_smcategChk]").prop("checked", bool);
		});// end of $("input:checkbox[id=allComCal]").click(function(){})-------
		
		// === 전사일정 에 속한 특정 체크박스를 클릭할 경우 === 
		$(document).on("click","input:checkbox[name=com_smcategChk]",function(){	
			var bool = $(this).prop("checked");
			
			if(bool){ // 체크박스에 클릭한 것이 체크된 것이라면 
				
				var flag=false;
				
				$("input:checkbox[name=com_smcategChk]").each(function(index, item){
					var bChecked = $(item).prop("checked");
					
					if(!bChecked){     // 체크되지 않았다면 
						flag=true;     // flag 를 true 로 변경
						return false;  // 반복을 빠져 나옴.
					}
				}); // end of $("input:checkbox[name=com_smcategChk]").each(function(index, item){})---------

				if(!flag){ // 사내캘린더 에 속한 서브캘린더의 체크박스가 모두 체크가 되어진 경우라면 			
	                $("input#allComCal").prop("checked",true); // 사내캘린더 체크박스에 체크를 한다.
				}
				
				var com_smcatgonoArr = document.querySelectorAll("input.com_smcategChk");
			    
				com_smcatgonoArr.forEach(function(item) {
			         item.addEventListener("change", function() {  // "change" 대신에 "click" 을 해도 무방함.
			         //	 console.log(item);
			        	 calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
			         });
			    });// end of com_smcatgonoArr.forEach(function(item) {})---------------------

			}
			
			else {
				   $("input#allComCal").prop("checked",false);
			}
			
		});// end of $(document).on("click","input:checkbox[name=com_smcategChk]",function(){})--------
		
		
		// === 팀별일정 체크박스 전체 선택/전체 해제 === //
		$("input:checkbox[id=allTeamCal]").click(function(){		
			var bool = $(this).prop("checked");
			$("input:checkbox[name=team_smcategChk]").prop("checked", bool);
		});// end of $("input:checkbox[id=allTeamCal]").click(function(){})-------
		
		
		// === 팀별일정 에 속한 특정 체크박스를 클릭할 경우 === 
		$(document).on("click","input:checkbox[name=team_smcategChk]",function(){	
			var bool = $(this).prop("checked");
			
			if(bool){ // 체크박스에 클릭한 것이 체크된 것이라면 
				
				var flag=false;
				
				$("input:checkbox[name=team_smcategChk]").each(function(index, item){
					var bChecked = $(item).prop("checked");
					
					if(!bChecked){     // 체크되지 않았다면 
						flag=true;     // flag 를 true 로 변경
						return false;  // 반복을 빠져 나옴.
					}
				}); // end of $("input:checkbox[name=com_smcategChk]").each(function(index, item){})---------

				if(!flag){ // 사내캘린더 에 속한 서브캘린더의 체크박스가 모두 체크가 되어진 경우라면 			
	                $("input#allTeamCal").prop("checked",true); // 사내캘린더 체크박스에 체크를 한다.
				}
				
				var com_smcatgonoArr = document.querySelectorAll("input.team_smcategChk");
			    
				com_smcatgonoArr.forEach(function(item) {
			         item.addEventListener("change", function() {  // "change" 대신에 "click" 을 해도 무방함.
			         //	 console.log(item);
			        	 calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
			         });
			    });// end of com_smcatgonoArr.forEach(function(item) {})---------------------

			}
			
			else {
				   $("input#allTeamCal").prop("checked",false);
			}
			
		});// end of $(document).on("click","input:checkbox[name=team_smcategChk]",function(){})--------
		
		
		// === 개인일정 체크박스 전체 선택/전체 해제 === //
		$("input:checkbox[id=allMyCal]").click(function(){		
			var bool = $(this).prop("checked");
			$("input:checkbox[name=my_smcategChk]").prop("checked", bool);
		});// end of $("input:checkbox[id=allMyCal]").click(function(){})-------
		
		
		// === 개인일정 에 속한 특정 체크박스를 클릭할 경우 === 
		$(document).on("click","input:checkbox[name=my_smcategChk]",function(){	
			var bool = $(this).prop("checked");
			
			if(bool){ // 체크박스에 클릭한 것이 체크된 것이라면 
				
				var flag=false;
				
				$("input:checkbox[name=my_smcategChk]").each(function(index, item){
					var bChecked = $(item).prop("checked");
					
					if(!bChecked){     // 체크되지 않았다면 
						flag=true;     // flag 를 true 로 변경
						return false;  // 반복을 빠져 나옴.
					}
				}); // end of $("input:checkbox[name=com_smcategChk]").each(function(index, item){})---------

				if(!flag){ // 사내캘린더 에 속한 서브캘린더의 체크박스가 모두 체크가 되어진 경우라면 			
	                $("input#allMyCal").prop("checked",true); // 사내캘린더 체크박스에 체크를 한다.
				}
				
				var com_smcatgonoArr = document.querySelectorAll("input.my_smcategChk");
			    
				com_smcatgonoArr.forEach(function(item) {
			         item.addEventListener("change", function() {  // "change" 대신에 "click" 을 해도 무방함.
			         //	 console.log(item);
			        	 calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
			         });
			    });// end of com_smcatgonoArr.forEach(function(item) {})---------------------

			}
			
			else {
				   $("input#allMyCal").prop("checked",false);
			}
			
		});// end of $(document).on("click","input:checkbox[name=my_smcategChk]",function(){})--------
		////////////////////////////////////////////////////////////////////////////////////////////////
		 
		 
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
			events:function(info, successCallback, failureCallback) {
	
				$.ajax({
					url: '<%= ctxPath%>/schedule/selectSchedule.on',
					data:{"empno":$('input#empno').val(),
						  "cpemail":$('input#cpemail').val()
	                 	  },
					dataType: "json",
	                success:function(json) {
						var events = [];
	                    if(json.length > 0){
	                         
							$.each(json, function(index, item) {
	                            var startdate = moment(item.startdate).format('YYYY-MM-DD HH:mm:ss');
	                            var enddate = moment(item.enddate).format('YYYY-MM-DD HH:mm:ss');
	                            var subject = item.subject;
	                              
                                // 전사일정 달력에 표시 
                               	if( $("input:checkbox[name=com_smcategChk]:checked").length <= $("input:checkbox[name=com_smcategChk]").length ){
                                
                                   	for(var i=0; i<$("input:checkbox[name=com_smcategChk]:checked").length; i++){
                             	  
                            			if($("input:checkbox[name=com_smcategChk]:checked").eq(i).val() == item.fk_smcatgono){
 			                                // alert("캘린더 소분류 번호 : " + $("input:checkbox[name=com_smcategChk]:checked").eq(i).val());
                              			    events.push({
	                          	                id: item.scheduleno,
	                                            title: item.subject,
	                                            start: startdate,
	                                            end: enddate,
	                                  	        url: "<%= ctxPath%>/schedule/viewSchedule.on?scheduleno="+item.scheduleno,
	                                            color: item.color,
	                                            cid: item.fk_smcatgono  
	                                            // 사내캘린더 내의 서브캘린더 체크박스의 value값과 일치하도록 만들어야 한다. 
	                                            // 그래야만 서브캘린더의 체크박스와 cid 값이 연결되어 체크시 풀캘린더에서 일정이 보여지고 체크해제시 풀캘린더에서 일정이 숨겨져 안보이게 된다. 
		                                	}); // end of events.push({})---------
 		                                }
                             	   
									}// end of for-------------------------------------
                              
								}// end of if-------------------------------------------
	                             
								
                             	// 팀별일정 달력에 표시 
                                if( $("input:checkbox[name=team_smcategChk]:checked").length <= $("input:checkbox[name=team_smcategChk]").length ){
	                                   
									for(var i=0; i<$("input:checkbox[name=team_smcategChk]:checked").length; i++){
	                                
										if($("input:checkbox[name=team_smcategChk]:checked").eq(i).val() == item.fk_smcatgono && item.department == "${sessionScope.loginuser.department}" ){
	   			                        	//  alert("캘린더 소분류 번호 : " + $("input:checkbox[name=my_smcatgono]:checked").eq(i).val());
	                                		events.push({
			                                	id: item.scheduleno,
                                                title: item.subject,
                                                start: startdate,
                                                end: enddate,
                                        	    url: "<%= ctxPath%>/schedule/viewSchedule.on?scheduleno="+item.scheduleno,
                                                color: item.color,
                                                cid: item.fk_smcatgono  
                                        	}); // end of events.push({})---------
										}
										
									}// end of for-------------------------------------
                                 
								}// end of if-------------------------------------------
								
								
								// 개인일정 달력에 표시 
                                if( $("input:checkbox[name=my_smcategChk]:checked").length <= $("input:checkbox[name=my_smcategChk]").length ){
	                                   
									for(var i=0; i<$("input:checkbox[name=my_smcategChk]:checked").length; i++){
	                                
										if($("input:checkbox[name=my_smcategChk]:checked").eq(i).val() == item.fk_smcatgono && item.empno == "${sessionScope.loginuser.empno}" ){
	   			                        	//  alert("캘린더 소분류 번호 : " + $("input:checkbox[name=my_smcatgono]:checked").eq(i).val());
	                                		events.push({
			                                	id: item.scheduleno,
                                                title: item.subject,
                                                start: startdate,
                                                end: enddate,
                                        	    url: "<%= ctxPath%>/schedule/viewSchedule.on?scheduleno="+item.scheduleno,
                                                color: item.color,
                                                cid: item.fk_smcatgono 
											}); // end of events.push({})---------
										}
										
									}// end of for-------------------------------------
                                 
								}// end of if-------------------------------------------

								
                             	// 공유일정
                                if (  (item.fk_lgcatgono == 2 && item.department != "${sessionScope.loginuser.department}" && item.empno != "${sessionScope.loginuser.empno}" && (item.joinuser).indexOf("${sessionScope.loginuser.cpemail}") != '-1')
                                		|| (item.fk_lgcatgono == 3 && item.empno != "${sessionScope.loginuser.empno}" && (item.joinuser).indexOf("${sessionScope.loginuser.cpemail}") != '-1') ){  
                                      
									events.push({
                          				id: "0",  // "0" 인 이유는  배열 events 에 push 할때 id는 고유해야 하는데 위의 사내캘린더 및 내캘린더에서 push 할때 id값으로 item.scheduleno 을 사용하였다. item.scheduleno 값은 DB에서 1 부터 시작하는 시퀀스로 사용된 값이므로 0 값은 위의 사내캘린더나 내캘린더에서 사용되지 않으므로 여기서 고유한 값을 사용하기 위해 0 값을 준 것이다. 
                                        title: item.subject,
                                        start: startdate,
                                        end: enddate,
                                	    url: "<%= ctxPath%>/schedule/viewSchedule.on?scheduleno="+item.scheduleno,
                                        color: item.color,
                                        cid: "0"  // "0" 인 이유는  공유받은캘린더 에서의 체크박스의 value 를 "0" 으로 주었기 때문이다.
									}); // end of events.push({})--------- 
	                                   
                        		}// end of if------------------------- 
								
							}); // end of $.each(json, function(index, item) {})-----------------------
							
						} // end of if(json.length > 0)                            
	                         
	                    // console.log(events);                       
                    	successCallback(events);                               
					},
				    error: function(request, status, error){
				    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}	
	                                            
				}); // end of $.ajax()--------------------------------
	        
			}, // end of events:function(info, successCallback, failureCallback) {}---------
			// ===================== DB 와 연동하는 법 끝 ===================== //
		    
		    
			// 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
		    dateClick: function(info) {
		    	// alert('클릭한 Date: ' + info.dateStr); // 클릭한 Date: 2021-11-20
	      		$(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
	      	    info.dayEl.style.backgroundColor = '#f9f9f9'; // 클릭한 날짜의 배경색 지정하기
	      	    $("form > input[name=chooseDate]").val(info.dateStr);
	      	    
	      	    var frm = document.dateFrm;
	      	    frm.action="<%= ctxPath%>/schedule/insertSchedule.on";
	      	    frm.submit();
			}, // end of dateClick: function(info)
      	  

			// === 전사일정, 팀별일정, 개인일정, 공유일정의 체크박스에 체크유무에 따라 일정을 보여주거나 일정을 숨기게 하는 것이다. === 
	    	eventDidMount: function (arg) {
		    	var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
		        // 사내캘린더, 내캘린더, 공유받은캘린더 에서의 모든 체크박스임
		            
		        arr_calendar_checkbox.forEach(function(item) { // item 이 전사일정, 팀별일정, 개인일정, 공유일정의 모든 체크박스 중 하나인 체크박스임
			    	if (item.checked) { 
			    		// === 전사일정, 팀별일정, 개인일정, 공유일정의 체크박스중 체크박스에 체크를 한 경우 라면
			                
			        	if (arg.event.extendedProps.cid === item.value) { // item.value 가 체크박스의 value 값이다.
			             // 	 console.log("일정을 보여주는 cid : "  + arg.event.extendedProps.cid);
			             // 	 console.log("일정을 보여주는 체크박스의 value값(item.value) : " + item.value);
			                    
			              	arg.el.style.display = "block"; // 풀캘린더에서 일정을 보여준다.
			            }
					} else { 
						// === 전사일정, 팀별일정, 개인일정, 공유일정의 체크박스중 체크박스에 체크를 해제한 경우 라면
			                
						if (arg.event.extendedProps.cid === item.value) {
	            	//	 console.log("일정을 숨기는 cid : "  + arg.event.extendedProps.cid);
	                //	 console.log("일정을 숨기는 체크박스의 value값(item.value) : " + item.value);
			                	
	            			arg.el.style.display = "none"; // 풀캘린더에서 일정을  숨긴다.
			            }
					}
				});// end of arr_calendar_checkbox.forEach(function(item) {})------------
			}
      	  
		}); // end of var calendar = new FullCalendar.Calendar(calendarEl,
		
		calendar.render();  // 풀캘린더 보여주기
		
		var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
		// 전사일정, 팀별일정, 개인일정, 공유일정의 체크박스
		
		arr_calendar_checkbox.forEach(function(item) {
	 		item.addEventListener("change", function () {
	     		// console.log(item);
				calendar.refetchEvents(); // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
			});
    	});
		//==== 풀캘린더와 관련된 소스코드 끝(화면이 로드되면 캘린더 전체 화면 보이게 해줌) ==== //

		
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
		

		// 검색 할 때 엔터를 친 경우
		$("input#searchWord").keyup(function(event){
			if(event.keyCode == 13){ 
				goSearch();
			}
		});
	
	
	}); // end of ready


	// ===== function declaration =====
		
	// 일정 검색하는 메소드
	function goSearch( ){
		
		if( $("#fromDate").val() > $("#toDate").val() ) {
			swal("검색 종료 날짜를 검색 시작 날짜 이후로 설정해주세요.");
			return;
		}
	    
	   	var frm = document.searchScheduleFrm;
	    frm.method="get";
	    frm.action="<%= ctxPath%>/schedule/searchSchedule.on";
	    frm.submit();
		
	} // end of function goSearch
	
	
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

		<form name="searchScheduleFrm">
			<table style="width:100%;">
				<tr style="vertical-align: middle;">
					<th><label class="mr-5 search_title" for="searchType" >검색분류</label></th>
					<td>
						<select id="searchType" name="searchType" >
							<option value="">전체 검색</option>
							<option value="subject">일정명</option>
							<option value="content">일정내용</option>
							<option value="joinuser">참석자</option>
						</select>
					</td>
				</tr>
				<tr style="vertical-align: middle;">
					<th><label class="mr-5 search_title" for="fk_lgcatgono">일정분류</label></th>
					<td>
						<select id="fk_lgcatgono" name="fk_lgcatgono">
							<option value="">모든 일정</option>
							<option value="1">전사 일정</option>
							<option value="2">팀별 일정</option>
							<option value="3">개인 일정</option>
						</select>
					</td>
				</tr>
				<tr style="vertical-align: middle;">
					<th><label class="mr-5 search_title" for="searchWord">검색어</label></th>
					<td>
						<input type="text" id="searchWord" name="searchWord" placeholder="검색어를 입력하세요." style="width: 90%;">
						<button class="btn bg-light mt-1" style="width: 9%; height: 44px;" onclick="goSearch();">검색</button>
					</td>
				</tr>
				<tr style="vertical-align: middle;">
					<th>
						<label class="mr-5 search_title" for="fromDate">검색기간</label>
					</th>
					<td>
						<input type="text" id="fromDate" name="startdate" style="width:48.1%;" readonly="readonly">
						&nbsp;&nbsp;-&nbsp;&nbsp;  
			            <input type="text" id="toDate" name="enddate" style="width:48.1%;" readonly="readonly">
					</td>
				</tr>
			</table>
			<input type="hidden" id="empno" name="empno" value="${sessionScope.loginuser.empno}">
			<input type="hidden" id="cpemail" name="cpemail" value="${sessionScope.loginuser.cpemail}">
		</form>
		
	</div>
	
	
	<%-- 풀캘린더가 보여지는 엘리먼트  --%>
	<div id="calendar" style="margin: 100px 20px 50px 0;" ></div>


</div>    


<%-- === 마우스로 클릭한 날짜의 일정 등록을 위한 폼 === --%>     
<form name="dateFrm">
	<input type="hidden" name="chooseDate" />	
</form>	

