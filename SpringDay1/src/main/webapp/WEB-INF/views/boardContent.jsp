<%@page import="com.smhrd.entity.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<% pageContext.setAttribute("line", "\n"); %>

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
					<tr>
						<td>제목</td>
						<td>${vo.title}</td>
						
					</tr>
					<tr>
						<td>내용</td>
						<td>${fn:replace(vo.content, line, "<br>")}</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>${vo.writer}</td>
					</tr>
					<tr>
						<td>작성일</td>
						   <td>${fn:split(vo.indate," ")[0]}</td>
					</tr>
					
				<tr>
					<td colspan="2" align="center">
						<a href="boarList.do" class="btn btn-info btn-sm"> 돌아가기</a>
						<a href="boardUpdateForm.do?idx=${vo.idx}" class="btn btn-danger btn-sm">수정화면</a>
						<a href="boardDelete.do?idx=${vo.idx}" class="btn btn-warning btn-sm">삭제</a>				
					</td>
				
				
				
				</table>
	    </div>
	    <div class="panel-footer">스프링 - 박병관</div>
	  </div>
	</div>
</body>
</html>




