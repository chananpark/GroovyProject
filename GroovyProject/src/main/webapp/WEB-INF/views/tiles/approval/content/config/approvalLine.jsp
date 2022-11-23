<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>	
<style>
.accordion {
	background-color: white;
	color: #444;
	cursor: pointer;
	padding: 18px;
	width: 100%;
	border: none;
	border-bottom: 1px solid #bfbfbf;
	text-align: left;
	outline: none;
	font-size: 15px;
	transition: 0.4s;
}

.active, .accordion:hover {
	background-color: #F9F9F9;
}

.panel {
	padding: 0 18px;
	display: none;
	background-color: white;
	overflow: hidden;
}

#editBtn {
	background-color: #E3F2FD;
}

#editBtn:hover {
	background-color: #cfe9fc;
}

#saveBtn {
	background-color: #086BDE;
	color: white;
}

#approvalLineContainer {
	font-size: small;
}

.table {
	width: 50%;
}

</style>
<script>
$(()=>{
	$('a#approvalLine').css('color','#086BDE');
	$('.configMenu').show();
	
	var acc = document.getElementsByClassName("accordion");
	var i;

	for (i = 0; i < acc.length; i++) {
	  acc[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    if (panel.style.display === "block") {
	      panel.style.display = "none";
	    } else {
	      panel.style.display = "block";
	    }
	  });
	}
	
	// 수정버튼 클릭시
	$('#editBtn').click(()=>{
		
	});
	
	// 삭제버튼 클릭시
	$('#deleteBtn').click(()=>{
		swal({
			  title: "이 결재라인을 삭제하시겠습니까?",
			  /* text: "Once deleted, you will not be able to recover this imaginary file!", */
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
			    swal("결재라인이 삭제되었습니다.", {
			      icon: "success",
			    });
			  } else {
			    swal("삭제가 취소되었습니다.");
			  }
			});
	});
	
});
</script>

<div style='margin: 1% 0 5% 1%'>
	<h4>환경설정</h4>
</div>

<h5 class='m-4'>결재라인</h5>

<div id='approvalLineContainer' class='m-4'>

	<div class="btn-group my-4">
	  <button type="button" class="btn btn-light" onclick="location.href='<%=ctxPath%>/approval/config/approvalLine.on'">저장된 결재라인</button>
	  <button type="button" class="btn btn-light" onclick="location.href='<%=ctxPath%>/approval/config/approvalLine/add.on'">결재라인 추가</button>
	</div>
	
	<button class="accordion"><i class="fas fa-chevron-down mr-2"></i>기본결재라인</button>
	<div class='panel'>
		<div class='approvalLine mb-4'>
			<div class='my-4'>
				<button type="button" class="btn btn-sm" id='editBtn'>수정</button>
				<button type="button" class="btn btn-sm btn-light" id='deleteBtn'>삭제</button>
				<span class='ml-2'>결재라인 수정 후 반드시 저장버튼을 클릭해주세요.</span>
				<button type="button" class="btn btn-sm" id='saveBtn'>저장</button>
			</div>

		</div>
		<table class="table">
		    <thead>
		      <tr>
		        <th>순서</th>
		        <th>소속</th>
		        <th>직급</th>
		        <th>성명</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		        <td>1</td>
		        <td>개발팀</td>
		        <td>책임</td>
		        <td>김개발</td>
		      </tr>
		      <tr>
		        <td>2</td>
		        <td>개발팀</td>
		        <td>팀장</td>
		        <td>윤팀장</td>
		      </tr>
		      <tr>
		        <td>3</td>
		        <td>이사실</td>
		        <td>CEO</td>
		        <td>찰스 데이비드 황</td>
		      </tr>
		    </tbody>
		  </table>
		</div>
</div>
