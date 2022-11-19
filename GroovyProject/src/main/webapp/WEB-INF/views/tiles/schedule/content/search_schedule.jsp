<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
	
	/* 상세 검색 숨기기 */
	.hide{display:none;}
	
	/* 검색 */
	input[type=text], select, textarea {
	  width: 100%; /* Full width */
	  padding: 9px; /* Some padding */ 
	  border: 1px solid #ccc; /* Gray border */
	  border-radius: 4px; /* Rounded borders */
	  box-sizing: border-box; /* Make sure that padding and width stays in place */
	  margin-top: 5px; /* Add a top margin */
	  resize: vertical; /* Allow the user to vertically resize the textarea (not horizontally) */
	  vertical-align: middle;
	}
	

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 클릭하면 나타나기
		// menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $("#search_btn").click(function(){
            var submenu = $(this).parent().parent().find("#detail_search");
 
            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
		
		
		// 검색 열 클릭
		$("tbody > tr").click(function(e){
			
			const $target = $(e.target); // <td> 태그 이다. 왜냐하면 tr 속에 td가 있기 때문에
		//	console.log("확인용 : "+ $target.html());
			
			// 클릭한 tr의 userid 알아오기
		//	const userid = $target.parent().find("td[name='userid']").text(); 
		//	console.log("확인용 : "+ userid);
			 
			location.href = "<%= ctxPath %>/schedule/viewSchedule.on"; 
		}); // end of $("tbody > tr").click(function()
		
		
		
		
		
	}); // end of ready





</script>

<div>

	<div style='margin: 1% 0 5% 1%; display: flex;'>
		<h4 class="mt-2">일정 검색</h4>
		<button id="search_btn" class="bg-white text-end ml-3" style="border: none; color:#ccc;"><i class="fas fa-search fa-1x"></i></button> 
	</div>
	
	<div class="hide" id="detail_search" style="width:90%; margin:0 0 100px 5%;">
	
		<table style="width:100%;">
			<tr style="vertical-align: middle;">
				<th><label class="mr-5" for="select_search" style="font-weight: bold; font-size: 12pt;">검색분류</label></th>
				<td>
					<select name="select_search">
						<option>일정명 및 일정내용</option>
						<option>일정명</option>
						<option>일정내용</option>
						<option>공유자</option>
					</select>
				</td>
			</tr>
			<tr style="vertical-align: middle;">
				<th><label class="mr-5" for="search_woard" style="font-weight: bold; font-size: 12pt;">검색어</label></th>
				<td>
					<input type="text" id="search_woard" name="search_woard" placeholder="검색어를 입력하세요." style="width: 90%;">
					<button class="btn bg-light mt-1" style="width: 9%; height: 44px;" onclick="search_schedule();">검색</button>
				</td>
			</tr>
			<tr style="vertical-align: middle;">
				<th><label class="mr-5" for="search_woard" style="font-weight: bold; font-size: 12pt;">검색기간</label></th>
				<td>
					<input type="text" id="fromDate" name="startdate" style="width:48.1%;" readonly="readonly">&nbsp;&nbsp; 
		            	-&nbsp;&nbsp; <input type="text" id="toDate" name="enddate" style="width:48.1%;" readonly="readonly">
				</td>
			</tr>
		</table>
		
	</div>
	
	<div class="mb-1" style="float:right;">
		<i class="fas fa-download"></i>&nbsp;목록 다운로드
	</div>
	
	
	<table class="table" style="margin: 0px 20px 50px 0;">
		
		<thead style="width:100%;">
			<tr class="text-center">
				<th class="col-3">일자</th>
				<th class="col-2">일정 분류</th>
				<th class="col-2">작성자</th>
				<th class="col-2">일정명</th>
				<th class="col-3">일정내용</th>
			</tr>
		</thead>	
		<tbody>
			<tr>
				<td class="text-center">2022.11.14 15:00 ~ 2022.11.14 17:00</td>
				<td class="text-center">개인 일정 : 기타</td>
				<td class="text-center">손여진</td>
				<td class="text-center">HTML이랑 싸우기</td>
				<td>나중에 java 하면서 페이지바 처리하세요</td>
			</tr>
			<tr>
				<td class="text-center">2022.11.14 15:00 ~ 2022.11.14 17:00</td>
				<td class="text-center">개인 일정 : 기타</td>
				<td class="text-center">손여진</td>
				<td class="text-center">HTML이랑 싸우기</td>
				<td>룰루</td>
			</tr>
			<tr>
				<td class="text-center">2022.11.14 15:00 ~ 2022.11.14 17:00</td>
				<td class="text-center">개인 일정 : 기타</td>
				<td class="text-center">손여진</td>
				<td class="text-center">HTML이랑 싸우기</td>
				<td>룰루</td>
			</tr>
			<tr>
				<td class="text-center">2022.11.14 15:00 ~ 2022.11.14 17:00</td>
				<td class="text-center">개인 일정 : 기타</td>
				<td class="text-center">손여진</td>
				<td class="text-center">HTML이랑 싸우기</td>
				<td>룰루</td>
			</tr>
		</tbody>
	</table>

</div>


