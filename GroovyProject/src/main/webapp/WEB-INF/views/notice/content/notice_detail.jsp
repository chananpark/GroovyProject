<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>

<style>
	img#profile {
		border-radius: 50%;
		width: 35px;
	}
	
	button { border-style: none;	}
	
	textarea {
	    height: 30px;
	    overflow-y: hidden;
	    resize: none;
	}
	
	a{ color:black;	}
</style>

<script>

	$(document).ready(function(){
		
	});


	function editPost(){
		location.href="<%=ctxPath%>/notice/edit.on?seq=${noticevo.seq}";
	}
	
	function replyPost(){
		// console.log("${noticevo.groupno}, ${noticevo.fk_seq}, ${noticevo.depthno}");
		location.href="<%=ctxPath%>/notice/write.on?seq=${noticevo.seq}&groupno=${noticevo.groupno}&fk_seq=${noticevo.seq}&depthno=${noticevo.depthno}&subject=${noticevo.subject}";
	}
	
	function deletePost(){
		
		$.ajax({
			url:"<%=ctxPath%>/notice/deletePost.on",
			data : {"seq":"${noticevo.seq}"},
			dataType : "json",
			method: "post",
			success : function(json) {
				swal(json.msg)
				.then(function (result) {
					location.href="<%=ctxPath%>/notice/list.on";
			      });
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: "
						+ request.responseText + "\n" + "error: " + error);
			}
		});
		
	}

</script>




<div class='container'>
	<div class='my-4'>
		<h4>공지사항</h4>
	</div>
	
	<c:choose>
		<c:when test="${not empty noticevo}">
			<div class="text-left" style="margin-top: 80px;">
		      <div style="font-weight: bold; font-size: 20px;">${noticevo.subject}</div><br>
	
		      	<div>
					<c:if test="${empty noticevo.empimg}">
						<div class="header_profile_css" id="header_profile_bg" style="display: inline-block;">
						${fn:substring(noticevo.name,0,1)}
						</div>
					</c:if>
					<c:if test="${not empty noticevo.empimg}">
				      	<img id='profile' class='mr-2' src='<%=ctxPath%>/resources/images/profile/${noticevo.empimg}' width='100'/>
					</c:if>
						<span style="font-weight:bold; margin-bottom: 10px;">
				      	${noticevo.name}</span>
			      <span style="font-size: 15.5px; margin-bottom: 10px;"><i class="far fa-eye mx-2"></i>${noticevo.readCount}</span>
			      <span style="font-size: 15.5px; margin-bottom: 10px;"><i class="far fa-clock mx-2"></i>${noticevo.regDate}</span>
		    	</div>
		    </div>
	
	    <hr style="border-top: solid 1.2px black">
			
		<%-- 글수정, 삭제 버튼은 작성자만 보임 --%>		
		<div class="text-right" style="margin-top: 30px;">
			<c:if test="${loginuser.empno == noticevo.fk_empno }">
			   <button type="button" class="rounded" id="deleteBtn"  style="margin-left: 5px;" onclick="deletePost()">삭제</button>
			   <button type="button" class="rounded" id="updateBtn" style="margin-right: 0" onclick="editPost()">수정</button>
		   </c:if>
		   <button type="button" class="rounded" id="replyBtn" style="margin-right: 0" onclick="replyPost()">답글작성</button>
		</div>
		
		
		<!-- 글 내용 -->
		<div>
			<p>${noticevo.content}</p>
				
			<!-- 첨부파일 -->		
			<c:if test="${not empty fileList}"> 
			<p style='margin-top: 30px;' class='text-small text-right'>
				<span>첨부파일: </span>
				<c:forEach items="${fileList}" var="file" varStatus="sts">
					<a href="<%= ctxPath%>/notice/fileDownload.on?notice_file_seq=${file.notice_file_seq}">${file.originalfilename}</a>
					<c:if test="${sts.count != fn:length(fileList) }">,</c:if>
				</c:forEach>
			</p>
			</c:if>
								
			<div style='margin-top: 30px;'>
			  	<div style="display: inline-block; float:right"> 
				  <button type="button" id="showList" class="btn-secondary listView rounded" onclick="location.href='${noticeBackUrl}'">목록보기</button>
			    </div>
			</div>
		</div>
	
	    <hr style="border-top: solid 1.2px black">
	    	<div><i style='vertical-align: bottom;' class="fas fa-sort-up"></i>&nbsp;다음글&nbsp;&nbsp;
	    		<c:if test="${not empty noticevo.next_seq}">
		    		<a href="<%= ctxPath%>/notice/detail.on?seq=${noticevo.next_seq}">
		    		${noticevo.next_subject}
		    		</a>
	    		</c:if>
	    		<c:if test="${empty noticevo.next_seq}">
	    			마지막 글입니다.
	    		</c:if>
	    	</div>
	    	<div><i style='vertical-align: top;' class="fas fa-sort-down"></i>&nbsp;이전글&nbsp;&nbsp;
	    		<c:if test="${not empty noticevo.prev_seq}">
		    		<a href="<%= ctxPath%>/notice/detail.on?seq=${noticevo.prev_seq}">
		    		${noticevo.prev_subject}
		    		</a>
		    	</c:if>
	    		<c:if test="${empty noticevo.prev_seq}">
	    			첫 글입니다.
	    		</c:if>
	    	</div>
	    <hr style="border-top: solid 1.2px black">
	    
		</c:when>
		<c:otherwise>
			존재하지 않는 글입니다.
		</c:otherwise>
	</c:choose>
	
</div>