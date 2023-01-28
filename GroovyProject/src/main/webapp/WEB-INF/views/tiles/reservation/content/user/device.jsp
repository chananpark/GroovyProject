<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	
	.time_hover:hover {
		background-color: #E3F2FD;
		cursor: pointer;
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

	.alreadyReserv {
		background-color: #e9ecef;
	}
	
	.alreadyReserv:hover {
		pointer-events: none;
	}
	
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 첫창에서 오늘 날짜 선택하게 만들기
		let offset = now.getTimezoneOffset() * 60000; //ms단위라 60000곱해줌
		let dateOffset = new Date(now.getTime() - offset);	
		var today_date = dateOffset.toISOString().substring(0, 10);
	    $("input#reservStartDate").val(today_date);

	    // insertReservation 에 넣어줄 변수인 클릭한 날짜 잡아오기
	   	var selectDate =  $("input#reservStartDate").val();
	    
		// 화면 로딩될 때 처음으로 ajax를 불러오고 그 다음에 change 일 때 그에 따른 ajax를 다시 불러와야 해당하는 selectDate 가 변한다
	    callReservationTable(selectDate);
		
		// input date 의 값이 변할 때
	    $("input#reservStartDate").change(function(){
			selectDate = $("input#reservStartDate").val();
	    	
	    	var str_selectDay = selectDate.substring(0,4).toString() + selectDate.substring(5,7).toString() + selectDate.substring(8,10).toString();
	    	
	    	// 현재 시간 날짜 구해오기
			var now_year = now.getFullYear();
			var now_month = now.getMonth();
			var now_date = now.getDate();
			var now_hours = now.getHours();
			
			if(now_month < 10) {
				now_month = "0"+(now_month+1);
			} else {
				now_month = now_month + 1;
			}
			
			if(now_date < 10) {
				now_date = "0"+now_date;
			} 
			
			if(now_hours < 10) {
				now_hours = "0"+now_hours;
			} 
			
			var now_day =  now_year.toString() + now_month.toString() + now_date.toString();
	    	
	    	if(Number(str_selectDay) < Number(now_day)) {
	    		swal("지난 날짜는 예약할 수 없습니다.");
				$("input#reservStartDate").val(today_date);
	    		return;
	    	} else {
	    		// 타임테이블 불러오는 메소드
		    	callReservationTable(selectDate);
		    	
		    	// 예약된 시간 보여주면서 예약 못하게 막아주는 메소드		
			    reservTime(selectDate);
		    	
			 	// 이전 날짜 선택 막기
		    	blockSelectDate(selectDate);
	    	}
	    	
	    }); // end of  $("input#reservStartDate").change(function()
	    
	   
		// 예약된 시간 보여주면서 예약 못하게 막아주는 메소드		
	    reservTime(selectDate);
	
	}); // end of ready
	
	
	// 예약된 시간 보여주면서 예약 못하게 막아주는 메소드
	function reservTime(selectDate) {
		
		var str_selectDay = selectDate.substring(0,4).toString() + selectDate.substring(5,7).toString() + selectDate.substring(8,10).toString();
		
		$.ajax({
			url:"<%= ctxPath%>/reservation/reservTime.on",
			type:"get",
			data:{"fk_lgcatgono":2,
				  "selectDate":selectDate},
			dataType:"json",
			success:function(json){

				// 선택한 날짜에 예약 목록이 있을 경우
				if(json.length > 0){
				
					$.each(json, function(index, item){
						
						var str_startdate = item.startdate;
						var str_enddate = item.enddate;
						
						var sub_startdate = str_startdate.substring(0,8);
						var sub_enddate = str_enddate.substring(0,8);
						var sub_starttime = Number(str_startdate.substring(8,10));
						var sub_endtime = Number(str_enddate.substring(8,10));
						
						// 시작일자, 반납일자 모두 오늘일 경우
						if(sub_startdate == str_selectDay && sub_enddate == str_selectDay) {
							
							for(i=sub_starttime; i<sub_endtime; i++) {
								if(i < 10) {
									var reservtimeClass = "revtime" + item.fk_smcatgono + "0" +i;
									
									$("."+reservtimeClass).addClass("alreadyReserv"); 
									$("."+reservtimeClass).removeClass("time_hover");
								} else {
									var reservtimeClass = "revtime" + item.fk_smcatgono + i;
									
									$("."+reservtimeClass).addClass("alreadyReserv"); 
									$("."+reservtimeClass).removeClass("time_hover");
									
								}
							} // end of for
							
						// 시작일자는 오늘 이전이고 종료일자가 오늘일 경우	
						} else if(Number(sub_startdate) < Number(str_selectDay) && Number(sub_enddate) == Number(str_selectDay)) {
							
							for(i=0; i<sub_endtime; i++) {
								if(i < 10) {
									var reservtimeClass = "revtime" + item.fk_smcatgono + "0" +i;
									
									$("."+reservtimeClass).addClass("alreadyReserv"); 
									$("."+reservtimeClass).removeClass("time_hover");
								} else {
									var reservtimeClass = "revtime" + item.fk_smcatgono + i;
									
									$("."+reservtimeClass).addClass("alreadyReserv"); 
									$("."+reservtimeClass).removeClass("time_hover");
									
								}
							} // end of for
							
						// 시작일자는 오늘이전이고 종료일자가 오늘 이후일 경우	
						} else if(Number(sub_startdate) < Number(str_selectDay) && Number(sub_enddate) > Number(str_selectDay)) {
							
							for(i=0; i<24; i++) {
								
								if(i < 10) {
									var reservtimeClass = "revtime" + item.fk_smcatgono + "0" +i;
									
									$("."+reservtimeClass).addClass("alreadyReserv"); 
									$("."+reservtimeClass).removeClass("time_hover");
								} else {
									var reservtimeClass = "revtime" + item.fk_smcatgono + i;
									
									$("."+reservtimeClass).addClass("alreadyReserv"); 
									$("."+reservtimeClass).removeClass("time_hover");
									
								}
							} // end of for
							
						// 시작날짜는 오늘이고 종료날짜는 오늘 이후일 경우	
						} else if(Number(sub_startdate) == Number(str_selectDay) && Number(sub_enddate) > Number(str_selectDay)) {
							
							for(i=sub_starttime; i<24; i++) {
								if(i < 10) {
									var reservtimeClass = "revtime" + item.fk_smcatgono + "0" +i;
									
									$("."+reservtimeClass).addClass("alreadyReserv"); 
									$("."+reservtimeClass).removeClass("time_hover");
								} else {
									var reservtimeClass = "revtime" + item.fk_smcatgono + i;
									
									$("."+reservtimeClass).addClass("alreadyReserv"); 
									$("."+reservtimeClass).removeClass("time_hover");
									
								}
							} // end of for
						} // end of 시작날짜 ~ 종료날짜 addclass
						
						
						
					}); // end of each
					
				} // end of if
				 
			 },
			 error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		     }	 	
		}); // end of ajax
		
		
	} // end of function reservTime()
	

	// 타임테이블 불러오는 메소드
	function callReservationTable(selectDate) {
		
		$.ajax({
			url:"<%= ctxPath%>/reservation/reservationTable.on",
			type:"get",
			data:{"fk_lgcatgono":2},
			dataType:"json",
			success:function(json){
				var html = "";
				if(json.length > 0){
					html += "<table class='table' style='border-left: none !important; border-right: none;'>";
					html += "<tr>";
					html += "<td>&nbsp;&nbsp;</td>";
					for(i=0; i<24; i++) {
				    	if(i<10) {
				    		html +=  "<td>"+'0'+i+"</td>";
				    	} else {
				    		html +=  "<td>"+i+"</td>";
				    	}
				    }; // end of for
					html += "</tr>";
					
					html += "<tr>";	 
					 
					$.each(json, function(index, item){
						
						if(item.sc_status == 1) {
							html += "<td>"+item.smcatgoname+"</td>";
							for(i=0; i<24; i++) { 
								if(i<10) {
									html +=  "<td id='mtr"+item.smcatgono+"' class='time_hover time0"+i+" revtime"+item.smcatgono+"0"+i+"' onclick='insertReservation(\""+selectDate+"\", \"0"+i+"\", 2, \""+item.smcatgono+"\");' >&nbsp;&nbsp;</td>";
						    	} else {
						    		html +=  "<td id='mtr"+item.smcatgono+"' class='time_hover time"+i+" revtime"+item.smcatgono+i+"' onclick='insertReservation(\""+selectDate+"\", \""+i+"\", 2, \""+item.smcatgono+"\");' >&nbsp;&nbsp;</td>";
						    	}
							} // end of for
							html += "</tr>";
						}
						
					}); // end of each
					 
					html += "</table>";
					
				} // end of if
				$("div#selectTimeTable").html(html);
				 
			 },
			 error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		     }	 	
		}); // end of ajax
		
	} // end of function callReservationTable() 

	
			
			
</script>



<div style='margin: 1% 0 5% 1%; display: flex;'>
	<h4>기기 예약</h4>
</div>

<div id="reservationFormat" style="width:95%; margin: 0 auto;">
	<div class="jumbotron">
	    <div class="container">
			${lvo.lgcategcontent}
	    </div>
	    <c:if test="${sessionScope.loginuser.department == '인사총무팀'}">
        	<div class="container" style="text-align: right; margin-top: 20px;"><i class="btn fas fa-tools fa-lg" style="color:#6c757d;" onclick="goEditContent(2);"></i></div>
        </c:if>
	</div>
	
		
	<%-- 오늘 날짜 선택 --%>
	<div class="reservation_title" id="reservSelectDate">
		<span class="reservation_title_item mr-3" style="font-size: 15pt;" >예약일자</span>
		<span class="reservation_title_item mb-1">
			<input class="date_style" type="date" id="reservStartDate"/>
		</span>
	</div>

	<%-- 시간 선택 --%>
	<div id="selectTimeTable"></div>
	
	
</div>


<%-- === 마우스로 클릭한 날짜의 예약을 위한 폼 === --%>   
<form name="reservFrm">
	<input type="hidden" name="chooseDate" />	
</form>	


<%-- 자원 안내 수정 폼 --%>
<form name="editContentFrm">
	<input type="hidden" name="lgcatgono" />	
	<input type="hidden" name="listgobackURL_reserv" value="${requestScope.listgobackURL_reserv}"/>
</form>	
