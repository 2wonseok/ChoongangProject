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

	.btn_add {
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


<title>Insert title here</title>
</head>
<body>
	
	<u:navbar></u:navbar>

	<div class="container">
		<div class="row">
			<div class="col-md-6, col-md-offset-3">

				보기
				<form action="/product/modify" method="get">
					제품 이름<input name="product_name" type="text" readonly value="${product.product_name }"> <br>
					제품 단위 가격<input name="product_price" type="number" readonly value="${product.product_price }"> <br>
					제품 수량<input name="product_quantity" type="number" readonly value="${product_quantity }"> <br>
					제품 판매자id를hidden으로넣을예정<input name="product_seller" type="text" readonly>  <br> <!--value=authUser로 넣을 예정  -->
					제품 이미지파일이름<input name="product_filename" type="text" readonly> <br>
					제품 설명 <input name="product_info" type="text" readonly> <br>
					상품 카테고리 번호(카테고리테이블에서 가져와서 넣어질 예정) <input name="category_seq" type="number" readonly> <br>
					
					<button>수정하기</button>
				</form>
				
				
				<c:url value="/product/remove" var="productRemove">
					<c:param name="product_seq" value="${product.product_seq }"></c:param>
	            	<c:param name="pageNum" value="${cri.pageNum }"></c:param>
	            	<c:param name="amount" value="${cri.amount }"></c:param>
	            	<c:param name="type" value="${cri.type }"></c:param>
		    		<c:param name="keyword" value="${cri.keyword }"></c:param>      
				</c:url>
				<form action="${productRemove }" method="post">
					<button class="btn_add">삭제</button>
					
				</form>
			</div>
		</div>
	</div>

</body>
</html>