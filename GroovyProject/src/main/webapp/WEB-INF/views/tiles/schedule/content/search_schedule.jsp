<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	
	.search_title {
		font-weight: bold; 
		font-size: 12pt;
	}

	#search_list_table tbody > tr:hover {
		cursor: pointer;
	}
	
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 검색할 때 필요한 datepicker
		// 모든 datepicker에 대한 공통 옵션 설정
	    $.datepicker.setDefaults({
	         dateFormat: 'yy-mm-dd'  // Input Display Format 변경
	        ,showOtherMonths: true   // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
	        ,showMonthAfterYear:true // 년도 먼저 나오고, 뒤에 월 표시
	        ,changeYear: true        // 콤보박스에서 년 선택 가능
	        ,changeMonth: true       // 콤보박스에서 월 선택 가능                
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트             
	    });
		
	    // input 을 datepicker로 선언
	    $("input#fromDate").datepicker();                    
	    $("input#toDate").datepicker();
	    	    
	    // From의 초기값을 한달전 날짜로 설정
	    $('input#fromDate').datepicker('setDate', '-1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	    
	    // To의 초기값을 오늘 날짜로 설정
		 $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
		
		
		
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
		$("#search_list_table tbody > tr").click(function(e){
			
			const $target = $(e.target); // <td> 태그 이다. 왜냐하면 tr 속에 td가 있기 때문에
		//	console.log($target.parent());
		//	console.log("확인용 : "+ $target.parent().find("td[name='scheduleno']").text());
			
			// 클릭한 tr의 userid 알아오기
		//	const userid = $target.parent().find("td[name='userid']").text(); 
		//	console.log("확인용 : "+ userid);
		//	var scheduleno = $target;
			
			var scheduleno = $target.parent().find("td[name='scheduleno']").text();
		//	location.href = "<%= ctxPath %>/schedule/viewSchedule.on?scheduleno="+scheduleno; 
			
			goViewFrm(scheduleno);
		
		}); // end of $("tbody > tr").click(function()
		
		
		// 검색 할 때 엔터를 친 경우
		$("input#searchWord").keyup(function(event){
			if(event.keyCode == 13){ 
				goSearch();
			}
		});
	
		
		if(${not empty requestScope.paraMap}){
			$("input[name=empno]").val("${requestScope.paraMap.empno}");
			$("input[name=cpemail]").val("${requestScope.paraMap.cpemail}");
			$("input[name=startdate]").val("${requestScope.paraMap.startdate}");
			$("input[name=enddate]").val("${requestScope.paraMap.enddate}");
			$("select#searchType").val("${requestScope.paraMap.pagination.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.pagination.searchWord}");
			$("select#fk_lgcatgono").val("${requestScope.paraMap.fk_lgcatgono}");
		}
		
		
		// 검색분류가 참석자일 경우 일정분류에서 전사일정 제외하기
		$("select#searchType").change(function(){
			if($("select#searchType").val() == "joinuser") {
				$("select#fk_lgcatgono option[value='1']").remove();
			} else {
				$("select#fk_lgcatgono option[value='1']").remove();
				$("select#fk_lgcatgono").append('<option value="1">전사 일정</option>');
			}
		});  // end of $("select#searchType").change(function()
		
		// 일정분류가 전사일정일 경우 검색분류에서 참석자 제외하기
		$("select#fk_lgcatgono").change(function(){
			if($("select#fk_lgcatgono").val() == "1") {
				$("select#searchType option[value='joinuser']").remove();
			} else {
				$("select#searchType option[value='joinuser']").remove();
				$("select#searchType").append('<option value="joinuser">참석자</option>');
			}
		}); // end of $("select#fk_lgcatgono").change(function()
		
		
		
	}); // end of ready


	// 일정 검색하는 메소드
	function goSearch( ){
		
		if( $("#fromDate").val() > $("#toDate").val() ) {
			swal("검색 종료 날짜를 검색 시작 날짜 이후로 설정해주세요.");
			return;
		}
	    
	   	var frm = document.searchScheduleFrm;
	    frm.method="get";
	    frm.action="<%= ctxPath%>/schedule/searchSchedule.on";
	    frm.submit();
		
	} // end of function goSearch


	// 엑셀 파일 다운로드 메소드
	function scheDownload() {
		
		var frm = document.searchScheduleFrm;
	   	frm.method = "POST";
	   	frm.action = "<%= ctxPath %>/schedule/scheDownload.on";
	   	frm.submit();
		
		
	} // end of function scheDownload() 
	
	
	// 일정 상세보기 메소드
	function goViewFrm(scheduleno){
		var frm = document.goViewFrm;
		frm.scheduleno.value = scheduleno;
		
		frm.method="get";
		frm.action="<%= ctxPath%>/schedule/viewSchedule.on";
		frm.submit();
	} // end of function goDetail(scheduleno){}-------------------------- 

</script>

<div>

	<div style='margin: 1% 0 5% 1%; display: flex;'>
		<h4>일정 검색</h4>
		<button id="search_btn" class="bg-white text-end ml-3" style="border: none; color:#ccc;"><i class="fas fa-search fa-1x"></i></button> 
	</div>
	
	<div class="hide" id="detail_search" style="width:90%; margin:0 0 100px 5%;">
	
		<form name="searchScheduleFrm">
			<table style="width:100%;">
				<tr style="vertical-align: middle;">
					<th><label class="mr-5 search_title" for="searchType" >검색분류</label></th>
					<td>
						<select id="searchType" name="searchType" >
							<option value="">전체 검색</option>
							<option value="subject">일정명</option>
							<option value="content">일정내용</option>
							<option value="joinuser">참석자</option>
						</select>
					</td>
				</tr>
				<tr style="vertical-align: middle;">
					<th><label class="mr-5 search_title" for="fk_lgcatgono">일정분류</label></th>
					<td>
						<select id="fk_lgcatgono" name="fk_lgcatgono">
							<option value="">모든 일정</option>
							<option value="1">전사 일정</option>
							<option value="2">팀별 일정</option>
							<option value="3">개인 일정</option>
						</select>
					</td>
				</tr>
				<tr style="vertical-align: middle;">
					<th><label class="mr-5 search_title" for="searchWord">검색어</label></th>
					<td>
						<input type="text" id="searchWord" name="searchWord" placeholder="검색어를 입력하세요." style="width: 90%;">
						<button class="btn bg-light mt-1" style="width: 9%; height: 44px;" onclick="goSearch();">검색</button>
					</td>
				</tr>
				<tr style="vertical-align: middle;">
					<th>
						<label class="mr-5 search_title" for="fromDate">검색기간</label>
					</th>
					<td>
						<input type="text" id="fromDate" name="startdate" style="width:48.1%;" readonly="readonly">
						&nbsp;&nbsp;-&nbsp;&nbsp;  
			            <input type="text" id="toDate" name="enddate" style="width:48.1%;" readonly="readonly">
					</td>
				</tr>
			</table>
			<input type="hidden" id="empno" name="empno" value="${sessionScope.loginuser.empno}">
			<input type="hidden" id="cpemail" name="cpemail" value="${sessionScope.loginuser.cpemail}">
		</form>
		
	</div>

	
	<button class="mb-1 btn bg-white" style="float:right;" onclick="scheDownload();">
		<i class="fas fa-download"></i>&nbsp;목록 다운로드
	</button>
	
	
	<table id="search_list_table" class="table" style="margin: 0px 20px 50px 0;">
		
		<thead style="width:100%;">
			<tr class="text-center">
				<th class="col-4">일자</th>
				<th class="col-2">일정 분류</th>
				<th class="col-1">작성자</th>
				<th class="col-2">일정명</th>
				<th class="col-3">일정내용</th>
			</tr>
		</thead>	
		<tbody>
			<c:if test="${empty requestScope.scheduleList}">
				<tr>
					<td colspan="5" style="text-align: center;">검색 결과가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty requestScope.scheduleList}">
				<c:forEach var="map" items="${requestScope.scheduleList}">
					<tr class="infoSchedule">
						<td name="scheduleno" style="display: none;" class="scheduleno text-center" >${map.SCHEDULENO}</td>
						<td class="text-center">
							${map.STARTDATE} ~ ${map.ENDDATE}
						</td>
						<td class="text-center">
						
							<c:if test="${map.FK_LGCATGONO eq '1'}">전사일정</c:if>
							<c:if test="${map.FK_LGCATGONO eq '2'}">팀별일정</c:if>
							<c:if test="${map.FK_LGCATGONO eq '3'}">개인일정</c:if>
							 : ${map.SMCATGONAME}
						 </td>
						<td class="text-center">${map.NAME}</td>  <%-- 캘린더 작성자명 --%>
						<td class="text-center">${map.SUBJECT}</td>
						<td class="text-center">${map.CONTENT}</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	${pagebar}

</div>
<form name="goViewFrm">
	<input type="hidden" name="scheduleno"/>
	<input type="hidden" name="listgobackURL_schedule" value="${requestScope.listgobackURL_schedule}"/> <%-- 뒤로가기 url 기억 --%>
</form>	

