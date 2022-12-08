<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style type="text/css">
.btn_submenu>a{
	color:black;
}
.btn_submenu{
    display: inline-block;
    position: relative;
    vertical-align: middle;
}
.tool_bar .optional {
    float: right;
    margin: 5px 24px 0 0;
    position: inherit;
}

#mailToolbar{
    padding: 0;

}

.toolflag{
	color:inherit !important;
}

.table#empInfo td, .table#empInfo th ,.table#empInfo2 td, .table#empInfo2 th{
    padding: 0.75rem;
    vertical-align: top;
    border-top: none;
}





</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#afClick").hide();
		

		$(document).on('click','#mailLAllCheck_btn', function(){
			if($("#mailLAllCheck").is(":checked")){
				$("input:checkbox[id='mailLAllCheck']").prop("checked", false);
	        }else{
	        	$("input:checkbox[id='mailLAllCheck']").prop("checked", true);
	        }
		});
		
		
		// 검색 엔터
		$("input#searchWord").keyup(function(e){
			if(e.keyCode == 13) {
				// 검색어에 엔터를 했을 경우
				goSearch();
			}
		});
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if( ${not empty requestScope.paraMap} ) {
			$("select#searchType").val("${requestScope.paraMap.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.searchWord}");
		}

		
	});
	
	function goSearch() {
		const frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/organization.on";
		frm.submit();
	}// end of function goSearch()--------------------
	
	
	function ViewInfo(empno){
		$("#afClick").show();
		$("#bfClick").hide();
		<c:forEach var="emp" items="${requestScope.empList}" varStatus="status">

			if('${emp.empno}'==empno){
				$("#selectName").val("${emp.name}");
				$("#selectBumun").val("${emp.bumun}");
				$("#selectDepartment").val("${emp.department}");
				$("#selectCpemail").val("${emp.cpemail}");
				$("#selectMobile").val("${emp.mobile}");
				$("#selectJoindate").val("${emp.joindate}");
				$("#selectBirth_date").val("${emp.birth_date}");
			}
		</c:forEach>
			
		
		
		
	}




   	


	

   	
   	
</script>

<div style="margin: 1% 0 5% 1%;">
	<h4>보낸 메일</h4>
</div>



<div style="width:100%">
	<div id="mail_box"style="width:50%; float:left;padding-right: 24px; border-right: 2px solid darkgray;">
		<div id="mailToolbar" class="tool_bar" style="width:100%">
			<div class="critical">
				
				<button id="mailLAllCheck_btn" type="button" class="btn btn-outline-dark toolbtn">
					<input type="checkbox" id="mailLAllCheck" value="off" style="vertical-align:middle;"/>&nbsp전체선택
			    
			    </button>
			    <button type="button" class="btn btn-outline-dark toolbtn" onclick="importantCheckSelect()">
					<i class="fas fa-flag toolflag"></i>
				</button>
			    
				<button type="button" class="btn btn-outline-dark toolbtn" onclick="replySelect()"><i class="fas fa-reply"></i> 답장</button>
			</div>
			
		</div>
		<div id ="mailTable" style="margin-top: 10px;">
			<table class="table">
		
			
			    
				   <thead>
				   		<th>
				   		</th>
				   		<th>부서</th>
				   		<th>팀</th>
				   		<th>직급</th>
				   		<th>이름</th>
				   		<th>이메일</th>
				   </thead>
				   <c:forEach var="emp" items="${requestScope.empList}" varStatus="status">
				 
				   		<tr onclick = 'ViewInfo(${emp.empno})'>
						  	  <td class="mail_list_option" onclick="event.stopPropagation()">
						      	<i id="flag${mailVO.mail_no}" class="fas fa-flag" style="color:darkgray;" onclick="importantCheck(${mailVO.mail_no})"></i>
						      </td>
						      <td class = "mail_list_sender" >
									${emp.bumun}
						      </td>
						      <td class = "mail_list_subject">
						     		${emp.department}
						      </td>
					   		  <td>
					   		  		${emp.position}
					   		  </td>
					   		  <td>
					   		  ${emp.name}
					   		  </td>
					   		  <td>
					   		  ${emp.cpemail}
					   		  </td>
				    	</tr>
				   </c:forEach>
					    
			  	
			</table>
		</div>
		
		
		
		
		
		
		<div id = "papagebar">
		${pagebar}
		</div>
		
		
	
	    <form name="searchFrm" style="margin-top: 20px;">
	        <select name="searchType" id="searchType" style="height: 26px;">
	           <option value="bumun">부문</option>
	           <option value="department">부서</option> 
	           <option value="name">성명</option>
	        </select>
	        <input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off"/>
	        <input type="text" style="display: none;" /> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
	        
	        <button type="button" style="float:right" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
	    </form>
	    
	

	</div>
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

	<div style="width:45%; float:right;" id="infoPage">
		<div class="text-center" id="bfClick" style="width:100%; height: 100%">
			<h2 style="margin-top: 50%;">사원을 선택해주세요.</h2>
		</div>
		<div id="afClick">
			<table id="empInfo" class="table">
				<tr>
					<td colspan="3" class="text-center">
						<h4 class="font-weight-bold ">직원  ooo 님 정보</h4>
					</td>
				</tr>
				<tr>
					<td rowspan="5" style="width:150px;">
						<img src="<%= ctxPath%>/resources/images/picture/꼬미사진.jpg" height="200px;" width="200px"/>
						
					</td>
					
					
				</tr>
				<tr>
					<th>성명</th>
					<td><input type="text" id="selectName" name="selecteName" value="이름" /></td>
				</tr>
	
				<tr>	
					<th>부문</th>
					<td><input type="text" id="selectBumun" name="selectBumun" /></td>
				<tr>
				<tr>	
					<th>부서</th>
					<td><input type="text" id="selectDepartment" name="selectDepartment" /></td>
				</tr>
			</table>
			
			<table id="empInfo2" class="table">
				<tr>	
					<th>이메일</th>
					<td><input type="text" id="selectCpemail" name="selectCpemail" /></td>
				</tr>
				<tr>	
					<th>휴대폰 번호</th>
					<td><input type="text" id="selectMobile" name="selectMobile" /></td>
				</tr>
				<tr>	
					<th>입사일자</th>
					<td><input type="text" id="selectJoindate" name="selectJoindate" /></td>
				</tr>
				<tr>	
					<th>생년월일</th>
					<td><input type="text" id="selectBirth_date" name="selectBirth_date" /></td>
				</tr>
			</table>
		</div>
	</div>
	
	
</div>


