<%@page import="com.smhrd.entity.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	// html 이 다 로딩이 되고 boardList가 작동하게 해주는 함수
	$(document).ready(function() {
		boardList();
	})

	function boardList() {
		// 비동기 통신할 때 JavsScript jQuery사용 -> ajax
		// 어떤 형태? 객체형태 -> JSON(JavaScript Object Notation) -> {key1 : value1, key2 : value2, key3 : {key4 : value4}}
		// 어디로 보낼건지, 어떤 데이터타입을 보낼건지, 어떤 데이터타입을 받을건지, 어떤방식으로 보낼건지, 성공시에는 뭘할건지, 실패시에는 뭘할건지

		$.ajax({
			url : "board/all",
			type : "get",
			dataType : "json",
			success : makeView,
			error : function() {
				alert("error");
			}
		})
	}

	// 성공시 makeView 함수 실행 -> jsp에 데이터를 뿌려주겠다!
	function makeView(data) { // data = [{key : value}, {} ,{} , ...]
		console.log(data);
		var listHtml = "<table class='table table-bordered'>";
		listHtml += "<tr>";
		listHtml += "<td>번호</td>";
		listHtml += "<td>제목</td>";
		listHtml += "<td>작성자</td>";
		listHtml += "<td>작성일</td>";
		listHtml += "<td>조회수</td>";
		listHtml += "</tr>";

		// jQuery 반복문
		// data를 받아왔을 때 실행될 함수
		$
				.each(
						data,
						function(index, obj) { // obj -> {idx:23, title:ttt, content:월월...}
							listHtml += "<tr>";
							listHtml += "<td>" + (index + 1) + "</td>";
							listHtml += "<td id='t"+obj.idx+"'><a href='javascript:goContent("+ obj.idx + ")'>" + obj.title + "</a></td>";
							listHtml += "<td>" + obj.writer + "</td>";
							listHtml += "<td>" + obj.indate + "</td>";
							listHtml += "<td>" + obj.count + "</td>";
							listHtml += "</tr>";

							// 상세 게시글 보여주기

							listHtml += "<tr id='c"+obj.idx+"' style='display: none;'>";
							listHtml += "<td>내용</td>";
							listHtml += "<td colspan='4'>";
							listHtml += "<textarea id='ta"+obj.idx+"' readonly class='form-control'>";
							// listHtml += obj.content;
							listHtml += "</textarea>";
							
							listHtml += "<span id='ud"+obj.idx+"'><button class='btn btn-sm btn-success' onclick='goUpdateForm("+obj.idx+")'>수정</button></span> &nbsp";
							listHtml += "<span><button class='btn btn-sm btn-warning' onclick='goDelete("+obj.idx+")'>삭제</button></span>";
							
							listHtml += "</td>";
							listHtml += "</tr>";

						})

		// 글쓰기 버튼 추가해서 클릭하면 글쓰기 폼 띄우기
		listHtml += "<tr>";
		listHtml += "<td colspan='5'>";
		listHtml += "<button class='btn btn-primary btn-sm' onclick='goForm()'>";
		listHtml += "글쓰기";
		listHtml += "</button>";
		listHtml += "</td>";
		listHtml += "</tr>";

		listHtml += "</table>";

		// view라는 id값을 가진 요소를 가지고 온 다음에
		// 그 태그 안쪽에 html형식으로 뿌려주겠다!
		$("#view").html(listHtml);

		// none으로 되어있는 목록을 다시 block으로 바꿔주는 기능
		goList();

	}

	// 글쓰기 버튼 눌렀을 때 글 작성하는 폼 보여주는 함수
	function goForm() {
		$("#wform").css("display", "block");
		$("#view").css("display", "none");
	}

	// 목록으로가기 버튼 눌렀을 때 목록 보여주는 함수
	function goList() {
		$("#wform").css("display", "none");
		$("#view").css("display", "block");
	}

	// 게시글 입력하는 함수
	function goInsert() {
		var fData = $("#frm").serialize();
		console.log(fData);

		$.ajax({
			url : "board/new",
			type : "post",
			data : fData,
			success : boardList,
			error : function() {
				alert("error");
			}
		})

		// 글쓰기 폼에 있는 기존값 지워주기
		/* $("#title").val("");
		$("#content").val("");
		$("#writer").val(""); */

		$("#fclear").trigger("click");

	}

	// 게시글 상세보기 함수
	function goContent(idx) { // 30, 29, 28 ...

		if ($("#c" + idx).css("display") == "none") {

			$.ajax({
				url : "board/"+idx, // url?idx=20&name=이주희
				type : "get",
				dataType : "json",
				success : function(data) {
					$("#ta" + idx).val(data.content);
				},
				error : function() {
					alert("error");
				}
			})

			$("#c" + idx).css("display", "table-row");

		} else {
			// 게시글 닫을 때
			$("#c" + idx).css("display", "none");
			// 조회수 올리기
			$.ajax({
				url : "board/count/"+idx,
				type : "put",
				/* data : {"idx" : idx}, */
				success : boardList,
				error : function(){
					alert("error");
				}
			})
		}

	}
	
	// 게시물 삭제하는 함수
	function goDelete(idx){
		
		$.ajax({
			url : "board/"+idx,
			type : "delete",
			success : boardList,
			error : function(){
				alert("error")
			}
		})
		
	}
	
	// 게시그 수정하는 화면(form) 만들어주는 함수
	function goUpdateForm(idx){
		// 제목을 input 태그로 바꿔주기
		var title = $("#t"+idx).text();
		var newInput = "<input type='text' id='nt"+idx+"' value='"+title+"' class='form-control'>";
		$("#t"+idx).html(newInput);
		
		// textarea 태그 가져와서 readonly 속성 풀어주기
		$("#ta"+idx).attr("readonly", false);
		
		// 수정하기 기능이 있는 버튼으로 변경
		var newButton = "<button class='btn btn-sm btn-primary' onclick='goUpdate("+idx+")'>수정하기</button>";
		$("#ud"+idx).html(newButton);
	}
	
	// 게시글 수정하는 함수
	function goUpdate(idx){ // idx, title, content
		var title = $("#nt"+idx).val();
		var content = $("#ta"+idx).val();
		
		$.ajax({
			url : "board/update",
			type : "put",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify({"idx" : idx, "title" : title, "content" : content}),
			success : boardList,
			error : function(){alert("error");}
		})
		
	}
	
	
</script>

</head>
<body>

	<div class="container">
		<h2>Spring Day2</h2>
		<div class="panel panel-warning">
			<div class="panel-heading">Board</div>
			<div class="panel-body" id="view"></div>

			<!-- 글쓰기 폼 -->
			<div class="panel-body" style="display: none" id="wform">
				<form id="frm">
					<table class="table">
						<tr>
							<td>제목</td>
							<td><input type="text" name="title" id="title"
								class="form-control"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea type="text" name="content" id="content"
									class="form-control"></textarea></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td><input type="text" name="writer" id="writer"
								class="form-control"></td>
						</tr>

						<tr>
							<td>
								<button class="btn btn-sm btn-success" type="button"
									onclick="goInsert()">등록</button>
								<button class="btn btn-sm btn-warning" type="reset" id="fclear">취소</button>
								<button class="btn btn-sm btn-info" type="button"
									onclick="goList()">목록으로가기</button>
							</td>
						</tr>

					</table>
				</form>
			</div>

			<div class="panel-footer">스프링 - 이주희</div>
		</div>
	</div>



	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">게시글 안내</h4>
				</div>
				<div class="modal-body">게시글이 등록되었습니다 :D</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {

			let result = '${result}';

			if (result == 'ok') {
				$('#myModal').modal("show");
			}

		});
	</script>






</body>
</html>













