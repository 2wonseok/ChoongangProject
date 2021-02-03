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
	<form action="${root }/rev/register" method="POST">
	카테고리 <input type="text" name="rev_category" class="form-control" /> <br>
	제목 <input type="text" name="rev_title"  class="form-control" /> <br>
	내용 <input type="text" name="rev_content" class="form-control" /> <br>
	작성자 <input type="text" name="rev_writer" class="form-control" /> <br>
	파일 <input type="file" name="rev_filename" class="form-control" /> <br>
	<input type="submit"  value="글 등록">
	</form>
	
</div>
</body>
</html>