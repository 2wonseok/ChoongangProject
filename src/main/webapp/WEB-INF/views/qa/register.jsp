<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<style>
#btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #4a4a4a;
    padding: 0px 30px;
    margin: 0px;
    line-height: 40px;
    float: right;
    width: 120px;
	height : 40px;
	border-radius: 3px;
	text-align: center;
}
#container {
    clear: both;
    position: relative;
    margin: 35px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
}


</style>

<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<title> 질문과 답변 글쓰기</title>

</head>
<body>
<script>

</script>

<u:mainNav/>
<div class="container">
	<section id="container">
	<h3>질문 답변 글쓰기</h3>
		<!-- <div class="col-12 col-lg-6 offset-lg-3"> -->
			<form action="${root }/qa/register" method="post" enctype="multipart/form-data">
				<!-- 게시물의 공개, 비공개 상태 선택 (라디오) -->
				<input class="btn-check" id="open" name="qa_secret" value="공개" type="radio" checked/> 
					<label class="btn btn-secondary" for="open">공개</label>
				<input class="btn-check" id="close" name="qa_secret" value="비공개" type="radio"/>
					<label class="btn btn-secondary" for="close">비공개</label>
				<!-- 공개, 비공개 값이 비어있는 경우 -->
				<c:if test="${errors.noSecret }">
					<small class="form-text text-danger">
						공개 여부를 선택해주세요.
					</small>
				</c:if>	
				<!-- 질문 분류 선택 (셀렉트) -->
				<div class="input-group mb-3">
				<label class="input-group-text" for="select_category">질문 선택</label>
					<select id="select_category" class="form-select" name="qa_category">
						<option value="">질문 분류 선택</option>
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
				<!-- 질문분류 값이 비어있는 경우 -->
				<c:if test="${errors.noCategory }">
					<small class="form-text text-danger">
						질문 분류를 선택 해주세요.
					</small>
				</c:if>	
				
				<!-- 제목 -->
				<input maxlength="25" class="form-control" type="text" name="qa_title" value="${title }" placeholder="제목"/>	
					<!-- 제목이 비어있을 경우 -->
					<c:if test="${errors.noTitle }">
						<small class="form-text text-danger">
							제목을 입력 해주세요.
						</small>
					</c:if>	
					<c:if test="${errors.noSpace_title }">
						<small class="form-text text-danger">
							제목이 공백 상태입니다.
						</small>
					</c:if>	
				<br>
				<!-- 내용 -->
				<textarea class="form-control" name="qa_content" cols="30" rows="10" placeholder="내용" >${content }</textarea>
					<!-- 내용이 비어 있을경우 -->
					<c:if test="${errors.noContent }">
						<small class="form-text text-danger">
							내용을 입력 해주세요.
						</small>
					</c:if>	 
					<c:if test="${errors.noSpace_content }">
						<small class="form-text text-danger">
							내용이 공백 상태 입니다.
						</small>
					</c:if>	
					<br>
				<!-- 작성자 값 히든처리 -->
				<input type="hidden" type="text" name="qa_writer" value="${authUser.user_nickname }"/>	
	
				<!--이미지첨부시작  -->
				<div class="input-group mb-3">
					<label class="input-group-text" for="input_imgs">이미지</label>
					<input class="form-control" type="file" name="upload" id="input_imgs" multiple="multiple" accept="image/*" value="${filename }"/>
				</div>
				
				<!-- 파일 선택시 미리 보여짐 -->
				<div class="imgs_wrap">
					<img id="img"/>
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
			
				<input type="submit" value="글 등록" id="btn_add">	
			</form> 
		<!-- </div> -->
	</section>	
</div>
<u:footer/>
</body>
</html>