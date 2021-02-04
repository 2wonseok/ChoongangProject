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

<title>구매후기 글등록</title>
</head>
<body>

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
	
	<c:if test="${errors.noWriter }">
	<small class="form-text text-muted">
			작성자 누구임?
	</small>
	</c:if>
	작성자 <input type="text" name="rev_writer" class="form-group" value="${writer }"/> <br>
	<%-- 파일 <input type="file" name="rev_filename" class="form-group" value="${param.rev_filename }"/> <br> --%>
	<!-- 파일 <input type="file" name="rev_filename" class="form-control" /> --> <br>
	<%--  <form action="${$root }/file/fileUploadTest" method="post" enctype="multipart/form-data"> 
	<label><input type="file" name="upload" /></label> 
	 <label><input type="file" name="upload" /></label>
	<input type="submit" value="업로드" /> 
	</form>  --%>
	
	
	<div class = "inputArea">
	<label for="revImg">이미지</label>.
	 <label><input type="file" id="revImg" name="upload" /></label>  
	 <!-- <label><input type="file" name="upload" /></label> -->
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
 	
	</div>
	<input type="submit"  value="글 등록">
	</form>
	
</div>
</body>
</html>