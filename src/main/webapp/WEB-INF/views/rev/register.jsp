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
<script>
	$(document).ready(
			function() {

				var result = '${result}';
				var message = '${message}';

				// checkModal(result);
				checkModal2(message);

				history.replaceState({}, null, null);

				function checkModal2(message) {

					if (message && history.state == null) {
						$("#myModal .modal-body p").html(message);
						$("#myModal").modal("show");
					}
				}

				
			});
</script>
<title>구매후기 글등록</title>
</head>
<body>
<u:navbar></u:navbar>
	<div class="container">
	<form action="${root }/rev/register" method="POST" enctype="multipart/form-data">
	
	<c:if test="${errors.noCategory }">
	<small class="form-text text-muted">
			카테고리를 입력하세요
	</small>
	</c:if>
	카테고리 <%-- <input type="text" name="rev_category" class="form-group" value="${category }"/> --%> 
	<select name="rev_category" >
		<option value="">카테고리 선택</option>
		<option value="1">모자</option>
		<option value="2">신발</option>
		<option value="3">상의</option>
		<option value="4">하의</option>
	</select>
	
	<br>
	
	<c:if test="${errors.noTitle }">
	<small class="form-text text-muted">
			제목을 입력하세요
	</small>
	</c:if>
	제목 <input type="text" name="rev_title"  class="form-group" value="${title }"/> <br>
	
	<c:if test="${errors.noContent }">
	<small class="form-text text-muted">
			내용을 입력하세요
	</small>
	</c:if>
	내용 <input type="text" name="rev_content" class="form-group" value="${content }" /> <br>
	
	
	<input type="text" name="rev_writer" class="form-group" value="${authUser.user_id }" hidden/> <br>
	<%-- 파일 <input type="file" name="rev_filename" class="form-group" value="${param.rev_filename }"/> <br> --%>
	<!-- 파일 <input type="file" name="rev_filename" class="form-control" /> --> <br>
	<%--  <form action="${$root }/file/fileUploadTest" method="post" enctype="multipart/form-data"> 
	<label><input type="file" name="upload" /></label> 
	
	<input type="submit" value="업로드" /> 
	</form>  --%>
	 <%-- 파일 <input type="file" name="upload" class="form-group" value="${filename }"/>
	<br> --%>
	 <div class = "inputArea">
	<label for="revImg"></label>
	 <%-- <label><input type="file" id="revImg" name="upload" value="${RevVO.rev_filename }"/></label>  --%> 
	 <div class="select_img"><img src="" /></div>
	 
	<script>
	  $("#revImg").change(function(){
	   if(this.files && this.files[0]) {
	    var reader = new FileReader;
	    reader.onload = function(data) {
	     $(".select_img img").attr("src", data.target.result).width(500);        
	    }
	    reader.readAsDataURL(this.files[0]);
	   }
	  });
 </script>
 	<!--이미지첨부시작  -->
							<div class = "input_wrap">
								 <input type="file" name="upload" id="input_imgs" multiple="multiple" accept="image/*"/>
							</div>	
							<div class="imgs_wrap">
								<img id="img"/>
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
						<!--이미지첨부끝 -->
	</div>
	<input type="submit"  value="글 등록">
	</form>
	
</div>
</body>
</html>