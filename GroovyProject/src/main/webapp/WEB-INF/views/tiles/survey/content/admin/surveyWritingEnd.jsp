<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<style>

	div#div_writing {
		padding: 5% 2%;
		width: 95%;
	}
	
	div#surveyform > div {
		margin-bottom: 3%;
	}
	
	div.marginbottom {
		margin-bottom: 1%;
	}
	
	
	button#btn_next {
		width: 80px;
		background-color: #086BDE;
		color:white;
		font-size: 14px;
		border: none;
	}

	
	button#btn_cancle {
	 	background-color:#d9d9d9; 
	 	width: 80px; 
	 	margin-right: 2%;
	}
	
	div.radio {
		margin:2% 0 0 2%;
	}
	
	div.radio > input{
		margin:1%;
	}
	
	
	input{
		border: solid 1px #cccccc;
	}
	
	button#btn_deleteHm,button#btn_addHm {
		background: white;
		border: none;
	}
	
	
	
</style>

<script type="text/javascript">

// 전역변수
 let fk_surno = "";

	$(document).ready(function(){
		
		
		$("button#btn_submit").click(function(){
			
			const question = $("input[name='question']").val().trim();
			if(question == "") {
				alert("질문을 모두 작성해주세요");
				return;
			}
		/* 	
		 	const option1 = $("input[name='option1']").val().trim();
			if(option1 == "") {
				alert("선택지 모두 작성해주세요");
				return;
			}
			
			const option2 = $("input[name='option2']").val().trim();
			if(option1 == "") {
				alert("선택지 모두 작성해주세요");
				return;
			}
			
			const option3 = $("input[name='option3']").val().trim();
			if(option1 == "") {
				alert("선택지 모두 작성해주세요");
				return;
			}
			
			const option4 = $("input[name='option4']").val().trim();
			if(option1 == "") {
				alert("선택지 모두 작성해주세요");
				return;
			}
			
			const option5 = $("input[name='option5']").val().trim();
			if(option1 == "") {
				alert("선택지 모두 작성해주세요");
				return;
			} */
			
			// 설문지를 저장해주는 함수
			func_btn();
			
		}); // end of $("button#btn_submit").click(function(){ --------------------
		
	}); // end of $(document).ready(function(){---------------------
	/*	
		console.log(surtitle);
		console.log(surexplain);
		console.log(surstart);
		console.log(surtarget);
	*/	
	// >>> 완료버튼을 누르면 <<< //
	function func_btn(){
	
		// 설문번호 insert
		const queryString = $("form[name='frm_writing']").serialize();
		$.ajax({
			url:"<%=ctxPath%>/survey/surveyWritingNo.on",
			data: queryString,
			async: true, // 반복문이기때문에 비동기방식이 아닌 동기방식으로 해야한다.
			type:"POST",
			dataType:"JSON",
			success:function(json){
				console.log(json.n);
				
				if(json.n == 1) {
					alert("신청현황 변경을 모두 완료하였습니다.");
				}
				else {
					alert("신청현황 변경을 실패하였습니다.");
				}
				
			},
		  	 error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		}); // end of 설문번호 insert $.ajax({
		
		// 초기값 설정
		let i=0;
		// 설문항목 insert
		for(i=1; i<=5; i++){
			const frm = $("form[name='frm"+i+"']").serialize();
		//	리텀값frm.fk_surno.value=fk_surno; 을 전역변수에 담아놔야한다.
		
	//		function(i) {  ==> 함수를 사용해서(i)를 사용하는데 여기서는 function이 중복되서 안되는것 같음
		//		{	
					$.ajax({
						url:"<%=ctxPath%>/survey/surveyWritingFinish.on",
						data: frm,
						type:"POST",
						dataType:"JSON",
						async: true, // 반복문이기때문에 비동기방식이 아닌 동기방식으로 해야한다.
						success:function(json){
							console.log(i);
							console.log(json.p);
							frm.fk_surno.value=fk_surno;
							
						/* 	if(json.p == 1) {
								alert([i] +"질문 등록 완료하였습니다.");
								frm.fk_surno.value=fk_surno;
							}
							else {
								alert([i] +"질문 등록 실패하였습니다.");
							}
							 */
						},
					  	 error: function(request, status, error){
							  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						  }
					});
			//	}
	//		}
		} // end of for -------------------------
	} // end of function func_btn(){ --------------------

</script>

<div id="div_writing">
	
	<div style='margin: 1% 0 3% 1%'>
		<h4>설문문항작성</h4>
	</div>
	
	<div id="surveyform" class="m-4">
		
	<form name="frm_writing">
		<input type="hidden" name="empno" value="${paramap.empno}"/>
		<input type="hidden" name="surtitle" value="${paramap.surtitle}">
		<input type="hidden" name="surexplain" value="${paramap.surexplain}">
		<input type="hidden" name="surstart" value="${paramap.surstart}">
		<input type="hidden" name="surend" value="${paramap.surend}">
		<input type="hidden" name="surtarget" value="${paramap.surtarget}">
		<input type="hidden" name="department" value="${paramap.department}">
		<input type="hidden" name="suropenstatus" value="${paramap.suropenstatus}">
	</form>  
		
		<form name="frm1" id="frm1">
		<section style="border-bottom:solid 1px #bfbfbf; border-top:solid 1px #bfbfbf;">
			<div class="my-4 mx-2">
				<span class="mx-2">1.</span><input type="hidden" name="questno" value="1"/>
				 <input type="hidden" name="fk_surno" value=""/>
				<input type="text" name="question" placeholder="질문을 등록해주세요" style="width: 80%;" required /> 
				<div class="radio input1">
					º<input type="text" name="option1"/><br>
					º<input type="text" name="option2"/><br>
					º<input type="text" name="option3"/><br>
					º<input type="text" name="option4"/><br>
					º<input type="text" name="option5"/><br>
				</div>
			</div>	
		</section>
		</form>
		
		<form name="frm2" id="frm2">
		<section style="border-bottom:solid 1px #bfbfbf;">
			<div class="my-4 mx-2">
				<span class="mx-2">2.</span><input type="hidden" name="questno" value="2"/>
				 <input type="text" name="question" placeholder="질문을 등록해주세요" style="width: 80%;" required/> 
				<div class="radio input2">
					º<input type="text" name="option1"/><br>
					º<input type="text" name="option2"/><br>
					º<input type="text" name="option3"/><br>
					º<input type="text" name="option4"/><br>
					º<input type="text" name="option5"/><br>
				</div>
			</div>	
		</section>
		</form>
		
		<form name="frm3" id="frm3">
		<section style="border-bottom:solid 1px #bfbfbf;">
			<div class="my-4 mx-2">
				<span class="mx-2">3.</span><input type="hidden" name="questno" value="3"/>
				 <input type="text" name="question" placeholder="질문을 등록해주세요" style="width: 80%;" required/> 
				<div class="radio input3">
					º<input type="text" name="option1"/><br>
					º<input type="text" name="option2"/><br>
					º<input type="text" name="option3"/><br>
					º<input type="text" name="option4"/><br>
					º<input type="text" name="option5"/><br>
				</div>
			</div>	
		</section>
		</form>
		
		<form name="frm4" id="frm4">
		<section style="border-bottom:solid 1px #bfbfbf;">
			<div class="my-4 mx-2">
				<span class="mx-2">4.</span><input type="hidden" name="questno" value="4"/>
				  <input type="text" name="question" placeholder="질문을 등록해주세요" style="width: 80%;" required/>
				<div class="radio input4">
					º<input type="text" name="option1"/><br>
					º<input type="text" name="option2"/><br>
					º<input type="text" name="option3"/><br>
					º<input type="text" name="option4"/><br>
					º<input type="text" name="option5"/><br>
				</div>
			</div>	
		</section>
		</form>
		
		<form name="frm5" id="frm5">
		<section style="border-bottom:solid 1px #bfbfbf;">
			<div class="my-4 mx-2">
				<span class="mx-2">5.</span><input type="hidden" name="questno" value="5"/>
				 <input type="text" name="question" placeholder="질문을 등록해주세요" style="width: 80%;" required/>
				<div class="radio input5">
					º<input type="text" name="option1"/><br>
					º<input type="text" name="option2"/><br>
					º<input type="text" name="option3"/><br>
					º<input type="text" name="option4"/><br>
					º<input type="text" name="option5"/><br>
				</div>
			</div>	
		</section>
		</form>
	</div>
	
	<div align="center" style="margin-top: 3%;">
		<button id="btn_cancle" class="btn btn-sm" onclick="javascript:location.href='<%=ctxPath%>/survey/surveyWriting.on'">취소</button>
		<button id="btn_storage" class="btn btn-sm mr-3"onclick="javascript:location.href='<%= ctxPath%>/survey/surveyJoin.on'" style="border:solid 1px gray;">임시저장</button>
		<button id="btn_submit" class="btn btn-sm" style="background-color:#086BDE; color:white; width: 80px;">완료</button>
	</div>

</div>
