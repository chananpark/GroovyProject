<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<style>

.table {
	font-size: small;
}

.table th {
	background-color: #E3F2FD;
	vertical-align: middle;
	text-align: center;
}

.draftInfo,
.approvalLineInfo {
	display: inline-block;
}

.draftInfo {
	float: left;
}

.approvalLineInfo {
	float: right;
}

.approvalLineInfo table td, .approvalLineInfo table th{
	text-align: center;
}

.approvalLineInfo  tr:nth-child(3) > td {
	height: 100px;
	width: 100px;
	border-bottom-style: none;
}

.approvalLineInfo  tr:nth-child(4) > td {
	border-top-style: none;
}

#attachContainer p{
	padding: 1%;
	margin: 0;
	font-size: small;
	text-align: left;
}

#draftTable th{
	width: 20%;
}

#fileInfo {
	background-color: #E3F2FD;
}

#fileName {
	
}

.commentTable {
	width: 100%;
	margin: 0 auto;
}

.commentTable td {
	text-align: left;
}

.commentTable td#date {
	text-align: right;
	width: 200px;
}

.commentTable td#profile {
	width: 150px;
}

.card-header {
	background-color: #E3F2FD;
}

a {
	color: black;
}
</style>

<div class="container">
	<!-- 내가 작성한 기안이고 아직 결재가 시작되지 않았을 때만 보임 -->	
	<button type='button' class='btn btn-lg'><i class="far fa-window-close"></i> 상신 취소</button>
	<span style='color: gray; font-size: small'>상신 취소 시 임시저장함에 저장됩니다.</span>
	<!-- 상신취소버튼 끝 -->
		
	<div class="card">
		<div class="card-header py-3" align="center">
			<h3>
				<strong>지 출 결 의 서</strong>
			</h3>
			
		</div>
		<div class="card-body text-center p-4">
			<!-- 문서정보 -->
			<div class='draftInfo' style='width: 35%'>
				<h5 class='text-left my-4'>문서정보</h5>
				<table class='table table-bordered text-left'>
					<tr>
						<th>기안자</th>
						<td>구루비</td>
					</tr>
					<tr>
						<th>소속</th>
						<td>신사업개발팀</td>
					</tr>
					<tr>
						<th>기안일</th>
						<td>2022-11-15(수)</td>
					</tr>
					<tr>
						<th>문서번호</th>
						<td>20221115-01</td>
					</tr>
				</table>
			</div>
			
			<!-- 결재라인 -->
			<div class='approvalLineInfo' style='width: 40%'>
				<h5 class='text-left my-4'>결재라인</h5>
				<table class='mr-4 table table-sm table-bordered text-left'>
					<tr>
						<th rowspan='5' style='font-size: medium; vertical-align: middle;'>결<br>재<br>선</th>
					</tr>
					<tr>
						<td>책임</td>
						<td>팀장</td>
						<td>부문장</td>
					</tr>
					<tr>
						<td><img src='<%=ctxPath%>/resources/images/signature_pororo.png' width="100"/></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>김개발</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>2022/11/15</td>
						<td></td>
						<td></td>						
					</tr>
				</table>
			</div>
			<!-- 결재라인 끝 -->
			
			<div style="clear:both; padding-top: 8px; margin-bottom: 30px;">
			</div>
			
			<!-- 문서내용 -->
			<!-- 제목 및 지출사유 -->
			<table class='table table-sm table-bordered text-left' id='draftTable'>
				<tr>
					<th>제목</th>
					<td>법인카드 지출결의서</td>
				</tr>
				<tr>
					<th>지출사유</th>
					<td>쓸 일이 있어서 썼습니다</td>
				</tr>
			</table>
			<!-- 제목 및 지출사유 끝 -->
			
			<!-- 지출내역 표 -->
			<table class='table table-sm table-bordered mt-4' id='expenseListTable'>
				<thead>
					<tr>
						<th><span> 일자 </span></th>
						<th><span> 분류 </span></th>
						<th><span> 사용 내역 </span></th>
						<th><span> 금액 </span></th>
						<th><span> 비고 </span></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>2022/11/17</td>
						<td>식비</td>
						<td>갈비탕</td>
						<td><span>30,000</span></td>
						<td>맛있었다.</td>
					</tr>
					<tr>
						<th colspan="3">합계</th>
						<td colspan='2'>30,000</td>
					</tr>
				</tbody>
			</table>
			<!-- 지출내역 표 끝 -->
			<!-- 문서내용 끝 -->
			
			<!-- 첨부파일 -->
			<table class='mt-4 mr-4 table table-sm table-bordered text-left'>
				<tr>
					<th class='p-2 text-left'><i class="fas fa-paperclip"></i> 첨부파일 1개 (12.1Byte)</th>
				</tr>
				<tr>
					<td class='p-2'><a href=#>견적서.xls</a></td>
				</tr>
			</table>
			<!-- 첨부파일 끝 -->
			
			<div style="clear:both; padding-top: 8px; margin-bottom: 30px;">
			</div>
			
			<!-- 기안의견 -->
			<h5 class='text-left my-4'>기안의견</h5>
			<div class='card'>
				<div class='card-body'>
					<table class='commentTable'>
						<tr>
							<td id='profile' rowspan='2'><img style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/groovy_profile.jpg' width="100" /></td>
							<td><h6>구루비 선임</h6></td>
							<td id='date'><span style='color: #b3b3b3'>2022/11/15 10:21</span></td>
						</tr>
						<tr>
							<td>긍정적 검토 바랍니다.</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 기안의견 끝 -->

			<!-- 결재의견 -->
			<h5 class='text-left my-4'>결재의견</h5>
			<div class='card'>
				<div class='card-body'>
					<table class='commentTable'>
						<tr>
							<td id='profile' rowspan='2'><img style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/groovy_profile2.jpg' width="100" /></td>
							<td><h6>김개발 책임</h6></td>
							<td id='date'><span style='color: #b3b3b3'>2022/11/15 14:30</span></td>
						</tr>
						<tr>
							<td>굿굿 결재합니다</td>
						</tr>
					</table>
					<table class='commentTable mt-4' id='myComment'>
						<tr>
							<td id='profile' rowspan='2'><img style='border-radius: 50%; display: inline-block' src='<%=ctxPath%>/resources/images/default_profile.png' width="100" /></td>
							<td rowspan='2'><input type='text' id='approvalComment' name='approvalComment' placeholder='결재의견을 입력해주세요(선택)' style='width: 70%'/></td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 결재의견 끝 -->
			
			<!-- 결재버튼 -->
			<!-- 내가 결재 순서일 때만 보임 -->
			<div class='mt-4 text-left' >
				<button type='button' class='btn btn-lg'><i class="fas fa-pen-nib"></i> 승인</button>
				<button type='button' class='btn btn-lg'><i class="fas fa-undo"></i> 반려</button>
				<!-- 대결 버튼은 내가 승인 후, 다음 사람이 결재하기 전에만 보임 -->
				<button type='button' class='btn btn-lg'><i class="fas fa-arrow-right"></i> 대결</button>
			</div>
		</div>
	</div>
</div>
