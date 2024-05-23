<%@page import="com.smhrd.entity.BookVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	  <h2>보유 도서 현황</h2>
	  <div class="panel panel-primary">
	    <div class="panel-heading">Book</div>
	    <div class="panel-body">
			<table class="table table-hover">
				<thead>
					<tr class = "warning">
						<th>번호</th>
						<th>제목</th>
						<th>작가</th>
						<th>출판사</th>
						<th>ISBN</th>
						<th>보유도서</th>
					</tr>
				</thead>
				
				<tbody>
					<!-- BookController에서 받아온 리스트를 아래에 출력 -->
					<c:forEach var="vo" items="${list}">
						<tr>
							<td>${vo.num}</td>
							<td><a href="bookList.do?idx=${vo.num}"><c:out value="${vo.title}"></c:out></a></td>
							<td>${vo.author}</td>
							<td>${vo.company}</td>
							<td>${vo.isbn}</td>
							<td>${vo.cnt}</td>
						</tr>
					</c:forEach>
				</tbody>
				
			
				</thead>
			</table>	
			
			
			<h2>도서 입력</h2>
			<form action="bookInsert.do" method="post">
				<table class="table table-hover">
	
					<tr>
						<td>제목</td>
						<td><input required="required" class="form-control" type="text" name="title"></td>
					</tr>
					<tr>
						<td>작가</td>
						<td><input required="required" class="form-control" type="text" name="author"></td>
					</tr>
					<tr>
						<td>출판사</td>
						<td><input required="required" class="form-control" type="text" name="company"></td>
					</tr>
					<tr>
						<td>ISBN</td>
						<td><input required="required" class="form-control" type="text" name="isbn"></td>
					</tr>
					<tr>
						<td>보유도서수</td>
						<td><input required="required" class="form-control" type="number" name="cnt"></td>
					</tr>
					
					<tr>
						<td>
							<button type="submit" class="btn">등록</button>
						</td>
					</tr>
				</table>
			</form>	    	    



	</div>

  </div>
</div>

	
</body>
</html>