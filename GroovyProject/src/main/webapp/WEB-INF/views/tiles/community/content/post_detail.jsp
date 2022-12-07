<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String ctxPath = request.getContextPath(); %>
<style>
img#profile {
	border-radius: 50%;
	width: 35px;
}

button {
	border-style: none;
}

textarea {
    height: 30px;
    overflow-y: hidden;
    resize: none;
}
</style>

<script>
function resize(obj) {
    obj.style.height = '1px';
    obj.style.height = (12 + obj.scrollHeight) + 'px';
}
</script>
<div class='container'>
	<div class='my-4'>
		<h4>커뮤니티</h4>
	</div>
	
	<div class="text-left" style="margin-top: 80px;">
	      <div style="font-weight: bold; font-size: 20px;">글제목</div><br>

	      	<div>
		      <span style="font-weight:bold; margin-bottom: 10px;">
		      	<img id='profile' class='mr-2' src='<%=ctxPath%>/resources/images/profile/ham.jpg' width='100'/>
		      	나선임 선임</span>
		      <span style="font-size: 15.5px; margin-bottom: 10px;"><i class="far fa-eye mx-2"></i>10</span>
		      <span style="font-size: 15.5px; margin-bottom: 10px;"><i class="far fa-comment mx-2"></i>3</span>
		      <span style="font-size: 15.5px; margin-bottom: 10px;"><i class="far fa-clock mx-2"></i>2022-12-02 11:05</span>
	    	</div>
	    </div>
	
    <hr style="border-top: solid 1.2px black">
	    
	<%-- 글수정, 삭제 버튼은 작성자만 보임 --%>
	<div class="text-right" style="margin-top: 30px;">
	   <button type="button" class="rounded" id="deleteBtn"  style="margin-left: 5px;">삭제</button>
	   <button type="button" class="rounded" id="updateBtn" style="margin-right: 0">수정</button>
	</div>
	
	<div>
		글내용
		
		<div style='margin-top: 30px;'>
			<i class="far fa-heart fa-lg mr-2"></i>좋아요 12명
		  	<div style="display: inline-block; float:right"> 
			  <button type="button" id="showList" class="btn-secondary listView rounded">목록보기</button>
		    </div>
		</div>
	</div>
	
	<p style='margin-top: 30px;'>
		<span>첨부파일: </span><a href="<%= ctxPath%>/cs/fileDownload.tea?noticeNo=${nvo.noticeNo}">파일이름</a>
	</p>

    <hr style="border-top: solid 1.2px black">
    	<div>이전글&nbsp;<i style='vertical-align: bottom;' class="fas fa-sort-up"></i>&nbsp;
    		<span>이전글입니다</span>
    	</div>
    	<div>다음글&nbsp;<i style='vertical-align: top;' class="fas fa-sort-down"></i>&nbsp;
    		<span>다음글입니다</span>
    	</div>
    <hr style="border-top: solid 1.2px black">
    
	<div style="font-weight: bold; font-size: 20px; margin-top: 30px">댓글</div><br>
	
	<!-- 댓글 작성폼 -->
	<form>
		<img id='profile' src='<%=ctxPath%>/resources/images/profile/ham.jpg' width='100'/>
		<textarea placeholder="댓글을 입력하세요" style="width: 85%; vertical-align: middle;" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
		<i class="fas fa-upload btn"></i>
		<button type="button" id="addReplyBtn" class="btn-secondary listView rounded">등록</button>
	</form>
	
	<!-- 댓글 표시 영역 -->
	<div style="margin-top: 30px">
		<div class="my-2">
			<img id='profile' src='<%=ctxPath%>/resources/images/profile/marumaru.jpg' width='100'/> 한성준 과장
			<span style="color:gray" class='ml-2'>2022-12-02 12:05</span>
			<i class="fas fa-reply fa-rotate-180 mx-2"></i>댓글 작성
			<p>댓글내용</p>
		</div>
		<div class="my-2">
			<img id='profile' src='<%=ctxPath%>/resources/images/profile/ham.jpg' width='100'/> 나선임 선임
			<span style="color:gray" class='ml-2'>2022-12-02 13:05</span>
			<i class="fas fa-reply fa-rotate-180 mx-2"></i>댓글 작성
			<p>댓글내용</p>
		</div>
		<div class="my-2" style="margin-left: 40px">
			<img id='profile' src='<%=ctxPath%>/resources/images/profile/marumaru.jpg' width='100'/> 한성준 과장
			<span style="color:gray" class='ml-2'>2022-12-02 13:25</span>
			<i class="fas fa-reply fa-rotate-180 mx-2"></i>댓글 작성
			<p>대댓글 내용</p>
		</div>
	</div>
</div>
