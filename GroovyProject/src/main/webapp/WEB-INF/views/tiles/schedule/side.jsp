<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	#insertBtn:hover{
		border: 1px solid #086BDE;
		color: white;
		background-color: #086BDE;
	}
	
	.checkbox_color {
	  accent-color: #086BDE;
	}
	
	.icon-right {
		float:right;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		
		
		
		
		
	}); // end of ready


	
	// ===== function declaration =====
	
	// 일정 등록 메소드
	function insertSchedule() {
		
		location.href="<%=ctxPath %>/schedule/insertSchedule.on";
		
	} // end of function insertSchedule
		
		
	// === 사내 캘린더 소분류 추가를 위해 +아이콘 클릭시 ===
	function addComCalendar(){
		$('#modal_addComCal').modal('show'); // 모달창 보여주기	
	}// end of function addComCalendar(){}--------------------
	
</script>

<!-- A vertical navbar -->
<nav class="navbar bg-light">

	<!-- Links -->
  	<ul class="navbar-nav" style='width:100%;'>
    	<li class="nav-item">
      		<h4 class='mb-4'>일정관리</h4>
    	</li>
    	<li class="nav-item mb-4">
      		<button id="insertBtn" type="button" style='width:100%;' class="btn btn-outline-dark" onclick="insertSchedule();">일정등록</button>
   	 	</li>
   	 	
    	<li class="nav-item">
    		<%-- <div class="mb-3"><a href="<%=ctxPath %>/schedule.on">일정관리 홈</a></div> --%>
    		
      		<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
      		<label for="allComCal">전사일정</label><i class="fas fa-plus icon-right text-secondary" onclick="addComCalendar();"></i>
      		<ul>
	      		<li>
	      			<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
	      			<label for="allComCal">교육일정</label><i class="ml-1 far fa-edit icon-right text-secondary"></i><i class="ml-3 fas fa-trash-alt icon-right text-secondary"></i>
	      		</li>
	      		<li>
	      			<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
	      			<label for="allComCal">중요일정</label><i class="ml-1 far fa-edit icon-right text-secondary"></i><i class="ml-3 fas fa-trash-alt icon-right text-secondary"></i>
	      		</li>
	      	</ul>
    	</li>
    	
    	<li class="nav-item">
      		<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
      		<label for="allComCal">팀별일정</label><i class="fas fa-plus icon-right text-secondary" onclick="addComCalendar();"></i>
      		<ul>
	      		<li>
	      			<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
	      			<label for="allComCal">팀회의</label><i class="ml-1 far fa-edit icon-right text-secondary"></i><i style="float:right;" class="ml-1 fas fa-trash-alt icon-right text-secondary"></i>
	      		</li>
	      		<li>
	      			<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
	      			<label for="allComCal">휴가</label><i class="ml-1 far fa-edit icon-right text-secondary"></i><i class="ml-3 fas fa-trash-alt icon-right text-secondary"></i>
	      		</li>
	      	</ul>
    	</li>
    	
    	<li class="nav-item">
      		<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
      		<label for="allComCal">개인일정</label><i class="fas fa-plus icon-right text-secondary" onclick="addComCalendar();"></i>
      		<ul>
	      		<li>
	      			<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
	      			<label for="allComCal">운동</label><i class="ml-1 far fa-edit icon-right text-secondary"></i><i class="ml-3 fas fa-trash-alt icon-right text-secondary"></i>
	      		</li>
	      		<li>
	      			<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
	      			<label for="allComCal">기타</label><i class="ml-1 far fa-edit icon-right text-secondary"></i><i class="ml-3 fas fa-trash-alt icon-right text-secondary"></i>
	      		</li>
	      	</ul>
    	</li>
  	</ul>

</nav>












<%-- === 사내 캘린더 추가 Modal === --%>
<div class="modal fade" id="modal_addComCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">일정 분류 추가</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-borderless">
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">소분류명</td>
     						<td><input type="text" class="add_com_smcatgoname"/></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">만든이</td>
     						<td style="text-align: left; padding-left: 11px;">알프레도 3세</td>
     					</tr>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      			<button type="button" style="background-color:#086BDE; color:white;" id="addCom" class="btn btn-sm" onclick="goAddComCal()">추가</button>
      		</div>
      
    	</div>
  	</div>
</div>



<%-- === 사내 캘린더 수정 Modal === --%>
<div class="modal fade" id="modal_editMyCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">일정 분류 수정</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-borderless">
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">소분류명</td>
     						<td><input type="text" class="add_com_smcatgoname"/></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">만든이</td>
     						<td style="text-align: left; padding-left: 11px;">알프레도 3세</td>
     					</tr>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      			<button type="button" style="background-color:#086BDE; color:white;" id="addCom" class="btn btn-sm" onclick="goEditComCal()">추가</button>
      		</div>
      
    	</div>
  	</div>
</div>
