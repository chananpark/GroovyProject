<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

a{
	color:black;
}
</style>

<script>
$(()=>{
	
	// 댓글 읽어오기
	getComment();
	
	// 글 삭제 클릭 시 확인창
	$("#deleteBtn").click(()=>{
		swal({
			  title: "이 게시글을 삭제하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
			    // 삭제 함수 호출
				deletePost();
				
			  } else {
			    swal("삭제가 취소되었습니다.");
			  }
			});
	});

})

// 댓글입력창 리사이징
function resize(obj) {
    obj.style.height = '1px';
    obj.style.height = (12 + obj.scrollHeight) + 'px';
}

// 댓글 읽어오기
function getComment() {
	$.ajax({
		url:"<%=ctxPath%>/community/getComment.on",
		data : {"post_no":"${post.post_no}"},
		dataType : "json",
		success : function(cmtArr) {
			
			let cmt = "";
			cmtArr.forEach(el=>{
				cmt += "<div class='my-2' style='margin-left:" + el.depth * 30 + "px'>"
					+ "<img id='profile' src='<%=ctxPath%>/resources/images/profile/" + el.empimg + "' width='100'/>&nbsp;" 
					+ el.name
					+ "<span style='color:gray' class='ml-2'>" + el.comment_date + "</span>"
					+ "<button type='button' style='background-color:transparent' onclick='addReComment("+el.comment_no+ "," + el.group_no+")'>";
				if(el.depth == 0) {
					cmt += "<i class='fas fa-reply fa-rotate-180 mx-2'></i>답댓글 작성</button>";
				}
				if (el.fk_empno == "${loginuser.empno}") {
					cmt += "<button type='button' id='editComment"+el.comment_no+"' class='text-right mx-2 commentControl' onclick='editComment("+el.comment_no+")'>수정</button>"
					+ "<button type='button' style='display:none' id='cancelEdit"+el.comment_no+"' class='text-right mx-2 commentControl' onclick='cancelEdit("+el.comment_no+")'>취소</button>"
					+ "<button type='button' id='delComment"+el.comment_no+"' class='text-right mx-2 commentControl' onclick='delComment("+el.comment_no+")'>삭제</button>";

				}
				cmt += "<div id='comment"+el.comment_no+"' style='padding-left:50px'><p>" + el.comment_content + "</p></div></div>";
				
			});
			
			$("#cmtArea").html(cmt);
			
		},
		error : function(request, status, error) {
			alert("code: " + request.status + "\n" + "message: "
					+ request.responseText + "\n" + "error: " + error);
		}
	});
}

// 댓글 수정
const editComment = comment_no => {
	
	// p태그 감추기
	$("div#comment"+comment_no).find('p').hide();
	
	// textarea 추가
	$("div#comment"+comment_no).append('<textarea id="comment_textarea'+comment_no+'" name="comment_content" placeholder="댓글을 입력하세요" style="width: 85%; vertical-align: middle;" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>')
	
	console.log($("div#comment"+comment_no).find('p').text())
	// textarea에 내용 추가
	$("#comment_textarea"+comment_no).val($("div#comment"+comment_no).find('p').text());
	
	// 등록버튼 추가
	$("div#comment"+comment_no).append("<button type='button' id='editSubmit"+comment_no+"' class='text-right mx-2 commentControl'>등록</button>")
	
	// 수정버튼을 감추기
	$("#editComment"+comment_no).hide();
	
	// 취소버튼을 보이기
	$("#cancelEdit"+comment_no).show();

	// 등록버튼 이벤트바인딩
	$("#editSubmit"+comment_no).click((e)=>{
		const target = $(e.target);
		editSubmit(target);
	});
}

// 댓글 수정 취소
const cancelEdit = comment_no => {
	
	// textarea 삭제
	$("#comment_textarea"+comment_no).remove();
	
	// p태그 보이기
	$("div#comment"+comment_no).find('p').show();
	
	// 등록버튼 삭제
	$("#editSubmit"+comment_no).remove();
	
	// 수정버튼을 보이기
	$("#editComment"+comment_no).show();
	
	// 취소버튼을 감추기
	$("#cancelEdit"+comment_no).hide();
	
}

// 댓글 수정 컨트롤러 호출
const editSubmit = (target) => {
	const comment_content = target.parent().children('textarea').val();
	const comment_no = target.attr('id').substring(10);
	
	$.ajax({
		url:"<%=ctxPath%>/community/editComment.on",
		data : {"comment_no":comment_no, "comment_content":comment_content},
		dataType : "json",
		method: "post",
		success : function(json) {
			if (json.result == true) {
				getComment(); // 댓글 읽어오기
			} else {
				swal("댓글 수정 실패");
			}
		},
		error : function(request, status, error) {
			alert("code: " + request.status + "\n" + "message: "
					+ request.responseText + "\n" + "error: " + error);
		}
	});

}

// 답댓글 작성
const addReComment = (comment_no, group_no) => {
	
	// 답댓글 입력폼 추가
	let html = "<form id='reCommentFrm" + comment_no + "'>"
			+ "<img id='profile' src='<%=ctxPath%>/resources/images/profile/${loginuser.empimg}' width='100'/>"
			+ "<input type='hidden' name='fk_post_no' value='${post.post_no}'/>"
			+ "<input type='hidden' name='group_no' value='"+group_no+"'/>"
			+ "<input type='hidden' name='parent_comment_no' value='" + comment_no + "'/>"
			+ "<textarea name='comment_content' placeholder='댓글을 입력하세요' style='width: 85%; vertical-align: middle;' onkeydown='resize(this)' onkeyup='resize(this)'></textarea>"
			/* + "<i class='fas fa-upload btn'></i>" */
			+ "<button type='button' id='addReComment"+comment_no+"' class='btn-secondary listView rounded'>등록</button>"
			+ "</form>";
			
	$("div#comment"+comment_no).append(html);
	
	// 등록버튼 이벤트바인딩
	$("#addReComment"+comment_no).click(()=>{
		reCommentSubmit(comment_no);
	});
		
}

// 답댓글 작성 컨트롤러 호출
const reCommentSubmit = comment_no => {
	var queryString = $("#reCommentFrm"+comment_no).serialize();
	
	$.ajax({
		url:"<%=ctxPath%>/community/addReComment.on",
		data : queryString,
		dataType : "json",
		method: "post",
		success : function(json) {
			if (json.result == true) {
				getComment(); // 댓글 읽어오기
			} else {
				swal("답댓글 작성 실패");
			}
		},
		error : function(request, status, error) {
			alert("code: " + request.status + "\n" + "message: "
					+ request.responseText + "\n" + "error: " + error);
		}
	});

}

// 댓글 삭제
const delComment = comment_no => {
	
	swal({
		  title: "이 댓글을 삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
				$.ajax({
					url:"<%=ctxPath%>/community/delComment.on",
					data : {"comment_no":comment_no},
					dataType : "json",
					method: "post",
					success : function(json) {
						if (json.result == true) {
							getComment(); // 댓글 읽어오기
						} else {
							swal("댓글 삭제 실패");
						}
					},
					error : function(request, status, error) {
						alert("code: " + request.status + "\n" + "message: "
								+ request.responseText + "\n" + "error: " + error);
					}
				});
			
		  } else {
		    swal("삭제가 취소되었습니다.");
		  }
		});

	
}

// 글 삭제
const deletePost = () => {

	$.ajax({
		url:"<%=ctxPath%>/community/deletePost.on",
		data : {"post_no":"${post.post_no}"},
		dataType : "json",
		method: "post",
		success : function(json) {
			swal(json.msg)
			.then(function (result) {
				location.href="<%=ctxPath%>/community/list.on";
		      });
		},
		error : function(request, status, error) {
			alert("code: " + request.status + "\n" + "message: "
					+ request.responseText + "\n" + "error: " + error);
		}
	});

}

// 글 수정
const editPost = () => {

	location.href="<%=ctxPath%>/community/editPost.on?post_no=${post.post_no}";
}

// 댓글 작성
const addComment = () => {
	
	//const frm = document.commentFrm;
	var queryString = $("form[name=commentFrm]").serialize();
	
	$.ajax({
		url:"<%=ctxPath%>/community/addComment.on",
		data : queryString,
		dataType : "json",
		method: "post",
		success : function(json) {
			if (json.result == true) {
				$("textarea[name='comment_content']").val(""); // 댓글 입력창 비우기
				getComment(); // 댓글 읽어오기
			} else {
				swal("댓글 작성 실패");
			}
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
		<h4>커뮤니티</h4>
	</div>
	
	<c:choose>
		<c:when test="${not empty post}">
			<div class="text-left" style="margin-top: 80px;">
		      <div style="font-weight: bold; font-size: 20px;">${post.post_subject}</div><br>
	
		      	<div>
					<c:if test="${empty post.empimg}">
						<div class="header_profile_css" id="header_profile_bg" style="display: inline-block;">
						${fn:substring(post.name,0,1)}
						</div>
					</c:if>
					<c:if test="${not empty post.empimg}">
				      	<img id='profile' class='mr-2' src='<%=ctxPath%>/resources/images/profile/${post.empimg}' width='100'/>
					</c:if>
						<span style="font-weight:bold; margin-bottom: 10px;">
				      	${post.name}</span>
			      <span style="font-size: 15.5px; margin-bottom: 10px;"><i class="far fa-eye mx-2"></i>${post.post_hit}</span>
			      <span style="font-size: 15.5px; margin-bottom: 10px;"><i class="far fa-comment mx-2"></i>${post.commentCnt}</span>
			      <span style="font-size: 15.5px; margin-bottom: 10px;"><i class="far fa-clock mx-2"></i>${post.post_date}</span>
		    	</div>
		    </div>
	
	    <hr style="border-top: solid 1.2px black">
			
		<%-- 글수정, 삭제 버튼은 작성자만 보임 --%>
		<c:if test="${loginuser.empno == post.fk_empno }">
			<div class="text-right" style="margin-top: 30px;">
			   <button type="button" class="rounded" id="deleteBtn"  style="margin-left: 5px;">삭제</button>
			   <button type="button" class="rounded" id="updateBtn" style="margin-right: 0" onclick="editPost()">수정</button>
			</div>
		</c:if>
		
		<!-- 글 내용 -->
		<div>
			<p>${post.post_content}</p>
				
			<!-- 첨부파일 -->		
			<c:if test="${not empty postFileList}"> 
			<p style='margin-top: 30px;' class='text-small text-right'>
				<span>첨부파일: </span>
				<c:forEach items="${postFileList}" var="file" varStatus="sts">
					<a href="<%= ctxPath%>/community/download.on?post_file_no=${file.post_file_no}">${file.originalFilename}</a>
					<c:if test="${sts.count != fn:length(postFileList) }">,</c:if>
				</c:forEach>
			</p>
			</c:if>
								
			<div style='margin-top: 30px;'>
				<i class="far fa-heart fa-lg mr-2"></i>좋아요 ${post.likeCnt}명
			  	<div style="display: inline-block; float:right"> 
				  <button type="button" id="showList" class="btn-secondary listView rounded" onclick="location.href='${communityBackUrl}'">목록보기</button>
			    </div>
			</div>
		</div>
	
	    <hr style="border-top: solid 1.2px black">
	    	<div><i style='vertical-align: bottom;' class="fas fa-sort-up"></i>&nbsp;다음글&nbsp;&nbsp;
	    		<c:if test="${not empty post.next_no}">
		    		<a href="<%= ctxPath%>/community/detail.on?post_no=${post.next_no}">
		    		${post.next_subject}
		    		</a>
	    		</c:if>
	    		<c:if test="${empty post.next_no}">
	    			마지막 글입니다.
	    		</c:if>
	    	</div>
	    	<div><i style='vertical-align: top;' class="fas fa-sort-down"></i>&nbsp;이전글&nbsp;&nbsp;
	    		<c:if test="${not empty post.pre_no}">
		    		<a href="<%= ctxPath%>/community/detail.on?post_no=${post.pre_no}">
		    		${post.pre_subject}
		    		</a>
		    	</c:if>
	    		<c:if test="${empty post.pre_no}">
	    			첫 글입니다.
	    		</c:if>
	    	</div>
	    <hr style="border-top: solid 1.2px black">
	    
		<div style="font-weight: bold; font-size: 20px; margin-top: 30px">댓글</div><br>
		
		<!-- 댓글 작성폼 -->
		<form name="commentFrm">
			<input type="hidden" name="fk_post_no" value="${post.post_no}"/>
			<img id='profile' src='<%=ctxPath%>/resources/images/profile/${loginuser.empimg}' width='100'/>
			<textarea name="comment_content" placeholder="댓글을 입력하세요" style="width: 85%; vertical-align: middle;" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
			<!-- 파일첨부버튼 --><!-- <i class="fas fa-upload btn"></i> -->
			<button type="button" id="addReplyBtn" class="btn-secondary listView rounded" onclick="addComment()">등록</button>
		</form>
		
		<!-- 댓글 표시 영역 -->
		<div style="margin-top: 30px" id="cmtArea">
		</div>
	
		</c:when>
		<c:otherwise>
			존재하지 않는 글입니다.
		</c:otherwise>
	</c:choose>
	
</div>
