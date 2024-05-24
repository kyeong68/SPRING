<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
  		if(${not empty msgType}){
  			if(${msgType eq "실패 메세지"}){
  				$("#messageType").attr("class", "modal-content panel-warning");
  			}
  			$("#myMessage").modal("show");
  		}
  	});
  
  </script>
</head>
<body>
 
	<div class="container">
	<jsp:include page="../common/header.jsp"></jsp:include>
	  <h2>Spring MVC03</h2>
	  <div class="panel panel-default">
	    <div class="panel-heading">프로필사진등록</div>
	    <div class="panel-body">
	    
			<!-- enctype
	    		1) application/x-www-form-urlencoded
	    			-> form태그 안에서 보내는 요청데이터를 Key값과 Value값으로 보냄
	    		2) multipart/form-data
	    		 	-> 사진파일과 같이 용량이 큰 데이터를 보낼 때 사용 -->
	    	<form action="${contextPath}/imageUpdate.do" method="post" enctype="multipart/form-data">
			<table class="table table-bordered" style="text-align: center; border : 1px solid #dddddd">
				<tr>
					<td style="width: 110px; vertical-align: middle;">아이디</td>
					<td>
						${mvo.memID}
					</td>
				</tr>
				
				<tr>
					<td style="width: 110px; vertical-align: middle;">사진업로드</td>
					<td>
						<span class="btn btn-default"> <!-- default -> 무색 -->
							이미지를 업로드하세요.
							<input type="file" name="memProfile">
						</span>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align: left;">
						<input type="submit" class="btn btn-primary btn-sm pull-right" value="등록">
						<input type="reset" class="btn btn-warning btn-sm pull-right" value="취소">
					</td>
				</tr>
				
			</table>
			</form>
		</div>
	    <div class="panel-footer">스프링게시판-이주희</div>
	  </div>
	</div>
	
	
	<!-- 다이얼로그창(모달) -->
	<!-- 회원가입 실패시 나오게될 모달창 -->
	<!-- Modal -->
	  <div class="modal fade" id="myMessage" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div id="messageType" class="modal-content panel-info">
	        <div class="modal-header panel-heading">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">${msgType}</h4>
	        </div>
	        <div class="modal-body">
	          <p id="">${msg}</p>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	    </div>
	  </div>
	
	
	<!-- Modal -->
	  <div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div id="checkType" class="modal-content panel-info">
	        <div class="modal-header panel-heading">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">메세지 확인</h4>
	        </div>
	        <div class="modal-body">
	          <p id="checkMessage"></p>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	    </div>
	  </div>
</body>
</html>




