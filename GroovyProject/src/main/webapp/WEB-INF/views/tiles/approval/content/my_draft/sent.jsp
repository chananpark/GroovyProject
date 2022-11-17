<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#list {
	font-size: small;
	margin-bottom: 150px !important;
}

tbody > tr:hover{
	background-color: #E3F2FD;
	cursor: pointer;
}

#pageList a{
	font-size: small;
	color: black;
}

#pageList .active a{
	color: white;
	background-color: #086BDE;
}
</style>

<script>
$(()=>{
	$('a#sentList').css('color','#086BDE');
	$('.personalMenu').show();
});
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>개인 문서함</h4>
</div>

<h5 class='m-4'>상신함</h5>

<div id='list' class='m-4'>

	<div class="text-right mb-3">
		<form name="searchFrm">
			<!-- 검색 구분 -->
			<select id="searchType" name="searchType" class="mr-1">
				<option value="draftNo">문서번호</option>
				<option value="draftCate">종류</option>
				<option value="draftSubject">제목</option>
			</select>
			<!-- 검색어 입력창 -->
			<input type="text" style="display: none;" /> <input type="text"
				id="searchWord" name="searchWord" placeholder="검색어를 입력하세요" />&nbsp;
			<button class="rounded" type="button" onclick="goSearch()">
				<i class="fas fa-search"></i>
			</button>
		</form>
	</div>

	<div class="row mb-3">
		<div class='col'>
			<i class="fas fa-download"></i>&nbsp;목록 다운로드
		</div>
		<div class='col text-right'>
			<select id="sizePerPage" name="sizePerPage">
					<option value="10">10</option>
					<option value="30">30</option>
					<option value="50">50</option>
			</select> 
			<select id="sortType" name="sortType">
				<option value="newest">최신순</option>
				<option value="oldest">오래된순</option>
			</select>
		</div>
	</div>

	<table class="table">
		<thead>
			<tr class='row'>
				<th class='col col-2'>기안일</th>
				<th class='col col-2'>종류</th>
				<th class='col col-2'>문서번호</th>
				<th class='col'>제목</th>
				<th class='col col-2'>결재상태</th>
			</tr>
		</thead>
		<tbody>
			<tr class='row'>
				<td class='col col-2'>2022.11.09</td>
				<td class='col col-2'>지출결의</td>
				<td class='col col-2'>20221109-04</td>
				<td class='col'><span class="badge badge-pill badge-danger">긴급</span>&nbsp;시내교통비</td>
				<td class='col col-2'><span class="badge badge-success">진행중</span></td>
			</tr>
		</tbody>
	</table>
</div>

<div id="pageList">
	<!-- Center-aligned -->
	<ul class="pagination justify-content-center" style="margin:20px 0">
	    <li class="page-item"><a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a></li>
		<li class="page-item active"><a class="page-link" href="#">1</a></li>
		<li class="page-item"><a class="page-link" href="#">2</a></li>
		<li class="page-item"><a class="page-link" href="#">3</a></li>
		<li class="page-item"><a class="page-link" href="#"><i class="fas fa-chevron-right"></i></a></li>
	</ul>
</div>