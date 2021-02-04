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

table.type05 {
  border-collapse: separate;
  border-spacing: 1px;
  text-align: left;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  margin: 20px 10px;
}
table.type05 th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
  background: #efefef;
}
table.type05 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}


</style>

<title>Insert title here</title>
</head>
<body>

	<u:navbar></u:navbar>

	<div class="container">
		<div class="row d-flex justify-content-center">
			<hr>
		
			<div class="col-md-6, col-md-offset-3">
				<div class="row">
					
					<form action="/product/register" method="post" enctype="multipart/form-data">
						<table class="type05">
							<tbody>
								<tr>
									<td>제품 등록</td>
								</tr>
								<tr>
									<th scope="row">제품 이름</th>
									<td><input name="product_name" type="text"></td>
								</tr>
								<tr>
									<th scope="row">제품 단위 가격</th>
									<td><input name="product_price" type="number"></td>
								</tr>
								<tr>
									<th scope="row">제품 수량</th>
									<td><input name="product_quantity" type="number"></td>
								</tr>
								<tr>
									<th scope="row">제품 판매자id를hidden으로넣을예정</th><!--value=authUser로 넣을 예정  -->
									<td><input name="product_seller" type="text"></td>
								</tr>
								<tr>
									<th scope="row">제품 이미지파일이름</th>
									<td><input type="file" name="upload" /></td>
								</tr>
								<tr>
									<th scope="row">상품 카테고리 번호(카테고리테이블에서 가져와서 넣어질 예정)</th>
									<td> <input name="category_seq" type="number"></td>
								</tr>
								<tr>
									<th scope="row">제품 설명</th>
									<td><textarea name="product_info" rows="10" cols="23"></textarea></td>
								</tr>
							</tbody>
						</table>	
						
						<button class="btn_add">등록하기</button>
					</form>
				</div>
				
			</div>
			
			<hr>
		</div>
	</div>

	

</body>
</html>