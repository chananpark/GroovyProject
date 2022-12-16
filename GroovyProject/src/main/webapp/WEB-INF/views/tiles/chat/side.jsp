<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<style>
#writeBtn:hover{
	border: 1px solid #086BDE;
	color: white;
	background-color: #086BDE;
}
.ui-autocomplete {

  z-index:10000 !important;

}

.email-ids{
    padding: 1px 5px;
    margin: 1px 5px;
    background-color: #E3F2FD;
}
.non-email-ids{
	padding: 1px 5px;
    margin: 1px 5px;
    background-color: lightcoral;
}
</style>

<script type="text/javascript">
var recipient_addressList = [];
var recipient_addressList_original = [];

//이메일 자동완성
var emailList = ${requestScope.mailList};
	$(document).ready(function(){
		
		
		$("button#writeBtn").click(function(){
			$("button#addChatroom").show();
			$("button#changeChatroom").hide();
			recipient_addressList.push('${sessionScope.loginuser.cpemail}');
			$("#receiver").html(`<span class="rounded-pill email-ids" name="email-container">
					${sessionScope.loginuser.department}&nbsp${sessionScope.loginuser.position}&nbsp${sessionScope.loginuser.name } &lt; ${sessionScope.loginuser.cpemail } &gt; 									
					<br></span>`);
			
		});
		
		
		

		
		$("#addUser").autocomplete({
			source : emailList,
			select: function(event, ui){
				console.log("ui.item"+event);
			},
			focus: function(event, ui){ return false;} // 사라짐 방지용 
		});
		
		// 받는사람 입력후 스페이스바나 엔터 누르면 한 단위로 묶기
		$("#addUser").keydown(function(e){
			if(e.keyCode == 13 || e.keyCode == 32){
				var getValue = $(this).val();
				console.log("getValue: "+getValue);
				var inList = false;
				for(let i = 0; i < emailList.length; i++) {
	    	 		if(emailList[i] == getValue )  {
	    	 			// 가져온 리스트 안의값이라면 
	    	 			inList = true;
	    	 			break;
	    	 		  }
	    	 	}

				var emailStartIdx = getValue.indexOf("<")+2;
				var emailEndIdx = getValue.indexOf(">")-1;
				var emailOnly = getValue.substring(emailStartIdx, emailEndIdx);
				// 이미 가져온 값인지 비교
				for(let i = 0; i < recipient_addressList.length; i++) {
	    	 		if(recipient_addressList[i] == emailOnly )  {
	    	 			swal('중복된 사원입니다', "다른 사원을 선택해주세요.", 'warning')
	    	 			$("input#receieveName").val('');
	    	 			return false;
	    	 		  }
	    	 	}
				
				if(inList == true){
			
					$("#receiver").append('<span class="rounded-pill email-ids" name="email-container">'
							+ getValue + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span><br></span>');
					recipient_addressList.push(emailOnly);
				}
				else{
					$("#receiver").append('<span class="rounded-pill non-email-ids" name="email-container">'
							+ getValue + '<span class = "removeAddress" name="removeAddress"><i class="far fa-window-close"></i></span><br></span>');
					
					
				}
				$("#addUser").val("");
			}
		});
		// 버튼 수정
		$("button#add").click(function(){
			$("#addChatroom").show();
			$("#changeChatroom").hide();
		});
		// 주소 삭제버튼 클릭
		$(document).on('click','[name=removeAddress]', function(){
			$(this).parent().remove();

			var emailStartIdx = $(this).parent().text().indexOf("<")+2;
			var emailEndIdx = $(this).parent().text().indexOf(">")-1;
			var delete_address = $(this).parent().text().substring(emailStartIdx, emailEndIdx);
			
			for(let i = 0; i < recipient_addressList.length; i++) {
    	 		if(recipient_addressList[i] == delete_address )  {
    	 			recipient_addressList.splice(i, 1);
    	 		    i--;
    	 		  }
    	 	}
			console.log(recipient_addressList);
			
		});
		
		$('#modal_addChatroom').on('hidden.bs.modal', function () {
			recipient_addressList.length=0;
			recipient_addressList_original.length=0; // 나중에 빼줄거임
			$("#subject").val('');
			$("#addUser").val('');
			$("#receiver").empty();
			
		});
		
		
		
	});
	
	
	
	function goAddChatroom(){
		var frm = document.modal_frm;
		
		// 글제목 유효성 검사
		const subject = $("input#subject").val().trim();
		if(subject == "" || subject == null) {
			swal('개설 실패!', '채팅방 제목을 입력하세요.', 'warning')
		
			return;
		} 
		
		if(recipient_addressList.length == 1) {
			swal('개설 실패!', '채팅방 멤버를 추가해주세요', 'warning')
		
			return;
		} 
		var recipient_address = "";
		for(let i = 0; i < recipient_addressList.length; i++) {
	 		
			recipient_address += recipient_addressList[i]+",";
	 		  
	 	}
		recipient_address = recipient_address.slice(0, -1);
		
		frm.recipient_address.value = recipient_address;
		
		frm.method="post";
		frm.action="<%= ctxPath%>/chat/goAddChatroom.on";
		frm.submit();
	};
	
	
	
	
	
	function change(roomNo){ // 기존 인원명단 불러와 보여주기
		// 이벤트가 부모에게 전파되는 것을 막습니다.
	    event.stopPropagation();

		
	    if('${requestScope.chatroomList}' != null){
		    <c:forEach items="${requestScope.chatroomList}" varStatus="status" var="room" 	>
			if('${room.chatroom_no}'==roomNo){
				$("input#subject").val('${room.chatroom_name}');
				recipient_addressList.length=0;
				$.ajax({
					url:"<%= ctxPath%>/chat/getMember.on",
					data:{"roomNo":roomNo},
					type:"get",
					dataType:"json",
			        success:function(json){
			        	console.log(json[0]);
			        	memberArr =json[0];
			        	
			        	$("#receiver").empty();
			        	for(let idx =0  ;idx< memberArr.length;idx++){
			        		var getValue = memberArr[idx];
			        		getValue = getValue.substr(1, getValue.length);
			        		getValue = getValue.substr(-0, getValue.length-1);
			        		getValue = getValue.trim();
			        		console.log(getValue);

							/*
							for(let i = 0; i < emailList.length; i++) {
								console.log(emailList[i].trim());
				    	 		if(emailList[i].trim() == getValue )  {
				    	 			// 가져온 리스트 안의값이라면 
				    	 			inList = true;

				    	 		  }
				    	 	}
							*/
							var emailStartIdx = getValue.indexOf("<")+2;
							var emailEndIdx = getValue.indexOf(">")-1;
							var emailOnly = getValue.substring(emailStartIdx, emailEndIdx);

							$("#receiver").append('<span class="rounded-pill email-ids" name="email-container">'
									+ getValue + '<br></span>');
							recipient_addressList.push(emailOnly);
							recipient_addressList_original.push(emailOnly); // 나중에 빼줄거임
			        	}

						$("#addUser").val("");
						$("#roomNo").val(roomNo);
						$("#addChatroom").hide();
						$("#changeChatroom").show();
						
						$('#modal_addChatroom').modal('show'); // 모달창 보여주기
			        },
			        error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				
			}
			
			</c:forEach>
	    }
	    
	   
		
		
	};
	
	 function goChangeChatroom(){
		var frm = document.modal_frm;
		
		// 글제목 유효성 검사
		const subject = $("input#subject").val().trim();
		if(subject == "" || subject == null) {
			swal('변경 실패!', '채팅방 제목을 입력하세요.', 'warning')
		
			return;
		} 
		
		if(recipient_addressList.length == 1) {
			swal('변경 실패!', '채팅방 멤버를 추가해주세요', 'warning')
		
			return;
		} 
		var recipient_address = "";

		for(let i = recipient_addressList_original.length; i < recipient_addressList.length; i++) {
	 		
			recipient_address += recipient_addressList[i]+",";
	 		  
	 	}

		recipient_address = recipient_address.slice(0, -1);
		
		frm.recipient_address.value = recipient_address;
		
		frm.method="post";
		frm.action="<%= ctxPath%>/chat/goChangeChatroom.on";
		frm.submit();
	};
	
	
	function exit(room_no){
		// 이벤트가 부모에게 전파되는 것을 막습니다.
	     event.stopPropagation();
		alert("!!");
 
		$.ajax({
			url:"<%= ctxPath%>/chat/exit.on",
			data:{"room_no":room_no},
			type:"post",
	        success:function(n){
	        	if(n==1){
	        		
	        	}
	        	if(n==1) {
	    			swal(roomNo+'방에서 나갔습니다.', '다시 들어가려면 기존 멤버에게 초대를 요청하세요!', 'warning')
	    			location.reload();
	    			return;
	    		} 
	    		
	    		if(n!=0) {
	    			swal('나가기 실패!','' , 'warning')
	    		
	    			return;
	    		} 
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	};


</script>

<!-- A vertical navbar -->
<nav class="navbar bg-light">

  <!-- Links -->
  <ul class="navbar-nav" style="width: 100%">
    <li class="nav-item">
      <h4 class='mb-4'>채팅</h4>
    </li>
    <li class="nav-item mb-4">
      <button id="writeBtn" type="button" style='width:100%' class="btn btn-outline-dark" data-toggle="modal" data-target="#modal_addChatroom"> 채팅방 <br>개설하기 </button>
    </li>


    
  </ul>

</nav>


<div class="modal fade" id="modal_addChatroom" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">채팅방 개설하기</h4>
        		<button id="add" type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-borderless">
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">채팅방 이름</td>
     						<td><input type="text" name="subject" id="subject"/></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">참가자추가</td>
     						
     						<td>
     							<span id="receiver">
     								
     							</span><input id="addUser" type="text" /></td>
     					</tr>
     					<input type="hidden" name="recipient_address"/>
     					<input type="hidden" name="no" id="roomNo"/>
     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
      			
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      			<button type="button" style="background-color:#086BDE; color:white;" id="addChatroom" class="btn btn-sm" onclick="goAddChatroom()">추가</button>
				<button type="button" style="background-color:#086BDE; color:white;" id="changeChatroom" class="btn btn-sm" onclick="goChangeChatroom()">변경</button>
      		</div>
      
    	</div>
  	</div>
</div>





