<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath=request.getContextPath(); %>
<style>
#list {
	font-size: small;
	margin-bottom: 50px !important;
}

#pageList a{
	font-size: small;
	color: black;
}

#pageList .active a{
	color: white;
	background-color: #086BDE;
}

label {
	margin-bottom: 0;
}

label:hover {
	cursor: pointer !important;
}

.smallBtn {
	font-size: small;
	padding: 1px 2px;
	margin-left: 1px;
	vertical-align: middle;
}

input[type='checkbox'] {
	vertical-align: middle;
}
</style>

<script>
$(()=>{

	$('a#savedList').css('color','#086BDE');
	$('.personalMenu').show();
	
	// 검색창에서 엔터시 검색하기 함수 실행
	$("#searchWord").bind("keydown", (e) => {
		if (e.keyCode == 13) {
			goSearch();
		}
	});
	
	// 검색어가 있을 경우 검색타입 및 검색어 유지시키기
	if (${not empty paraMap.searchType}){
		$("select#searchType").val("${paraMap.searchType}");
		$("input#searchWord").val("${paraMap.searchWord}");
	}
	
	// pageSize 유지시키기
	$("select#pageSize").val("${paraMap.pageSize}");
	
	// sortType 유지시키기
	$("select#sortType").val("${paraMap.sortType}");
	
	// sortOrder 유지시키기
	$("select#sortOrder").val("${paraMap.sortOrder}");
	
	// 체크박스 한개 선택 시 이벤트
	$(".checkboxes").click(()=>{
		
		const checkArr = Array.from($(".checkboxes"));
		
		// 모든 체크박스가 체크되어 있는지 확인
		let isAllChecked = checkArr.every(el => el.checked);
		
		if(isAllChecked)
			$("#checkAll").prop('checked', true);
		else
			$("#checkAll").prop('checked', false);
	});
	
});
	
const goSearch = () => {
	const frm = document.searchFrm;
	
	frm.method = "get";
	frm.action = "<%=ctxPath%>/approval/personal/saved.on";
	frm.submit();
}

function checkAllBtns (e) {
	const checked = $(e).prop('checked');
	$(".checkboxes").prop('checked', checked);
	
}

const deleteDraft = () => {
	
	let selectedArr = Array.from($(".checkboxes")).filter(el=>el.checked);
	let valueArr = selectedArr.map(el=>el.previousElementSibling.value);
	const deleteList = valueArr.join(',');
	
	let formData = new FormData();
	formData.append('deleteList', deleteList);	
	
	fetch('<%=ctxPath%>/approval/delete.on', {
	    method: 'POST',
	    cache: 'no-cache',
	    body: formData // body 부분에 폼데이터 변수를 할당
	})
	.then((response) => response.json())
	.then((data) => {
		swal(data.result + "건의 문서가 성공적으로 삭제되었습니다.")
		.then((value) => {
				location.href="javascript:history.go(0)"
			});
	})
	.catch((err) => {
	   console.error(err)
	});
	
}
</script>


<div style='margin: 1% 0 5% 1%'>
	<h4>개인 문서함</h4>
</div>

<div id='list' class='m-4'>
	<h5 class='mb-3'>임시저장함</h5>
	<span>임시저장된 문서는 30일 뒤 자동으로 삭제됩니다.</span>

	<form name="searchFrm">
		<div class="text-right mb-3">
				<%-- 검색 구분 --%>
				<select id="searchType" name="searchType" class="mr-1" style="padding: 3px">
					<option value="draft_no">문서번호</option>
					<option value="draft_type">종류</option>
					<option value="draft_subject">제목</option>
					<option value="draft_emp_name">기안자</option>
				</select>
				<%-- 검색어 입력창 --%>
				<input type="text" style="display: none;" /> 
				<input type="text" id="searchWord" name="searchWord" placeholder="검색어를 입력하세요" />&nbsp;
				<button type="button" style="border: none; background-color: transparent;" onclick="goSearch()">
					<i class="fas fa-search fa-1x"></i>
				</button>
		</div>
	
		<div class="row mb-3">
			<div class='col'>
				<input type="checkbox" id='checkAll' style='vertical-align: middle; margin-right: 2px' onclick='checkAllBtns(this)'/>
				<label for='checkAll'>&nbsp;모두선택/해제</label>&nbsp;
				<button type="button" class='btn btn-secondary smallBtn' onclick='deleteDraft()'>선택삭제</button>
			</div>
			<div class='col text-right'>
				<select id="pageSize" name="pageSize" onchange="goSearch()">
					<option value="10">10</option>
					<option value="30">30</option>
					<option value="50">50</option>
				</select> 
				<select id="sortOrder" name="sortOrder" onchange="goSearch()">
					<option value="desc">최신순</option>
					<option value="asc">오래된순</option>
				</select>
			</div>
		</div>
	</form>

	<table class="table">
		<thead>
			<tr class='row'>
				<th class='col col-2'>선택</th>
				<th class='col col-2'>작성일</th>
				<th class='col col-2'>종류</th>
				<th class='col'>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty draftList}">
					<c:forEach items="${draftList}" var="draft" varStatus="sts">
						<tr class='row'>
							<td class='col col-2'>
								<input type="hidden" id="seq${sts.index}" class="sequences" value="${draft.draft_seq}"/>
								<input type="checkbox" id="check${sts.index}" class="checkboxes"/>
								<label for="check${sts.index}" class='btn smallBtn'>&nbsp;문서 선택</label>
							</td>
							<td class='col col-2'>${draft.draft_date}</td>
							<td class='col col-2'>${draft.draft_type}</td>
							<td class='col'>${draft.draft_subject}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan='6' class='text-center'>게시물이 존재하지 않습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>

<div id="pageList">
	${pagebar}
</div>