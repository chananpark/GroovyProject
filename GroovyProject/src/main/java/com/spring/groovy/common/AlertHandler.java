package com.spring.groovy.common;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.groovy.management.model.MemberVO;

public class AlertHandler extends TextWebSocketHandler {
	// 개별 유저
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	// init-method
	public void init() throws Exception { }
	
	// 웹소켓 연결이 수립된 직후 호출되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = getCurrentEmpno(session);
		if(senderId!=null) {
			log(senderId + " 연결됨");
			userSessionsMap.put(senderId,session); // <사번,세션>형태로 저장
		}
	}
	
	// 웹소켓 연결 후, 클라이언트가 메시지를 전송했을 때 호출되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload(); // 뷰의 send 함수를 통해 넘어온 값

		if(msg != null) {
			String[] strs = msg.split(",");
			log(String.valueOf(strs));
			
			if(strs != null && strs.length == 4) {
				
				String type = strs[0]; // 알림 종류
				String target = strs[1]; // 알림 받는사람
				String content = strs[2]; // 알림 내용
				String url = strs[3]; // 이동 url
				
				WebSocketSession targetSession = userSessionsMap.get(target);  // 메시지를 받을 세션 조회
				
				// 실시간 접속되어 있을 시
				if(targetSession!=null) {
					String now = getCurrentTime();
					TextMessage tmpMsg = new TextMessage("<div>[<b>" + type + "</b>] </div> <a target='_blank' href='"+ url +"'>" + content + "</a> <span class='text-secondary'> " + now + " </span>" );
					targetSession.sendMessage(tmpMsg);
				}
			}
		}
	}
	
	// 웹소켓 연결이 끊어진 직후 호출되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		String senderId = getCurrentEmpno(session);
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			log(senderId + " 연결 종료됨");
			userSessionsMap.remove(session);
		}
	}
	
	// 에러 발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());

	}

	// 로그 메시지
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}
	
	// 연결된 유저의 사원번호를 리턴
	private String getCurrentEmpno(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		MemberVO loginuser = (MemberVO)httpSession.get("loginuser");
		
		if(loginuser != null) {
			String mid = loginuser.getEmpno();
			return mid;
		}
		else return null;
	}
	
	private String getCurrentTime() {
		// 현재 날짜/시간
        Date now = new Date();
 
        // 포맷팅 정의
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
 
        // 포맷팅 적용
        String formatedNow = formatter.format(now);
        
        return formatedNow;
	}
}