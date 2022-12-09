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
	

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
	});


</script>

<div style="margin: 0 auto; width:95%;">

	
	<div style='margin: 1% 0 5% 1%;'>
		<h4 class="mt-2">자원 추가</h4>
	</div>
	
	<hr style="background-color:#E3F2FD; margin-bottom: 30px; width:98%;">
	
	<div class="" id="insert_schedule" style="width:95%; margin-left: 2.5%;">

		<form name="scheduleFrm">
		
			<table style="width:100%;">
				<tr class="insert_reserv_tr">
					<th class="col-2"><label class="mr-5 insert_reserv_title">자원명</label></th>
					<td class="col-10">
						<input class="input_width" type="text" id="subject" name="subject" placeholder="자원명을 입력하세요.">
					</td>
				</tr>
				
				<tr class="insert_reserv_tr">
					<th class="col-2"><label class="mr-5 insert_reserv_title">자원 분류 선택</label></th>
					<td class="col-10">
						<select class="calType input_style" name="fk_lgcatgono" id="fk_lgcatgono">
								<option value="">선택하세요</option>
								<option value="1">회의실</option>
								<option value="2">기기</option>
								<option value="3">차량</option>
						</select>
					</td>
				</tr>
				
				<tr style="vertical-align: middle; height: 230px;">
					<th class="col-2"><label class="mr-5 insert_reserv_title" >설명</label></th>
					<td class="col-10">
						<textarea class="input_width" id="content" name="content" placeholder="내용을 입력하세요." style="height:200px;"></textarea>
					</td>
				</tr>
	
			</table>
			<input type="hidden" value="${sessionScope.loginuser.empno}" name="empno"/>
		</form>
		
		<div style="float:right;" class="mr-2 mt-4">
			<button class="btn bg-light mr-2" onclick="javascript:location.href='<%= ctxPath%>/schedule/schedule.on'">취소</button>
			<button class="btn" id="register" style="background-color: #086BDE; color:white; ">등록</button>
		</div>
		
	</div>
	
</div>
