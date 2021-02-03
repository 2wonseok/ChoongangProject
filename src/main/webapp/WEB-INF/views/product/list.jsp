<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	올라온 상품 목록
	
	<div class="container d-flex justify-content-center">

		<c:forEach items="${list }" var="product">
			<!--bootstrap card 시작  -->
			<div class="card mx-2" style="width: 18rem;">
				<img class="card-img-top" src="..." alt="Card image cap">
				<div class="card-body">
					<h5 class="card-title">${product.product_name }</h5>
					<p class="card-text">${product.product_info }</p>
					<a href="#" class="btn btn-primary">구매하기</a>
				</div>
			</div>
			<!--bootstrap card 끝  -->
		</c:forEach>

	</div>
</body>
</html>