<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<div class="container-sm">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<h1>게시물 보기</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">


				<!-- 같은경로 라서 action="" 를 생략할수있음  -->
				<div class="form-group">
					<label for="input3">#번호</label> <input readonly
						value="${RevBoard.rev_seq }" type="text" class="form-control" id="input3" />
				</div>
				<div class="form-group">
					<label for="input4">카테고리</label> <input readonly
						value="${RevBoard.rev_category }" type="text" class="form-control" id="input4" />
				</div>
				<div class="form-group">
					<label for="input5">파일이름</label> <input readonly
						value="${RevBoard.rev_filename }" type="text" class="form-control" id="input5" />
				</div>
				<div class="form-group">
					<label for="input1">제목</label> <input readonly
						value='<c:out value= "${RevBoard.rev_title }"/>' type="text"
						class="form-control" id="input1" placeholder="제목을 입력하세요.">
				</div>

				<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea readonly class="form-control" id="textarea1" rows="3"><c:out
							value="${RevBoard.rev_content }" /></textarea>
				</div>
				 
				<div class="form-group">
						<label for="input6">조회수</label> <input  name="rev_readcnt"
							value="${RevBoard.rev_readCnt }" type="text" class="form-control"
							id="input6" readonly/>
					</div>

				<div class="form-group">
					<label for="input2">작성자</label> <input readonly
						value="${RevBoard.rev_writer }" type="text" class="form-control"
						id="input2">
				</div>
				
				<div class="form-group">
						<label for="input6">작성일</label> <input  name="rev_category"
							value="${RevBoard.rev_regdate }" type="text" class="form-control"
							id="input6"  readonly/>
					</div>
			</div>
		</div>
		<a href="${root}/rev/modify?rev_seq=${RevBoard.rev_seq}">글수정</a>
	</div>
</body>
</html>