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
	
	table {
	    width: 80%;
        height : 800px;
	}
	
    table,td,th,textarea {
    	border : 1px solid #F2DCF1;
    	margin: auto;
    }
    table td {
    	width : 50%;
    	text-align : center;
    }
    
    .tableLeftUp {
    	height : 400px;
    }
    
    #productMainImage {
    	width : 350px;
        height : 400px;
    }

</style>


<title>Insert title here</title>
</head>
<body>
	
	<u:navbar></u:navbar>

	<div class="container col-8">

				<hr>
				
					<p class="text-left">상품 카테고리 > <c:out value="${product.category_seq }"></c:out></p>
				<table>
					
					<tr>
					<!-- 상품정보 왼쪽위 이미지  -->
						<td class="tableLeftUp">
							<img id="productMainImage" class="card-img-top" src="${root }/resources/upload/${product.product_filename }" alt="제품이미지">
						</td>
					<!-- 상품정보 오른쪽 항목 -->
						<td rowspan="2" class="align-top">
							<div class="m-5">
								<h3 class="text-left"><c:out value="${product.product_name }"></c:out></h3>
								<fmt:formatNumber value="${product.product_price }" type="number" var="price"></fmt:formatNumber>
								<h5 class="text-right"><c:out value="${price }"></c:out>원</h5>					
								<fmt:formatNumber value="${product.product_quantity }" type="number" var="quantity"></fmt:formatNumber>
								<p class="text-right"><c:out value="${quantity }"></c:out>개 남음</p>
								<p class="text-right">판매자 : <c:out value="${product.product_seller }"></c:out></p>
								<p class="text-left">상품설명 </p>
								
								<textarea rows="15" cols="50" readonly><c:out value="${product.product_info }"></c:out></textarea>
	
								<c:if test="${product.product_seller eq authUser.user_id}">
									<div class="row justify-content-center">
										<!--수정버튼(작성자만보이도록)  -->
										<c:url value="/product/modify" var="productModify">
											<c:param name="product_seq" value="${product.product_seq }"></c:param>
							            	<c:param name="pageNum" value="${cri.pageNum }"></c:param>
							            	<c:param name="amount" value="${cri.amount }"></c:param>
							            	<c:param name="type" value="${cri.type }"></c:param>
								    		<c:param name="keyword" value="${cri.keyword }"></c:param>      
										</c:url>
										
										<button class="btn_add mx-2" type="button" onclick="location.href='${productModify}' ">정보 수정</button>
										
										<!--삭제버튼(작성자만보이도록)-->
										<c:url value="/product/remove" var="productRemove">
											<c:param name="product_seq" value="${product.product_seq }"></c:param>
							            	<c:param name="pageNum" value="${cri.pageNum }"></c:param>
							            	<c:param name="amount" value="${cri.amount }"></c:param>
							            	<c:param name="type" value="${cri.type }"></c:param>
								    		<c:param name="keyword" value="${cri.keyword }"></c:param>      
										</c:url>
										<form action="${productRemove }" method="post">
											<button class="btn_add mx-2">판매종료</button>
										</form>	
									</div>
								</c:if>
							</div>
							
							<div class="d-flex justify-content-center mt-2 align-middle">
								<form action="" method="get">
									<span>구매 수량</span>
									<input name="order_quantity" type="number">
									<button class="btn_add mx-2">구매</button>
								</form>
							</div>	
							
						</td>
					</tr>
					
					<!--상품 왼쪽아래 부가정보  -->
					<tr>
						<td>
							<p>부가정보란</p>
						</td>
					</tr>
				
				</table>	
		<br>
		<hr>
		<br>
	</div>

</body>
</html>