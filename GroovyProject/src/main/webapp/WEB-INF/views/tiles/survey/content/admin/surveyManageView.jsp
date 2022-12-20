<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 

<style>

	div#div_surveyManageView {
		padding: 5% 2%;
		width: 95%;
		margin: 1% 0 3% 1%
	}
	button {
		border: none;
		background-color: white;
	}
	
	input {
		border: none;
	}
	

	button#btn_delete {
	 	background-color:#d9d9d9; 
	 	margin-right: 1%;
	}
	
	div#viewstatus {
		margin: 1% 0; border: solid 1px #d9d9d9; width: 30%;
	}
	
	div#question{
		border: solid 1px  #cccccc;
		padding: 2%;
		border-radius: 1%;
	}

 

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// === 삭제하기 버튼을 클릭하면 === //
		$("button#btn_delete").click(function(){
			
			const $surno = $("input[name='surno']").val();
			const result = confirm("해당 설문지를 삭제하시겠습니까?");
			console.log($surno );
			
			if(result){
				btn_delete($surno);
			}
			
		}); // end of $("button#btn_delete").click(function(){ --------------------
	}); // end of $(document).ready(function(){ ------------------------------
	
		
		
	// >> 삭제하기 버튼을 클릭하면 << //
	function btn_delete(surno) {
		
		$.ajax({
			url:"<%=ctxPath%>/survey/surveyDelete.on",
			data:{"surno":$("input[name='surno']").val()},
			type:"POST",
			dataType:"JSON",
			success:function(json){
				
				console.log(json.n);
				if(json.n == 1){
					swal("해당 설문지를 삭제하였습니다");
					location.href="<%= ctxPath%>/survey/surveyManage.on";
				}
				else {
					swal("설문지 삭제실패.");
				}
			},
		  	 error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		
		}); // end of $.ajax({ ----------------------------------
	}


</script>



<form name="frm_surveyManageView">
<div id="div_surveyManageView">


<input type="hidden" name="surno" value="${requestScope.surno}">
	<c:forEach var="resultView" items="${requestScope.resultViewList}" varStatus="status">
	<c:if test="${status.count ==1 }">
		<div>
			<h4>${resultView.surtitle}</h4>
			<div>${resultView.surexplain}</div>
		</div>
		
	
		<div class="my-3">
			<button type="button" id="btn_delete"  class="btn btn-sm" >삭제</button>
			<!-- <button id="btn_update" class="btn btn-sm" style="background-color:#086BDE; color:white;">수정</button> -->
			<button ><i class="fas fa-download fa-1x"></i> 결과다운로드(Excel)</button>
		</div>
	
		<div class="mb-4">
			<span class="mr-5"><b>기간: </b>${resultView.surstart} ~ ${resultView.surend}</span>
			<span class="mr-5"><b>대상:</b>
				<c:choose>
					<c:when test="${resultView.surstatus == 1}">전사원</c:when>
					<c:otherwise>특정대상</c:otherwise>
				</c:choose>
			</span>
			<span class="mr-5"><b>참여현황: </b>${requestScope.joinempcnt}/${requestScope.empCnt}</span>
			<span class="mr-5"><b>참여율: </b></span>
		</div>
	</c:if>
	</c:forEach>
	
	<c:forEach var="askView" items="${requestScope.surveyAskList}" varStatus="status">
		<div id="contents" class="my-5">
			<div id="question" >
				${status.count}.<span class="ml-2">${askView.question}</span><br>
				<div id="viewstatus"></div>
				차트넣기
			</div>
		</div>
	</c:forEach>		
			
			
		</div>
		
		<div align="center">
			<button class="btn btn-sm" onclick="javascript:history.back()" style="background-color:#086BDE; color:white; width: 80px;">뒤로</button>
		</div>
		
	</div>
</form>
