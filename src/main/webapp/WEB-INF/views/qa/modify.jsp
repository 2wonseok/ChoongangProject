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
<style>
select {
width: 170px;
height : 30px;
border: 1px solid #D3D3D3;
border-radius: 0px;
}
</style>

<title>게시물 수정</title>


</head>
<body>

<u:mainNav/>
<h1>게시물 수정</h1>
<div class="container-sm">
	<div class="row">
		<div class="col-12 col-lg-6 offset-lg-3">
			<form id="modify-form" action="${root }/qa/modify" enctype="multipart/form-data" method="post">
				
				<div class="form-group">
						<input type="hidden" name="qa_seq" value="${board.qa_seq }" type="text" class="form-control"	/>
				</div>
				
				<c:if test="${board.qa_secret == '공개' }">
					<input id="open" name="qa_secret" value="공개" type="radio" checked/>
						<label for="open">공개 (누구나 열람 가능)</label> <br>
					<input id="close" name="qa_secret" value="비공개" type="radio"/>
						<label for="close">비공개 (본인과 관리자만 열람 가능)</label>
				</c:if>
				
				<c:if test="${board.qa_secret == '비공개' }">
					<input id="open" name="qa_secret" value="공개" type="radio"/>
						<label for="open">공개 (누구나 열람 가능)</label> <br>
					<input id="close" name="qa_secret" value="비공개" type="radio" checked/>
						<label for="close">비공개 (본인과 관리자만 열람 가능)</label>
				</c:if>
				
				<c:if test="${errors.noSecret }">
					<small class="form-text text-danger">
						공개 여부를 선택해주세요.
					</small>
				</c:if>	
				
				<div class="form-group">
					<select name="qa_category">
						<option value='<c:out value="${board.qa_category }" />'>${board.qa_category }</option>
					    <option value="회원 ">회원</option>
					    <option value="게시판">게시판</option>
					    <option value="결제">결제</option>
					    <option value="상품">상품</option>
					    <option value="리뷰">리뷰</option>
					    <option value="배송">배송</option>
					    <option value="환불">환불</option>
					    <option value="업체">업체</option>		    
					    <option value="기타">기타</option>    
					</select>
				</div>
			
				<c:if test="${errors.noCategory }">
					<small class="form-text text-danger">
						질문 종류를 선택 해주세요.
					</small>
				</c:if>
			
			<br>
					
		    <label for="input1">제목</label>
		    <input class="form-control" value='<c:out value="${board.qa_title }" />' name="qa_title" type="text" id="input1" placeholder="제목을 입력 하세요.">
			
			<c:if test="${errors.noTitle }">
			<small class="form-text text-danger">
			제목을 작성 해주세요.
			</small>
			</c:if>
		  	<br>
		  	
		    <label for="textarea1">내용</label>
		    <textarea class="form-control" name="qa_content" id="textarea1" rows="3" placeholder="내용을 입력 하세요."><c:out value="${board.qa_content }" /></textarea>
		    
		    <c:if test="${errors.noContent }">
			<small class="form-text text-danger">
			내용을 작성 해주세요.
			</small>
			</c:if>
		  	<br>		  	
		  	
		    <input readonly value='<c:out value="${board.qa_writer }" />' name="qa_writer" type="text" id="input2" placeholder="이름을 입력하세요">
		    
		    
		    <br>		  
		  	파일 이름 :
		  	<!-- 게시글 등록시 저장된 파일네임 값 가져오기 -->
		  	<input type="text" value="${board.qa_filename }" name ="preFileNames" > 
		  	
		  	
		  	<div class="input_wrap">
			<input type="file" name="upload" id="input_imgs" multiple="multiple" accept="image/*" />
			</div>
	
			<div class="imgs_wrap">
				<img id="img" />
			</div>

	<script>
		$("#input_imgs").on("change", handleImgFileSelect);

		//이미지셀렉트
		function handleImgFileSelect(e) {
		//이미지 정보를 초기화
		$(".imgs_wrap").empty();

			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);

			filesArr.forEach(function(f) {
				if (!f.type.match("image.*")) {

				var message = "그림파일형식만 허용됩니다";
				function checkModal(message) {
				if (message && history.state == null) {
					$("#myModal .modal-body p").html(message)
					$("#myModal").modal("show");
					}
				}
				checkModal(message);

				return;
			}

			var reader = new FileReader();
			reader.onload = function(e) {

			var html = "<div><img width=\"200\" src=\""+e.target.result+"\"></div>";
			$(".imgs_wrap").append(html);

					}
					reader.readAsDataURL(f);
				});
			}
	</script>
		  	
	<input type="hidden" value="${criteria.pageNum }" name="pageNum">
	<input type="hidden" value="${criteria.amount }" name="amount">
	<input type="hidden" value="${criteria.type }" name="type">
	<input type="hidden" value="${criteria.keyword }" name="keyword">
			
	<button type="submit">게시물 수정</button>
		  	
		  	
		</form>
	</div>
	</div>
</div>
</body>
</html>