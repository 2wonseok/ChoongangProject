<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
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

<title>Insert title here</title>
</head>
<body>

	<u:mainNav></u:mainNav>

	<div class="container-sm">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<h1>게시물 수정</h1>
			</div>
		</div>

		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<form id="modify-form" method="post"
					action="${root }/freeboard/modify">

					<div class="form-group">
						<label for="input3">번호</label> <input name="free_seq"
							class="form-control" id="input3" readonly
							value="${freeVO.free_seq }">
					</div>

					<div class="form-group">
						<label for="input1">제목</label> <input
							value='<c:out value="${freeVO.free_title }" />' name="free_title"
							type="text" class="form-control" id="input1"
							placeholder="제목을 입력 하세요." required="required" maxlength="15" >
					</div>

					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea name="free_content" class="form-control" id="textarea1"
							rows="3" required="required" maxlength="200"><c:out value="${freeVO.free_content }" /></textarea>

					</div>

					<div class="form-group">
						<label for="input2">닉네임</label> <input readonly
							value='<c:out value="${freeVO.free_nickname }" />'
							name="free_nickname" type="text" class="form-control" id="input2"
							placeholder="이름을 입력하세요">
					</div>

					<input type="hidden" value="${criteria.pageNum }" name="pageNum">
					<input type="hidden" value="${criteria.amount }" name="amount">
					<input type="hidden" value="${criteria.type }" name="type">
					<input type="hidden" value="${criteria.keyword }" name="keyword">
					<button type="submit" class="btn btn-primary">수정</button>
					<a href="${root}/freeboard/list" >목록</a>
				</form>
			</div>
		</div>
	</div>

<%-- <u:footer/> --%>
</body>
</html>