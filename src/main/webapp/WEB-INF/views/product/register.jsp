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

<title>Insert title here</title>
</head>
<body>

	등록
	<form action="/product/register" method="post">
		제품 이름<input name="product_name" type="text"> <br>
		제품 단위 가격<input name="product_price" type="number"> <br>
		제품 수량<input name="product_quantity" type="number"> <br>
		제품 판매자id를hidden으로넣을예정<input name="product_seller" type="text">  <br> <!--value=authUser로 넣을 예정  -->
		제품 이미지파일이름<input name="product_filename" type="text"> <br>
		제품 설명 <input name="product_info" type="text"> <br>
		상품 카테고리 번호(카테고리테이블에서 가져와서 넣어질 예정) <input name="category_seq" type="number"> <br>
		
		<button>등록하기</button>
	</form>

</body>
</html>