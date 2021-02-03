<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="container-sm">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<h1>게시물 보기</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">

				 <div class="form-group">
					<label for="input3">번호</label> <input class="form-control"
						type="text" id="input3" readonly value="${freeboard.free_seq }" />
				</div> 

				<div class="form-group">
					<label for="input1">제목</label> <input readonly
						value='<c:out value="${freeboard.free_title }" />' type="text"
						class="form-control" id="input1">
				</div>

				<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea readonly class="form-control" id="textarea1" rows="3">
					<c:out value="${freeboard.free_content }" /></textarea>
				</div>

				<div class="form-group">
					<label for="input2">작성자</label> <input readonly
						value='<c:out value="${freeboard.free_writer }" />' type="text"
						class="form-control" id="input2">
				</div>
					<div class="form-group">
					<label for="input3">작성일</label> <input readonly
						value='<c:out value="${freeboard.free_regdate }" />' type="text"
						class="form-control" id="input3">
				</div>
				<a href="${root }/freeboard/modify" class="btn btn-secondary">
					수정 </a>
			</div>
		</div>
	</div>
</body>
</html>