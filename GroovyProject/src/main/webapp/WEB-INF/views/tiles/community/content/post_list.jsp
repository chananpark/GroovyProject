<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

a {
	color: black;
}

#writeBtn {
	border-style: none;
	background-color: #086BDE;
	color: white;
	float: right;
	font-size: small;
	padding: 3px 7px;
}

</style>
<script>

$(()=>{
		
	// 정렬기준 변경시
	$("#sortType").change(()=>{
		setSortOrder();
	});
	
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

	setSortOrder();
});

const addPost = () =>{
	location.href='<%=ctxPath%>/community/write.on';
}


//검색
const goSearch = () => {
	const frm = document.searchFrm;
	
	frm.method = "get";
	frm.action = "<%=ctxPath%>/community/list.on";
	frm.submit();
}

// 정렬순서 설정하기
const setSortOrder = () => {
	if ($("#sortType").val() == "post_date") {
		$("#desc").text("최신순");
		$("#asc").text("오래된순");
	} else {
		$("#desc").text("많은 순");
		$("#asc").text("적은 순");
	}
}
</script>

<div class='container'>
	<div class='mt-4'>
		<h4>커뮤니티</h4>
	</div>
	
	<div id='list' class='m-4'>
	
		<form name="searchFrm">
			<div class="text-right mb-3">
				<%-- 검색 구분 --%>
				<select id="searchType" name="searchType" class="mr-1" style="padding: 3px">
					<option value="all">제목+내용</option>
					<option value="post_subject">제목</option>
					<option value="post_content">내용</option>
					<option value="name">작성자</option>
				</select>
				<%-- 검색어 입력창 --%>
				<input type="text" style="display: none;" /> 
				<input type="text" id="searchWord" name="searchWord" placeholder="검색어를 입력하세요" />&nbsp;
				<button type="button" style="border: none; background-color: transparent;" onclick="goSearch()">
					<i class="fas fa-search fa-1x"></i>
				</button>
			</div>
		
			<div class="row mb-3">
				<div class='col text-right'>
					<select id="pageSize" name="pageSize" onchange="goSearch()">
						<option value="10">10</option>
						<option value="30">30</option>
						<option value="50">50</option>
					</select> 
					<select id="sortType" name="sortType" onchange="goSearch()">
						<option value="post_date">작성일</option>
						<option value="post_hit">조회수</option>
					</select>
					<select id="sortOrder" name="sortOrder" onchange="goSearch()">
						<option value="desc" id='desc'></option>
						<option value="asc" id='asc'></option>
					</select>
				</div>
			</div>
		</form>
		
		<table class="table" id="teamDraftTable">
			<thead>
				<tr class='row'>
					<th class='col text-center'>번호</th>
					<th class='col col-4 text-center'>제목</th>
					<th class='col text-center'>작성자</th>
					<th class='col text-center'>작성일자</th>
					<th class='col text-center'>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
	                <c:when test="${not empty postList}">
	                    <c:forEach items="${postList}" var="post" >
	                        <tr class='row'>
								<td class='col text-center'>${post.post_no}</td>
								<td class='col col-4'><a href='<%=ctxPath%>/community/detail.on?post_no=${post.post_no}'>${post.post_subject}</a>
								&nbsp;<i class="far fa-comment mx-2"></i>${post.commentCnt}
								<c:if test="${post.fileCnt > 0}">
								&nbsp;<i class="fas fa-paperclip"></i>&nbsp;${post.fileCnt}
								</c:if>
								<c:if test="${post.likeCnt > 0}">
								&nbsp;<i class="fas fa-paperclip"></i>&nbsp;${post.likeCnt}
								</c:if>
								</td>
	                            <td class='col text-center'>${post.name}</td>
	                            <td class='col text-center'>${fn:substring(post.post_date,0,10)}</td>
	                            <td class='col text-center'>${post.post_hit}</td>
	                        </tr>
	                     </c:forEach>
	                </c:when>
	                <c:otherwise>
	                    <tr>
	                        <td colspan='5' class='text-center'>게시물이 존재하지 않습니다.</td>
	                    </tr>
	                </c:otherwise>            
	            </c:choose>
			</tbody>
		</table>
	</div>
	
	<button type="button" id="writeBtn" class='rounded' onclick='addPost()'>글쓰기</button>
	
	<div id="pageList">
		${pagebar}
	</div>
</div>