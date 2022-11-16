<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    padding: 10px 0;
    border-bottom: solid 1px #ddd;
    border-top: solid 1px #ddd;
}
td.mail_list_option{
	width:80px;
}
td.mail_list_sender{
	width:150px;
}
td.mail_list_time{
	width:150px;
}
#mail_box{
	margin-top:10px;
}
tr:hover{
	background-color: #E3F2FD;
	cursor: pointer;
}
i.fa-flag{
	color:#086BDE ;
}

.toolbtn{
	border-color: #ddd;
}
.toolbtn:hover {
    color: #fff !important;
    background-color: #086BDE ;
    border-color: #086BDE ;
}
.toolbtn:active {
    color: #fff;
    background-color: #086BDE !important;
    border-color: #086BDE !important;
}
.toolbtn:focus {
    box-shadow: none !important;
}
.textCut {
    text-overflow: ellipsis;
    white-space: nowrap;
}
.toolflag{
	color:inherit !important;
}



</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(document).on('click','#mailLAllCheck_btn', function(){
			if($("#mailLAllCheck").is(":checked")){
				$("input:checkbox[id='mailLAllCheck']").prop("checked", false);
	        }else{
	        	$("input:checkbox[id='mailLAllCheck']").prop("checked", true);
	        }
		});
		
	});
</script>

<h2>보낸메일함</h2>

<div id="mailToolbar" class="tool_bar">
	<div class="critical">
		
		<button id="mailLAllCheck_btn" type="button" class="btn btn-outline-dark toolbtn">
			<input type="checkbox" id="mailLAllCheck" value="off" style="vertical-align:middle;">&nbsp전체선택
	    
	    </button>
	    <button type="button" class="btn btn-outline-dark toolbtn">
			<i class="fas fa-flag toolflag"></i>
		</button>
	    
		<button type="button" class="btn btn-outline-dark toolbtn"><i class="fas fa-reply"></i> 답장</button>
		<div class="dropdown btn_submenu">
		  <span class="btn btn-outline-dark dropdown-toggle btn-sm toolbtn" data-toggle="dropdown">
		  <!-- 아이콘 클릭시 아래것들 나올예정 -->
		  </span>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="#">답장</a>
		    <a class="dropdown-item" href="#">전체답장</a>
		  </div>

		</div>
		<button type="button" class="btn btn-outline-dark toolbtn"><i class="fas fa-trash-alt"></i> 삭제</button>
		<button type="button" class="btn btn-outline-dark toolbtn"><i class="fas fa-long-arrow-alt-right"></i> 전달</button>
		<div class="dropdown btn_submenu">
		  <span class="btn btn-outline-dark dropdown-toggle toolbtn" data-toggle="dropdown">
		  <!-- 아이콘 클릭시 아래것들 나올예정 -->
		  <i class="fas fa-tag"></i>&nbsp태그
		  </span>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp태그이름1</a>
		    <a class="dropdown-item" href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp태그이름2</a>
		    <a class="dropdown-item" href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp태그이름3</a>
		    
		  </div>
	
		</div>
		<button type="button" class="btn btn-outline-dark toolbtn"><i class="far fa-envelope-open"></i> 읽음</button>

		

		
		

	</div>
	
</div>



<div id="mail_box">
	<table class="table">

	  <tbody>
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender" >받는사람 이름</td>
	      <td class = "mail_list_subject">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	    
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender" >받는사람 이름</td>
	      <td class = "mail_list_subject">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	    
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender textCut" >받는사람 이름</td>
	      <td class = "mail_list_subject textCut">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	    
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender" >받는사람 이름</td>
	      <td class = "mail_list_subject">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	    
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender" >받는사람 이름</td>
	      <td class = "mail_list_subject">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	    
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender" >받는사람 이름</td>
	      <td class = "mail_list_subject">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	    
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender" >받는사람 이름</td>
	      <td class = "mail_list_subject">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	    
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender" >받는사람 이름</td>
	      <td class = "mail_list_subject">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	    
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender" >받는사람 이름</td>
	      <td class = "mail_list_subject">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	    
	    <tr>
	      <td class="mail_list_option">
	      	<input type="checkbox" id="mailLCheck" value="off" style="vertical-align:middle">
	      	<i class="fas fa-flag"></i>
	      	<!-- 색조정 or 다른 아이콘 -->
	      	<i class="far fa-envelope"></i>
	      	<!-- 봤다면 <i class="far fa-envelope-open"></i> -->
	      </td>
	      <td class = "mail_list_sender" >받는사람 이름</td>
	      <td class = "mail_list_subject">
	      	<a href="#"><i class="fas fa-tag" style="color:#f9320c"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#00b9f1"></i> &nbsp</a>
		    <a href="#"><i class="fas fa-tag" style="color:#f9c00c"></i> &nbsp</a>
		      	<!-- 태그 개수에 따라 제목옆에 보여줄 예정 -->
	      	메일제목
	      </td>
	      <td class = "mail_list_time">보낸시간</td>
	    </tr>
	  	
	</table>
</div>


