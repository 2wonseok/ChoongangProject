<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	#btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}
</style>
<script>
	var appRoot = '${root}'; // 자바스크립트 코드에서 contextPath를 쓰기위해 선언.
	var rev_seq = ${RevBoard.rev_seq};
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
<script src="${root }/resources/rev_js/rev.js"></script>
<script>
	$(document).ready(function() {
		$("#goodbtn").click(function() {
			revService.goodAdd(rev_seq , function(data) {
				console.log(data);
			});
		})
	})
	
</script>
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
					<label for="input1">#번호</label> <input readonly
						value="${RevBoard.rev_seq }" type="text" class="form-control" id="input1" />
				</div>
				<div class="form-group">
					<label for="input2">카테고리</label> <input readonly
						value='<c:if test="${RevBoard.rev_category eq 1}">모자</c:if><c:if test="${RevBoard.rev_category eq 2}">신발</c:if><c:if test="${RevBoard.rev_category eq 3}">상의</c:if><c:if test="${RevBoard.rev_category eq 4}">하의</c:if>' type="text" class="form-control" id="input2" />
						
				</div>
				<div class="form-group">
					<label for="input3">파일이름</label> <input readonly
						value="${RevBoard.rev_filename }" type="text" class="form-control" id="input3" />
						<img alt="noImg" src="${root }/resources/upload/${RevBoard.rev_filename}">
				</div>
				<div class="form-group">
					<label for="input4">제목</label> <input readonly
						value='<c:out value= "${RevBoard.rev_title }"/>' type="text"
						class="form-control" id="input4" placeholder="제목을 입력하세요.">
				</div>

				<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea readonly class="form-control" id="textarea1" rows="3"><c:out
							value="${RevBoard.rev_content }" /></textarea>
				</div>
				 
				<div class="form-group">
						<label for="input5">조회수</label> <input  name="rev_readcnt"
							value="${RevBoard.rev_readCnt }" type="text" class="form-control"
							id="input5" readonly/>
					</div>

				<div class="form-group">
					<label for="input6">작성자</label> <input readonly
						value="${RevBoard.rev_writer }" type="text" class="form-control"
						id="input6">
				</div>
				
				<div class="form-group">
					<label for="input7">좋아요</label> <input readonly
						value="${RevBoard.rev_good }" type="text" class="form-control" id="input7" />
				</div>
				
				<div class="form-group">
					<label for="input8">싫어요</label> <input readonly
						value="${RevBoard.rev_hate }" type="text" class="form-control" id="input8" />
				</div>
				
				<div class="form-group">
						<label for="input9">작성일</label> <input  name="rev_regdate"
							value="${RevBoard.rev_regdate }" type="text" class="form-control"
							id="input9"  readonly/>
					</div>
			</div>
			
		</div>
		<a id="btn_add" class="btn btn-secondary"  href="${root}/rev//get/hate?rev_seq=${RevBoard.rev_seq}">싫어요!</a>
		<a id="goodbtn" class="btn btn-secondary"  href="${root}/rev/get/like?rev_seq=${RevBoard.rev_seq}">좋아요!</a>
		<a id="btn_add" class="btn btn-secondary"  href="${root}/rev/modify?rev_seq=${RevBoard.rev_seq}">글수정</a>
		<a id="btn_add" class="btn btn-secondary"  href="${root}/rev/list">목록으로</a>
	</div>
</body>
</html>