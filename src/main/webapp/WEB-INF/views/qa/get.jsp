<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<script>
var appRoot = '${root}';
var seq = ${board.qa_seq};
</script>
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
<script src="${root }/resources/js/reply.js"></script>

<title>게시물 보기</title>

</head>
<body>

	<u:navbar></u:navbar>

	
<div class="container-sm">
	<div class="row">
		<div class="col-12 col-lg-6 offset-lg-3">
			<h1>게시물 보기</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-12 col-lg-6 offset-lg-3">		
	<%-- 
		<form action="${pageContext.request.contextPath }/board/register">
	 --%>	

	 	<div class="form-group">
	 		<label for="input1">번호</label>
	 		<input class="form-control" id="input1" readonly value="${board.qa_seq }">
	 	</div>
	 	
	 	<div class="form-group">
	 		<label for="input2">질문 종류</label>
	 		<input class="form-control" id="input2" readonly value="${board.qa_category }">
	 	</div>
	 	
	 	
	 	<div class="form-group">
	 		<label for="input3">작성 시간</label>
	 		<input class="form-control" id="input3" readonly value="${board.qa_regdate }">
	 		
	 		<fmt:formatDate pattern="yyyy년 MM월 dd일 h시m분" value="${board.qa_regdate}" />
	 	</div>
	 	
	 	<div class="form-group">
	 		<label for="input4">수정 시간</label>
	 		<input class="form-control" id="input4" readonly value="${board.qa_updatedate }">
	 	</div>
	 	
			<div class="form-group">
		    <label for="input5">제목</label>
		    <input readonly value='<c:out value="${board.qa_title }" />' type="text" class="form-control" id="input5">
		  	</div>		  	
		  	
		  	<div class="form-group">
		    <label for="textarea1">내용</label>
		    <textarea readonly class="form-control" id="textarea1" rows="3" id="input6"><c:out value="${board.qa_content }" /></textarea>
		    
		  	</div>
		  	
		  	<div class="form-group">
		    <label for="input6">작성자</label>
		    <input readonly value='<c:out value="${board.qa_writer }" />' type="text" class="form-control" id="input7">
		  	</div>
		  <%-- 	
		  	<c:url value="/board/modify" var="modifyLink">
		  		<c:param name="qa_seq" value="${board.qa_seq }" />
		  		<c:param name="pageNum" value="${criteria.pageNum }" />
		  		<c:param name="amount" value="${criteria.amount }" />
		  		<c:param name="type" value="${criteria.type }" />
		  		<c:param name="keyword" value="${criteria.keyword }" />
		  	</c:url>
		  	<a href="${modifyLink }" class="btn btn-secondary">수정 , 삭제</a>
 --%>
		  	<a href="${root }/qa/modify?qa_seq=${board.qa_seq }">수정</a>
		  
			<a href="${root }/qa/remove?qa_seq=${board.qa_seq }">삭제</a>
			</div>
		</div>
	</div>
	
	
</body>
</html>