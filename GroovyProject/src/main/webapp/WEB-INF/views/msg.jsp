<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- sweet alert --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
window.onload = function(){
	
	swal("${requestScope.message}") // 메시지 출력해주기 
	.then((value) => {
		location.href = "${requestScope.loc}"; // 페이지 이동
		opener.location.reload(true); // 부모창 새로 고침
		self.close(); // 팝업창 닫기
	});
   
}
   
</script> 