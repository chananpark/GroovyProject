<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="java.net.InetAddress" %>

<style type="text/css">
    html{overflow:hidden;}
</style>
   




<script src="http://code.jquery.com/jquery-latest.js"></script> 
<script type="text/javascript">
<%
String ctxPath = request.getContextPath();

// === #193. (웹채팅관련3) === //
// === 서버 IP 주소 알아오기(사용중인 IP주소가 유동IP 이라면 IP주소를 알아와야 한다.) ===
InetAddress inet = InetAddress.getLocalHost(); 
String serverIP = inet.getHostAddress();

// System.out.println("serverIP : " + serverIP);
// serverIP : 211.238.142.40

// String serverIP = "211.238.142.72"; 만약에 사용중인 IP주소가 고정IP 이라면 IP주소를 직접입력해주면 된다.

// === 서버 포트번호 알아오기   ===
int portnumber = request.getServerPort();
// System.out.println("portnumber : " + portnumber);
// portnumber : 9090

String serverName = "http://"+serverIP+":"+portnumber; 
 System.out.println("serverName : " + serverName);
// serverName : http://211.238.142.40:9090
%>


	$( document ).ready(function() {
		$("div#chatMessage").scrollTop(999999999);
		$("div#mycontent").css({"background-color":"#cce0ff"});
		// div#mycontent 는 /Board/src/main/webapp/WEB-INF/tiles/layout/layout-tiles1.jsp 파일의 내용에 들어있는 <div id="mycontent"> 이다. 
		
		const url = window.location.host; // 웹브라우저의 주소창의 포트까지 가져옴
	 	console.log("결과값 url : " + url);
	 // 결과값 url : 211.238.142.40:9090
	 
	    const pathname = window.location.pathname; // 최초 '/' 부터 오른쪽에 있는 모든 경로
	 // console.log("결과값 pathname : " + pathname);
	 // 결과값 pathname : /groovy/chat/chatroom.on
	
	    const appCtx = pathname.substring(0, pathname.lastIndexOf("/") ); 
	 // console.log("결과값 appCtx : " + appCtx);
	 // 결과값 appCtx : /groovy/chat
	 
	    const root = url + appCtx;
	 // console.log("결과값 root : " + root);
	 // 결과값 root : 211.238.142.40:9090/groovy/chat
		
		const wsUrl = "ws://" + root + "/multichatstart.on";
	 //	console.log(wsUrl);
		// 웹소켓통신을 하기 위해서는 http:// 을 사용하는 것이 아니라 ws:// 을 사용해야 한다.
		// const wsUrl = "ws://211.238.142.40:9090/board/chatting/multichatstart.action";
		
		
		
		// >> ====== !!중요!! Javascript WebSocket 이벤트 정리 ====== << //
	   	/*   -------------------------------------
	   	               이벤트 종류             설명
	   	     -------------------------------------
	            onopen        WebSocket 연결
	   	        onmessage     메시지 수신
	   	        onerror       전송 에러 발생
	   	        onclose       WebSocket 연결 해제
	    */
	    
	    var websocket = new WebSocket(wsUrl);
		
		let messageObj = {};  // 자바스크립트 객체 생성함.
		
		// === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수 정의하기 === //
	    websocket.onopen = function() {


		//  또는
		    messageObj = {message : "채팅방에 <span style='color: red;'>입장</span> 했습니다."
		                 ,type : "enter"
		                 ,to : "all"
		                 ,no : "${requestScope.no}"
		                 ,fk_member_no : "${sessionScope.loginuser.empno}"};
		

		    
		    websocket.send(JSON.stringify(messageObj));
		    // JSON.stringify(자바스크립트객체) 는 자바스크립트객체를 JSON 표기법의 문자열(string)로 변환해준다. 
		    // JSON.parse(JSON 표기법의 문자열) 는 JSON 표기법의 문자열(string)을 자바스크립트객체(object)로 변환해준다.  
		    
		};
		
		
		// === 메시지 수신시 콜백함수 정의하기 === //
		websocket.onmessage = function(event) {

	    	//  event.data 는 수신받은 채팅문자이다.
	    	$("div#chatMessage").append(event.data);
	    	$("div#chatMessage").append("<br/>");
	    	$("div#chatMessage").scrollTop(999999999);

		};
		
		
		// === 메시지 입력후 엔터하기 === //
		$("input#message").keyup(function(key){
			if(key.keyCode == 13) {
				$("input#btnSendMessage").click();
			}
		});
		
		
		// === 메시지 보내기 === //
		let isOnlyOneDialog = false; // 귀속말 여부.  true 이면 귀속말 , false 이면 모두에게 공개되는 말 
		
		$("input#btnSendMessage").click(function(){
			
			if( $("input#message").val().trim() != "" ) {
			
				// ==== 자바스크립트에서 replace를 replaceAll 처럼 사용하기 ====
	            // 자바스크립트에서 replaceAll 은 없다.
	            // 정규식을 이용하여 대상 문자열에서 모든 부분을 수정해 줄 수 있다.
	            // 수정할 부분의 앞뒤에 슬래시를 하고 뒤에 gi 를 붙이면 replaceAll 과 같은 결과를 볼 수 있다.
				let messageVal = $("input#message").val();
				messageVal.replace(/<script/gi, "&lt;script");
				// 스크립트 공격을 막으려고 한 것임.
				
				
				messageObj = {}; // 자바스크립트 객체 생성함
		        messageObj.message = messageVal;
		        messageObj.type = "send"; 
		        messageObj.to = "all"; 
		        messageObj.no = "${requestScope.no}"; 
		        messageObj.fk_member_no = "${sessionScope.loginuser.empno}";
		        
		        const to = $("input#to").val(); 
		        
		        websocket.send(JSON.stringify(messageObj));
			    // JSON.stringify(자바스크립트객체) 는 자바스크립트객체를 JSON 표기법의 문자열(string)로 변환해준다. 
			    // JSON.parse(JSON 표기법의 문자열) 는 JSON 표기법의 문자열(string)을 자바스크립트객체(object)로 변환해준다. 
				
			    // 위에서 자신이 보낸 메시지를 웹소켓으로 보낸 다음에 자신이 보낸 메시지 내용을 웹페이지에 보여지도록 한다.
		        const now = new Date();
	            let ampm = "오전 ";
	            let hours = now.getHours();
	               
	            if(hours > 12) {
	               hours = hours - 12;
	               ampm = "오후 ";
	            }
	               
	            if(hours == 0) {
	               hours = 12;
	            }
	               
	            if(hours == 12) {
	               ampm = "오후 ";
	            }
	               
	            let minutes = now.getMinutes();
	       		if(minutes < 10) {
	       		   minutes = "0"+minutes;
	       		}
	       		
	            const currentTime = ampm + hours + ":" + minutes;
	            
	            if(isOnlyOneDialog == false) { // 모두에게 공개하는 대화인 경우
	            	$("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>");
	            	                                                                                                                                                         /* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
	            }
	            else { // 귀속말인 경우(비밀대화인 경우)
	            	$("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all; color:red;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>"); 
	            	                                                                                                                                                         /* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
	            }
	            
	            $("div#chatMessage").scrollTop(999999999);
	            $("input#message").val("");
	            $("input#message").focus();
			}
			
		});
		
		/////////////////////////////////////////////////////////////////
		

		
	
	
		
	}); // end of $(document).ready(function(){})-----------------------

</script>


<div class="container-fluid" style="margin: -8px;background-color:ghostwhite; height: 100%">
	<div class="row" >
		<div class="col-md-10 offset-md-1" >
		   <div id="chatStatus"></div>
		   <div class="my-3" style="position:fixed; padding: 10px 15px; width: 80%;background-color: #fff;margin: 0 6%;z-index:999;">
			 공지사항 입니다
			</div>
			
			
			<input type="hidden" id="to" placeholder="귓속말대상웹소켓.getId()"/>
			
			<div id="chatMessage"style="max-height: 100%; width:100%; overFlow: auto; position:relative; bottom:40px;">
			<div style="height: 150px"></div>
			<c:forEach var="message" items="${requestScope.messageList}">
				<c:set var="send_time" value="${message.send_time}" />
				<fmt:formatDate value="${send_time}" pattern="a h:mm" var="sendTime"/>

				<c:if test="${message.fk_member_no eq sessionScope.loginuser.empno}">
					<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'> ${message.message}</div> 
					<div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>${sendTime}</div> <div style='clear: both;'>&nbsp;</div>
				</c:if>
				<c:if test="${message.fk_member_no != sessionScope.loginuser.empno}">
					&nbsp;[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>${message.name}</span>]<br>
					<div style='background-color: white; display: inline-block; max-width: 60%; padding: 7px; border-radius: 15%; word-break: break-all;'>${message.message}</div> 
					<div style='display: inline-block; padding: 20px 0 0 5px; font-size: 7pt;'>${sendTime}</div> <div>&nbsp;</div>
				</c:if>
			
			
			</c:forEach>

			
			
			
			</div>
			
			
			
		    
		    
			<div style="position:fixed; bottom:0; padding: 25px 5px; width:100%;background-color: #fff">
		        <input type="text"   id="message" class="form-control" placeholder="메시지 내용"/ style="width: 80%;">
		        <input type="button" id="btnSendMessage" class="btn btn-secondary btn-sm my-3" value="전송" />
		        
			</div>
		</div>
	</div>
</div>





    