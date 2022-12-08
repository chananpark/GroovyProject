<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- sweet alert --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<<<<<<< HEAD
<script type="text/javascript">

   alert("${requestScope.message}");  // 메시지 출력해주기 
   location.href = "${requestScope.loc}"; // 페이지 이동
=======
<script type="text/javascript">
window.onload = function(){
	
	swal("${requestScope.message}") // 메시지 출력해주기 
	.then((value) => {
		location.href = "${requestScope.loc}"; // 페이지 이동
		opener.location.reload(true); // 부모창 새로 고침
		self.close(); // 팝업창 닫기
	});
>>>>>>> branch 'main' of https://github.com/Chanan-Park/GroovyProject.git
   
<<<<<<< HEAD
   opener.location.reload(true); // 부모창 새로 고침
// opener.history.go(0);         // 부모창 새로 고침
   /*	
		location.href="javascript:history.go(-2);";  // 이전이전 페이지로 이동 
	 	location.href="javascript:history.go(-1);";  // 이전 페이지로 이동
	 	location.href="javascript:history.go(0);";   // 현재 페이지로 이동(==새로고침) 캐시에서 읽어옴.
	 	location.href="javascript:history.go(1);";   // 다음 페이지로 이동.
	 	
	 	location.href="javascript:history.back();";       // 이전 페이지로 이동 
	 	location.href="javascript:location.reload(true)"; // 현재 페이지로 이동(==새로고침) 서버에 가서 다시 읽어옴. 
	 	location.href="javascript:history.forward();";    // 다음 페이지로 이동.
	*/
   self.close(); // 팝업창 닫기
   
=======
}
   
>>>>>>> branch 'main' of https://github.com/Chanan-Park/GroovyProject.git
</script>    