<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<title>Insert title here</title>

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

</head>
<body>
  
  <u:navbar></u:navbar>
  
	<div class="container">
		<div class="row ">
			<div class="col-md-6, col-md-offset-3">
			
			<hr>
			
				<div class="row d-flex justify-content-center">
					<!--상품 bootstrap card 시작  -->
					<c:forEach items="${list }" var="product">
			
						 <c:url value="/product/get" var="productLink">
			            	<c:param name="product_seq" value="${product.product_seq }"></c:param>
			            	<c:param name="pageNum" value="${pageDTO.cri.pageNum }"></c:param>
			            	<c:param name="amount" value="${pageDTO.cri.amount }"></c:param>
			            	<c:param name="type" value="${pageDTO.cri.type }"></c:param>
				    		<c:param name="keyword" value="${pageDTO.cri.keyword }"></c:param>            	
			            </c:url>
					
						<div class="card m-2" style="width: 15rem;">
							<img class="card-img-top" src="/resources/upload/${product.product_filename }" alt="Card image cap">
							<div class="card-body">
								<h5 class="card-title"><c:out value="${product.product_name }"></c:out></h5>
								<p class="card-text"><c:out value="${product.product_info }"></c:out></p>
								<a href="${productLink }" class="btn btn-primary">구매하기</a>
							</div>
						</div>
					</c:forEach>
				</div>
			
			<hr>
				<!--상품 bootstrap card 끝  -->
			
				<button onclick = "location.href = '/product/register'" class="btn_add">상품 등록</button>
			
			</div>
		</div>
	</div>
	
	



	<!--페이징 시작  -->
	<div class="row justify-content-center">
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<!--이전 버튼  -->
				<c:if test="${pageDTO.prev }">
					<c:url value="/product/list" var="prevLink">
						<!--c:url은 contextRoot를 안넣어도 자동으로 만들어진다!  -->
						<c:param value="${pageDTO.startPage-1 }" name="PageNum"></c:param>
						<c:param value="${pageDTO.cri.amount }" name="amount"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${prevLink }">Previous</a>
					</li>
				</c:if>

				<c:forEach var="num" begin="${pageDTO.startPage }"
					end="${pageDTO.endPage }">

					<c:url value="/product/list" var="pageLink">
						<c:param name="pageNum" value="${num }" />
						<c:param name="amount" value="${pageDTO.cri.amount }" />
						<c:param name="type" value="${pageDTO.cri.type }"></c:param>
						<c:param name="keyword" value="${pageDTO.cri.keyword }"></c:param>
					</c:url>
					<li
						class="page-item ${pageDTO.cri.pageNum eq num ? 'active' : '' }">
						<a class="page-link" href="${pageLink }">${num }</a> <%-- <a class="page-link" href="${num }">${num }</a> --%>
					</li>

				</c:forEach>

				<!--페이징다음버튼  -->
				<c:if test="${pageDTO.next }">
					<c:url value="/product/list" var="nextLink">
						<c:param value="${pageDTO.endPage+1 }" name="PageNum"></c:param>
						<c:param value="${pageDTO.cri.amount }" name="amount"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${nextLink }">Next</a>
					</li>
				</c:if>
			</ul>
		</nav>
	</div>
	<!-- 페이징 끝 -->


</body>
</html>