<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>
<link href="https://webfontworld.github.io/pretendard/Pretendard.css" rel="stylesheet">
    
<style>

	* {font-family: 'Pretendard', sans-serif; !important}
	
	.menuBlue {	color: #086BDE;	}



	
	.menus:hover {	cursor: pointer;	}
	.menu {	list-style: none;	}
	
	.topMenu {
		font-size: 12.5pt;
		margin-top: 20px;
		margin-bottom: 5px;		
	}
	
	.subMenus {	font-size: 11.5pt;	}
		
	#menuBox {	z-index: 1;	} /* div 겹치는거 때문에 함 */
	
   
</style>

<script>

	$(document).ready(function(){ // ======================================
		sideBar();

		
		

				
				
		
		
		
		
		
	}); // end of $(document).ready(function(){} ==========================
		



	function sideBar(){
		$.ajax({
            url : '<%= ctxPath%>/organizationSideAjax.on',
            type:'GET',
            processData:false,
            contentType:"application/json;charset=UTF-8",
            dataType:'json',
            cache:false,
            success:function(jsonArr){
            	console.log(jsonArr);
            	console.log("1 DEPARTMENT"+jsonArr[1].BUMUN_NO);
  
            	var html="";
            	var bumunarr = [];
				$.each(jsonArr, function(index, item){ 
					
            		if(item.bumunList != null){
            			console.log("bumunList"+item.bumunList);
            			const bumunstr = item.bumunList;
            			bumunarr = item.bumunList.split(",");
            			console.log(bumunarr);
            		}
            		else{
            			console.log("item"+item.BUMUN_NO);
            		}
				});	
				
				for(var i in bumunarr){
					console.log("bumunarr"+bumunarr[i]);
				}
            	html='<li><h4 class = "mb-4">조직도</h4></li>';
            	
       			for(var i in bumunarr){
       				html += '<li class="menu topMenu" id="topMenu'+i+'">';
       				$.each(jsonArr, function(index, item){ 
       					if((item.DEPARTMENT_NO != null) && (item.BUMUN_NO == bumunarr[i])){
       						console.log("item.BUMUN_NO"+item.BUMUN_NO);
   							console.log("bumun"+bumunarr[i]);
							html+= item.BUMUN;
						 	return false;
       					}
    				});

	       				
     				html +=	'<ul class="menu subMenus" id="subMenu'+i+'">';
       					$.each(jsonArr, function(index, item){
       						if((item.DEPARTMENT_NO != null) && (item.BUMUN_NO == bumunarr[i])){
       							html+= '<li style="margin-top: 7px;">'+item.department+'</a></li>';
       						}
       					});	
       				html +='</ul></li>';	
       				
       			}
       			console.log("html"+html);
       			$("ul.menus").html(html);
        			
       			$(".subMenus").hide(); // 사이드 메뉴 닫기(기본)
       			// 메뉴 선택시 다른 메뉴 닫기		
       			$(".topMenu").click(function(e) {
       			    const target = $(e.target.children[0]).attr('id');
       			    // console.log(target);
       			    if ($("#"+target).is(":visible")) {
       			    	$(".subMenus").slideUp("fast");		    	
       			    }
       			    else {
       			    	$(".subMenus").slideUp("fast");
       			    	$("#"+target).slideToggle("fast");
       			    }
       			    
       			}); // end of $(".topMenu").click() -------------------------------
        	
            	
   
            	

            	
            },error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            } 
        });
	}
</script>



<div id="menuBox">
	<ul class="menus">
<%-- 		<li>
			<h4 class = "mb-4">조직도</h4>
		</li>
		<li class="menu topMenu" id="topMenu1">근태 관리
			<ul class="menu subMenus" id="subMenu1">
				<li style="margin-top: 7px;"><a href="<%= ctxPath%>/attend/myAttend.on" class="hoverShadowText" id="my1">내 근태 조회</a></li>
				<li class=""><a href="<%= ctxPath%>/attend/myManage.on" class="hoverShadowText" id="my2">내 근태 관리</a></li>
			</ul>
		</li>
		
		<li class="menu topMenu" id="topMenu2">경영 지원
			<ul class="menu subMenus" id="subMenu2">
				<li style="margin-top: 7px;"><a href="<%= ctxPath%>/attend/teamStatusDaily.on" class="hoverShadowText" id="team1">부서 근태 조회</a></li>
				<li class=""><a href="<%= ctxPath%>/attend/teamManage.on" class="hoverShadowText" id="team2">부서 근태 관리</a></li>
			</ul>
		</li>
		
		<li class="menu topMenu" id="topMenu3">전사 근태관리
			<ul class="menu subMenus" id="subMenu3">
				<li style="margin-top: 7px;"><a href="<%= ctxPath%>/attend/allStatus.on" class="hoverShadowText" id="all1" >전사 근태 조회</a></li>
				<li class=""><a href="<%= ctxPath%>/attend/allManage.on" class="hoverShadowText" id="all2">전사 근태 관리</a></li>
			</ul>
		</li> --%>
	</ul>
</div>