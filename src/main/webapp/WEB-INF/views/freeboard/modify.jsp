<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

 <script>
$(document).ready(function() {
	$("#remove-btn").click(function(e) {
		e.preventDefault();
		// #modify-form의 action attr값을 바꿔야함.
				
		$("#modify-form").attr("action", "${root}/freeboard/remove");
		
		$("#modify-form").submit();
	})
})
</script> 


<title>Insert title here</title>
</head>
<body>

	<u:navbar></u:navbar>
	
<div class="container-sm">
	<div class="row">
		<div class="col-12 col-lg-6 offset-lg-3">
			<h1>게시물 수정</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-12 col-lg-6 offset-lg-3">		
	<%-- 
		<form action="${pageContext.request.contextPath }/board/register">
	 --%>	
	<form id="modify-form" method="post" action="${root }/freeboard/modify">
	
			<div class="form-group">
	 		<label for="input3">번호</label>
	 		<input name="free_seq" class="form-control" id="input3" readonly value="${freeboard.free_seq }">
	 		</div>

			<div class="form-group">
		    <label for="input1">제목</label>
		    <input value='<c:out value="${freeboard.free_title }" />' name="free_title" type="text" class="form-control" id="input1" placeholder="제목을 입력 하세요.">
		  	</div>		  	
		  	
		  	<div class="form-group">
		    <label for="textarea1">내용</label>
		    <textarea name="free_content" class="form-control" id="textarea1" rows="3"><c:out value="${freeboard.free_content }" /></textarea>
		    
		  	</div>
		  	
		  	<div class="form-group">
		    <label for="input2">작성자</label>
		    <input readonly value='<c:out value="${freeboard.free_writer }" />' name="free_writer" type="text" class="form-control" id="input2" placeholder="이름을 입력하세요">
		  	</div>
		  	
			<%-- <input type="hidden" value="${criteria.pageNum }" name="pageNum">
			<input type="hidden" value="${criteria.amount }" name="amount">
 			<input type="hidden" value="${criteria.type }" name="type">
			<input type="hidden" value="${criteria.keyword }" name="keyword"> --%>
		  	<button type="submit" class="btn btn-primary">게시물 수정</button>
		  	
		</form>
			</div>
		</div>
	</div>


</body>
</html>