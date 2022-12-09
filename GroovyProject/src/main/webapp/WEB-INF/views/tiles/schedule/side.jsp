<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		margin-top: 5px;
		float:right;
	}
	
	.side_vertical {
		display: flex;
		align-items: center;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 전사일정 소분류 보여주기
		showCompanyCal();
		// 팀별일정 소분류 보여주기
		showTeamCal();
		// 개인일정 소분류 보여주기
		showMyCal();
		
	}); // end of ready


	
	// ===== function declaration =====
	
	// 일정 등록 메소드
	function insertSchedule() {
		
		location.href="<%=ctxPath %>/schedule/insertSchedule.on";
		
	} // end of function insertSchedule
		
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// === 전사일정 소분류 추가를 위해 +아이콘 클릭시 ===
	function addComCalendar(){
		$('#modal_addComCal').modal('show'); // 모달창 보여주기	
	}// end of function addComCalendar(){}--------------------
	
	
	// === 전사일정 소분류 추가 모달에서 추가 버튼 클릭
	function goAddComCal() {
		
		if($(".add_com_smcatgoname").val().trim() == "") {
			swal("추가할 전사일정 분류명을 입력하세요.");
			return;
		} else {
			$.ajax({

				url:"<%= ctxPath%>/schedule/addComCalendar.on",		
				type:"post",
				data: {
					"com_smcatgoname":$(".add_com_smcatgoname").val(),
					"cal_side_empno":"${sessionScope.loginuser.empno}"
				},
				dataType:"json",
				success:function(json) {
					if(json.n != 1) {
						swal("이미 존재하는 전사일정 분류명 입니다.");
						return;
					} else if(json.n == 1) {
						$("#modal_addComCal").modal('hide');
						swal("일정 분류가 정상적으로 추가되었습니다.");
						
						$(".add_com_smcatgoname").val("");
						showCompanyCal(); // 전사일정 소분류
					}
				}, // end of success
				error: function(request, status, error){
	  	        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    	    }	 
			}); // end of ajax
		}

	} // end of function goAddComCal()
	
	
	// === 전사일정 소분류 보여주기  === //
	function showCompanyCal(){
		$.ajax({
			url:"<%= ctxPath%>/schedule/showCompanyCalendar.on",
			type:"get",
			dataType:"json",
			success:function(json){
				var html = "";
				if(json.length > 0){
					
					html += "<li>";
					
					$.each(json, function(index, item){
						html += '<div class="side_vertical">';
						html += '<input name="com_smcategChk" type="checkbox" id="ComCal'+item.smcatgono+'" value="'+item.smcatgono+'" class="calendar_checkbox checkbox_color mr-2 com_smcategChk" checked/><label class="pt-1 mb-0" style="width:70px;" for="ComCal'+item.smcatgono+'">'+item.smcatgoname+'</label>';
						
						// 인사총무팀만 전사일정 수정, 삭제 가능
						if("${sessionScope.loginuser.department}" == '인사총무팀') {						
				      		html += '<span><i class="ml-2 far fa-edit text-secondary" onclick="editComCalCateg('+item.smcatgono+',\''+item.smcatgoname+'\')"></i></span>';
				      		html += '<span><i class="ml-1 fas fa-trash-alt text-secondary" onclick="delCalCateg('+item.smcatgono+',\''+item.smcatgoname+'\')"></i></span></div>';
						} else {
							html += '<span><i style="color:#f9f9f9;" class="ml-2 far fa-edit")"></i></span>';
				      		html += '<span><i style="color:#f9f9f9;" class="ml-1 fas fa-trash-alt")"></i></span></div>';
						}
						 
					}); // end of each	
					
					html += "</li><br>";
					
				} // end of if
				 $("#comSmallCateg").html(html);
			}, // end of success
			error: function(request, status, error){
		           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }	 	
		}); // end of ajax

	}// end of function showCompanyCal()------------------	
	
	
	// === 전사일정 소분류 수정 모달창 나타내기 === 
	function editComCalCateg(smcatgono, smcatgoname){
		$('#modal_editComCal').modal('show'); // 모달 보이기
		$("input.edit_com_smcatgono").val(smcatgono);
		$("input.edit_com_smcatgoname").val(smcatgoname);
	}// end of function editComCalCateg(smcatgono, smcatgoname){}----------------------
	
	// === 전사일정 소분류 수정 모달창에서 수정 클릭 ===
	function goEditComCal() {
		
		if($("input.edit_com_smcatgoname").val().trim() == ""){
	  		swal("수정할 전사일정 분류명을 입력하세요.");
	  		 return;
	  	} else {
			$.ajax({
				url:"<%= ctxPath%>/schedule/editCalendar.on",
				type: "post",
				data:{
					"smcatgono":$("input.edit_com_smcatgono").val(), 
					"smcatgoname": $("input.edit_com_smcatgoname").val(), 
					"empno":"${sessionScope.loginuser.empno}",
					"caltype":"1"  // 전사일정
				},
				dataType:"json",
				success:function(json){
					if(json.n == 0){
	   					swal($("input.edit_com_smcatgoname").val()+"은(는) 이미 존재하는 분류명입니다.");
	   					return;
	   				 }
					if(json.n == 1){
						$('#modal_editComCal').modal('hide'); // 모달 숨기기
						swal("일정 분류가 정상적으로 수정되었습니다.");
						showCompanyCal();
					}
				},
				error: function(request, status, error){
			    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			}); // end of ajax
		} // end of else 
		
	} // end of function goEditComCal()
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// === 팀별일정 소분류 추가를 위해 +아이콘 클릭시 ===
	function addTeamCalendar(){
		$('#modal_addTeamCal').modal('show'); // 모달창 보여주기	
	}// end of function addTeamCalendar(){}--------------------
	
	
	// === 팀별일정 소분류 추가 모달에서 추가 버튼 클릭 ===
	function goAddTeamCal() {
		if($(".add_team_smcatgoname").val().trim() == "") {
			swal("추가할 팀별 일정 분류명을 입력하세요.");
			return;
		} else {
			$.ajax({

				url:"<%= ctxPath%>/schedule/addTeamCalendar.on",		
				type:"post",
				data: {
					"team_smcatgoname":$(".add_team_smcatgoname").val(),
					"cal_side_empno":"${sessionScope.loginuser.empno}"
				},
				dataType:"json",
				success:function(json) {
					if(json.n != 1) {
						swal("이미 존재하는 팀별일정 분류명 입니다.");
						return;
					} else if(json.n == 1) {
						$("#modal_addTeamCal").modal('hide');
						swal("일정 분류가 정상적으로 추가되었습니다.");
						
						$(".add_team_smcatgoname").val("");
						showTeamCal(); // 팀별일정 소분류
					}
				}, // end of success
				error: function(request, status, error){
	  	        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    	    }	 
			}); // end of ajax
		}
	} // end of function goAddTeamCal()
	

	// === 팀별일정 소분류 보여주기  === //
	function showTeamCal(){
		$.ajax({
			url:"<%= ctxPath%>/schedule/showTeamCalendar.on",
			type:"get",
			data:{"dept":"${sessionScope.loginuser.department}"},
			dataType:"json",
			success:function(json){
				var html = "";
				if(json.length > 0){
					
					html += "<li>";
					
					$.each(json, function(index, item){
						html += '<div class="side_vertical">';
						html += '<input name = "team_smcategChk" type="checkbox" id="teamCal'+item.smcatgono+'" value="'+item.smcatgono+'" class="calendar_checkbox checkbox_color mr-2 team_smcategChk" checked/><label class="pt-1 mb-0"  style="width:70px;" for="teamCal'+item.smcatgono+'">'+item.smcatgoname+'</label>'
			      		html += '<span><i class="ml-2 far fa-edit text-secondary" onclick="editTeamCalCateg('+item.smcatgono+',\''+item.smcatgoname+'\')"></i></span>';
			      		html += '<span><i class="ml-1 fas fa-trash-alt text-secondary" onclick="delCalCateg('+item.smcatgono+',\''+item.smcatgoname+'\')"></i></span></div>';
					 
					}); // end of each	
					
					html += "</li><br>";
					
				} // end of if
				 $("#teamSmallCateg").html(html);
			}, // end of success
			error: function(request, status, error){
		           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }	 	
		}); // end of ajax

	}// end of function showTeamCal()------------------	
	

	// === 팀별일정 소분류 수정 모달창 나타내기 === 
	function editTeamCalCateg(smcatgono, smcatgoname){
		$('#modal_editTeamCal').modal('show'); // 모달 보이기
		$("input.edit_team_smcatgono").val(smcatgono);
		$("input.edit_team_smcatgoname").val(smcatgoname);
	}// end of function editTeamCalCateg(smcatgono, smcatgoname){}----------------------
	
	
	// === 팀별일정 소분류 수정 모달창에서 수정 클릭 ===
	function goEditTeamCal() {
		
		if($("input.edit_team_smcatgoname").val().trim() == ""){
	  		swal("수정할 팀별일정 분류명을 입력하세요.");
	  		 return;
	  	} else {
			$.ajax({
				url:"<%= ctxPath%>/schedule/editCalendar.on",
				type: "post",
				data:{
					"smcatgono":$("input.edit_team_smcatgono").val(), 
					"smcatgoname": $("input.edit_team_smcatgoname").val(), 
					"empno":"${sessionScope.loginuser.empno}",
					"caltype":"2"  // 전사일정
				},
				dataType:"json",
				success:function(json){
					if(json.n == 0){
	   					swal($("input.edit_team_smcatgoname").val()+"은(는) 이미 존재하는 분류명입니다.");
	   					return;
	   				 }
					if(json.n == 1){
						$('#modal_editTeamCal').modal('hide'); // 모달 숨기기
						swal("일정 분류가 정상적으로 수정되었습니다.");
						showTeamCal();
					}
				},
				error: function(request, status, error){
			    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			}); // end of ajax
		} // end of else 
		
	} // end of function goEditTeamCal()
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// === 개인일정 소분류 추가를 위해 +아이콘 클릭시 ===
	function addMyCalendar(){
		$('#modal_addMyCal').modal('show'); // 모달창 보여주기	
	}// end of function addMyCalendar(){}--------------------
	
	
	// === 개인일정 소분류 추가 모달에서 추가 버튼 클릭 ===
	function goAddMyCal() {
		if($(".add_my_smcatgoname").val().trim() == "") {
			swal("추가할 개인 일정 분류명을 입력하세요.");
			return;
		} else {
			$.ajax({

				url:"<%= ctxPath%>/schedule/addMyCalendar.on",		
				type:"post",
				data: {
					"my_smcatgoname":$(".add_my_smcatgoname").val(),
					"cal_side_empno":"${sessionScope.loginuser.empno}"
				},
				dataType:"json",
				success:function(json) {
					if(json.n != 1) {
						swal("이미 존재하는 개인일정 분류명 입니다.");
						return;
					} else if(json.n == 1) {
						$("#modal_addMyCal").modal('hide');
						swal("일정 분류가 정상적으로 추가되었습니다.");
						
						$(".add_my_smcatgoname").val("");
						showMyCal(); // 개인일정 소분류
					}
				}, // end of success
				error: function(request, status, error){
	  	        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    	    }	 
			}); // end of ajax
		}
	} // end of function goAddMyCal()
	
	// === 개인일정 소분류 보여주기  === //
	function showMyCal(){
		$.ajax({
			url:"<%= ctxPath%>/schedule/showMyCalendar.on",
			type:"get",
			data:{"empno":"${sessionScope.loginuser.empno}"},
			dataType:"json",
			success:function(json){
				var html = "";
				if(json.length > 0){
					
					html += "<li>";
					
					$.each(json, function(index, item){
						html += '<div class="side_vertical">';
						html += '<input name="my_smcategChk" type="checkbox" id="myCal'+item.smcatgono+'" value="'+item.smcatgono+'" class="calendar_checkbox checkbox_color mr-2 my_smcategChk" checked/><label class="pt-1 mb-0"  style="width:70px;" for="myCal'+item.smcatgono+'">'+item.smcatgoname+'</label>'
			      		html += '<span><i class="ml-2 far fa-edit text-secondary" onclick="editMyCalCateg('+item.smcatgono+',\''+item.smcatgoname+'\')"></i></span>';
			      		html += '<span><i class="ml-1 fas fa-trash-alt text-secondary" onclick="delCalCateg('+item.smcatgono+',\''+item.smcatgoname+'\')"></i></span></div>';
					 
					}); // end of each	
					
					html += "</li><br>";
					
				} // end of if
				 $("#mySmallCateg").html(html);
			}, // end of success
			error: function(request, status, error){
		           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }	 	
		}); // end of ajax

	}// end of function showMyCal()------------------	
	
	
	// === 개인일정 소분류 수정 모달창 나타내기 === 
	function editMyCalCateg(smcatgono, smcatgoname){
		$('#modal_editMyCal').modal('show'); // 모달 보이기
		$("input.edit_my_smcatgono").val(smcatgono);
		$("input.edit_my_smcatgoname").val(smcatgoname);
	}// end of function editMyCalCateg(smcatgono, smcatgoname){}----------------------
	
	
	// === 개인일정 소분류 수정 모달창에서 수정 클릭 ===
	function goEditMyCal() {
		
		if($("input.edit_my_smcatgoname").val().trim() == ""){
	  		swal("수정할 개인일정 분류명을 입력하세요.");
	  		 return;
	  	} else {
			$.ajax({
				url:"<%= ctxPath%>/schedule/editCalendar.on",
				type: "post",
				data:{
					"smcatgono":$("input.edit_my_smcatgono").val(), 
					"smcatgoname": $("input.edit_my_smcatgoname").val(), 
					"empno":"${sessionScope.loginuser.empno}",
					"caltype":"3"  // 개인일정
				},
				dataType:"json",
				success:function(json){
					if(json.n == 0){
	   					swal($("input.edit_my_smcatgoname").val()+"은(는) 이미 존재하는 분류명입니다.");
	   					return;
	   				 }
					if(json.n == 1){
						$('#modal_editMyCal').modal('hide'); // 모달 숨기기
						swal("일정 분류가 정상적으로 수정되었습니다.");
						showMyCal();
					}
				},
				error: function(request, status, error){
			    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			}); // end of ajax
		} // end of else 
		
	} // end of function goEditTeamCal()
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	// 전사일정, 팀별일정, 개인일정 소분류 카테고리 삭제하기
	function delCalCateg(smcatgono, smcatgoname){ // smcatgono => 캘린더 소분류 번호, smcatgoname => 캘린더 소분류 명
	
		swal({
			title: "일정 분류를 삭제하시겠습니까?",
			text: "※일정분류 삭제 시 해당 분류에 포함된 모든 일정이 삭제됩니다.",
		  	icon: "warning",
		  	buttons: true,
		  	dangerMode: true,
		  	buttons: ["취소", "삭제"],
		})
		.then((willDelete) => {
			if (willDelete) {
				// 삭제
				$.ajax({
					url:"<%= ctxPath%>/schedule/delCalCateg.on",
					type: "post",
					data:{"smcatgono":smcatgono},
					dataType:"json",
					success:function(json){
						if(json.n==1){
							swal("일정 분류가 정상적으로 삭제되었습니다.", {
					      		icon: "success",
					    	});
							//location.href="javascript:history.go(0);"; // 페이지 새로고침
							showCompanyCal();
							showTeamCal();
							showMyCal();
						}
					},
					error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				    }
				});
				
		  	} else {
		  		// 삭제 취소
		    	swal("일정 분류 삭제를 취소하였습니다.");
		  	}
		}); // end of swal-.then((willDelete)
		
	}// end of function delCalCateg(smcatgono, smcatgoname){}------------------------
	
	
	// 모달 창에서 입력된 값 초기화 시키기 //
	$("button.modal_close").on("click", function(){
		var modal_frmArr = document.querySelectorAll("form[name=modal_frm]");
		for(var i=0; i<modal_frmArr.length; i++) {
	 		modal_frmArr[i].reset();
	 	}
	});
	
</script>

<!-- A vertical navbar -->
<nav class="navbar bg-light">

	<!-- Links -->
  	<ul class="navbar-nav" style='width:100%;'>
    	<li class="nav-item">
      		<h4 class='mb-4'>일정관리</h4>
      		<input type="hidden" value="${sessionScope.loginuser.empno}" id="cal_side_empno"/>
      		<input type="hidden" value="${sessionScope.loginuser.department}" id="cal_side_dept"/>
    	</li>
    	<li class="nav-item mb-4">
      		<button id="insertBtn" type="button" style='width:100%;' class="btn btn-outline-dark" onclick="insertSchedule();">일정등록</button>
   	 	</li>
   	 	
    	<li class="nav-item">
    		<%-- <div class="mb-3"><a href="<%=ctxPath %>/schedule.on">일정관리 홈</a></div> --%>
    		
      		<input type="checkbox" id="allComCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
      		<label for="allComCal">전사일정</label>
      		<c:if test="${sessionScope.loginuser.department == '인사총무팀'}">
      			<i class="fas fa-plus icon-right text-secondary" onclick="addComCalendar();"></i>
      		</c:if>
      		<ul id="comSmallCateg"></ul>
    	</li>
    	
    	<li class="nav-item">
      		<input type="checkbox" id="allTeamCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
      		<label for="allTeamCal">팀별일정</label>
      		
    		<i class="fas fa-plus icon-right text-secondary" onclick="addTeamCalendar();"></i>
      		<ul id="teamSmallCateg"></ul>
    	</li>
    	
    	<li class="nav-item">
      		<input type="checkbox" id="allMyCal" class="calendar_checkbox checkbox_color" checked/>&nbsp;&nbsp;
      		<label for="allMyCal">개인일정</label>
      		
      		<i class="fas fa-plus icon-right text-secondary" onclick="addMyCalendar();"></i>
      		<ul id="mySmallCateg"></ul>
    	</li>
    	
    	<li class="nav-item">
    		<input type="checkbox" id="sharedCal" class="calendar_checkbox checkbox_color" value="0" checked/>&nbsp;&nbsp;
    		<label for="sharedCal">공유일정</label>
    	</li> 
  	</ul>

</nav>












<%-- === 전사일정 소분류 추가 Modal === --%>
<div class="modal fade" id="modal_addComCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">전사 일정 분류 추가</h4>
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
     						<td style="text-align: left; padding-left: 11px;">${sessionScope.loginuser.name}</td>
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



<%-- === 전사일정 소분류 수정 Modal === --%>
<div class="modal fade" id="modal_editComCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">전사 일정 분류 수정</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-borderless">
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">소분류명</td>
     						<td><input type="text" class="edit_com_smcatgoname"/></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">만든이</td>
     						<td style="text-align: left; padding-left: 11px;">
     							${sessionScope.loginuser.name}
     							<input type="hidden" value="" class="edit_com_smcatgono" />
   							</td>
     					</tr>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      			<button type="button" style="background-color:#086BDE; color:white;" id="addCom" class="btn btn-sm" onclick="goEditComCal()">수정</button>
      		</div>
      
    	</div>
  	</div>
</div>



<%-- === 팀별일정 소분류 추가 Modal === --%>
<div class="modal fade" id="modal_addTeamCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">${sessionScope.loginuser.department} 일정 분류 추가</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-borderless">
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">소분류명</td>
     						<td><input type="text" class="add_team_smcatgoname"/></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">만든이</td>
     						<td style="text-align: left; padding-left: 11px;">${sessionScope.loginuser.name}</td>
     					</tr>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      			<button type="button" style="background-color:#086BDE; color:white;" id="addTeam" class="btn btn-sm" onclick="goAddTeamCal()">추가</button>
      		</div>
      
    	</div>
  	</div>
</div>


<%-- === 팀별일정 소분류 수정 Modal === --%>
<div class="modal fade" id="modal_editTeamCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">${sessionScope.loginuser.department} 일정 분류 수정</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-borderless">
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">소분류명</td>
     						<td><input type="text" class="edit_team_smcatgoname"/></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">만든이</td>
     						<td style="text-align: left; padding-left: 11px;">
     							${sessionScope.loginuser.name}
     							<input type="hidden" value="" class="edit_team_smcatgono" />
   							</td>
     					</tr>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      			<button type="button" style="background-color:#086BDE; color:white;" id="addCom" class="btn btn-sm" onclick="goEditTeamCal()">수정</button>
      		</div>
      
    	</div>
  	</div>
</div>




<%-- === 개인일정 소분류 추가 Modal === --%>
<div class="modal fade" id="modal_addMyCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">${sessionScope.loginuser.name}님의 일정 분류 추가</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-borderless">
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">소분류명</td>
     						<td><input type="text" class="add_my_smcatgoname"/></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">만든이</td>
     						<td style="text-align: left; padding-left: 11px;">${sessionScope.loginuser.name}</td>
     					</tr>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      			<button type="button" style="background-color:#086BDE; color:white;" id="addTeam" class="btn btn-sm" onclick="goAddMyCal()">추가</button>
      		</div>
      
    	</div>
  	</div>
</div>


<%-- === 개인일정 소분류 수정 Modal === --%>
<div class="modal fade" id="modal_editMyCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">${sessionScope.loginuser.name}님의 일정 분류 수정</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-borderless">
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">소분류명</td>
     						<td><input type="text" class="edit_my_smcatgoname"/></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">만든이</td>
     						<td style="text-align: left; padding-left: 11px;">
     							${sessionScope.loginuser.name}
     							<input type="hidden" value="" class="edit_my_smcatgono" />
   							</td>
     					</tr>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      			<button type="button" style="background-color:#086BDE; color:white;" id="addCom" class="btn btn-sm" onclick="goEditMyCal()">수정</button>
      		</div>
      
    	</div>
  	</div>
</div>

