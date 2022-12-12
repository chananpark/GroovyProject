<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<style>

	div#div_writing {
		padding: 5% 2%;
		width: 95%;
	}
	
	div#surveyform > div {
		margin-bottom: 3%;
	}
	
	div.marginbottom {
		margin-bottom: 1%;
	}
	input {
		border: solid 1px #d9d9d9;
		margin-bottom: 1%;
	}
	
	button#btn_next {
		width: 80px;
		background-color: #086BDE;
		color:white;
		font-size: 14px;
		border: none;
	}

	
	button#btn_cancle {
	 	background-color:#d9d9d9; 
	 	width: 80px; 
	 	margin-right: 2%;
	}
	div#team {
		margin: 1% 3%;
		width:30%;
	}
	div#team > input {
		margin-top: 1%;
	}
	
	button#btn_next {
		background-color:#086BDE; 
		color:white;
		 width: 80px;
	}
	div.mb-3{
		font-weight: bold;
	}
	
</style>

<script type="text/javascript">

$("div#team").hide();


	$(document).ready(function(){
	
		$("input#check_team").change(function(){
			
			$("div#team").show();
			
		}); // end of $("input#check_team").click(function(){-------------------
	
		
	}); // end of $(document).ready(function(){-----------------------
	

	// >>> 대상선택버튼 <<<
	function checkOnlyOne(element) {
		  
		  const checkboxes 
		      = document.getElementsByName("surtarget");
		  
		  checkboxes.forEach((cb) => {
		    cb.checked = false;
		  })
		  
		  element.checked = true;
		}
	
	// >>> 공개여부 선택버튼 <<<
	function checkOpenOne(element) {
		  
		  const checkboxes 
		      = document.getElementsByName("suropenstatus");
		  
		  checkboxes.forEach((cb) => {
		    cb.checked = false;
		  })
		  
		  element.checked = true;
		}
	
	
	// >>> 다음버튼을 누르면<<<
	function go_nextSelect() {
	
		const frm = document.frm_writing
		frm.action = "<%= ctxPath%>/survey/surveyWritingEnd.on";
		frm.method = "GET";
		frm.submit();
	}
	
	
</script>



<form name="frm_writing">
<div id="div_writing">
	
	<div style='margin: 1% 0 3% 1%'>
		<h4>설문작성</h4>
	</div>
	
	<div id="surveyform" class="m-4" >
		<div>
			<div class="mb-3">설문제목</div>
			<input type="text" name="surtitle" style="width: 95%;" placeholder="설문 제목을 입력해주세요."/>
		</div>
		
		<div>
			<div class="mb-3">설명(선택사항)</div>
			<input type="text" name="surexplain" size="300px;"  style="width: 95%; height: 100px;" placeholder="설문에대한 설명을 입력해주세요." />
		</div>
		
		<div>
			<span class="mb-3 mr-5" style="font-weight: bold;">설문시작일&nbsp;&nbsp;<input type="date" name="surstart"/></span>
			<span class="mb-3 mr-5" style="font-weight: bold;">설문종료일&nbsp;&nbsp;<input type="date" name="surend"/></span>
		</div>
		
		<div>
			<div class="mb-3">설문대상</div>
			<input type="checkbox" name="surtarget" value="1" onclick="checkOnlyOne(this)" style="margin-left: 1%;">&nbsp;전사원 </input> <br>
			<input type="checkbox" name="surtarget" value="0" onclick="checkOnlyOne(this)" id="check_team" style="margin-left: 1%;">&nbsp;직접선택(팀)</input>   <!-- 여길 누르면 설문대상을  선택하는 창 띄우기 -->
			<div id="team">
				<input type="checkbox" name="fk_department_no" value="1" class="teamCheck"> 이사실</input> <br>
				<input type="checkbox" name="fk_department_no" value="2"  class="teamCheck"> 인사총무팀</input> <br>
				<input type="checkbox" name="fk_department_no" value="3"  class="teamCheck"> 개발팀</input> <br>
				<input type="checkbox" name="fk_department_no" value="4"  class="teamCheck"> 기획팀</input> <br>
				<input type="checkbox" name="fk_department_no" value="5"  class="teamCheck"> 영업팀</input> <br>
				<input type="checkbox" name="fk_department_no" value="6"  class="teamCheck"> 마케팅</input> <br>
				<input type="checkbox" name="fk_department_no" value="7"  class="teamCheck"> 재경팀</input>
				
			</div>
		</div>
		
		
		<div>
			<div class="mb-3">설문결과 공개</div>
			<input type="checkbox" name="suropenstatus" onclick="checkOpenOne(this)" value="1" calss="my-2" >&nbsp;비공개</input> <br>  
			<input type="checkbox" name="suropenstatus" onclick="checkOpenOne(this)" value="2" >&nbsp;공개 </input> 
			
		</div>
	</div>
	
	<div align="center" class="mt-5">
		<button id="btn_cancle" class="btn btn-sm"  href="location.href='redirect:/survey/surveyList.on'">취소</button>
		<button id="btn_next" class="btn btn-sm"  onclick="go_nextSelect()" >다음</button>
	</div>

</div>
</form>  