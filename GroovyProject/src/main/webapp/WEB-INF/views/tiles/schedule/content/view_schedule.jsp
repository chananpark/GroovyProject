<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<style type="text/css">
		
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
	
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 시작 ==== //
		// 시작 시 분
		var str_startdate = $("span#startdate").text();
		var target = str_startdate.indexOf(":");
		var start_min = str_startdate.substring(target+1);
		var start_hour = str_startdate.substring(target-2,target);
		
		// 종료 시 분
		var str_enddate = $("span#enddate").text();
		target = str_enddate.indexOf(":");
		var end_min = str_enddate.substring(target+1);
		var end_hour = str_enddate.substring(target-2,target);
		
		if(start_hour=='00' && start_min=='00' && end_hour=='23' && end_min=='59' ){
			$("input#allDay").prop("checked",true);
		}
		else{
			$("input#allDay").prop("checked",false);
		}
		
		var start_day = str_startdate.substring(0,10);
		var end_day = str_enddate.substring(0,10);
		if($("input#allDay").is(":checked") && (start_day == end_day)){
			$("#startdate").text(start_day);
			$("#hyphen").hide();
			$("#enddate").hide();
		} else if($("input#allDay").is(":checked") && (start_day != end_day)) {
			$("#startdate").text(start_day);
			$("#enddate").text(end_day);
		}
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 끝 ==== //
		
	}); // end of $(document).ready(function(){})==============================
	
	
	// ~~~~~~~ Function Declartion ~~~~~~~
	// 상세보기의 일정 수정, 삭제, 돌아가기 만들기
	
	// 일정 삭제하기
	function delSchedule(scheduleno){
	
		var bool = confirm("일정을 삭제하시겠습니까?");
		
		if(bool){
			$.ajax({
				url: "<%= ctxPath%>/schedule/deleteSchedule.action",
				type: "post",
				data: {"scheduleno":scheduleno},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						alert("일정을 삭제하였습니다.");
					}
					else {
						alert("일정을 삭제하지 못했습니다.");
					}
					
					location.href="<%= ctxPath%>/schedule/scheduleManagement.action";
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		
	}// end of function delSchedule(scheduleno){}-------------------------
	

	// 일정 삭제하기
	function delSchedule(scheduleno){
	
		var bool = confirm("일정을 삭제하시겠습니까?");
		
		if(bool){
			$.ajax({
				url: "<%= ctxPath%>/schedule/deleteSchedule.on",
				type: "post",
				data: {"scheduleno":scheduleno},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						alert("일정을 삭제하였습니다.");
						location.href="<%= ctxPath%>/schedule/schedule.on";
					}
					else {
						alert("일정 삭제에 실패하였습니다.");
						location.href="<%= ctxPath%>/schedule/schedule.on";
					}
					
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		
	}// end of function delSchedule(scheduleno){}-------------------------

	
	
	// 일정 수정하기
	function editSchedule(scheduleno){
		var frm = document.goEditFrm;
		frm.scheduleno.value = scheduleno;
		
		frm.action = "<%= ctxPath%>/schedule/editSchedule.on";
		frm.method = "post";
		frm.submit();
	}
	

</script>


<div>

	<div style='margin: 1% 0 5% 1%; display: flex;'>
		<h4>일정 상세보기</h4>
	</div>
	
	<hr style="background-color:#E3F2FD; margin-bottom: 30px; width:98%;">

	<div style="width: 95%; margin:0 auto;">
		<table class="table table-borderless">
			<tr>
				<th class="col-2">일정명</th>
				<td class="col-10">${map.SUBJECT}</td>
			</tr>
			<tr>
				<th class="col-2">일정 분류</th>
				<td class="col-10">
					<c:if test="${map.FK_LGCATGONO eq 1}">
						전사일정&nbsp;-&nbsp;${map.SMCATGONAME}
					</c:if>
					<c:if test="${map.FK_LGCATGONO eq 2}">
						팀별일정&nbsp;-&nbsp;${map.SMCATGONAME}
					</c:if>
					<c:if test="${map.FK_LGCATGONO eq 3}">
						개인일정&nbsp;-&nbsp;${map.SMCATGONAME}
					</c:if>
				</td>
			</tr>
			<tr>
				<th class="col-2">일자</th>
				<td class="col-10">
					<span id="startdate">${requestScope.map.STARTDATE}</span>
					<span id="hyphen">&nbsp;-&nbsp; </span>
					<span id="enddate">${requestScope.map.ENDDATE}</span>
					<input type="checkbox" id="allDay" class="ml-3 mr-2 checkbox_color" disabled/>종일
				</td>
			</tr>
			<tr>
				<th class="col-2">참석자</th>
				<td class="col-10">${map.JOINUSER}</td>
			</tr>
			<tr>
				<th class="col-2">장소</th>
				<td class="col-10">${map.PLACE}</td>
			</tr>
			<tr>
				<th class="col-2">내용</th>
				<td class="col-10">${fn:replace(map.CONTENT, replaceChar, "<br>")}</td>
			</tr>
			<tr>
				<th class="col-2">작성자</th>
				<td class="col-10">${map.NAME}</td>
			</tr>
		</table>
		
		
		<input type="hidden" value="${sessionScope.loginuser.empno}" />
		<input type="hidden" value="${requestScope.map.FK_LGCATGONO}" />
		<input type="hidden" value="${requestScope.map.department}" />
		
		<c:set var="v_fk_empno" value="${requestScope.map.FK_EMPNO}" />
		<c:set var="v_fk_lgcatgono" value="${requestScope.map.FK_LGCATGONO}"/>
		<c:set var="v_department" value="${requestScope.map.DEPARTMENT}"/>
		<c:set var="v_loginuser_empno" value="${sessionScope.loginuser.empno}"/>
		<c:set var="v_loginuser_department" value="${sessionScope.loginuser.department}"/>
		<c:set var="v_loginuser_position" value="${sessionScope.loginuser.position}"/>
			
		<div style="float:right;" class="mr-2 mt-4">
		
			<%-- 검색에서 상세보기로 넘어온 경우 --%>
			<c:if test="${not empty requestScope.listgobackURL_schedule}">
				<%-- 전사일정이면서 인사총무팀일 경우 --%>	
				<c:if test="${v_fk_lgcatgono eq '1' && v_loginuser_department == '인사총무팀' && v_loginuser_empno == v_fk_empno }">
					<button class="btn bg-light mr-2" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
					<button class="btn bg-light mr-2" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
				</c:if>
				
				<%-- 팀별일정이면서 해당 팀일 경우  --%>
				<c:if test="${v_fk_lgcatgono eq '2' && v_loginuser_department == v_department && v_loginuser_empno == v_fk_empno }">
					<button class="btn bg-light mr-2" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
					<button class="btn bg-light mr-2" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
				</c:if>
				
				<%-- 개인일정 --%>
				<c:if test="${v_fk_lgcatgono eq '3' && v_loginuser_empno == v_fk_empno }">
					<button class="btn bg-light mr-2" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
					<button class="btn bg-light mr-2" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
				</c:if>
				
				<button class="btn" style="background-color: #086BDE; color:white;" onclick="javascript:location.href='<%= ctxPath%>${requestScope.listgobackURL_schedule}'">돌아가기</button>
			</c:if>	
			
			<%-- 달력에서 상세보기로 넘어온 경우 --%>
			<c:if test="${empty requestScope.listgobackURL_schedule}">
				<%-- 전사일정이면서 인사총무팀일 경우 --%>	
				<c:if test="${v_fk_lgcatgono eq '1' && v_loginuser_department == '인사총무팀' && v_loginuser_empno == v_fk_empno }">
					<button class="btn bg-light mr-2" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
					<button class="btn bg-light mr-2" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
				</c:if>
				
				<%-- 팀별일정이면서 해당 팀일 경우  --%>
				<c:if test="${v_fk_lgcatgono eq '2' && v_loginuser_department == v_department && v_loginuser_empno == v_fk_empno }">
					<button class="btn bg-light mr-2" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
					<button class="btn bg-light mr-2" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
				</c:if>
				
				<%-- 개인일정 --%>
				<c:if test="${v_fk_lgcatgono eq '3' && v_loginuser_empno == v_fk_empno }">
					<button class="btn bg-light mr-2" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
					<button class="btn bg-light mr-2" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
				</c:if>
				
				<button class="btn" style="background-color: #086BDE; color:white;" onclick="javascript:location.href='<%= ctxPath%>/schedule/schedule.on'">돌아가기</button>
			</c:if>	
				
		</div>
	
	</div>

<form name="goEditFrm">
	<input type="hidden" name="scheduleno"/>
	<input type="hidden" name="gobackURL_detailSchedule" value="${requestScope.gobackURL_detailSchedule}"/>
</form>	



</div>