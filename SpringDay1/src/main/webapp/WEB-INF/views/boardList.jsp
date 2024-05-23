<%@page import="com.smhrd.entity.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div class="container">
	  <h2>Spring Day1</h2>
	  <div class="panel panel-warning">
	    <div class="panel-heading">Board</div>
	    <div class="panel-body">
	    		<table class="table table-bordered table-hover">
					<thead>
						<tr class="warning">
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<!-- BoardController에서 받아온 게시판 리스트를 아래에 출력 -->
						<c:forEach var="vo" items="${list}">
			            <tr>
			               <td>${vo.idx}</td>
			               <td><a href="boardContent.do?idx=${vo.idx}"><c:out value="${vo.title}"></c:out> </a></td>
			               <td>${vo.writer}</td>
			               <td>${fn:split(vo.indate," ")[0]}</td>
			               <td>${vo.count}</td>
			            </tr>
			         </c:forEach>
					</tbody>
				</table>
				<a class="btn btn-warning btn-sm" href="boardForm.do">글쓰기</a>
	    </div>
	    <div class="panel-footer">스프링 - 박병관</div>
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
      <div class="modal-body">
        게시글이 등록되었습니다 :D
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		
		let result = '${result}';
		
		if(result == 'ok'){
			$('#myModal').modal("show");
		}
		
	});
	
	</script>
	
	
	
</body>
</html>




