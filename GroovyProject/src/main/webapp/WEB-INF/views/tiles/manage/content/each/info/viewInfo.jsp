<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style>

	div#info_manageInfo {
		padding: 5% 2%;
		width: 95%;
	}

	
	table{
		width: 95%;
		padding: 2%;
		font-size: 12px;
	}

	td {
		width:18%;
	}

	
	th {
		font-weight: bold;
		background-color: #e3f2fd; 
		width: 10%;
		text-align: center;
	}
	
	.t1 {
		width: 7%;
		background-color: #black; 
	}
	
	input {
		border: solid 1px #cccccc;
		background-color: #e6e6e6;
	}
	
	button.btn_check, button#btn_adrsearch, .btn_search{
		width:50px; 
		font-size:12px;
		display: inline-block;
		border: none;
		background-color:#F9F9F9;
	}
	
	span#birthday > select {
		width:85px;
		font-size: 12px;
		height: 20px;
		border: solid 1px #cccccc;
	}
	
	
	select.select_3{
		width: 165px;
		height: 25px;
		border: solid 1px #cccccc;
	}
	
	div.error {
		color: red;
	}
	
	.update {
		background-color: white;
	}
	
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	
	$(document).ready(function(){
	
		 $("div#msg_probation").hide();
		 $("div.error").hide();
		 
		// === 생년월일 === //
	        
		    var dt = new Date();
		    var com_year = dt.getFullYear();
		    var year = "";
		    
		 // 년도 뿌려주기
		    $("#year").append("<option value=''>년도</option>");
		    // 올해 기준으로 -50년부터 +1년을 보여준다.
		    for (var i = (com_year - 50); i <= (com_year); i++) {
		      $("#year").append("<option value='" + i+ "'>" + i + " 년" + "</option>");
		    }
		    
		    // 월 뿌려주기(1월부터 12월)
		    var month;
		    $("#month").append("<option value=''>월</option>");
		    for (var i = 1; i <= 12; i++) {
		    	
		    	if(i<10){
		    		month += "<option>0"+i+"</option>";
				}
				else{
					month += "<option>"+i+"</option>";
				}
		    } 
			$("#month").html(month);
		    
		    // 일 뿌려주기(1일부터 31일)
		    var day;
		    $("#day").append("<option value=''>일</option>");
		    for (var i = 1; i <= 31; i++) {
		    	if(i<10){
		    		day += "<option>0"+i+"</option>";
				}
				else{
					day += "<option>"+i+"</option>";
				}
		    }
			$("#day").html(day);
		 
		 
		 
		 
		 
		 
		 
		 
		// === 우편번호 찾기를 클릭했을 때 이벤트 처리하기 === //
		 $("button#btn_adrsearch").click(function() {
		 	b_flag_btn_adrsearch_click = true;
		 });
		 
		 // === 우편번호 입력란에 키보드로 입력할 경우 이벤트 처리하기 === //
		 $("input:text[id='postcode']").keyup( function() {
		 	alert("우편번호 입력은 \"우편번호찾기\"를 클릭하여 입력해야 합니다. ");
		 	$(this).val("");
		 });
		 
		 
			 
		// === 수습시간 체크박스 버튼을 누르면 === // 
		$("input#che_probation").click(function(){
			
			$("div#msg_probation").show();
		
		}); // end of $("input#che_probation").click(function(){
		 
}); // end of $(document).ready(function(){}-----------------------------------------







//>>> Function Declaration <<< //

	
 // >>> select box  생년월일 표시 <<<
	  function setDateBox() {
	    
	  }
	// === 생년월일 끝 === 
		
		
	// >>> 주소 <<<		
	function openDaumPOST(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            let addr = ''; // 주소 변수
	            let extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("extraaddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("extraaddress").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('postcode').value = data.zonecode;
	            document.getElementById("address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("detailaddress").focus();
	        }
	    }).open();
	} // end of openDaumPOST() -------------------------------
	
	
	// >> 정보수정 << 
	function go_update(){
		
		
		
		
		const frm = document.frm_login
		frm.action = "<%= ctxPath%>.on";
		frm.method = "POST";
		frm.submit();
		
	} // end of function go_update(){ ----------------------
	
	
	
</script>




<form id="frm_manageInfo">
<div id="info_manageInfo">

<div style='margin: 1% 0 5% 1%'>
	<h4>사원정보</h4>
</div>

	<h5 class='m-4'>사원등록</h5>
	
	<table class="m-4 mb-3 table table-bordered table-sm" id="first_table">
		<tr>
			<td rowspan='4' style="width:2%;"><img class="float-center" src="<%= ctxPath%>/resources/images/picture/꼬미사진.jpg" height="150px;" width="150px" alt="..." value=""${loginuser.empimg}/></td>
			<th class="t1">사원번호</th>
			<td>	
				<input type="text" id="" name="empno" value="${loginuser.empno}" readonly />
			</td>
			
			<th class="t1">성명</th>
			<td><input type="text" id="name" name="name" value="${loginuser.name}"  required readonly></input></td>
		</tr>
		<tr >
			<th class="t1">주민등록번호</th>
				<td>
					<span>
						<input type="text" id="jubun" name="jubun" value="${loginuser.jubun}" style="display: inline;" required readonly/>
					</span>
				</td>
			<th class="t1">성별</th>
			 <td style="text-align: left;">
	            <input type="radio" id="male" name="gender" value="1" value="${loginuser.gender}"  /><label for="male" style="margin-left: 2%;">남자</label>
	            <input type="radio" id="female" name="gender" value="2" value="${loginuser.gender}" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
	         </td>
		</tr>
		<tr>
			<th class="t1"><span class="alert_required" style="color: red;">*</span>생년월일</th>
			<td>
				<span id="birthday" name="birthday" >
				    	<select name="year" id="birthyyyy" title="년도" class=" requiredInfo" <%-- value="${loginuser.birthyyyy} --%>" ></select>
						<select name="month" id="birthmm" title="월" class=" requiredInfo" <%-- value="${loginuser.birthmm} --%>"  ></select>
						<select name="day" id=birthdd title="일" class=" requiredInfo" <%-- value="${loginuser.birthdd} --%>" ></select>
				</span>
			</td>
			<th></th>
			<td></td>
		</tr>
		<tr>
			<th class="t1">자택주소</th>
			<td colspan="3">
			<span>
				<input type="text" id="postcode" name="postcode" value="${loginuser.postcode}" placeholder="우편번호" style="display: inline-block;" class="update"/>
				<input type="text" id="address" name="address" value="${loginuser.address}" class="input_style update" placeholder="예)00동, 00로"/>
				<input type="text" id="detailaddress" name="detailaddress" value="${loginuser.detailaddress}"  class="input_style update"  placeholder="상세주소" style="display: inline-block;  width: 190px;"/>
				<input type="text" id="extraaddress" name="extraaddress" value="${loginuser.extraaddress}" placeholder="참고항목" style="display: inline-block;  width: 190px;  margin: 10px 0 10px 8px;" class="update"/>
				<button type="button" id="btn_adrsearch" onclick="openDaumPOST();" class="btn btn-sm ml-2">추가</button>
			</span>
			</td>
		</tr>

	</table>
	
	<table  class="m-4 mb-3 table table-bordered" >
		<tr>
			<th>내선번호</th>
			<td><input type="text" id="" name="" readonly value="${loginuser.depttel}" />
			</td>
			<th>핸드폰번호</th>
	         <td style="text-align: left;" id="telNum" name="mobile">
	             <input type="text" id="hp1" name="hp1" <%-- value="${loginuser.hp1} --%>" size="6" maxlength="3" value="010" class="requiredInfo update" readonly/>&nbsp;-&nbsp;
	             <input type="text" id="hp2" name="hp2" <%-- value="${loginuser.hp2} --%>" size="6" maxlength="4" class="requiredInfo update"/>&nbsp;-&nbsp;
	             <input type="text" id="hp3" name="hp3" <%-- value="${loginuser.hp3} --%>" size="6" maxlength="4" class="requiredInfo update"/>
	             <div class="error">휴대폰 형식이 아닙니다.</div>
	         </td>

		</tr>
		<tr>
			<th>회사이메일</th>
			<td><input type="email" id="cpemail" name="cpemail" value="${loginuser.cpemail}" readonly/>
				
			</td>
			<th>외부이메일</th>
			<td>
				<input type="email" id="pvemail" name="pvemail" value="${loginuser.pvemail}" class="update" />
				<div class="error">이메일 형식이 아닙니다.</div>
			</td>

		</tr>
	</table>
	
	<table  class=" m-4 mb-3 table table-bordered ">
		<tr>
			<th>부문</th>
			<td>
				<input type="text" id="bumun" name="bumun" value="${loginuser.bumun}" readonly />
			</td>
			<th>부서</th>
			<td>
				<input type="text" id="department" name="department" value="${loginuser.department}" readonly />
			</td>
			<th>직급</th>
			<td>
				<input type="text" id="position" name="position" value="${loginuser.position}" readonly />
			</td>
		</tr>
		<tr>
			<th><span style="color: red;">*</span>급여계약기준</th>
			<td><input type="text" id="empstauts" name="empstauts" value="${loginuser.empstauts}" readonly />
			</td>
			
			<th>수습기간</th>
			<td>
				<input type="text" id="che_probation" name="" value="${loginuser.empstauts}" readonly />
			</td>
			<th><td></td></th>
		</tr>
		
		<tr>
			<th><span style="color: red;">*</span>입사일자</th>
			<td><input type="date" id="joindate" name="joindate" value="${loginuser.joindate}" style="width: 165px;" required readonly/></td>
			<th>퇴직일자</th>
			<td><input type="date" id="" name=""  style="width: 165px;" required readonly/></td>
			<th></th>
			<td></td>
		</tr>
	</table>
	<div align="right" style="margin: 3% 0;">
		<button id="btn_update" onclick="go_update" style="color: white; background-color:#086BDE; border: none; width: 80px;">수정</button>
	</div>
	
	
	<%-- 정보수정 페이지에서 보이는 버튼 --%>
	<div align="right" style="margin: 3% 0;">
		<button id="btn_updateEnd" style="color: white; background-color:#086BDE; border: none; width: 80px;">저장</button>
	</div>
	
	
</div>
</form>
