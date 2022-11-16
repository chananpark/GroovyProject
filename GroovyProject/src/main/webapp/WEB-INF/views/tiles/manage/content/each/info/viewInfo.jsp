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
	
	input {
		border: solid 1px #cccccc;
	}

	button#btn_adrsearch {
		display: inline; 
		background-color:#F9F9F9;
	}
	
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	
	$(document).ready(function(){

		// === 우편번호 찾기를 클릭했을 때 이벤트 처리하기 === //
		 $("button#btn_adrsearch").click(function() {
		 	b_flag_btn_adrsearch_click = true;
		 });
		 
		 // === 우편번호 입력란에 키보드로 입력할 경우 이벤트 처리하기 === //
		 $("input:text[id='postcode']").keyup( function() {
		 	alert("우편번호 입력은 \"우편번호찾기\"를 클릭하여 입력해야 합니다. ");
		 	$(this).val("");
		 });
		 
}); // end of $(document).ready(function(){}-----------------------------------------







//>>> Function Declaration <<< //
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
</script>




<form id="frm_manageInfo">
<div id="info_manageInfo">

<div style='margin: 1% 0 5% 1%'>
	<h4>사원정보</h4>
</div>

	<h5 class='m-4'>사원등록</h5>
	
	<table class="m-4 mb-3 table table-bordered table-sm" id="first_table">
		<tr >
			<td rowspan='4' style="width:7%;"><img class="float-center" src="<%= ctxPath%>/resources/images/picture/꼬미사진.jpg" height="150px;" width="150px" alt="..."/></td>
			<th>사원번호</th>
			<td><input type="text" id="" name="" /></td>
			
			<th>성명</th>
			<td><input type="text" id="name" name="name" /></td>
		</tr>
		<tr >
			<th>주민등록번호</th>
				<td >
					<span>
						<input type="text" id="jubun" name="jubun" style="display: inline;"/>
						<button type="button" style="width:70px; display: inline; border: none;background-color:#F9F9F9; " class="btn btn-sm ml-5">확인/수정</button>
					</span>
				</td>
			<th>성별</th>
			 <td style="text-align: left;">
	            <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
	            <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
	         </td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td><input type="text" id="birth" name="birth"/></td>
			<th></th>
			<td></td>
		</tr>
		<tr>
			<th class="">자택주소</th>
			<td colspan="3">
			<span>
				<input type="text" id="postcode" name="postcode" placeholder="우편번호" style="display: inline-block;"/>
				<input type="text" id="address" name="address" class="input_style" placeholder="예)00동, 00로" />
				<input type="text" id="detailaddress" name="detailaddress" class="input_style"  placeholder="상세주소" style="display: inline-block;  width: 190px;" />
				<input type="text" id="extraaddress" name="extraaddress" placeholder="참고항목" style="display: inline-block;  width: 190px;  margin: 10px 0 10px 8px;"/>
				<button type="button" id="btn_adrsearch" onclick="openDaumPOST();" class="btn btn-sm ml-2">주소입력</button>
			</span>
			</td>
		</tr>

	</table>
	
	<table  class="m-4 mb-3 table table-bordered ">
		<tr>
			<th>회사전화</th>
			<td><input type="text" id="mobile" name="mobile" /></td>
			<th>핸드폰번호</th>
			<td><input type="text" id="mobile" name="mobile" /></td>
			<th></th>
			<td></td>
		</tr>
		<tr>
			<th>회사이메일</th>
			<td><input type="text" id="mobile" name="mobile" /></td>
			<th>외부이메일</th>
			<td><input type="text" id="mobile" name="mobile" /></td>
			<th></th>
			<td></td>
		</tr>
	</table>
	
	<table  class=" m-4 mb-3 table table-bordered table-sm">
		<tr>
			<th><span style="color: red;">*</span>사업장</th>
			<td><input type="text" id="" name="" /></td>
			<th>부문</th>
			<td><input type="text" id="" name="" /></td>
			<th>직급</th>
			<td><input type="text" id="" name="" /></td>
		</tr>
		<tr>
			<th><span style="color: red;">*</span>급여계약기준</th>
			<td><input type="text" id="" name="" /></td>
			<th>팀</th>
			<td><input type="text" id="" name="" /></td>
			<th>직책</th>
			<td><input type="text" id="" name="" /></td>
		</tr>
		<tr>
			<th ><span style="color: red;">*</span>수습여부/적용률</th>
			<td><input type="text" id="" name="" /></td>
			<th>수습기간</th>
			<td ><input type="date" id="" name="" />&nbsp;~&nbsp;<input type="date" id="" name="" /></td>
			<th >비고</th>
			<td></td>
		</tr>
		<tr>
			<th><span style="color: red;">*</span>입사일자</th>
			<td><input type="date" id="" name="" style="width: 165px;"/></td>
			<th>퇴직일자</th>
			<td><input type="date" id="" name="" style="width: 165px;"/></td>
			<th></th>
			<td></td>
		</tr>
	</table>
	
	
	<%-- 정보수정 페이지에서 보이는 버튼 --%>
	<div align="right" style="margin: 3% 0;">
		<button id="btn_update" style="background-color:#F9F9F9; border: none; width: 80px;">삭제</button>
		<button id="btn_update" style="color: white; background-color:#086BDE; border: none; width: 80px;">저장</button>
	</div>
	
	
</div>
</form>
