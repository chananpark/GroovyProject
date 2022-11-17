<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<style>
#writeBtn:hover{
	border: 1px solid #086BDE;
	color: white;
	background-color: #086BDE;
}

.topMenu:hover {
	cursor: pointer;
}

#okBtn {
	background-color: #086BDE;
	color: white;
}

#okBtn:hover {
	background-color: #E3F2FD;
	color: #086BDE;
}

.modal-body > div {
	display: table-row-group;
}
</style>

<script>
$(()=>{
	// 사이드 메뉴 닫기
	$(".subMenus").hide(); 
	
	// 메뉴 선택시 다른 메뉴 닫기      
    $(".topMenu").click(function(e) {
        const target = $(e.target.children[0]);
        if ($(target).is(":visible")) {
           $(".subMenus").slideUp("fast");             
        }
        else {
           $(".subMenus").slideUp("fast");
           $(target).slideToggle("fast");
        }
        
    });
});

const selectApv = () => {
	$('#selectApvForm').modal();
}

const goWriteForm = () => {
	const forms = Array.from($('.formChoice'));
	const selected = forms.filter(el => $(el).is(':checked'))[0].id;
	
	location.href="<%=ctxPath%>/approval/write/"+selected+".on";
}
</script>

<!-- A vertical navbar -->
<nav class="navbar bg-light">

  <!-- Links -->
  <ul class="navbar-nav">
    <li class="nav-item">
      <h4 class='mb-4'>전자결재</h4>
    </li>
    <li class="nav-item mb-4">
      <button id="writeBtn" type="button" style='width:170px' class="btn btn-outline-dark"  onclick="selectApv()">기안문서 작성</button>
    </li>
    <li class="nav-item">
      <a id="home" class="nav-link" href="<%=ctxPath%>/approval/home.on">홈</a>
    </li>
    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/approval/requested.on">결재하기<span class="badge badge-pill badge-primary ml-1">7</span></a>
    </li>
    <li class="nav-item topMenu">개인 문서함
      	<ul class='subMenus personalMenu'>
      		<li><a id="sentList" class="nav-link" href="<%=ctxPath%>/approval/personal/sent.on">상신함</a></li>
      		<li><a id="processedList" class="nav-link" href="<%=ctxPath%>/approval/personal/processed.on">결재함</a></li>
      		<li><a id="savedList" class="nav-link" href="<%=ctxPath%>/approval/personal/saved.on">임시저장함</a></li>
      	</ul>
    </li>
    <li class="nav-item">
      <a id="teamList" class="nav-link" href="<%=ctxPath%>/approval/team.on">팀 문서함</a>
    </li>
    <li class="nav-item topMenu">환경설정
      	<ul class='subMenus configMenu'>
      		<li><a id="approvalLine" class="nav-link" href="<%=ctxPath%>/approval/config/approvalLine.on">결재라인 설정</a></li>
      		<li><a id="signature" class="nav-link" href="<%=ctxPath%>/approval/config/signature.on">서명 관리</a></li>
      	</ul>
    </li>
  </ul>

</nav>

<!-- 결재양식 선택 모달 -->
<div class="modal text-left" id="selectApvForm">
	<div class="modal-dialog modal-dialog-centered ">
		<div class="modal-content">

			<!-- Modal Header -->
	<div class="modal-header">
		<h5 class="modal-title">결재양식 선택</h5>
		<button type="button" class="close" data-dismiss="modal">&times;</button>
	</div>

	<!-- Modal body -->
	<div class="modal-body" style='display: table'>
		<div>
			<input type="radio" id="work" name="formChoice" class='formChoice mr-3'>
			<label for='work'>업무품의</label>
		</div>
		<div>
			<input type="radio" id="expense" name="formChoice" class='formChoice mr-3'>
			<label for='expense'>지출결의서</label>
		</div>
		<div>
			<input type="radio" id="businessTrip" name="formChoice" class='formChoice mr-3'>
			<label for='businessTrip'>출장보고서</label>
		</div>
	</div>

	<!-- Modal footer -->
	<div class="modal-footer">
		<button type="button" id='calcelBtn' class="btn btn-secondary" data-dismiss="modal">취소</button>
		<button type="button" id='okBtn' class="btn" data-dismiss="modal" onclick='goWriteForm()'>확인</button>
			</div>
		</div>
	</div>
</div>