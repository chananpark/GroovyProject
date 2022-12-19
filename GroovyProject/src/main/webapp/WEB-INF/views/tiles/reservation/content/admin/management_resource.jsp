<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	
	.input_width {
	  width: 100%; /* Full width */
	  padding: 8px; /* Some padding */ 
	  border: 1px solid #ccc; /* Gray border */
	  border-radius: 4px; /* Rounded borders */
	  box-sizing: border-box; /* Make sure that padding and width stays in place */
	  margin-top: 5px; /* Add a top margin */
	  resize: vertical; /* Allow the user to vertically resize the textarea (not horizontally) */
	  vertical-align: middle;
	}
	
	.input_style {
	  padding: 8px; /* Some padding */ 
	  border: 1px solid #ccc; /* Gray border */
	  border-radius: 4px; /* Rounded borders */
	  box-sizing: border-box; /* Make sure that padding and width stays in place */
	  margin-top: 5px; /* Add a top margin */
	  resize: vertical; /* Allow the user to vertically resize the textarea (not horizontally) */
	  vertical-align: middle;
	}
	
	.checkbox_color {
	  accent-color: #086BDE;
	}
	
	#color {
		border: 1px solid #ccc; /* Gray border */
		border-radius: 4px; /* Rounded borders */
		box-sizing: border-box; /* Make sure that padding and width stays in place */
		margin-top: 5px; /* Add a top margin */
		resize: vertical; /* Allow the user to vertically resize the textarea (not horizontally) */
		vertical-align: middle;
		height: 40px;
		width: 100px;
		background-color: white;
	}

	
	.insert_reserv_title {
		font-weight: bold; 
		font-size: 12pt;
	}
	
	.insert_reserv_tr {
		vertical-align: middle; 
		height: 70px;
	}
	
	#management_resource_table td {
		vertical-align: middle;
	}

	.filterBtnColor {
		background-color: #f9f9f9;
		color: black;
	}
	
	.filterBtnColor:hover {
		background-color: #086BDE;
		color: white;
	}
	
	.filterBtnColor.active {
		background-color: #086BDE;
		color: white;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 필터링 버튼 선택되게 만들기
		var btnContainer = document.getElementById("filterBtnDiv");
		var btns = btnContainer.getElementsByClassName("filterBtnColor");
		for (var i = 0; i < btns.length; i++) {
		  btns[i].addEventListener("click", function(){
		    var current = document.getElementsByClassName("active");
		    current[0].className = current[0].className.replace(" active", "");
		    this.className += " active";
		  });
		}
		
	}); // end of ready
	
	
	// 자원명 수정 모달 오픈
	function openEditModal(smcatgono, smcatgoname, lgcatgoname) {
		$('#modal_editResource').modal('show');
		$("input[name=smcatgono]").val(smcatgono);
		$("input[name=smcatgoname]").val(smcatgoname);
		$("td#td_lgcategoname").text(lgcatgoname);
	} // end of function openEditModal()

	
	// 자원명 수정 
	function goEditSmcatgoname() {
		
		var smcatgono = $("input[name=smcatgono]").val();
		var smcatgoname = $("input[name=smcatgoname]").val();
		
		if(smcatgoname.trim() == "") {
			swal("수정할 자원명을 입력하세요.");
			return;
		}
		
		var frm = document.modal_editResource_frm;
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/reservation/admin/editSmcatgoname.on";
		frm.submit();
		
	} // end of function goEditSmcatgoname()
	
	
	// 자원 추가 모달창
	function addResourceModal() {
		$('#modal_addResource').modal('show');
	} // end of function addResource()
	
	
	// 자원 추가하기
	function goAddSmcatgo() {
		
		var smcatgoname = $("input#addResourceName").val();
		var fk_lgcatgono = $("select#addResourceType").val();
		
		if(smcatgoname.trim() == "") {
			swal("자원명을 입력하세요.");
			return;
		}
		
		if(fk_lgcatgono == "") {
			swal("자원 분류를 선택하세요.");
			return;
		}
		
		var frm = document.modal_addResource_frm;
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/reservation/admin/addSmcatgo.on";
		frm.submit();
	} // end of function goAddSmcatgo()
	
	
	// 자원 상태 변경
	function changeStatus(smcatgono, sc_status) {
		
		$("input[name=smcatgono]").val(smcatgono);
		$("input[name=sc_status]").val(sc_status);
		
		var frm = document.hiddenFrm_changeStatus;
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/reservation/admin/changeStatus.on";
		frm.submit();
	} // end of function changeStatus(smcatgono)

	
	// 버튼 클릭 시 자원 항목 리스트 변경
	function filterBtnChange(lgcategono){
		
		$.ajax({
			url:"<%= ctxPath%>/reservation/admin/resourceFilter.on",
			type:"get",
			data:{"fk_lgcatgono":lgcategono},
			dataType:"json",
			success:function(json){
				var html = "";
				if(json.length > 0){
					
					$.each(json, function(index, item){
						
						html += "<tr>";
						html += "<td style='display: none;' class='smcatgono sno"+item.smcatgono+" text-center' >"+item.smcatgono+"</td>";
						html += "<td class='text-center'>"+item.lgcatgoname+"</td>";
						html += "<td class='text-center'>"+item.smcatgoname+"</td>";
						
						if(item.sc_status == 0) {
							html += "<td class='text-center text-danger'>이용 불가</td>";
						} else if(item.sc_status == 1) {
							html += "<td class='text-center'>이용 가능</td>";
						}
						
						html += "<td class='text-center'><button class='btn bg-light' onclick='openEditModal(\""+item.smcatgono+"\", \""+item.smcatgoname+"\", \""+item.lgcatgoname+"\");'>수정</button></td>";
						html += "<td class='text-center'>";
						
						if(item.sc_status == 0) {
							html += "<button class='btn' style='color:black; background-color: #E3F2FD;' onclick='changeStatus("+item.smcatgono+", "+item.sc_status+");'>이용 가능 변경</button>";
						} else if(item.sc_status == 1) {
							html += "<button class='btn' style='color:black; background-color: #E3F2FD;' onclick='changeStatus("+item.smcatgono+", "+item.sc_status+");'>이용 불가 변경</button>";
						}
						
						html += "</td>";
						html += "</tr>";
						
					});
					$("table#management_resource_table tbody").html(html);
				}	
			},
			error: function(request, status, error){
		    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }	 	
		}); // end of ajax
		
	}
	
	
</script>

<div id="add_resource_div"> 
	
	<div style='margin: 1% 0 5% 1%; display: flex;'>
		<h4 class="mt-2">자원 관리</h4>
		<div style="text-align: right;">
			<button class="btn bg-light ml-3 mt-1" onclick="addResourceModal();">자원 추가</button>
		</div>	
	</div>
	
	<div id="filterBtnDiv" style="display:flex; justify-content: flex-end; margin-bottom: 20px;">
		<button id="allBtn" class="btn mr-3 filterBtnColor active" onclick="filterBtnChange(999);">전체 항목</button>
		<button id="mtroomBtn" class="btn mr-3 filterBtnColor" onclick="filterBtnChange(1);">회의실</button>
		<button id="deviceBtn" class="btn mr-3 filterBtnColor" onclick="filterBtnChange(2);">기기</button>
		<button id="vehicleBtn" class="btn mr-3 filterBtnColor" onclick="filterBtnChange(3);">차량</button>
	</div>
	
	<div class="" id="">

		<table id="management_resource_table" class="table" style="margin: 0px 20px 50px 0;">
		
			<thead style="width:100%;">
				<tr class="text-center">
					<th class="col-3">자원 항목</th>
					<th class="col-3">자원명</th>
					<th class="col-3">자원 상태</th>
					<th class="col-1">수정</th>
					<th class="col-2">상태변경</th>
				</tr>
			</thead>	
			<tbody>
			
				<c:if test="${empty requestScope.resourceList}">
					<tr>
						<td colspan="5" style="text-align: center;">자원 항목이 없습니다. </td>
					</tr>
				</c:if>
				
				<c:if test="${not empty requestScope.resourceList}">
					<c:forEach var="map" items="${requestScope.resourceList}">
						<tr>
							<td style="display: none;" class="smcatgono sno${map.smcatgono} text-center" >${map.smcatgono}</td>
							<td class="text-center">${map.lgcatgoname}</td>
							<td class="text-center">${map.smcatgoname}</td>
							<c:if test="${map.sc_status eq '0'}">
								<td class="text-center text-danger">이용 불가</td>
							</c:if>
							<c:if test="${map.sc_status eq '1'}">
								<td class="text-center">이용 가능</td>
							</c:if>
							
							<td class="text-center"><button class="btn bg-light" onclick="openEditModal('${map.smcatgono}', '${map.smcatgoname}', '${map.lgcatgoname}');">수정</button></td>
							
							<td class="text-center">
								<c:if test="${map.sc_status eq '0'}">
									<button class="btn" style="color:black; background-color: #E3F2FD;" onclick="changeStatus(${map.smcatgono}, ${map.sc_status});">이용 가능 변경</button>
								</c:if>
								<c:if test="${map.sc_status eq '1'}">
									<button class="btn" style="color:black; background-color: #E3F2FD;" onclick="changeStatus(${map.smcatgono}, ${map.sc_status});">이용 불가 변경</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				
			</tbody>
		</table>
		
	</div>
	
</div>

<form name="hiddenFrm_changeStatus">
	<input type="hidden" name="smcatgono" value=""/>
	<input type="hidden" name="sc_status" value=""/>
</form>



<%-- 자원명 수정 모달창 --%>
<div class="modal fade" id="modal_editResource" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">자원명 수정하기</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_editResource_frm">
       				<table style="width: 100%;" class="table table-borderless">
       					<tr>
     						<td style="text-align: left; vertical-align: middle;">자원항목</td>
     						<td id="td_lgcategoname"></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">자원명</td>
     						<td><input type="text" class="input_style" name="smcatgoname" value="" /></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">편집자</td>
     						<td style="text-align: left; padding-left: 11px;">
     							${sessionScope.loginuser.name}
     							<input type="hidden" value="" name="smcatgono" />
     							<input type="hidden" value="${sessionScope.loginuser.empno}" name="fk_empno" />
   							</td>
     					</tr>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
				<button type="button" style="background-color:#086BDE; color:white;" class="btn btn-sm" onclick="goEditSmcatgoname()">수정</button>
      		</div>
      
    	</div>
  	</div>
</div>




<%-- 자원 추가 모달창 --%>
<div class="modal fade" id="modal_addResource" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">자원 추가하기</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_addResource_frm">
       				<table style="width: 100%;" class="table table-borderless">
       					<tr>
     						<td style="text-align: left; vertical-align: middle;">자원 분류</td>
     						<td>
     							<select class="input_style" name="fk_lgcatgono" id="addResourceType">
									<option value="">선택하세요</option>
									<option value="1">회의실 예약</option>
									<option value="2">기기 예약</option>
									<option value="3">차량 예약</option>
								</select>
     						</td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">자원명</td>
     						<td><input type="text" id="addResourceName" class="input_style" name="smcatgoname" /></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">작성자</td>
     						<td style="text-align: left; padding-left: 11px;">
     							${sessionScope.loginuser.name}
     							<input type="hidden" value="" name="smcatgono" />
     							<input type="hidden" value="${sessionScope.loginuser.empno}" name="fk_empno" />
   							</td>
     					</tr>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
				<button type="button" style="background-color:#086BDE; color:white;" class="btn btn-sm" onclick="goAddSmcatgo()">추가</button>
      		</div>
      
    	</div>
  	</div>
</div>


