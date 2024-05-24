<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  
  	  $(document).ready(function(){
  		  // HTML이 다 로딩되고 작동하는 함수
  		  loadList();
  	  });
  
  
	  function loadList(){
		  // BoardController에서 게시글 전체목록을 가져오는 기능
		  // JavaScript에서 객체 표현법 {key:value}
		  $.ajax({
			  url : "board/all",
			  type : "get",
			  dataType : "json",
			  success : makeView,
			  error : function(){ alert("error"); }
		  });
	  }
	                           //           0              1         2
	  function makeView(data){ // data = [{title="하하"}, {     }, {     }]
		  console.log(data);
		  var listHtml = "<table class='table table-bordered'>";
		  listHtml += "<tr>";
		  listHtml += "<td>번호</td>";
		  listHtml += "<td>제목</td>";
		  listHtml += "<td>작성자</td>";
		  listHtml += "<td>작성일</td>";
		  listHtml += "<td>조회수</td>";
		  listHtml += "</tr>";
		  
		  // 게시글을 반복문을 통해 만들어주는 부분
		  $.each(data, function(index, obj){
			  listHtml += "<tr>";
			  listHtml += "<td>" + (index + 1) + "</td>";
			  listHtml += "<td id='t"+obj.idx+"'><a href='javascript:goContent("+obj.idx+")'>" + obj.title + "</a></td>";
			  listHtml += "<td>" + obj.writer + "</td>";
			  listHtml += "<td>" + obj.indate + "</td>";
			  listHtml += "<td>" + obj.count + "</td>";
			  listHtml += "</tr>";
			  
			  // 상세 게시글 보여주기
			  listHtml += "<tr id='c"+obj.idx+"' style='display:none;'>";
			  listHtml += "<td>내용</td>";
			  listHtml += "<td colspan='4'>";
			  listHtml += "<textarea id='ta"+obj.idx+"' readonly rows='7' class='form-control'>";
			  listHtml += "</textarea>";
			  
			  // 수정 삭제 버튼 추가
			  // EL문법을 자바스크립트 안에서 비교하려면 ""로 감싸줘야 함
			  if("${mvo.memID}" == obj.memID){
				  listHtml += "<br>";
				  listHtml += "<span id='ub"+obj.idx+"'>";
				  listHtml += "<button class='btn btn-sm btn-success' onclick='goUpdateForm("+obj.idx+")'>수정</button></span> &nbsp;";
				  listHtml += "<button class='btn btn-sm btn-warning' onclick='goDelete("+obj.idx+")'>삭제</button>";
			  }else{
				  listHtml += "<br>";
				  listHtml += "<span id='ub"+obj.idx+"'>";
				  listHtml += "<button disabled class='btn btn-sm btn-success' onclick='goUpdateForm("+obj.idx+")'>수정</button></span> &nbsp;";
				  listHtml += "<button disabled class='btn btn-sm btn-warning' onclick='goDelete("+obj.idx+")'>삭제</button>";
			  }
			  
			  listHtml += "</td>";
			  listHtml += "</tr>";
		  });
		  // 글쓰기 버튼 추가
		  if(${not empty mvo}){
			  listHtml += "<tr>";
			  listHtml += "<td colspan='5'>";
			  listHtml += "<button class='btn btn-primary btn-sm' onclick='goForm()'>";
			  listHtml += "글쓰기";
			  listHtml += "</button>";
			  listHtml += "</td>";
			  listHtml += "</tr>";
		  }
		  listHtml += "</table>";
		  
		  $("#view").html(listHtml);
		  goList();
		  
	  }
	   
	  // 글쓰기 버튼 눌렀을때 글 작성 부분 보여주는 함수
	  function goForm(){
		  $("#view").css("display","none");
		  $("#wform").css("display","block");
	  }
	                           
	  // 리스트 다시 보여주기
	  function goList(){
		  $("#view").css("display","block");
		  $("#wform").css("display","none");
	  }
	  
	  // 게시글 입력 기능
	  function goInsert(){
		  // 제목, 내용, 작성자를 DB에 입력
		  var fData = $("#frm").serialize();
		  console.log(fData);
		  
		  $.ajax({
			  url : "board/new",
			  type : "post",
			  data : fData,
			  success : loadList,
			  error : function(){ alert("error"); }
		  });		  
		  
		  $("#fclear").trigger("click");
		  
	  }
	  
	  // 게시글 상세보기 기능
	  function goContent(idx){
		  if($("#c"+idx).css("display") == "none"){
			  
			  $.ajax({
				  url : "board/"+idx,
				  type : "get",
				  dataType : "json",
				  success : function(data){
					  $("#ta"+idx).val(data.content);
				  },
				  error : function(){ alert("error"); }
			  });
			  
			  $("#c"+idx).css("display","table-row");
			  $("#ta"+idx).attr("readonly", true);
		  }else{
			  $("#c"+idx).css("display","none");
			  
			  $.ajax({
				  url : "board/count/"+idx,
				  type : "put",
				  success : loadList,
				  error : function(){ alert("error"); }
			  });
			  
			  
			  
		  }
	  }
	  
	  
	  // 게시글 삭제 기능
	  function goDelete(idx){
		  $.ajax({
				url : "board/"+idx,
				type : "delete",
				success : loadList,
				error : function(){ alert("error"); }
		  });
	  }
	  
	  // 게시글 수정화면 만들어주는 부분
	  function goUpdateForm(idx){
		  $("#ta"+idx).attr("readonly",false);
		  
		  // 제목을 input태그로 변경하기
		  var title = $("#t"+idx).text();
		  var newInput = "<input id='nt"+idx+"' value='"+title+"' type='text' class='form-control' >";
		  $("#t"+idx).html(newInput);
		  
		  // 수정하기 기능이 있는 버튼으로 변경
		  var newButton = "<button onclick='goUpdate("+idx+")' class='btn btn-sm btn-primary'>수정하기</button>";
		  $("#ub"+idx).html(newButton);
	  }
	  
	  // 게시글 수정 기능
	  function goUpdate(idx){
		  var title = $("#nt"+idx).val();
		  var content = $("#ta"+idx).val();
		  
		  $.ajax({
				url : "board/update",
				type : "put",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify({"idx" : idx, "title" : title, "content" : content}),
				success : loadList,
				error : function(){ alert("error"); }
		  });
		  
	  }
  
  </script>
</head>
<body>
 
	<div class="container">
	
	  <jsp:include page="../common/header.jsp"></jsp:include>
		
	  <h2>Spring MVC03</h2>
	  <div class="panel panel-default">
	    <div class="panel-heading">Board</div>
	    <div class="panel-body" id="view">

		</div>
		
		<!-- 글쓰기 폼 -->
		<div class="panel-body" style="display: none;" id="wform">
			<form id="frm">
				<input type="hidden" name="memID" value="${mvo.memID}">
				<table class="table">
					<tr>
						<td>제목</td>
						<td><input id="title" type="text" name="title" class="form-control"></td>					
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea id="content" class="form-control" name="content" rows="7" cols=""></textarea>
						</td>					
					</tr>
					<tr>
						<td>작성자</td>
						<td><input readonly="readonly" value="${mvo.memName}" id="writer" type="text" name="writer" class="form-control"></td>					
					</tr>
					<tr>
						<td align="center" colspan="2">
							<button class="btn btn-sm btn-success" type="button" onclick="goInsert()">등록</button>
							<button class="btn btn-sm btn-warning" type="reset" id="fclear">취소</button>
							<button class="btn btn-sm btn-info" type="button" onclick="goList()">리스트로가기</button>
						</td>
					</tr>
				</table>			
			</form>
		</div>


	    <div class="panel-footer">스프링게시판-박병관</div>
	  </div>
	</div>

</body>
</html>




