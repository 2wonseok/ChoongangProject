<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

</style>

<title>게시물 수정</title>


</head>
<body>

<u:mainNav/>
<div class="container">
	<section id="container">
	<h3>게시물 수정</h3>
			<form id="modify-form" action="${root }/qa/modify" enctype="multipart/form-data" method="post">
				<!-- 게시물 번호 히든 처리 -->
				<input type="hidden" name="qa_seq" value="${board.qa_seq }" type="text" class="form-control"/>
				<!-- 게시물 수정시 기존의 값이 공개 일경우 라디오버튼이 공개에 체크 되어있도록(라디오) -->
				<c:if test="${board.qa_secret == '공개' }">
					<input class="btn-check" id="open" name="qa_secret" value="공개" type="radio" checked/>
						<label class="btn btn-secondary" for="open">공개</label>
					<input class="btn-check" id="close" name="qa_secret" value="비공개" type="radio"/>
						<label class="btn btn-secondary" for="close">비공개</label>
				</c:if>
				<!-- 게시물 수정시 기존의 값이 비공개 일경우 라디오버튼이 비공개에 체크 되어있도록(라디오) -->				
				<c:if test="${board.qa_secret == '비공개' }">
					<input id="open" name="qa_secret" value="공개" type="radio"/>
						<label class="btn btn-secondary" for="open">공개</label>
					<input id="close" name="qa_secret" value="비공개" type="radio" checked/>
						<label class="btn btn-secondary" for="close">비공개</label>
				</c:if>
				<!-- 라디오 버튼이라 비어있을 경우는 없지만 -->
				<c:if test="${errors.noSecret }">
					<small class="form-text text-danger">
						공개 여부를 선택해주세요.
					</small>
				</c:if>	
				<!-- 기존 질문 분류의 값을 가져옴. 질문 선택(셀렉트) -->
				<div class="input-group mb-3">
				<label class="input-group-text" for="select_category">질문 선택</label>
					<select id="select_category" class="form-select" name="qa_category">
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
				<!-- 값이 비어있는 경우 -->
				<c:if test="${errors.noCategory }">
					<small class="form-text text-danger">
						질문 종류를 선택 해주세요.
					</small>
				</c:if>
			<!-- 기존 제목을 불러옴 -->		
		    <label for="input1">제목</label>
		    	<input class="form-control" value='<c:out value="${board.qa_title }" />' name="qa_title" type="text" id="input1" placeholder="제목을 입력 하세요.">
					<c:if test="${errors.noTitle }">
						<small class="form-text text-danger">
							제목이 비어있습니다. (기존 제목을 불러옵니다)
						</small>
					</c:if><br>		
			<!-- 기존 내용을 불러옴 -->  	
		    <label for="textarea1">내용</label>
		    	<textarea class="form-control" name="qa_content" id="textarea1" rows="3" placeholder="내용을 입력 하세요."><c:out value="${board.qa_content }" /></textarea>
		   		    <c:if test="${errors.noContent }">
						<small class="form-text text-danger">
						내용이 비어있습니다. (기존 내용을 불러옵니다)
						</small>
					</c:if><br>		  	
		  	<!-- 이미지 첨부 -->
		    <input type="text" value="${preFileNames }" name ="preFileNames" hidden="hidden">							
				<div class = "input_wrap">
					<input type="file" name="upload" id="input_imgs" multiple="multiple" accept="image/*"/>
				</div>
				<div class="imgs_wrap">
					<c:forEach items="${qafileNameList }" var="qa_img">	
						<div>
							<img width="200" height="200" src="${root }/resources/qaboard/upload/${qa_img }"/>
						</div>
					</c:forEach>
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

			var html = "<div><img width=\"100\" src=\""+e.target.result+"\"></div>";
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
			
	<button type="submit" id="btn_add">글 수정</button>
		  	
		  	
		</form>
	</section>
</div>
<u:footer/>
</body>
</html>