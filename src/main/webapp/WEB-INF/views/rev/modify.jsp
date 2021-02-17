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
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
    }
    
    #remove-btn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
    }
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
<script>
$(document).ready(function() {
	$("#remove-btn").click(function(e) {
		e.preventDefault();
 
		// #modify-form 의 action attr 값을 바꿔야함.

		$("#modify-form").attr("action", "${removeLink}");

		$("#modify-form").submit();
	});
});
	
</script>
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
			<c:url value="${root }/rev/modify" var="modifyLink">
					<c:param name="rev_seq" value="${RevBoard.rev_seq }" />
					<c:param name="pageNum" value="${cri.pageNum }" />
					<c:param name="amount" value="${cri.amount }" />
					<c:param name="type" value="${cri.type }"/>
					<c:param name="keyword" value="${cri.keyword }"/>
				</c:url>
			
			<c:url value="${root }/rev/remove" var="removeLink">
					<c:param name="rev_seq" value="${RevBoard.rev_seq }" />
					<c:param name="pageNum" value="${cri.pageNum }" />
					<c:param name="amount" value="${cri.amount }" />
					<c:param name="type" value="${cri.type }"/>
					<c:param name="keyword" value="${cri.keyword }"/>
				</c:url>

				<form id="modify-form" action="${modifyLink }" method="post"
				enctype="multipart/form-data">
					<!-- 같은경로 라서 action="" 를 생략할수있음  -->
					<div class="form-group">
						<label for="input1">#번호</label> <input readonly name="rev_seq"
							value="${RevBoard.rev_seq }" type="text" class="form-control"
							id="input1" />
					</div>
					<div class="form-group">
						
						<label for="input2">카테고리</label> <%-- <input  name="rev_category"
							value="${RevBoard.rev_category }" type="text" class="form-control"
							id="input2" /> --%>
							<select name="rev_category" >
								<option value="${RevBoard.rev_category }">카테고리 선택</option>
								<option value="1">모자</option>
								<option value="2">신발</option>
								<option value="3">상의</option>
								<option value="4">하의</option>
							</select>
							<c:if test="${errors.noCategory }">
							<small class="form-text text-muted">
								카테고리를 입력하세요
							</small>
						</c:if>
					</div>
	
					
					<div class="form-group">
						<%--<label for="input3">파일이름</label> <input  name="upload"
							value="${RevBoard.rev_filename }" type="file" class="form-control"
							id="input3" /> --%>
							<!--이미지첨부시작  -->
							<label for="input3">파일이름</label>
							<input type="text" value="${preFileNames }" name ="preFileNames" hidden="hidden">							
							<div class = "input_wrap">
								 <input type="file" name="upload" id="input_imgs" multiple="multiple" accept="image/*"/>
							</div>
							<div class="imgs_wrap">
								<c:forEach items="${fileNamesList }" var="product_img">	
									<div>
										<img width="500" src="${root }/resources/upload/${product_img }"/>
									</div>
								</c:forEach>
							</div>
							<script>
							  
							  $("#input_imgs").on("change", handleImgFileSelect);

							  //이미지셀렉트
							  function handleImgFileSelect(e){
									//이미지 정보를 초기화
									$(".imgs_wrap").empty();
									
									var files = e.target.files;
									var filesArr = Array.prototype.slice.call(files);
								
									filesArr.forEach(function(f){
										if(!f.type.match("image.*")){
											
											// 이전에 쓰던 모달창 복붙한거로나오게
											var message = "그림파일형석만 허용됩니다";
											function checkModal(message){
												if (message && history.state == null) {
													$("#myModal .modal-body p").html(message)
													$("#myModal").modal("show");
												}
											}
											checkModal(message);
											
											return;
										}
										
										var reader = new FileReader();
										reader.onload = function(e){
											
											 var html = "<div><img width=\"500\" src=\""+e.target.result+"\"></div>";
											$(".imgs_wrap").append(html);
										
										}
										reader.readAsDataURL(f);
									});
							 }
						 	</script>
					</div>
					
					
					
					<div class="form-group">
						
						<label for="input4">제목</label> <input
							value='<c:out value = "${RevBoard.rev_title }"/>' name=rev_title type="text"
							class="form-control" id="input4" placeholder="제목을 입력하세요.">
							<c:if test="${errors.noTitle }">
							<small class="form-text text-muted">
								제목을 입력하세요
							</small>
							</c:if>
					</div>

					<div class="form-group">
						
						<label for="textarea1">내용</label>
						<textarea name="rev_content" class="form-control" id="textarea1"
							rows="3"><c:out value="${RevBoard.rev_content }" /></textarea>
							<c:if test="${errors.noContent }">
							<small class="form-text text-muted">
								내용을 입력하세요
							</small>
							</c:if>
					</div>
					
					<div class="form-group">
						<label for="input5">조회수</label> <input  name="rev_readcnt"
							value="${RevBoard.rev_readCnt }" type="text" class="form-control"
							id="input5"  readonly/>
					</div>
					

					<div class="form-group">
						<label for="input6">작성자</label> <input name="rev_writer"
							value='<c:out value="${RevBoard.rev_writer }"/>' type="text"
							class="form-control" id="input6" readonly>
					</div>
										
					
					<div class="form-group">
						<label for="input7">수정일</label> <input  
							value="${RevBoard.rev_updatedate }" type="text" class="form-control"
							id="input7" readonly />
					</div>

					<input type="hidden" value="${cri.pageNum }" name="pageNum" /> 
					<input type="hidden" value="${cri.amount }" name="amount" /> 
					<input type="hidden" value="${cri.type }" name="type" /> 
					<input type="hidden" value="${cri.keyword }" name="keyword" /> 
					<c:if test="${ sessionScope.authUser.user_id eq RevBoard.rev_writer || authUser.user_grade == 0}">
					<button id="remove-btn" type="submit" class="btnbtn-danger">글
						삭제</button>
					<button id="btn_add" type="submit" class="btn btn-primary">글 수정</button>
					</c:if>
				</form>
			</div>
		</div>
	</div>
</body>
</html>