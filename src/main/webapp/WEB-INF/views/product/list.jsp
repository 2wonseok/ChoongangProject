<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

<script>
	$(document).ready(function(){
		
		/*모달창-메세지넘어왔을때나오게함  */
		var message = '${message}';
		checkModal(message);
		history.replaceState({}, null, null);//뒤로가기로왔을시에없앰?
		function checkModal(message){
			if (message && history.state == null) {
				$("#myModal .modal-body p").html(message)
				$("#myModal").modal("show");
			}
		}
		
	});
</script>
		

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
	

	.card {
	    width:14.1rem;
	    height:30rem;
	}
	
	.img_box {
	    width: 14.0rem;
	    height:16.0rem;
	    position: relative;
	}
		
	.card img {
	    width: 14.0rem;
	    height:16.0rem;
	}
	.card p{
	    text-overflow:ellipsis;
	    height:40px;
	    line-height:20px;	
	    overflow:hidden;
	    
	}
	
	.cardLine1{
	    text-overflow:ellipsis;
	    height:20px;
	    line-height:20px;	
	    overflow:hidden;
	    
	}
	
	

</style>

</head>
<body>
  
  <u:navbar></u:navbar>
  
	<div class="container col-8">
			<hr>
			<h3>[철수안내] 로그인을 해야 상품등록 버튼이 생김.</h3>
			<div class="row">
				<div class="col-md-6, col-md-offset-3">
			
			
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
			            <c:set var="visibility" value="100%"></c:set>
						<c:if test="${product.product_status == 1 }">
							<c:set var="visibility" value="30%"></c:set>
						</c:if>
			            
						<a href="${productLink }" >
						<div class="card m-2">
								<div class="img_box">
									<img style="opacity : ${visibility}" src="${root }/resources/upload/${product.product_filename }" alt="Card image cap">
									<div style="position:absolute;top:45%;left:30%">
										<c:if test="${product.product_status == 1 }">
											<h5>판매 종료</h5>
										</c:if>
									</div>
								</div>
								<div class="card-body" >
						            <fmt:formatNumber value="${product.product_price }" type="number" var="price"></fmt:formatNumber>
									<h5 class="card-title"><c:out value="${price }"></c:out>원</h5>
									<p><c:out value="${product.product_name }"></c:out></p>
									
									<div>
										<span><i class="fas fa-eye"></i> ${product.product_readcnt }</span>	
										<span><i class="fas fa-heart"></i> ${product.product_readcnt }</span>										
									</div>
						            <fmt:formatNumber value="${product.product_quantity }" type="number" var="quantity"></fmt:formatNumber>
									<div class="cardLine1">(${quantity })개 남음</div>
										<hr>
						</a>
								    <p class="card-text">판매자 : <c:out value="${ product.user_nickname}"></c:out></p>
								</div>
						</div>
					</c:forEach>
				</div>
			
				<!--상품 bootstrap card 끝  -->			
			</div>
		</div>
			<hr>
		<c:if test="${not empty authUser.user_id}">
			<div class="row">
				<div class=col-10>
				</div>
				<div>
					<button onclick = "location.href = '${root}/product/register'" class="btn_add">상품 등록</button>
				</div>
			</div>
		</c:if>
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
	
	<!--모달창시작-->
	<div id="myModal" class="modal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">알림</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <p>처리가완료되었습니다</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!--모달창끝-->

</body>
</html>