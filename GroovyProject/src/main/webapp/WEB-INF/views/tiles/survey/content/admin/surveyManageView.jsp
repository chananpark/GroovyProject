<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% String ctxPath = request.getContextPath(); %>

<style>

	div#div_surveyManageView {
		padding: 5% 2%;
		width: 95%;
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
	
	

 

</style>

<script type="text/javascript">



</script>



<form name="frm_surveyManageView">
<div id="div_surveyManageView">

	<div style='margin: 1% 0 3% 1%'>
		<h4>설문상세</h4>
	</div>
	
	<div class="m-4">
		<div class="mb-4">
			<button id="btn_delete" class="btn btn-sm" onclick="">삭제</button>
			<button id="btn_update" class="btn btn-sm" style="background-color:#086BDE; color:white;">수정</button>
			<button><i class="fas fa-download fa-1x"></i> 결과다운로드(Excel)</button>
		</div>
	
		<div class="mb-4">
			<span>기간: 2022-11-9 ~ 2022-12-10</span>
			<span>대상: 전직원</span>
			<span>결과: 비공개</span>
			<span>참여현황: 12/50</span>
		</div>
		
			<div id="contents" class="mb-4">
				<input type="text" name=""  value="1.~~~~~~~~" style="border: none;"/><br>
				<div id="viewstatus"><span>전체참여자 : 25명 </span><span style="margin-left: 4%;">참여율 : </span></div>
				차트넣기
			</div>
		</div>
		
		
		<div align="center">
			<button class="btn btn-sm" onclick="javascript:location.href='<%= ctxPath%>/survey/surveyManage.on'"style="background-color:#086BDE; color:white; width: 80px;">뒤로</button>
		</div>
		
	</div>
</form>
