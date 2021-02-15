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
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script>
$(document).ready(function(){
	
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});	
	
	
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
    width: 1200px;
    z-index: 1;
}
.table img {
	width: 100px;
	height: 100px;
}
.tablep p {
	display:table-cell
}
p {
	vertical-align: middle;
	padding-top: 30px;
} 
</style>
<body>
<u:mainNav/>
<c:choose>
	<c:when test="${authUser != null }">
		<div class="container">
			<section id ="container">
			<h3>장바구니</h3><br>
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
							<td><p><input type="checkbox" id="seq" name="seq" value="" /></p></td>
							<td>
								<img alt="상품사진" src="${root }/resources/upload/${cart.order_filename}">
								<a href="#" style="color: #000; font-weight: 600; font-size: 18px; line-height: 20px;">
									<c:out value="${cart.order_poname }"></c:out>
								</a>
							</td>
							<td><p><c:out value="${cart.order_poprice }"></c:out></p></td>
							<td><p><c:out value="500,000원"></c:out></p></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</section>
		</div>
	</c:when>
	<c:otherwise>
		<script>
			alert('로그인 사용자만 이용 가능합니다.');
			location.href="${root}/main/index";
		</script>
	</c:otherwise>
</c:choose>	
</body>
</html>