<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<style>
#writeBtn:hover{
	border: 1px solid #086BDE;
	color: white;
	background-color: #086BDE;
}
.mail_list_option>i.fas, i.fa{
padding-left: 4px;
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script type="text/javascript">
	toastr.options = { // toastr 옵션
	  "closeButton": false,
	  "debug": false,
	  "newestOnTop": false,
	  "progressBar": true,
	  "positionClass": "toast-top-center",
	  "preventDuplicates": false,
	  "onclick": null,
	  "showDuration": "300",
	  "hideDuration": "1000",
	  "timeOut": "2000",
	  "extendedTimeOut": "1000",
	  "showEasing": "swing",
	  "hideEasing": "linear",
	  "showMethod": "fadeIn",
	  "hideMethod": "fadeOut"
	}
	$(document).ready(function(){
		sideTag();
		// 목록 체크박스
		$(document).on('click','#mailLAllCheck_btn', function(){
			if($("#mailLAllCheck").is(":checked")){
				$("input:checkbox[id='mailLAllCheck']").prop("checked", false);
	        }else{
	        	$("input:checkbox[id='mailLAllCheck']").prop("checked", true);
	        }
			
			if($("#mailLAllCheck").is(":checked")) $("input[name=mailCheck]").prop("checked", true);
			else $("input[name=mailCheck]").prop("checked", false);
			
		});
		
		$(document).on('click','#mailLAllCheck', function(){
			if($("#mailLAllCheck").is(":checked")){
				$("input:checkbox[id='mailLAllCheck']").prop("checked", false);
	        }else{
	        	$("input:checkbox[id='mailLAllCheck']").prop("checked", true);
	        }
			
			if($("#mailLAllCheck").is(":checked")) $("input[name=mailCheck]").prop("checked", true);
			else $("input[name=mailCheck]").prop("checked", false);
			
		});
	});// ------------------- end of $(document).ready(function(){})

	function sideTag(){
		$.ajax({
            url : '<%= ctxPath%>/mail/getTagListSide.on',
            type:'POST',
            processData:false,
            contentType:"application/json;charset=UTF-8",
            dataType:'json',
            cache:false,
            success:function(json){
            	var html="";
            	$.each(json, function(index, item){
					html += '<li><a id="tag" class="nav-link" href="<%=ctxPath%>/mail/tagMailBox.on?tagColor='+item.tag_color+'&tagName='+item.tag_name+'"><i class="fas fa-tag" style="color:#';
					html += item.tag_color;
					html +=	'";"></i>&nbsp';
					html += item.tag_name
					html +='</a></li>';
				});	
            	$("#sidebarTag").html(html);
            	

            	
            },error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            } 
        });
	}
	
	function clickCheck(){
		var total = $("input[name=mailCheck]").length;
		var checked = $("input[name=mailCheck]:checked").length;

		if(total != checked) {
			$("input#mailLAllCheck").prop("checked", false);
		}
		else {
			$("input#mailLAllCheck").prop("checked", true); 
		}
		
	}
</script>

<!-- A vertical navbar -->
<nav class="navbar bg-light">

  <!-- Links -->
  <ul class="navbar-nav" style="width: 100%">
    <li class="nav-item">
      <h4 class='mb-4'>메일</h4>
    </li>
    <li class="nav-item mb-4">
      <button id="writeBtn" type="button" style='width:100%' class="btn btn-outline-dark" onClick='location.href="<%=ctxPath%>/mail/writeMail.on"'> 메일 쓰기</button>
    </li>

    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/mail/receiveMailBox.on">받은 메일함</a>
    </li>
    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/mail/sendMailBox.on">보낸 메일함</a>
    </li>
    <li class="nav-item">
      <a id="requestedList" class="nav-link" href="<%=ctxPath%>/mail/importantMailBox.on">중요 메일함</a>
    </li>


    <li class="nav-item">
      <a class="nav-link" href="#">태그 메일함</a>
      	<ul id="sidebarTag">
      		 	
      	</ul>
    </li>
    <!-- 
    <li><div id ="tagAdd" class="nav-link" onclick="">태그 추가</div></li>
    <li><div class="colorPickSelector"  ></div></li>
     -->

  </ul>
  

</nav>


<div class="modal fade" id="modal_addTag" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">태그 추가하기</h4>
        		<button id="add" type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-borderless">
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">태그 이름</td>
     						<td><input type="text" name="tag_name" id="tag_name"/></td>
     					</tr>
     					<tr>
     						<td style="text-align: left; vertical-align: middle;">색상 선택</td>
     						
     						<td>
     							<input id="tag_color" name="tag_color" type="color" value="#ffffff" />
     						</td>
     					</tr>

     				</table>
       			</form>	
      		</div>
      
      		<!-- Modal footer -->
      		<div class="modal-footer">
      			
				<button type="button" class="btn btn-light btn-sm modal_close" data-dismiss="modal">취소</button>
      			<button type="button" style="background-color:#086BDE; color:white;" id="addTag" class="btn btn-sm" onclick="goAddTag()">추가</button>
      		</div>
      
    	</div>
  	</div>
</div>
