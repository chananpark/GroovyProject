<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// === *** 달력(type="date") 관련 시작 *** === //
		// 시작시간, 종료시간		
		var html="";
		for(var i=0; i<24; i++){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else{
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for----------------------
		
		$("select#startHour").html(html);
		$("select#endHour").html(html);
		
		// 시작분, 종료분 
		html="";
		for(var i=0; i<60; i=i+5){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else {
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for--------------------
		html+="<option value="+59+">"+59+"</option>"
		
		$("select#startMinute").html(html);
		$("select#endMinute").html(html);
		// === *** 달력(type="date") 관련 끝 *** === //
		
		// '종일' 체크박스 클릭시
		$("input#allDay").click(function() {
			var bool = $('input#allDay').prop("checked");
			
			if(bool == true) {
				$("select#startHour").val("00");
				$("select#startMinute").val("00");
				$("select#endHour").val("23");
				$("select#endMinute").val("59");
				$("select#startHour").prop("disabled",true);
				$("select#startMinute").prop("disabled",true);
				$("select#endHour").prop("disabled",true);
				$("select#endMinute").prop("disabled",true);
				
				$("select#startHour").hide();
				$("select#startMinute").hide();
				$("select#endHour").hide();
				$("select#endMinute").hide();
				
				$("#startHour_text").hide();
				$("#startMinute_text").hide();
				$("#endHour_text").hide();
				$("#endMinute_text").hide();
			} 
			else {
				$("select#startHour").prop("disabled",false);
				$("select#startMinute").prop("disabled",false);
				$("select#endHour").prop("disabled",false);
				$("select#endMinute").prop("disabled",false);
				
				$("select#startHour").show();
				$("select#startMinute").show();
				$("select#endHour").show();
				$("select#endMinute").show();
				
				$("#startHour_text").show();
				$("#startMinute_text").show();
				$("#endHour_text").show();
				$("#endMinute_text").show();
			}
		});
		
		
		
		
		
		
	}); // end of ready


	// ===== function declaration =====
	
		
		
	
</script>


<div style="margin: 0 auto; width:95%;">

	
	<div style='margin: 1% 0 5% 1%;'>
		<h4 class="mt-2">일정 등록</h4>
	</div>
	
	<hr style="background-color:#E3F2FD; margin-bottom: 30px; width:98%;">
	
	<div class="" id="insert_schedule" style="width:95%; margin-left: 2.5%;">

		<table style="width:100%;">
			<tr style="vertical-align: middle; height: 70px;">
				<th class="col-2"><label class="mr-5" for="search_woard" style="font-weight: bold; font-size: 12pt;">일정명</label></th>
				<td class="col-10">
					<input class="input_width" type="text" id="search_woard" name="search_woard" placeholder="일정명을 입력하세요.">
				</td>
			</tr>
			
			<tr style="vertical-align: middle; height: 70px;">
				<th class="col-2"><label class="mr-5" for="search_woard" style="font-weight: bold; font-size: 12pt;">일자</label></th>
				<td class="col-10">
		            <input class="input_style" type="date" id="startDate" value="${requestScope.chooseDate}"/>&nbsp; 
					<select id="startHour" class="schedule input_style"></select><span class="ml-1" id="startHour_text">시</span> 
					<select id="startMinute" class="schedule input_style"></select><span class="ml-1" id="startMinute_text">분</span>  
					<span class="mr-3 ml-3">-</span> 
					<input class="input_style" type="date" id="endDate" value="${requestScope.chooseDate}"/>&nbsp;
					<select id="endHour" class="schedule input_style"></select><span class="ml-1" id="endHour_text">시</span>
					<select id="endMinute" class="schedule input_style"></select><span class="ml-1" id="endMinute_text">분</span>  
					
					<span style="margin-left:3%;">
						<input class="checkbox_color" type="checkbox" id="allDay"/>&nbsp;<label for="allDay">종일</label>
					</span>
					
					<input type="hidden" name="startdate"/>
					<input type="hidden" name="enddate"/>
				</td>
			</tr>
			
			<tr style="vertical-align: middle; height: 70px;">
				<th class="col-2"><label class="mr-5" for="select_search" style="font-weight: bold; font-size: 12pt;">일정 분류 선택</label></th>
				<td class="col-10">
					<select class="input_style" name="select_search">
						<option>선택하세요</option>
						<option>전사일정</option>
						<option>팀별일정</option>
						<option>개인일정</option>
					</select>
					<select class="input_style" name="select_search">
						<option>선택하세요</option>
						<option>놀러가기</option>
						<option>밥먹기</option>
					</select>
				</td>
			</tr>
			
			<tr style="vertical-align: middle; height: 70px;">
				<th class="col-2"><label class="mr-5" for="select_search" style="font-weight: bold; font-size: 12pt;">색상</label></th>
				<td class="col-10">
					<input class="" type="color" id="color" list="list"/>
					<datalist id="list">
						<option>#6D4C41</option>
				  		<option>#BF360C</option>
				  		<option>#F44336</option>
				  		<option>#FFC107</option>
				  		<option>#FFF176</option>
				  		<option>#F48FB1</option>
				  		<option>#BA68C8</option>
				  		<option>#9575CD</option>
				  		<option>#5C6BC0</option>
				  		<option>#2196F3</option>
				  		<option>#B3E5FC</option>
				  		<option>#26A69A</option>
				  		<option>#4CAF50</option>
				  		<option>#AED581</option>
				  		<option>#9E9E9E</option>
					</datalist>
				</td>
			</tr>
			<tr style="vertical-align: middle; height: 70px;"> 
				<th class="col-2"><label class="mr-5" for="joinuser" style="font-weight: bold; font-size: 12pt;">공유자</label></th>
				<td class="col-10">
					<input type="text" id="joinUserName" class="input_width" placeholder="일정을 공유할 회원명을 입력하세요"/>
					<div class="badge rounded-pill displayUserList" style="color:white; background-color:#086BDE;">손여진<i class="ml-2 far fa-times-circle"></i></div>
					<input type="hidden" name="joinuser"/>
				</td>
			</tr>
			<tr style="vertical-align: middle; height: 70px;">
				<th class="col-2"><label class="mr-5" for="search_woard" style="font-weight: bold; font-size: 12pt;">장소</label></th>
				<td class="col-10">
					<input class="input_width" type="text" id="search_woard" name="search_woard" placeholder="장소를 입력하세요.">
				</td>
			</tr>
			<tr style="vertical-align: middle; height: 230px;">
				<th class="col-2"><label class="mr-5" for="search_woard" style="font-weight: bold; font-size: 12pt;">내용</label></th>
				<td class="col-10">
					<textarea class="input_width" id="search_woard" name="search_woard" placeholder="내용을 입력하세요." style="height:200px;"></textarea>
				</td>
			</tr>

		</table>
		
		<div style="float:right;" class="mr-2 mt-4">
			<button class="btn bg-light mr-2" style="">취소</button>
			<button class="btn" style="background-color: #086BDE; color:white; ">등록</button>
		</div>
		
	</div>





</div>