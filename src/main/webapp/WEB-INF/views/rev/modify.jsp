<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
 
		// #modify-form 의 action attr 값을 바꿔야함.

		$("#modify-form").attr("action", "${root}/rev/remove")

		$("#modify-form").submit();
	});
});
	
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="container-sm">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<h1>게시물 수정</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
			


				<form id="modify-form" action="${root }/rev/modify" method="post">
					<!-- 같은경로 라서 action="" 를 생략할수있음  -->
					<div class="form-group">
						<label for="input3">#번호</label> <input readonly name="rev_seq"
							value="${RevBoard.rev_seq }" type="text" class="form-control"
							id="input3" />
					</div>
					<div class="form-group">
						<label for="input4">카테고리</label> <input  name="rev_category"
							value="${RevBoard.rev_category }" type="text" class="form-control"
							id="input4" />
					</div>
					
					<div class="form-group">
						<label for="input5">파일이름</label> <input  name="rev_filename"
							value="${RevBoard.rev_filename }" type="file" class="form-control"
							id="input5" />
					</div>

					<div class="form-group">
						<label for="input1">제목</label> <input
							value='<c:out value = "${RevBoard.rev_title }"/>' name=rev_title type="text"
							class="form-control" id="input1" placeholder="제목을 입력하세요.">
					</div>

					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea name="rev_content" class="form-control" id="textarea1"
							rows="3"><c:out value="${RevBoard.rev_content }" /></textarea>
					</div>
					
					<div class="form-group">
						<label for="input6">조회수</label> <input  name="rev_category"
							value="${RevBoard.rev_readCnt }" type="text" class="form-control"
							id="input6"  readonly/>
					</div>
					

					<div class="form-group">
						<label for="input7">작성자</label> <input name="rev_writer"
							value='<c:out value="${RevBoard.rev_writer }"/>' type="text"
							class="form-control" id="input7" readonly>
					</div>
										
					
					<div class="form-group">
						<label for="input8">수정일</label> <input  name="rev_category"
							value="${RevBoard.rev_updatedate }" type="text" class="form-control"
							id="input8" readonly />
					</div>

					<%-- <input type="hidden" value="${cri.pageNum }" name="pageNum" /> 
					<input type="hidden" value="${cri.amount }" name="amount" /> 
					<input type="hidden" value="${cri.type }" name="type" /> 
					<input type="hidden" value="${cri.keyword }" name="keyword" /> --%>
					<button type="submit" class="btn btn-primary">글 수정</button>
					<button id="remove-btn" type="submit" class="btn btn-danger">글
						삭제</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>