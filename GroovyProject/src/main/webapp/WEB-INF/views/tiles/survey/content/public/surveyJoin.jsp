<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		border: solid 1px #d9d9d9;
		border-radius: 2%;
	}

	span.askinput{
		margin: 2% 3%;
		display: block;
	}
	
	input.inputopt{
		border: none;
		margin-left: 1%;
	}
	
	input:focus{
		outline: none;
	}
	
	
	
	button#btn_cancle {
	 	background-color:#d9d9d9; 
	 	width: 80px; 
	 	margin-right: 2%;
	}
	
	
	
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		// === 취소버튼을 누르면 === //
		$("button#btn_cancle").click(function(e){
			location.href="redirect:/survey/surveyList.on";
		}); // end of $("button#btn_sumbit").click(function(){ -------------

			
		/*
		// === 제출버튼을 누르면 === //
		$("button#btn_sumbit").click(function(e){
		
			
			if(confirm("제출된 응답은 수정할 수 없습니다.\n제출하시겠습니까?") == true ) {
				func_submit();
			} 
			
		}); // end of $("button#btn_sumbit").click(function(){ -------------
		*/
	
		
		
	}); // end of document.ready(function(){--------------------------
		
	


		
	// >>> 제출버튼을 누르면 <<<
	function func_submit(){
		
		// 설문내용 insert
		const queryString = $("form[name='frm_surveyJoin']").serialize();
		
		$.ajax({
			url:"<%=ctxPath%>/survey/surveyJoinEnd.on",
			data: queryString,
			async: false, // 전역변수에 결과값을 담기위해서 방식을 동기방식으로 바꿔야한다.(아래의 ajax를 사용하기 위해서도 해야함.)
			type:"POST",
			dataType:"JSON",
			success:function(json){
				
				if(json.n == 1) {
					alert("설문 제출완료");
				else {
					alert("설문지 등록 실패하였습니다.");
				}
			},
		  	 error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		}); // end of 설문내용 insert $.ajax({
		
	}
	
	
	


</script>

<form name="frm_surveyJoin">
<div id="div_surveyJoin">

	<c:forEach var="askno" items="${requestScope.surveyAskList}" varStatus="status">
		<c:if test="${status.count ==1 }">
		<div style='margin: 1% 0 2% 1%'>
			<h4>${askno.surtitle}</h4>
			<div class="ml-3 mt-1">${askno.surexplain}</div>
			<input type="hidden" name="jvoList[${status.index}].fk_surno" value="${requestScope.surno}"/><br>
			<input type="hidden" name="jvoList[${status.index}].fk_empno" value="${sessionScope.loginuser.empno}"/><br>
		</div>
		</c:if>
	</c:forEach>

	<c:forEach var="askno" items="${requestScope.surveyAskList}" varStatus="status">
		<div id="contents">
			<span>${status.count}. <input type="text" name="jvoList[${status.index}].surtitle"value="${askno.question}" readonly style="border: none;"/></span><br>
			<span class="askinput"><input type="radio" name="jvoList[${status.index}].answer" value="1" class="mr-2 "/>${askno.option1}</span>
			<span class="askinput"><input type="radio" name="jvoList[${status.index}].answer" value="2" class="mr-2" />${askno.option1}</span>
			<span class="askinput"><input type="radio" name="jvoList[${status.index}].answer" value="3" class="mr-2" />${askno.option1}</span>
			<span class="askinput"><input type="radio" name="jvoList[${status.index}].answer" value="4" class="mr-2" />${askno.option1}</span>
			<span class="askinput"><input type="radio" name="jvoList[${status.index}].answer" value="5" class="mr-2" />${askno.option1}</span>
		</div>
	</c:forEach>
	
	<!-- 컨트롤러로 넘져줄때 answer${status.count}에서  ${status.count}을 substr(0,-1)해야한다. 그래야 set됨-->
	
	<div align="center">
		<button id="btn_cancle" class="btn btn-sm">취소</button>
		<button id="btn_sumbit" onclick="func_submit();" class="btn btn-sm" style="background-color:#086BDE; color:white; width: 80px;">제출</button>
	</div>

	<!-- 설문을 제출하면 내가 작성한 답변을 확인할 수 있다. 답변창 readonly로 설정하기-->

</div>
</form>