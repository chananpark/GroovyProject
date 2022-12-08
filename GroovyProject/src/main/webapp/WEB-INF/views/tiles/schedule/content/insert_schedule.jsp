<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

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

	
	.insert_sche_title {
		font-weight: bold; 
		font-size: 12pt;
	}
	
	.insert_sche_tr {
		vertical-align: middle; 
		height: 70px;
	}
	
	.ui-autocomplete {
		max-height: 150px;
		overflow-y: auto;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 캘린더 소분류 카테고리 숨기기
		$("select.small_category").hide();
		
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
		}); // end of $("input#allDay").click(function() 
		
		
		// 전사일정, 팀별일정, 개인일정 선택에 따른 서브캘린더 종류를 알아와서 select 태그에 넣어주기 
		$("select.calType").change(function(){
			var fk_lgcatgono = $("select.calType").val();      // 전사일정1, 팀별일정2, 개인일정3
			var empno = $("input[name=empno]").val();  		// 로그인 된 사용자아이디
			
			if(fk_lgcatgono != "") { // 선택하세요 가 아니라면
				if(fk_lgcatgono == "3" && ${requestScope.mySmcategCnt == 0}) {
					// 개인일정 소분류 카테고리가 없는 상태에서 개인일정을 선택한 경우
					swal("개인일정 소분류 카테고리 생성 후 개인일정 등록이 가능합니다.");
					$("select.small_category").hide();
					$("button#register").attr("disabled", true);
					return false;
				} else if(fk_lgcatgono == "2" && ${requestScope.teamSmcategCnt == 0}) {
					// 팀별일정 소분류 카테고리가 없는 상태에서 팀별일정을 선택한 경우
					swal("팀별일정 소분류 카테고리 생성 후 팀별일정 등록이 가능합니다.");
					$("select.small_category").hide();
					$("button#register").attr("disabled", true);
				} else if(fk_lgcatgono == "1" && ${requestScope.comSmcategCnt == 0}) {
					// 전사일정 소분류 카테고리가 없는 상태에서 전사일정을 선택한 경우
					swal("전사일정 소분류 카테고리 생성 후 팀별일정 등록이 가능합니다.");
					$("select.small_category").hide();
					$("button#register").attr("disabled", true);
				} else {
					$("button#register").attr("disabled", false);
					$.ajax({
						url: "<%= ctxPath%>/schedule/selectSmallCateg.on",
						data: {"fk_lgcatgono":fk_lgcatgono, 
							   "empno":empno},
						dataType: "json",
						success:function(json){
							var html ="";
							if(json.length>0){
								
								$.each(json, function(index, item){
									html+="<option value='"+item.smcatgono+"'>"+item.smcatgoname+"</option>"
								});
								$("select.small_category").show();
								$("select.small_category").html(html);
							}
						},
						error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
					});
				}
			} else {
				// 선택하세요 이라면
				$("select.small_category").hide();
			}
			
		}); // end of $("select.calType").change(function(){
			
		
		
			
			
		// 참석자 추가하기(내가 검색한 이름 목록 보여주기)
		$("input#joinUserName").bind("keyup",function(){
			var joinUserName = $(this).val();
			//	console.log("확인용 joinUserName : " + joinUserName);
			$.ajax({
				url:"<%= ctxPath%>/schedule/insertSchedule/searchJoinUserList.on",
				data:{"joinUserName":joinUserName},
				dataType:"json",
				success : function(json){
					var joinUserArr = [];
			    
				//  input태그 참석자입력란에 "이" 를 입력해본 결과를 json.length 값이 얼마 나오는지 알아본다. 
				//	console.log(json.length);
				
					if(json.length > 0){
						
						$.each(json, function(index,item){
							var name = item.name;
							if(name.includes(joinUserName)){ // name 이라는 문자열에 joinUserName 라는 문자열이 포함된 경우라면 true , 
								                             // name 이라는 문자열에 joinUserName 라는 문자열이 포함되지 않은 경우라면 false 
							   joinUserArr.push(name+"("+item.cpemail+")");
							}
						});
						
						$("input#joinUserName").autocomplete({  // 참조 https://jqueryui.com/autocomplete/#default
							source:joinUserArr,
							select: function(event, ui) {       // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
								addJoinUser(ui.item.value);    // 아래에서 만들어 두었던 add_joinUser(value) 함수 호출하기 
								                                // ui.item.value 이  선택한이름 이다.
								return false;
					        },
					        focus: function(event, ui) {
					            return false;
					        }
						}); 
						
					}// end of if------------------------------------
				}// end of success-----------------------------------
			});
		});	// end of $("input#joinUserName").bind("keyup",function()
			
			
		// x아이콘 클릭시 참석자 제거하기
		$(document).on('click','div.displayUserList > span.plusUser > i',function(){
			var joinUserName = $(this).parent().text(); // 이순신(leess/leesunsin@naver.com)
			
			swal({
				title: "",
				text: "참석자 목록에서 "+ joinUserName +" 님을 삭제하시겠습니까?",
			  	icon: "warning",
			  	buttons: true,
			  	dangerMode: true,
			  	buttons: ["취소", "삭제"],
			})
			.then((willDelete) => {
				if (willDelete) {
					// 삭제
					$(this).parent().remove();
					
			  	} else {
			  		// 삭제 취소
			    	swal("참석자 목록 삭제를 취소하였습니다.");
			  	}
			}); // end of swal-.then((willDelete)		

		}); // end of $(document).on('click','div.displayUserList > span.plusUser > i',function()

		
		// 등록 버튼 클릭
		$("button#register").click(function(){
		
			// 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
			var startDate = $("input#startDate").val();	
	    	var sArr = startDate.split("-");
	    	startDate= "";	
	    	for(var i=0; i<sArr.length; i++){
	    		startDate += sArr[i];
	    	}
	    	
	    	var endDate = $("input#endDate").val();	
	    	var eArr = endDate.split("-");   
	     	var endDate= "";
	     	for(var i=0; i<eArr.length; i++){
	     		endDate += eArr[i];
	     	}
			
	     	var startHour= $("select#startHour").val();
	     	var endHour = $("select#endHour").val();
	     	var startMinute= $("select#startMinute").val();
	     	var endMinute= $("select#endMinute").val();
	        
	     	// 조회기간 시작일자가 종료일자 보다 크면 경고
	        if (Number(endDate) - Number(startDate) < 0) {
	        	swal("종료 날짜 및 시간을 시작 날짜 및 시간 이후로 설정해주세요."); 
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		swal("종료 날짜 및 시간을 시작 날짜 및 시간 이후로 설정해주세요."); 
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			swal("종료 날짜 및 시간을 시작 날짜 및 시간 이후로 설정해주세요."); 
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			swal("종료 날짜 및 시간을 시작 날짜 및 시간 이후로 설정해주세요."); 
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	    	
			// 일정명 유효성 검사
			var subject = $("input#subject").val().trim();
	        if(subject==""){
	        	swal("일정명을 입력하세요."); 
				return;
			}
	        
	        // 일정분류 선택 유무 검사
			var calType = $("select.calType").val().trim();
			if(calType==""){
				swal("일정 분류를 선택하세요."); 
				return;
			}
			
			// 달력 형태로 만들어야 한다.(시작일과 종료일)
			// 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
			var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
			var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
			
		//	console.log($("select#startHour").val());
		//	console.log($("select#startMinute").val());
			
			$("input[name=startdate]").val(sdate);
			$("input[name=enddate]").val(edate);
		
		//	console.log("캘린더 소분류 번호 => " + $("select[name=fk_smcatgono]").val());
			/*
			      캘린더 소분류 번호 => 1 OR 캘린더 소분류 번호 => 2 OR 캘린더 소분류 번호 => 3 OR 캘린더 소분류 번호 => 4 
			*/
			
		// 	console.log("색상 => " + $("input#color").val());
			
			// 공유자 넣어주기
			var plusUser_elm = document.querySelectorAll("div.displayUserList > span.plusUser");
			var joinUserArr = new Array();
			
			plusUser_elm.forEach(function(item,index,array){
				joinUserArr.push(item.innerText.trim());
			});
			
			var joinuser = joinUserArr.join(",");
			
			$("input[name=joinuser]").val(joinuser);
			
			var frm = document.scheduleFrm;
			frm.action="<%= ctxPath%>/schedule/insertScheduleEnd.on";
			frm.method="post";
			frm.submit();

		});// end of $("button#register").click(function(){})--------------------
		
		
		// 전사일정 참석자 지정 막기
		$("#fk_lgcatgono").change(function(){
			
			if($("#fk_lgcatgono").val() == "1") {
				$("#joinUserName").attr("disabled",true); 
				$("#joinUserName").attr("placeholder","전사일정은 참석자 지정이 불가능합니다"); 
			} else {
				$("#joinUserName").attr("disabled",false); 
				$("#joinUserName").attr("placeholder","일정을 공유할 회원명을 입력하세요"); 
			}
		});
		
		
		
		
			
		
		
		
		
		
	}); // end of ready
	

	// ===== function declaration =====
	
	// div.displayUserList 에 공유자를 넣어주는 함수
	function addJoinUser(value){  // value 가 공유자로 선택한이름 이다.
		
		var plusUser_es = $("div.displayUserList > span.plusUser").text();
	
	  	// console.log("확인용 plusUser_es => " + plusUser_es);
	    /*
	    	확인용 plusUser_es => 
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)아이유2(iyou2/younghak0959@naver.com)
	    */
	
		if(plusUser_es.includes(value)) {  // plusUser_es 문자열 속에 value 문자열이 들어있다라면 
			swal("이미 추가한 회원입니다.");
		}
		
		else {
			$("div.displayUserList").append("<span class='plusUser badge rounded-pill mr-2' style='color:white; background-color:#086BDE;'>"+value+"<i class='ml-2 far fa-times-circle'></i></span>");
		}
		
		$("input#joinUserName").val("");
		
	}// end of function add_joinUser(value){}----------------------------			
		
	
</script>


<div style="margin: 0 auto; width:95%;">

	
	<div style='margin: 1% 0 5% 1%;'>
		<h4 class="mt-2">일정 등록</h4>
	</div>
	
	<hr style="background-color:#E3F2FD; margin-bottom: 30px; width:98%;">
	
	<div class="" id="insert_schedule" style="width:95%; margin-left: 2.5%;">

		<form name="scheduleFrm">
		
			<table style="width:100%;">
				<tr class="insert_sche_tr">
					<th class="col-2"><label class="mr-5 insert_sche_title">일정명</label></th>
					<td class="col-10">
						<input class="input_width" type="text" id="subject" name="subject" placeholder="일정명을 입력하세요.">
					</td>
				</tr>
				
				<tr class="insert_sche_tr">
					<th class="col-2"><label class="mr-5 insert_sche_title">일자</label></th>
					<td class="col-10">
			            <input class="input_style" type="date" id="startDate" value="${requestScope.chooseDate}"/>&nbsp; 
						<select id="startHour" class="input_style"></select>
						<span class="ml-1" id="startHour_text">시</span> 
						<select id="startMinute" class="input_style"></select>
						<span class="ml-1" id="startMinute_text">분</span>  
						<span class="mr-3 ml-3">-</span> 
						<input class="input_style" type="date" id="endDate" value="${requestScope.chooseDate}"/>&nbsp;
						<select id="endHour" class="input_style"></select>
						<span class="ml-1" id="endHour_text">시</span>
						<select id="endMinute" class="input_style"></select>
						<span class="ml-1" id="endMinute_text">분</span>  
						
						<span style="margin-left:3%;">
							<input class="checkbox_color" type="checkbox" id="allDay"/>&nbsp;<label for="allDay">종일</label>
						</span>
						
						<input type="hidden" name="startdate"/>
						<input type="hidden" name="enddate"/>
					</td>
				</tr>
				
				<tr class="insert_sche_tr">
					<th class="col-2"><label class="mr-5 insert_sche_title">일정 분류 선택</label></th>
					<td class="col-10">
						<select class="calType input_style" name="fk_lgcatgono" id="fk_lgcatgono">
							<c:choose>
								<c:when test="${sessionScope.loginuser.department eq '인사총무팀'}">
									<option value="">선택하세요</option>
									<option value="1">전사일정</option>
									<option value="2">팀별일정</option>
									<option value="3">개인일정</option>
								</c:when>
								<c:otherwise>
									<option value="">선택하세요</option>
									<option value="2">팀별일정</option>
									<option value="3">개인일정</option>
								</c:otherwise>
							</c:choose>
						</select>
						<select class="small_category input_style" name="fk_smcatgono"></select>
					</td>
				</tr>
				
				<tr class="insert_sche_tr">
					<th class="col-2"><label class="mr-5" class="insert_sche_title">색상</label></th>
					<td class="col-10">
						<input class="" type="color" id="color" name="color" value="#086BDE" list="list"/>
						<datalist id="list">
							<option value="#6D4C41">#6D4C41</option>
					  		<option value="#BF360C">#BF360C</option>
					  		<option value="#F44336">#F44336</option>
					  		<option value="#FFC107">#FFC107</option>
					  		<option value="#FFF176">#FFF176</option>
					  		<option value="#F48FB1">#F48FB1</option>
					  		<option value="#BA68C8">#BA68C8</option>
					  		<option value="#9575CD">#9575CD</option>
					  		<option value="#5C6BC0">#5C6BC0</option>
					  		<option value="#2196F3">#2196F3</option>
					  		<option value="#B3E5FC">#B3E5FC</option>
					  		<option value="#26A69A">#26A69A</option>
					  		<option value="#4CAF50">#4CAF50</option>
					  		<option value="#AED581">#AED581</option>
					  		<option value="#9E9E9E">#9E9E9E</option>
						</datalist>
					</td>
				</tr>
				<tr class="insert_sche_tr"> 
					<th class="col-2"><label class="mr-5 insert_sche_title" for="joinuser ">참석자</label></th>
					<td class="col-10">
						<input type="text" id="joinUserName" class="input_width" placeholder="일정을 공유할 회원명을 입력하세요"/>
						<div class="displayUserList"></div>
						<input type="hidden" name="joinuser"/>
					</td>
				</tr>
				<tr class="insert_sche_tr">
					<th class="col-2"><label class="mr-5 insert_sche_title">장소</label></th>
					<td class="col-10">
						<input class="input_width" type="text" id="place" name="place" placeholder="장소를 입력하세요.">
					</td>
				</tr>
				<tr style="vertical-align: middle; height: 230px;">
					<th class="col-2"><label class="mr-5 insert_sche_title" >내용</label></th>
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
