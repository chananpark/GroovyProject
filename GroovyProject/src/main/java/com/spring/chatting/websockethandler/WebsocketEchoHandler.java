package com.spring.chatting.websockethandler;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.groovy.mail.service.InterMailService;
import com.spring.groovy.management.model.MemberVO;

//=== #198. (웹채팅관련8) === //

public class WebsocketEchoHandler extends TextWebSocketHandler {
	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterMailService service;
	
	// (<"no", 방ID>, <"session", 세션>) - (<"bang_id", 방ID>, <"session", 세션>) - (<"bang_id", 방ID>, <"session", 세션>) 형태 
	private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
		

	// init-method
	public void init() throws Exception { }
	
	
	// === 클라이언트가 웹소켓서버에 연결했을때의 작업 처리하기 ===
    /*
       afterConnectionEstablished(WebSocketSession wsession) 메소드는 
              클라이언트가 웹소켓서버에 연결이 되어지면 자동으로 실행되는 메소드로서
       WebSocket 연결이 열리고 사용이 준비될 때 호출되어지는(실행되어지는) 메소드이다.
    */
	@Override
	public void afterConnectionEstablished(WebSocketSession wsession) throws Exception {
		// >>> 파라미터  WebSocketSession wsession 은 웹소켓서버에 접속한 클라이언트 이다. <<< //

		System.out.println("wsession"+wsession);
	}
	
	
	
	// === 클라이언트가 웹소켓 서버로 메시지를 보냈을때의 Send 이벤트를 처리하기 ===
    /*
       handleTextMessage(WebSocketSession wsession, TextMessage message) 메소드는 
                 클라이언트가 웹소켓서버로 메시지를 전송했을 때 자동으로 호출되는(실행되는) 메소드이다.
                 첫번째 파라미터  WebSocketSession 은  메시지를 보낸 클라이언트임.
	          두번째 파라미터  TextMessage 은  메시지의 내용임.
     */
	@Override 
	public void handleTextMessage(WebSocketSession wsession, TextMessage message) throws Exception {
		
		


		Map<String, Object> map = wsession.getAttributes();
		MemberVO loginuser = (MemberVO) map.get("loginuser");
		// "loginuser" 은 HttpSession에 저장된 키 값으로 로그인 되어진 사용자이다.
		

		MessageVO messageVO = MessageVO.convertMessage(message.getPayload());
		

		Date now = new Date(); // 현재시각 
        String currentTime = String.format("%tp %tl:%tM",now,now,now); 
        
        // %tp              오전, 오후를 출력
        // %tl              시간을 1~12 으로 출력
		// %tM              분을 00~59 으로 출력
        
        messageVO.setSend_time(now);
        ////////////////////
        System.out.println("messageVO.getType()"+messageVO.getType());
        switch (messageVO.getType()) {
        	
        	case "enter":
        		// 세션 리스트에 저장
    			Map<String, Object> Smap = new HashMap<String, Object>();
    			System.out.println("messageVO.getNo()"+messageVO.getNo());
    			System.out.println("messageVO.getNo()"+messageVO.getMessage());
    			Smap.put("no", messageVO.getNo());
    			Smap.put("session", wsession);
    			sessionList.add(Smap);
    			
    			// 같은 채팅방에 입장 메세지 전송
    			for (int i = 0; i < sessionList.size(); i++) {
    				Map<String, Object> mapSessionList = sessionList.get(i);
    				String no = (String) mapSessionList.get("no");
    				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
    				
    				
    				if(no.equals(messageVO.getNo())) {
    					System.out.println("sess"+sess.getId());
    					sess.sendMessage(new TextMessage(messageVO.getMessage()));
    				}
    			}
    			break;
        	
        	case "send":	
        		// 같은 채팅방에 메세지 전송
    			for (int i = 0; i < sessionList.size(); i++) {
    				Map<String, Object> mapSessionList = sessionList.get(i);
    				String no = (String) mapSessionList.get("no");
    				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
    				int n = service.addMessage(messageVO);
					System.out.println("n"+n);

    				if (no.equals(messageVO.getNo()) && sess != wsession) { // 같은 방에만 전송 나는 제외
    					
    					
    					if(n == 1) {
    						sess.sendMessage(new TextMessage("&nbsp;[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>" +loginuser.getName()+ "</span>]<br><div style='background-color: white; display: inline-block; max-width: 60%; padding: 7px; border-radius: 15%; word-break: break-all;'>"+ messageVO.getMessage() +"</div> <div style='display: inline-block; padding: 20px 0 0 5px; font-size: 7pt;'>"+currentTime+"</div> <div>&nbsp;</div>"));  
                			
							
						} else { 
							sess.sendMessage(new TextMessage("&nbsp;[<span>업로드 실패</span>]")); 
						}
							 
    				
    					
    				}

    			}
    			break;
        
        }
        
        

	
	}
	
	
	
	// === 클라이언트가 웹소켓서버와의 연결을 끊을때 작업 처리하기 ===
	/*
       afterConnectionClosed(WebSocketSession session, CloseStatus status) 메소드는 
              클라이언트가 연결을 끊었을 때 
              즉, WebSocket 연결이 닫혔을 때(채팅페이지가 닫히거나 채팅페이지에서 다른 페이지로 이동되는 경우) 자동으로 호출되어지는(실행되어지는) 메소드이다. 
    */
		@Override
	    public void afterConnectionClosed(WebSocketSession wsession, CloseStatus status) throws Exception {
			
			Map<String, Object> map =  wsession.getAttributes();
			MemberVO loginuser = (MemberVO) map.get("loginuser");
					
			
			super.afterConnectionClosed(wsession, status);
	        
			ObjectMapper objectMapper = new ObjectMapper();
			String now_no = "";
			
			// 사용자 세션을 리스트에서 제거
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> Smap = sessionList.get(i);
				String no = (String) Smap.get("no");
				WebSocketSession sess = (WebSocketSession) Smap.get("session");
				
				if(wsession.equals(sess)) {
					now_no = no;
					sessionList.remove(Smap);
					System.out.println("sessionList"+sessionList);
					break;
				}	
			}
	

			
	
			
			
		}
	
	
}
