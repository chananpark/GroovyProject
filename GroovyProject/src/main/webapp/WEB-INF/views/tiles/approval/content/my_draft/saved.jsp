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

#searchBtn {
	border-style: none;
	padding: 3px 7px;
}
</style>

<script>
$(()=>{
	$('a#savedList').css('color','#086BDE');
	$('.personalMenu').show();
});
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>개인 문서함</h4>
</div>

<div id='list' class='m-4'>
	<h5 class='mb-3'>임시저장함</h5>
	<span>임시저장된 문서는 30일 뒤 자동으로 삭제됩니다.</span>

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
			<button class="rounded" type="button" onclick="goSearch()" id='searchBtn'>
				<i class="fas fa-search"></i>
			</button>
		</form>
	</div>

	<div class="row mb-3">
		<div class='col'>
			<input type="checkbox" id='checkAll' style='vertical-align: middle; margin-right:2px'/><label for='checkAll'>모두선택/해제</label>
			<button type="button" class='btn btn-sm btn-light'>선택삭제</button>
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
				<th class='col col-1'>선택</th>
				<th class='col col-2'>작성일</th>
				<th class='col col-2'>종류</th>
				<th class='col'>제목</th>
			</tr>
		</thead>
		<tbody>
			<tr class='row'>
				<td class='col col-1'><input type="checkbox" id='checkAll'/></td>
				<td class='col col-2'>2022.11.15</td>
				<td class='col col-2'>지출결의</td>
				<td class='col'>법인카드지출결의</td>
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