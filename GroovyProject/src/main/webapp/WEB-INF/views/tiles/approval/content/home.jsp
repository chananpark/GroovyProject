<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.listContainer {
	font-size: small;
	margin-bottom: 5%;
}

.approveThis {
	text-align: center;
}

.activeBtn {
	color: white;
	background-color: #086BDE;
	cursor: pointer;
}

.card-deck {
	font-size: small;
}

.floating { 
    animation-name: floating;
    animation-duration: 1s;
    animation-iteration-count: infinite;
    animation-timing-function: ease-in-out;
    cursor: pointer;
}
 
@keyframes floating {
	0% {
		box-shadow: 0 3px 10px 0px #e6e6e6;
		transform: translateY(0);
	}
	50% {
		box-shadow: 0 3px 10px 0px #e6e6e6;
		transform: translateY(-15px);
	}
	100% {
		box-shadow: 0 3px 10px 0px #e6e6e6;
		transform: translateY(0);
	}
}
</style>	

<script>

$(()=>{
	// 사이드바 메뉴 글씨색 변경
	$('a#home').css('color','#086BDE');
	
	// 결재대기문서 카드에 hover시 카드 띄우는 효과
	$('div.card').hover(function() {
        $(this).addClass('floating');
        $(this).find('.approveThis').addClass('activeBtn');
    }, function() {
        $(this).removeClass('floating');
        $(this).find('.approveThis').removeClass('activeBtn');
    });
	
	// 결재대기문서 클릭시
	$('div.card').click(function() {
		// 해당 문서 결재하기 화면으로	
	});
});
</script>
	
<div style='margin: 1% 0 5% 1%'>
	<h4>전자결재</h4>
</div>

<div class='m-4'>

	<div class='listContainer'>
		<h5 class='mb-3'>결재 대기 문서</h5>
		<h6 class='mb-3'>결재해야 할 문서가 <span style='color:#086BDE'>7</span>건 있습니다.</h6>
		
		<div class='card-deck'>
			<div class="card p-0 mr-3">
			  <div class="card-body">
			  	<h5 class="title m-0">지출결의서&nbsp;&nbsp;<span style='font-size:x-small;' class="badge badge-pill badge-danger">긴급</span></h5><br>
			  	문서번호: <span class='docNo'>221109-01</span><br>
			  	기안자: <span class='writer'>김동식</span><br>
			  	기안일: <span class='inDate'>2022.11.09</span><br>
			  	종류: <span class='inDate'>지출결의</span>
			  </div>
			  <div class="card-footer approveThis">결재하기</div>
			</div>
			<div class="card p-0 mr-3">
			  <div class="card-body">
			  	<h5 class="title">지출결의서</h5><br>
			  	문서번호: <span class='docNo'>221109-01</span><br>
			  	기안자: <span class='writer'>김동식</span><br>
			  	기안일: <span class='inDate'>2022.11.09</span><br>
			  	종류: <span class='inDate'>지출결의</span>
			  </div>
			  <div class="card-footer approveThis">결재하기</div>
			</div>
			<div class="card p-0 mr-3">
			  <div class="card-body">
			  	<h5 class="title">지출결의서</h5><br>
			  	문서번호: <span class='docNo'>221109-01</span><br>
			  	기안자: <span class='writer'>김동식</span><br>
			  	기안일: <span class='inDate'>2022.11.09</span><br>
			  	종류: <span class='inDate'>지출결의</span>
			  </div>
			  <div class="card-footer approveThis">결재하기</div>
			</div>
			<div class="card p-0 mr-3">
			  <div class="card-body">
			  	<h5 class="title">지출결의서</h5><br>
			  	문서번호: <span class='docNo'>221109-01</span><br>
			  	기안자: <span class='writer'>김동식</span><br>
			  	기안일: <span class='inDate'>2022.11.09</span><br>
			  	종류: <span class='inDate'>지출결의</span>
			  </div>
			  <div class="card-footer approveThis">결재하기</div>
			</div>
		</div>
		<div class='text-right mr-2 mt-4'>
			<i class="fas fa-angle-double-right"></i> 더보기
		</div>
	</div>
	<div class='listContainer'>
		<h5 class='mb-3'>기안 진행 문서</h5>
		<h6 class='mb-3'>진행 중인 문서가 <span style='color:#086BDE'>4</span>건 있습니다.</h6>
		<table class="table">
			<thead>
				<tr class='row'>
					<th class='col col-1'>기안일</th>
					<th class='col col-1'>종류</th>
					<th class='col col-2'>문서번호</th>
					<th class='col'>제목</th>
					<th class='col col-1'>현재 결재자</th>
					<th class='col col-1'>최종 결재자</th>
				</tr>
			</thead>
			<tbody>
				<tr class='row'>
					<td class='col col-1'>2022.11.09</td>
					<td class='col col-1'>지출결의</td>
					<td class='col col-2'>20221109-04</td>
					<td class='col'>시내교통비</td>
					<td class='col col-1'>이순신</td>
					<td class='col col-1'>엄정화</td>
				</tr>
			</tbody>
		</table>
		<div class='text-right mr-2'>
			<i class="fas fa-angle-double-right"></i> 더보기
		</div>
	</div>
	<div class='listContainer'>
		<h5 class='mb-3'>결재 완료 문서</h5>

		<table class="table">
			<thead>
				<tr class='row'>
					<th class='col col-1'>결재완료일</th>
					<th class='col col-1'>종류</th>
					<th class='col col-2'>문서번호</th>
					<th class='col'>제목</th>
					<th class='col col-1'>기안일</th>
					<th class='col col-1'>결재상태</th>
				</tr>
			</thead>
			<tbody>
				<tr class='row'>
					<td class='col col-1'>2022.11.10</td>
					<td class='col col-1'>지출결의</td>
					<td class='col col-2'>20221109-04</td>
					<td class='col'>시내교통비</td>
					<td class='col col-1'>2022.11.09</td>
					<td class='col col-1'><span class="badge badge-secondary">완료</span></td>
				</tr>
			</tbody>
		</table>
		<div class='text-right mr-2'>
			<i class="fas fa-angle-double-right"></i> 더보기
		</div>
	</div>
  
</div>