<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	
	/* 상세 검색 숨기기 */
	.hide{display:none;}
	
	/* 검색 */
	#adminconfirm_div input[type=text], #adminconfirm_div select, #adminconfirm_div textarea {
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

	#confrim_list_table tbody > tr:hover {
		cursor: pointer;
	}
	
	#admin_confrim_table td {
		vertical-align: middle;
	}
	
	#admin_confrim_table tbody > tr:hover {
		cursor: pointer;
	}
	
	.modal_viewReservation_td {
		text-align: left; 
		vertical-align: middle;
		font-weight: bold;
	}

	
	.modal_viewReservation_content {
		text-align: left; 
		padding-left: 11px;
	}


</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 클릭하면 나타나기
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
		
		
		// 검색 열 클릭
		$("#admin_confrim_table tbody td.clicktd").click(function(e){
			
			const $target = $(e.target); // <td> 태그 이다. 왜냐하면 tr 속에 td가 있기 때문에
		//	console.log($target.parent());
		//	console.log("확인용 : "+ $target.parent().find("td[name='scheduleno']").text());
			
			// 클릭한 tr의 userid 알아오기
		//	const userid = $target.parent().find("td[name='userid']").text(); 
		//	console.log("확인용 : "+ userid);
		//	var scheduleno = $target;
			
			var reservationno = $target.parent().find(".reservationno").text();
			viewReservation(reservationno);
		}); // end of $("tbody > tr").click(function()
				
				
		// 취소 및 반납 버튼 만들기
		statusButton();
				
		if(${not empty requestScope.paraMap.startdate}) {
			$("input[name=startdate]").val("${requestScope.paraMap.startdate}");
			$("input[name=enddate]").val("${requestScope.paraMap.enddate}");
			$("select#searchType").val("${requestScope.paraMap.pagination.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.pagination.searchWord}");
		}
		
		
		
	}); // end of ready
	
	
	// 예약 내역 상세보기
	function viewReservation(reservationno) {
		
		$('#modal_viewReservation').modal('show');
		
		var reservationno = reservationno;
		
		$.ajax({
			url:"<%= ctxPath%>/reservation/viewReservation.on",
			data:{"reservationno":reservationno},
			dataType:"json",
			success:function(json){
				
				var html = "";

				$.each(json, function(index,item){
					html += "<tr>";
					html += 	"<td class='col-3 modal_viewReservation_td'>자원 예약 시간</td>";
					html += 	"<td class='modal_viewReservation_content'>"+item.startdate+"</td>";
					html += "</tr>";
					html += "<tr>";
					html += 	"<td class='modal_viewReservation_td'>자원 반납 시간</td>";
					html += 	"<td class='modal_viewReservation_content'>"+item.enddate+"</td>";
					html += "</tr>";
					html += "<tr>";
					html += 	"<td class='modal_viewReservation_td'>예약 항목</td>";
					html += 	"<td class='modal_viewReservation_content'>"+item.lgcatgoname+" : " +item.smcatgoname+"</td>";
					html += "</tr>";
					html += "<tr>";
					html += 	"<td class='modal_viewReservation_td'>실사용자</td>";
					html += 	"<td class='modal_viewReservation_content'>"+item.realuser+"</td>";
					html += "</tr>";
					html += "<tr>";
					html += 	"<td class='modal_viewReservation_td'>예약자</td>";
					html += 	"<td class='modal_viewReservation_content'>"+item.name+"("+item.cpemail+")</td>";
					html += "</tr>";
					html += "<tr>";
					html += 	"<td class='modal_viewReservation_td'>예약 상태</td>";
					html += 	"<td class='modal_viewReservation_content'>";
					
					if(item.status == 0) {
						html += "예약 완료";
					} else if(item.status == 1) {
						html += "예약 취소";
					} else if(item.status == 2) {
						html += "이용 완료";
					}
					
					html += 	"</td>";
					html += "</tr>";
					html += "<tr>";
					html += 	"<td class='modal_viewReservation_td'>승인 여부</td>";
					html += 	"<td class='modal_viewReservation_content'>";
					
					if(item.confirm == 0) {
						html += "승인 대기 중";
					} else if(item.confirm == 1) {
						html += "승인 완료";
					}
					
					html += 	"</td>";
					html += "</tr>";
					
					$("table#table_viewReservation").html(html);
				});
				
			},
			error: function(request, status, error){
		    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }	 	
		}); // end of ajax
		
		
	} // end of function viewReservation(reservationno)
	
	
	// 취소 및 반납 / 승인 버튼 만들기
	function statusButton() {
		
		$.ajax({
			url:"<%= ctxPath%>/reservation/statusButton.on",
			type:"post",
			dataType:"json",
			success:function(json){
				
				// 현재 시간 날짜 구해오기
				var now_year = now.getFullYear();
				var now_month = now.getMonth();
				var now_date = now.getDate();
				var now_hours = now.getHours();
				var now_minutes = now.getMinutes();
				
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
				
				if(now_minutes < 10) {
					now_minutes = "0"+now_minutes;
				}
				
				var now_day =  now_year.toString() + now_month.toString() + now_date.toString() + now_hours.toString() + now_minutes.toString();
				
				var html = "";

				if(json.length > 0){
					
					$.each(json, function(index, item){
						
						var rno = "rno"+item.reservationno;
						var returnbtn = "returnbtn" + item.reservationno
						var confirmbtn = "confirmbtn" + item.reservationno
						$("tr.reservCell").find(rno);
						
						var num_start_day = Number(item.startdate);
						var num_end_day = Number(item.enddate);
						var num_now_day = Number(now_day);
						
						// 취소 및 반납 버튼 만들기
						if((num_start_day > num_now_day) && item.status == 0) {
							// 이용 시간 이전 취소 버튼
							html = '<button class="btn bg-light" onclick="reservCancle('+item.reservationno+');">취소</button>';
							$("td."+returnbtn).html(html);
							
						} else if( (num_start_day <= num_now_day && num_end_day >= num_now_day) && item.status == 0) {
							// 이용 시간 중 반납 버튼
							html = '<button class="btn" style="color:black; background-color: #E3F2FD;" onclick="reservReturn('+item.reservationno+');">반납</button>';
							$("td."+returnbtn).html(html);
							
						} else if(num_end_day < num_now_day || item.status == 2) {
							// 이용 시간 후 이용 완료 문구
							html = '<button class="btn bg-white">이용 완료</button>';
							$("td."+returnbtn).html(html);
						} else if(item.status == 1) {
							// 예약 취소의 경우
							html = '<button class="btn bg-white">예약 취소</button>';
							$("td."+returnbtn).html(html);
						}
						
						var html2 = "";
						// 승인 버튼 만들기
						if(item.confirm == 0) {
							html2 = '<button class="btn" style="color:white; background-color: #086BDE;" onclick="reservConfirm('+item.reservationno+');">승인</button>';
							$("td."+confirmbtn).html(html2);
							
						} else if(item.confirm = 1) {
							html2 = '<button class="btn bg-white">승인 완료</button>';
							$("td."+confirmbtn).html(html2);
						}
						
					}); // end of each
					
				}	
			},
			error: function(request, status, error){
		    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }	 	
		}); // end of ajax
		
	} // end of function statusButton()
	
	
	// 검색 메소드
	function goSearch() {
		
		var frm = document.searchReservFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath %>/reservation/admin/adminConfirm.on";
		frm.submit();
		
	} // end of function goSearch
	

	
	// 예약 취소 메소드
	function reservCancle(reservationno) {
		
		swal({
			title: "",
			text: "자원 예약을 취소하시겠습니까?",
		  	icon: "warning",
		  	buttons: true,
		  	dangerMode: true,
		  	buttons: ["취소", "예약 취소"],
		})
		.then((willDelete) => {
			if (willDelete) {
				// 예약 취소
				
				var frm = document.reservationForm;
				$("input[name=reservationno]").val(reservationno);
				
				frm.method = "POST";
				frm.action = "<%= ctxPath %>/reservation/reservCancle.on";
				frm.submit();
				
		  	} else {
		  		// 취소
		    	swal("자원 예약 취소를 취소하였습니다.");
		  	}
		}); // end of swal-.then((willDelete)	
		
		
	} // end of function reservCancle() 
	
	
	
	// 자원 반납 메소드
	function reservReturn(reservationno) {
		
		// 현재 시간 날짜 구해오기
		var now_year = now.getFullYear();
		var now_month = now.getMonth();
		var now_date = now.getDate();
		var now_hours = now.getHours();
		var now_hours_plus = now_hours + 1;
		
		if(now_month < 10) {
			now_month = "0"+(now_month+1);
		} else {
			now_month = now_month + 1;
		}
		
		if(now_date < 10) {
			now_date = "0"+now_date;
		} 
		
		if(now_hours_plus < 10) {
			now_hours_plus = "0"+now_hours_plus;
		} 
		
		var now_day =  now_year.toString() + now_month.toString() + now_date.toString() + now_hours_plus.toString() + "0000";
		
		swal({
			title: "",
			text: "자원을 반납하시겠습니까?",
		  	icon: "warning",
		  	buttons: true,
		  	dangerMode: true,
		  	buttons: ["취소", "반납"],
		})
		.then((willDelete) => {
			if (willDelete) {
				// 반납
				var frm = document.reservationForm;
				$("input[name=reservationno]").val(reservationno);
				$("input[name=hidden_enddate]").val(now_day);
				
				frm.method = "POST";
				frm.action = "<%= ctxPath %>/reservation/reservReturn.on";
				frm.submit();
				
		  	} else {
		  		// 취소
		    	swal("자원 반납을 취소하였습니다.");
		  	}
		}); // end of swal-.then((willDelete)	
		
		
	} // end of function reservReturn()
	
	
	
	// 자원 예약 승인 메소드
	function reservConfirm(reservationno) {
		
		swal({
			title: "",
			text: "자원 예약을 승인하시겠습니까?",
		  	icon: "info",
		  	buttons: true,
		  	buttons: ["취소", "승인"],
		})
		.then((willDelete) => {
			if (willDelete) {
				// 승인
				
				var frm = document.reservationForm;
				$("input[name=reservationno]").val(reservationno);
				
				frm.method = "POST";
				frm.action = "<%= ctxPath %>/reservation/reservConfirm.on";
				frm.submit();
				
		  	} else {
		  		// 취소
		    	swal("자원 예약 승인을 취소하였습니다.");
		  	}
		}); // end of swal-.then((willDelete)	
		
	} // end of function reservConfirm()
	

</script>


<div id="adminconfirm_div"> 

	<div style='margin: 1% 0 5% 1%; display: flex;'>
		<h4>예약 내역 승인</h4>
		<button id="search_btn" class="bg-white text-end ml-3" style="border: none; color:#ccc;"><i class="fas fa-search fa-1x"></i></button> 
	</div>
	
	<div class="hide" id="detail_search" style="width:90%; margin:0 0 100px 5%;">
	
		<form name="searchReservFrm">
			<table style="width:100%;">
				<tr style="vertical-align: middle;">
					<th><label class="mr-5 search_title" for="searchType">예약 항목</label></th>
					<td>
						<select id="searchType" name="searchType">
							<option value="">모든 예약</option>
							<option value="1">회의실 예약</option>
							<option value="2">기기 예약</option>
							<option value="3">차량 예약</option>
						</select>
					</td>
				</tr>
				<tr style="vertical-align: middle;">
					<th><label class="mr-5 search_title" for="searchWord">검색어</label></th>
					<td>
						<input type="text" id="searchWord" name="searchWord" placeholder="예약자명 및 실사용자명을 입력하세요." style="width: 90%;">
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
		            	<input type="hidden" name="listgobackURL_reserv" value="${requestScope.listgobackURL_reserv}"/>
					</td>
				</tr>
			</table>
		</form>
		
	</div>
	

	<table id="admin_confrim_table" class="table" style="margin: 0px 20px 50px 0;">
		
		<thead style="width:100%;">
			<tr class="text-center">
				<th class="col-4">예약 일자</th>
				<th class="col-3">예약 항목</th>
				<th class="col-1">예약자</th>
				<th class="col-2">취소 및 반납</th>
				<th class="col-2">승인</th>
			</tr>
		</thead>	
		<tbody>
		
			<c:if test="${empty requestScope.reservList}">
				<tr>
					<td colspan="5" style="text-align: center;">검색 결과가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty requestScope.reservList}">
				<c:forEach var="map" items="${requestScope.reservList}">
					<tr class="reservCell">
						<td style="display: none;" class="reservationno rno${map.reservationno} text-center" >${map.reservationno}</td>
						<td class="text-center clicktd">
							${map.startdate_view} ~ ${map.enddate_view}
						</td>
						<td class="text-center clicktd">
						
							<c:if test="${map.fk_lgcatgono eq '1'}">회의실</c:if>
							<c:if test="${map.fk_lgcatgono eq '2'}">기기</c:if>
							<c:if test="${map.fk_lgcatgono eq '3'}">차량</c:if>
							 : ${map.smcatgoname}
						 </td>
						<td class="text-center clicktd">${map.name}</td> 
						<td class="text-center returnbtn${map.reservationno}" style="vertical-align: middle;"></td>
						<td class="text-center confirmbtn${map.reservationno}" style="vertical-align: middle;"></td>
					</tr>
				</c:forEach>
			</c:if> 
			
		</tbody>
	</table>
	${pagebar}

</div>



<%-- 예약 관련 frm --%>
<form name="reservationForm">
	<input type="hidden" name="reservationno" value="">
	<input type="hidden" name="hidden_enddate" value="">
	<input type="hidden" name="listgobackURL_reserv" value="${requestScope.listgobackURL_reserv}"/>
</form>


<%-- 자원 상세보기 모달창 --%>
<div class="modal fade" id="modal_viewReservation" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">자원 예약 상세보기</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="addReservation_frm">
       				<table id="table_viewReservation" style="width: 100%;" class="table table-borderless">
     					
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      		</div>
      
    	</div>
  	</div>
</div>






