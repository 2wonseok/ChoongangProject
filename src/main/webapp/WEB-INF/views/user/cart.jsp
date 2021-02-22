<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<script>
$(document).ready(function(){
	
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});	
	
	$("#buy").click(function(e) {
		e.preventDefault();
		var checkVal = $("input:checkbox[name='order_seq']:checked").val();
		
		if (!checkVal) {
			alert('체크 박스를 선택해주세요');
			return false;
		} 
		
		$("#buyForm").submit();
	})
	

	
});
</script>
<title>장바구니</title>
</head>
<style>
#container {
    clear: both;
    position: relative;
    margin: 50px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
}
.table img {
	width: 70px;
	height: 70px;
}
.tablep p {
	display:table-cell
}
p {
	vertical-align: middle;
	padding-top: 30px;
} 
#buy {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #4a4a4a;
    padding: 0px 30px;
    margin-top: -20px;
    margin-bottom: 5px;
    line-height: 40px;
    float: left;
    width: 125px;
    height: 40px;
    border-radius: 3px;
    text-align: center;
}
/* 페이지 네이션 css */
.pagerWrap {
    position: relative;
    text-align: center;
    margin: 0px 0;
}
.pagerWrap a {
    width: 34px;
    height: 34px;
    color: #333;
    border: 1px solid #dedede;
    text-align: center;
    line-height: 34px;
    background: #fff;
    display: inline-block;
}
.pagerWrap a.on {
    border-color: #222222;
    background: #4a4a4a;
    color: #fff;
}
.pagerWrap a:hover {
    border-color: #4a4a4a;
    color: #4a4a4a;
}
.pagerWrap a.on:hover {
    border-color: #4a4a4a;
    color: #fff;
}
</style>
<body>
<u:mainNav/>
<c:choose>
	<c:when test="${authUser != null }">
		<div class="container">
			<section id ="container">
			<h3>장바구니</h3><br>
			<form action="${root }/product/orderFromCart" id="buyForm">
			<button type="submit" id="buy">구매하기</button>
				<table class="table table-hover">
					<thead>
						<tr>
							<th><input type="checkbox" id="allCheck"  value=""/>&nbsp; 전체선택</th>
							<th>상품명</th>
							<th>상품금액</th>
							<th>배송비</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${cartList }" var="cart">
						<tr>
							<td><p><input type="checkbox" id="order_seq" name="order_seq" value="${cart.order_seq }" /></p></td>
							<td>
								<img alt="상품사진" src="${root }/resources/upload/${cart.order_filename}">
								<a href="${root}/product/get?product_seq=${cart.order_productseq}" style="color: #000; font-weight: 600; font-size: 18px; line-height: 20px;">
									<c:out value="${cart.order_poname }"></c:out>
								</a>
							</td>
							<td><p><fmt:formatNumber value='${cart.order_poprice }' type="number"></fmt:formatNumber>원</p></td>
							<td><p><c:out value="500,000원"></c:out></p></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				</form>
				<!--페이징 -->
			<div class="container d-flex justify-content-center">
				<div class="pagerWrap">
						<c:if test="${pageMaker.prev}">
							<c:url value="/user/cart" var="preLink">
								<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
									<c:param name="type" value="${pageMaker.cri.type }"></c:param>
									<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
								</c:if>
								<c:param name="pageNum" value="${pageMaker.startPage - 1 }"></c:param>
								<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
							</c:url>
								<a href="${preLink}">Previous</a>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<c:url value="/user/cart" var="pageLink">
								<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
									<c:param name="type" value="${param.type }"></c:param>
									<c:param name="keyword" value="${param.keyword }"></c:param>
								</c:if>	
								<c:param name="pageNum" value="${num }"></c:param>
								<c:param name="amount" value="${pageMaker.cri.amount }"></c:param>
							</c:url>
								<a class="${pageMaker.cri.pageNum == num ? 'on' : ''}" href="${pageLink}">${num }</a>
						</c:forEach>
						
						<c:if test="${pageMaker.next }">
							<c:url value="/user/cart" var="nextLink">
								<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
									<c:param name="type" value="${pageMaker.cri.type }"></c:param>
									<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
								</c:if>
								<c:param name="pageNum" value="${pageMaker.endPage + 1 }"></c:param>
								<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
							</c:url>
							<a href="${nextLink }">Next</a>
						</c:if>
				</div>
			</div>
				
			</section>
		</div>
	</c:when>
	<c:otherwise>
		<script>
			alert('로그인 사용자만 이용 가능합니다.');
			location.href="${root}/main/mainPage";
		</script>
	</c:otherwise>
</c:choose>	
<u:footer/>
</body>
</html>