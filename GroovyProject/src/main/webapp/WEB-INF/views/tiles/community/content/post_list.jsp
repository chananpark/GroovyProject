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

const addPost = () =>{
	location.href='<%=ctxPath%>/community/write.on';
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
						<option value="">제목+내용</option>
						<option value="">제목</option>
						<option value="">내용</option>
						<option value="">작성자</option>
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
					<c:if test="${not empty draftList}">
					<button type="button" id="excelButton" onclick="excelDownLoad()"><i class="fas fa-download"></i>&nbsp;목록 다운로드</button>
					</c:if>
				</div>
				<div class='col text-right'>
					<select id="pageSize" name="pageSize" onchange="goSearch()">
						<option value="10">10</option>
						<option value="30">30</option>
						<option value="50">50</option>
					</select> 
					<select id="sortType" name="sortType" onchange="goSearch()">
						<option value="">작성일</option>
					</select>
					<select id="sortOrder" name="sortOrder" onchange="goSearch()">
						<option value="desc">최신순</option>
						<option value="asc">오래된순</option>
					</select>
				</div>
			</div>
		</form>
		
		<table class="table" id="teamDraftTable">
			<thead>
				<tr class='row'>
					<th class='col text-center'>번호</th>
					<th class='col col-6 text-center'>제목</th>
					<th class='col text-center'>작성자</th>
					<th class='col text-center'>작성일자</th>
					<th class='col text-center'>조회수</th>
				</tr>
			</thead>
			<tbody>
				<%-- <c:choose>
	                <c:when test="${not empty draftList}">
	                    <c:forEach items="" var="" > --%>
	                        <tr class='row'>
								<td class='col text-center'>1</td>
								<td class='col col-6'><a href='<%=ctxPath%>/community/detail.on'>제목</a></td>
	                            <td class='col text-center'>작성자</td>
	                            <td class='col text-center'>작성일자</td>
	                            <td class='col text-center'>조회수</td>
	                        </tr>
	            <%--         </c:forEach>
	                </c:when>
	                <c:otherwise>
	                    <tr>
	                        <td colspan='5' class='text-center'>게시물이 존재하지 않습니다.</td>
	                    </tr>
	                </c:otherwise>            
	            </c:choose> --%>
			</tbody>
		</table>
	</div>
	
	<button type="button" id="writeBtn" class='rounded' onclick='addPost()'>글쓰기</button>
	
	<div id="pageList">
		${pagebar}
	</div>
</div>