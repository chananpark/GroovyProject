<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style>

	div#info_manageInfo {
		padding: 5% 2%;
		width: 95%;
	}

	/* input{
		display: none;
		
	} */
	
	table{
		width: 95%;
		margin-bottom: 5%;
		padding: 2%;
		font-size: 12px;
	}
	

	tr{
		
	}
	
	th {
		font-weight: bold;
		background-color: #e3f2fd; 
		width: 20%;
		text-align: center;
	}
	
	

</style>

<form id="frm_manageInfo">
<div id="info_manageInfo">
	<h2>상세정보</h2>
	<hr style="border:1px color= silver;" >
	
	<table class="table table-bordered" >
		<tr>
			<img src="<%= ctxPath%>/resources/images/picture/꼬미사진.jpg" height="100px;" width="100px" alt="..."/>
		</tr>
		<tr>
			<th>사원번호</th>
			<td><input type="text" id="" name="" /></td>
			
			<th>성명</th>
			<td><input type="text" id="name" name="name" /></td>
		</tr>
		<tr >
			<th>주민등록번호</th>
				<td>
					<input type="text" id="jubun" name="jubun" style="display: inline;"><button type="button" style="width:70px; display: inline; border: none;">확인/수정</button>
				</td>
			<th>성별</th>
			 <td style="width: 80%; text-align: left;">
	            <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
	            <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
	         </td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td><input type="text" id="birth" name="birth"/></td>
		</tr>
		
		
	</table>
	
	<table  class="table table-bordered">
		<tr>
			<th>핸드폰</th>
			<td><input type="text" id="mobile" name="mobile" /></td>
			<th>회사전화</th>
			<td><input type="text" id="mobile" name="mobile" /></td>
		</tr>
		<tr>
			<th>회사이메일</th>
			<td><input type="text" id="mobile" name="mobile" /></td>
			<th>외부이메일</th>
			<td><input type="text" id="mobile" name="mobile" /></td>
		</tr>
	</table>
	
	<table  class="table table-bordered">
		<tr>
			<th><span style="color: red;">*</span>사업장</th>
			<td><input type="text" id="" name="" /></td>
			<th>부서</th>
			<td><input type="text" id="" name="" /></td>
			<th>직급</th>
			<td><input type="text" id="" name="" /></td>
		</tr>
		<tr>
			<th><span style="color: red;">*</span>급여계약기준</th>
			<td><input type="text" id="" name="" /></td>
			<th>호봉</th>
			<td><input type="text" id="" name="" /></td>
			<th>직책</th>
			<td><input type="text" id="" name="" /></td>
		</tr>
		<tr>
			<th><span style="color: red;">*</span>수습여부/적용률</th>
			<td><input type="text" id="" name="" /></td>
			<th>수습기간</th>
			<td><input type="date" id="" name="" />~<input type="date" id="" name="" /></td>
			<th>비고</th>
			<td><input type="text" id="" name="" /></td>
		</tr>
		<tr>
			<th><span style="color: red;">*</span>입사일자</th>
			<td><input type="text" id="" name="" /></td>
			<th>퇴직일자</th>
			<td><input type="date" id="" name="" /></td>
			<th></th>
			<td><input type="text" id="" name="" /></td>
		</tr>
	</table>
	
	<div align="right" style="margin: 3% 0;">
		<button id="btn_update" style="color: white; background-color:#086BDE; border: none; width: 100px;"  >정보수정</button>
	</div>
	
</div>
</form>
