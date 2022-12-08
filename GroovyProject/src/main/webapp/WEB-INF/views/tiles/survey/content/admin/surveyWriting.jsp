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
	
</style>

<script type="text/javascript">



</script>



<form name="frm_writing">
<div id="div_writing">
	
	<div style='margin: 1% 0 3% 1%'>
		<h4>설문작성</h4>
	</div>
	
	<div id="surveyform" style='margin: 1% 0 3% 1%'>
		<div>
			<div class="marginbottom">설문제목</div>
			<input type="text" style="width: 95%;"  placeholder="설문 제목을 입력해주세요."/>
		</div>
		
		<div>
			<div class="marginbottom">설명(선택사항)</div>
			<input type="text" style="width: 95%; height: 100px;" placeholder="설문에대한 설명을 입력해주세요." />
		</div>
		
		<div>
			<div class="marginbottom">설문기간</div>
			<input type="date"/>   ~  <input type="date"/> 
		</div>
		
		<div>
			<div class="marginbottom">설문대상</div>
			<input type="checkbox" style="margin-left: 1%;">&nbsp;전사원 </input> <br>
			<input type="checkbox" style="margin-left: 1%;">&nbsp;직접선택(팀)</input>   <!-- 여길 누르면 설문대상을  선택하는 창 띄우기 -->
		</div>
		
		
		<div>
			<div class="marginbottom">설문결과 공개</div>
			<input type="checkbox" style="margin-left: 1%;">&nbsp;공개 </input> <br>
			<input type="checkbox" style="margin-left: 1%;">&nbsp;비공개</input>   <!-- 여길 누르면 설문대상을  선택하는 창 띄우기 -->
		</div>
	</div>
	
	<div align="center" style="margin-top: 3%;">
		<button id="btn_cancle" class="btn btn-sm" onclick="javascript:location.href='<%= ctxPath%>/survey/surveyList.on'">취소</button>
		<button id="btn_next" class="btn btn-sm" onclick="<%= ctxPath%>/survey/surveyWritingEnd.on" style="background-color:#086BDE; color:white; width: 80px;">다음</button>
	</div>

</div>
</form>  