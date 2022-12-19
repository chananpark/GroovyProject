<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
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
	
	#extraaddress {
		display: inline-block; 
		width: 190px; 
		margin: 10px 0 10px 8px;
	}
	
	#detailaddress {
		display: inline-block; 
		 width: 190px;
	}
	
	span#birthday > input{
		width: 55px;
	}
	
	input#empimg {
		 height:150px; 
		 width: 100px;
	}

	
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	
	$(document).ready(function(){
	
		 $("div#msg_probation").hide();
		 $("div.error").hide();
		 $("input#btn_updateEnd").hide();
		 $("button#btn_adrsearch").hide();
		 $("button#checkPvEmail").hide();
		 $("input#file").hide();
		 
		 $("input").prop("readonly",true);
		 
		// === 생년월일 === //
	        
		    var dt = new Date();
		    var com_year = dt.getFullYear();
		    
		    
		 // 년도 뿌려주기
		    $("#birthyyyy").append("<option value=''>년도</option>");
		    // 올해 기준으로 -50년부터 +1년을 보여준다.
		    for (var i = (com_year - 50); i <= (com_year); i++) {
		      $("#birthyyyy").append("<option value='" + i+ "'>" + i + " 년" + "</option>");
		    }
		    
		    // 월 뿌려주기(1월부터 12월)
		    var month;
		    $("#birthmm").append("<option value=''>월</option>");
		    for (var i = 1; i <= 12; i++) {
		    	
		    	if(i<10){
		    		month += "<option>0"+i+"</option>";
				}
				else{
					month += "<option>"+i+"</option>";
				}
		    } 
			$("#birthmm").html(month);
		    
		    // 일 뿌려주기(1일부터 31일)
		    var day;
		    $("#birthdd").append("<option value=''>일</option>");
		    for (var i = 1; i <= 31; i++) {
		    	if(i<10){
		    		day += "<option>0"+i+"</option>";
				}
				else{
					day += "<option>"+i+"</option>";
				}
		    }
			$("#birthdd").html(day);
		 
			
		// === 주소추가 버튼을 클릭하면 === //	
		$("button#btn_adrsearch").click(function(){
			
			 $("input#detailaddress").val("");
		});
		 
		 
		// === 우편번호 찾기를 클릭했을 때 이벤트 처리하기 === //
		 $("button#btn_adrsearch").click(function() {
		 	b_flag_btn_adrsearch_click = true;
		 });
		 
		 // === 우편번호 입력란에 키보드로 입력할 경우 이벤트 처리하기 === //
		 $("input:text[id='postcode']").keyup( function() {
		 	alert("우편번호 입력은 \"우편번호찾기\"를 클릭하여 입력해야 합니다. ");
		 	$(this).val("");
		 });
		 
		/*  // === 이미지 파일첨부 === //
		 $("input#empimg").change(function(){
			 if(this.files && files[0]){
				 var reader = new FileReader;
				 
				 reader.onload = function(date){
					 $(".select_img").attr("src", data.target.result);
				 }
				 reader.readAsDataURL(this.files[0]);
			 }
		 }); // end of  $("input#empimg").change(function(){ --------------------------
		  */
		  
		  
		
		 
		 
		 // === 수정버튼을 클릭하면 === // 
		$("input#btn_update").click(function(e){
			let result = confirm("정보를 수정하시겠습니까?");
			
			if (result == true){
			/* 	
				var inputs = document.getElementsByClassName('readonly');
				
				for(var i=0; i< inputs.length; i++) {
					inputs[i].readOnly = false;
				}
				 */
				$("input.readonly").prop('readonly',false); // 수정가능
				$("button#btn_adrsearch").show();
				$("button#checkPvEmail").show();
				$("input#btn_update").hide();
				$("input#btn_updateEnd").show();
				$("input[name='attach']").show();
				$("i#personimg").hide();
				return;
			}
				
		}); // end of $("button#btn_update").click(function(e){ -------------------
		 
			
		// === 저장버튼을 누르면 === //
		$("input#btn_updateEnd").click(function(e){
			let result = confirm("정보를 수정하시겠습니까?");
			
			if (result == true){
				go_updateEnd();
			}
		}); // end of $("input#btn_updateEnd").click(function(e){ ------------------
			
			
			
	
}); // end of $(document).ready(function(){}-----------------------------------------







//>>> Function Declaration <<< //

// 이미지 미리보기
function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      document.getElementById('preview').src = e.target.result;
    };
    reader.readAsDataURL(input.files[0]);
  } else {
    document.getElementById('preview').src = "";
  }
}
		
	
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
	
	
	
	
	// >>> 개인이메일 확인버튼 누르면 (ajax)<<<
	function func_checkEmail(pvemail) {
	 
		let b_flag_emailDuplicate_click = true;
		
		const $pvemail = $("input#pvemail").val();
		
		if($pvemail == "") {
			$("div#pvemailCheck").text("이메일을 입력해주세요").show();
			$("input#cpemail").focus();
			
		}
		else {
			$("div#pvemailCheck").text("이메일을 입력해주세요").hide();
		
		$.ajax({
		  url:"<%= request.getContextPath()%>/manage/admin/checkPvEmail.on",
		  data:{"pvemail":$("input#pvemail").val()},
		  type:"POST",
		  dataType:"JSON",
		  success:function(json){
			  
			  if(json.n == 1) {
				$("div#pvemailcheckResult").html($("input#pvemail").val()+" 은(는) 이미 사용중인 개인이메일 입니다.").css("color","red");
	           	$("input#pvemail").val("");
			  }
			  else {
				  $("div#pvemailcheckResult").html($("input#pvemail").val()+" 은(는) 사용가능한  개인이메일 입니다.").css("color","##086BDE");
			  }
		  },
		  error: function(request, status, error){
			  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
		
		}
	} // end of function btn_register() { -----------------------------
	

	
	
	// >> 정보수정완료 페이지로 이동 << 
	function go_updateEnd(){
		
/* 		const queryString = $("form[name='frm_manageInfo']").serialize();
		console.log(queryString); */
		const formData = new FormData($('#frm_manageInfo')[0]) ; 

		
		$.ajax({
			url:"<%= ctxPath%>/manage/info/viewInfoEnd.on",
			data: formData,
			type:"post",
			dataType:"JSON",
			// ajax를 이용한 요청인 경우 ajax 옵션에 processData: false, contentType: false 이 두가지 속성 값을 추가
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			success:function(json){
				
				if(json.n == 1) {
					alert("정보수정이 완료되었습니다.");
					history.go(0);// 새로고침
				}
				else {
					alert("정보수정 실패하였습니다.");
					console.log(json);
				}
			},
		  	 error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		
		}); // $.ajax({ ---------------------
	} // end of function go_update(){ -------------------------------

		
</script>




<form name="frm_manageInfo" id="frm_manageInfo" method="post" enctype="multipart/form-data">
	
<div style='margin: 1% 0 7% 1%'>
	<h4>내정보</h4>
</div>

<div class='mx-4'>
	
	<table class="m-4 mb-3 table table-bordered table-sm" id="first_table">
		<tr>
			<td rowspan='4' style="width:2%;">
				<c:choose>
					<c:when test="${empty loginuser.empimg}">
						<i id="personimg" class="fas fa-user-tie fa-10x mt-2 ml-2" ></i><input type="hidden" name="empimg"/>
					</c:when>
					<c:otherwise>
						<img id="preview" src="<%=ctxPath%>/resources/images/profile/${loginuser.empimg}" class="image-box" width="150px;" />
				    	<input id="file" name="attach" type="file" accept="image/*" onchange="readURL(this)" style="width: 65px;"/>
					</c:otherwise>
				</c:choose>
			</td>
			
			<!-- <td rowspan='4' style="width:2%;"><input type="file" name="empimg" id="empimg" accept=".png, .jpeg" onchange="fileUpload(this)" class"readonly"/></td>   -->
																					  <!-- accept는 입력받을 수 있는 파일의 유형을 지정하는 속성 -->
			<th class="t1">사원번호</th>
			<td>	
				<input type="text" id="" name="empno" value="${loginuser.empno}" />
			</td>
			
			<th class="t1">성명</th>
			<td><input type="text" id="name" name="name" value="${loginuser.name}" required></input></td>
		</tr>
		<tr >
			<th class="t1">주민등록번호</th>
				<td>
					<span>
						<input type="text" id="jubun" name="jubun" value="${loginuser.jubun}" style="display: inline;" />
					</span>
				</td>
			<th class="t1">성별</th>
			 <td style="text-align: left;">
			 <c:choose>
				 	<c:when test="${loginuser.gender eq '1' }">남성</c:when>
		            <c:otherwise>여성</c:otherwise>
	         	</c:choose>
	         </td>
		</tr>
		<tr>
			<th class="t1"><span class="alert_required" style="color: red;">*</span>생년월일</th>
			<td>
				<span id="birthday">
				    	<input name="year" id="birthyyyy" class="requiredInfo" required value="${requestScope.birthyyyy}"/>
						<input name="month" id="birthmm" title="월" class=" requiredInfo" required value="${requestScope.birthmm}"/> 
						<input name="day" id=birthdd title="일" class=" requiredInfo" required  value="${requestScope.birthdd}"/> 
				</span>
			</td>
			<th></th>
			<td></td>
		</tr>
		<tr>
			<th class="t1">자택주소</th>
			<td colspan="3">
			<span>
				<input type="text" id="postcode" name="postcode" value="${loginuser.postcode}" class="update readonly" placeholder="우편번호" style="display: inline-block;" />
				<input type="text" id="address" name="address" value="${loginuser.address}" class="input_style update readonly" readonly placeholder="예)00동, 00로" readonly/>
				<input type="text" id="detailaddress" name="detailaddress" value="${loginuser.detailaddress}"  class="input_style update readonly" readonly placeholder="상세주소"/>
				<input type="text" id="extraaddress" name="extraaddress" value="${loginuser.extraaddress}" placeholder="참고항목" class="update readonly"/>
				<button type="button" id="btn_adrsearch" onclick="openDaumPOST();" class="btn btn-sm ml-2">변경</button>
			</span>
			</td>
		</tr>

	</table>
	
	<table  class="m-4 mb-3 table table-bordered" >
		<tr>
			<th>내선번호</th>
			<td><input type="text" id="" name="" value="${loginuser.depttel}" />
			</td>
			<th>핸드폰번호</th>
	         <td style="text-align: left;" id="telNum" >
	             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" class="requiredInfo update"/>&nbsp;-&nbsp;
	             <input type="text" id="hp2" name="hp2" value="${requestScope.tel1}" size="6" maxlength="4" class="requiredInfo update readonly"/>&nbsp;-&nbsp;
	             <input type="text" id="hp3" name="hp3" value="${requestScope.tel2}" size="6" maxlength="4" class="requiredInfo update readonly"/>
	             <div class="error">휴대폰 형식이 아닙니다.</div>
	         </td>

		</tr>
		<tr>
			<th>회사이메일</th>
			<td><input type="email" id="cpemail" name="cpemail" value="${loginuser.cpemail}"/>
				
			</td>
			<th>외부이메일</th>
			<td>
				<input type="email" id="pvemail" name="pvemail" value="${loginuser.pvemail}" class="update readonly" />
				<button type="button" class="btn btn-sm ml-5 btn_check" id="checkPvEmail" onclick="func_checkEmail()">확인</button>
				<div id="pvemailCheck"></div>
				<div id="pvemailcheckResult"></div>
			</td>

		</tr>
	</table>
	
	<table  class=" m-4 mb-3 table table-bordered ">
			
	
	<tr>
			<th><span class="alert_required" style="color: red;">*</span>부문</th>
			<td>
				<input type="text" id="bumun" name="bumun"  value="${loginuser.bumun}" />
			</td>
			<th><span class="alert_required required" style="color: red;">*</span>부서</th>
			<td>
				<input type="text" id="department"   name="department" value="${loginuser.department}" />
			</td>
			
		</tr>
		<tr>
			<th><span class="alert_required" style="color: red;">*</span>직급</th>
			<td>
				<input type="text" id="position" name="position" value="${loginuser.position}" />
			</td>
			<th><span class="alert_required" style="color: red;">*</span>급여계약기준</th>
			<td>
			<c:choose>
				<c:when test="${loginuser.empstauts eq '1'}">
					<input type="text" id="empstauts" name="empstauts" value="정규직" />
				</c:when>
				<c:otherwise><input type="text" id="empstauts" name="empstauts" value="비정규직" /></c:otherwise>
			</c:choose>
			
			
				
			</td>
		</tr>
		<tr>
			<th>연봉</th>
			<td><div style="background-color: "><fmt:formatNumber value="${loginuser.salary}" pattern="#,###"/></div></td>
			<th><span class="alert_required" style="color: red;">*</span>입사일자</th>
			<td><input type="text" style="width: 165px;"  value="${loginuser.joindate}"/></td>
		</tr>
		<tr>
			<th><span class="alert_required" style="color: red;">*</span>은행</th>
			<td>
				<input type="text" class="emppay readonly" name="bank" value="${loginuser.bank}" style="width: 165px; background-color: white;"/>
			</td>
			<th><span class="alert_required" style="color: red;">*</span>계좌</th>
			<td><input type="text" name="account"  class="readonly" value="${loginuser.account}"  style="width: 165px; background-color: white;" /></td>
		</tr>
	</table>
	
	<div align="right" style="margin: 3% 0;">
		<input type="button" id="btn_update" style="color: white; background-color:#086BDE; border: none; width: 80px;" value="수정"/>
	</div>
	
	
	<%-- 정보수정 페이지에서 보이는 버튼 --%>
	<div align="right" style="margin: 3% 0;">
		<input type="button"  id="btn_updateEnd" style="color: white; background-color:#086BDE; border: none; width: 80px;" value="저장"/>
	</div>
	

</div>
</form>