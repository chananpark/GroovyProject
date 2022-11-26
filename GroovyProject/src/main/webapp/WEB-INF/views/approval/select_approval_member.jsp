<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>결재자 선택</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css">

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%=ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<%=ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<%-- sweet alert --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<%-- ajaxForm --%>
<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery.form.min.js"></script>

<style>

label {
	cursor: pointer;
}

ul {
	list-style: none;
}

div#empContainer, #aprvContainer {
	width: 350px;
	height: 400px;
	max-height: 400px;
	overflow: auto;
	margin-top: 50px;
	display: inline-block;
}

.table {
	margin-top: 100px;
	font-size: small;
}

.table th {
	background-color: #E3F2FD;
	vertical-align: middle;
	text-align: center;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret::before {
  display: inline-block;
  margin-right: 6px;
}

.nested {
  display: none;
}

.active {
  display: block;
}
</style>

<script>
// 부문 json배열
let bumunArray = JSON.parse('${bumunArray}');
// 팀(부서) json배열
let deptArray = JSON.parse('${deptArray}');
// 사원 json배열
let empArray = JSON.parse('${empArray}');

$(()=>{
	
	makeTree(); // 사원목록 트리 만들기
	
	var toggler = document.getElementsByClassName("caret");
	var i;

	for (i = 0; i < toggler.length; i++) {
	  toggler[i].addEventListener("click", function() {
	    this.parentElement.querySelector(".nested").classList.toggle("active");
	    
	    if (this.parentElement.querySelector(".nested").classList.contains("active")) {
		    this.classList.remove("fa-plus-square");
		    this.classList.add("fa-minus-square");
	    } else {
		    this.classList.remove("fa-minus-square");
		    this.classList.add("fa-plus-square");
	    }
	  });
	}
	
	// 체크박스 클릭 시
	$("input[type='checkbox']").click((e)=>{
		const target = $(e.target);
		const checked = target.prop('checked');
		
		// 선택된 사람의 사원번호
		const selectedEmpNo = target.prop('id').substring(3);
		
		if(checked) {
			// 결재자는 4명까지만 추가 가능
			const body = $('#tblBody');
			const cnt = body.children('tr').length;
			if (cnt > 3) {
				swal ( "오류" ,  "결재자는 최대 4명까지 추가 가능합니다." ,  "error" );
				target.prop('checked', false); // 체크 해제
				return;
			}
			// 결재자 추가
			selectAprvMember(selectedEmpNo);
		}
		else 
			// 결재자 삭제
			cancelAprvMember(selectedEmpNo);

	});
	
});

const makeTree = () => {

	let html = "";
	bumunArray.forEach(function(bumun, index) {
		html += "<ul id='bumun"+index+"'>"
			+ "<li id='bumun"+bumun.bumun_no+"'><i class='caret fas fa-minus-square'></i>"+bumun.bumun;
		// 부문에 해당하는 팀만 필터링
		let newDeptArray = deptArray.filter(dept => dept.bumun_no == bumun.bumun_no);
		
		newDeptArray.forEach(function(dept, index) {
 			if(index == 0) {
				html += "<ul class='nested active' id='dept'>"
			} 
			html += "<li id='bumun"+dept.department_no+"'><i class='caret fas fa-minus-square'></i>"+dept.department;

			// 팀에 해당하는 사원만 필터링
			let newEmpArray = empArray.filter(emp => emp.department == dept.department);
			if (newEmpArray.length > 0) {
				newEmpArray.forEach(function(emp, index) {
					if(index == 0) {
						html += "<ul class='nested active' id='emp'>"
					}
					html += "<li>"
						+ "<input type='checkbox' id='emp"+emp.empno+"'/>"
						+ "<label for='emp"+emp.empno+"'>" + emp.name + " " + emp.position + "</label></li>";
					if(index == newEmpArray.length-1) {
						html += "</ul></li>";
					}
				});
			}
			else {
				html += "<ul class='nested active'><li>비어있음</ul></li>";
			}
			
			if(index == newDeptArray.length-1) {
				html += "</ul></li>";
			}
		});
		html += "</ul>";
	});
	
	$("#empContainer").html(html);
	
}

const selectAprvMember = (selectedEmpNo) => {
	// 선택된 사원을 오른쪽에 표시함
	const emp = empArray.find(el => el.empno == selectedEmpNo);
	
	const body = $('#tblBody');
	const cnt = body.children('tr').length;
	
 	var html = "<tr id='" + emp.empno + "'>"
 			+ "<td class='levelno'></td>"
			+ "<td class='department'>" + emp.department + "</td>"
			+ "<td class='position'>" + emp.position + "</td>"
			+ "<td class='position_no' style='display:none'>" + emp.position_no + "</td>"
			+ "<td class='empno' style='display:none'>" + emp.empno + "</td>"
			+ "<td class='name'>" + emp.name + "</td></tr>";
		
	body.append(html);
	
	// 결재순서 부여하기
	orderLevelno();
}

const orderLevelno = () => {
	levelArr = Array.from($("td.levelno"));
	
	levelArr.forEach((el, index) => {
		el.innerText = index+1;
	});
}

const cancelAprvMember = (selectedEmpNo) => {
	$('tr#'+selectedEmpNo).remove();
	
	// 결재순서 부여하기
	orderLevelno();
}

const submitAprvLine = () => {
	// 사용자가 지정한 결재라인의 직급 배열
	const positionArr = Array.from($("#tblBody > tr").children('td.position_no').text());
	
	// 결재라인 순서가 올바른지 검사
	const isRightOrder = checkAprvOrder(positionArr);
	
	// 순서가 틀리면 리턴
	if (!isRightOrder) {
		swal ( "오류" ,  "결재 순서가 잘못되었습니다." ,  "error" );
		return;
	}
	
	// 중복된 직급이 있는지 검사
	const isDuplicated = checkDuplication(positionArr);
	
	// 순서가 틀리면 리턴
	if (isDuplicated) {
		swal ( "오류" ,  "같은 직급의 결재자가 있습니다." ,  "error" );
		return;
	}
		
	// 순서가 맞으면 값을 넘긴다
	let jsonArr = new Array(); // 값을 넘길 json배열

	const aprvArr = Array.from($("#tblBody > tr")); // 선택된 결재라인

	aprvArr.forEach(el => {
		
		// 각 사원의 정보를 담을 객체
		const empObj = new Object();
 		empObj.levelno = el.getElementsByClassName('levelno')[0].innerText;
		empObj.department = el.getElementsByClassName('department')[0].innerText;
		empObj.position = el.getElementsByClassName('position')[0].innerText;
		empObj.empno = el.getElementsByClassName('empno')[0].innerText;
		empObj.name = el.getElementsByClassName('name')[0].innerText;
		
		jsonArr.push(empObj); // json배열에 결재자 정보를 담는다
	});

 	window.opener.postMessage(jsonArr, '*');
	window.self.close();
}

const checkAprvOrder = (positionArr) => {
	
	// 직급 배열을 복사하여 오름차순으로 정렬한 것
	let sortedArr = JSON.parse(JSON.stringify(positionArr)).sort();
	
	// 둘이 일치하는지 비교
	const isSameArray = JSON.stringify(positionArr) === JSON.stringify(sortedArr); 
	
	return isSameArray;
}

const checkDuplication = (positionArr) => {

	// 직급 배열을 가지고 set을 만든다
	const positionSet = new Set(positionArr);

	// set의 크기가 더 작다면 중복된것
	const isDuplicated = positionSet.size < positionArr.length;
	
	return isDuplicated;
	
}
</script>

</head>
<body>

<div class='container-fluid'>
	<div id='empContainer'>
	</div>
	<div id='aprvContainer' style='margin-left: 40px'>
		<table class='table table-sm table-bordered apprvTable' style="vertical-align: middle;">
			<thead>
				<tr>
					<th>순서</th>
					<th>소속</th>
					<th>직급</th>
					<th>성명</th>
				</tr>
			</thead>
			<tbody id="tblBody">
			</tbody>
		</table>
	</div>
	<div>
		<button type='button' class='btn btn-secondary'>취소</button>
		<button type='button' class='btn btn-primary' onclick='submitAprvLine()'>확인</button>
	</div>
</div>
</body>
</html>