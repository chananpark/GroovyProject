<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% String ctxPath = request.getContextPath(); %>

<style>

	div#div_surveyJoin {
		padding: 5% 2%;
		width: 95%;
	}
	button {
		border: none;
		background-color: white;
	}

	div#contents {
		margin: 1% 0 10% 1%;
		width: 90%;
		padding: 2% 0 0 3%;
	}


	div#contents > input.answer{
		width:95%;
		height: 100px;
		margin: 2% 0;
		border: solid 1px #d9d9d9;
	}
	
	
	button#btn_cancle {
	 	background-color:#d9d9d9; 
	 	width: 80px; 
	 	margin-right: 2%;
	}
	
	
	
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		
		// === 제출버튼을 누르면 === //
		$("button#btn_sumbit").click(function(e){
			
			if(confirm("제출된 응답은 수정할 수 없습니다.\n제출하시겠습니까?") == true ) {
				func_submit();
			}
			
		}); // end of $("button#btn_sumbit").click(function(){ -------------
		

		
		
	}); // end of document.ready(function(){--------------------------


</script>

<form name="frm_surveyJoin">
<div id="div_surveyJoin">


<div style='margin: 1% 0 5% 1%' >
	<input type="hidden" name="" value="${requestScope.surno}"/><br>
	<input type="text" name="" value="${surveyAskList.surtitle}" style="font-size: 24px; font-weight: bold; border:none;" readonly/><br>
	<input type="text" name="" value="${surveyAskList.surexplain}" style="border:none;" readonly/>
</div>


	
	<div id="contents">
		<input type="text" name=""  value="1.~~~~~~~~" style="border: none;"/><br>
		<input class="answer" type="text" name="" value="" placeholder="답변을 입력해주세요"/>
	</div>
	
	
	<div align="center">
		<button id="btn_cancle"  onclick="javascript:location.href='<%= ctxPath%>/survey/surveyList.on'" class="btn btn-sm">취소</button>
		<button id="btn_sumbit" class="btn btn-sm" style="background-color:#086BDE; color:white; width: 80px;">제출</button>
	</div>

	<!-- 설문을 제출하면 내가 작성한 답변을 확인할 수 있다. 답변창 readonly로 설정하기-->

</div>
</form>