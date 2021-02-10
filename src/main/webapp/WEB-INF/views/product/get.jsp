<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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


<script>
$(document).ready(function(){
	
	/*밑의 이미지를 호버하면 main이미지가 바뀌는 js */
	/*일단 아래 섬네일에서 호버된걸 선택  */
	$(".hoveredImage").hover(function(){
		
		/* 호버된 이미지의 src값  */
		var hovered = $(this).attr("src");
		/* 왼쪽위의 주소를 변경 */
		$("#productMainImage").attr("src",hovered);
	})
	
	
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
	
	/* 옵션클릭시 아래에 추가 */
	 $(".optionClicked").click(function(){
	     
	 });
	
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
	
	<u:mainNav/>

	<div class="container col-8">

				<hr>
				
					<p class="text-left">상품 카테고리 > <c:out value="${product.category_seq }"></c:out></p>
				<table>
					
					<tr>
						<!-- 상품정보 왼쪽위 이미지  -->
						<c:set var="visibility" value="100%"></c:set>
						<c:if test="${product.product_status == 1 }">
							<c:set var="visibility" value="30%"></c:set>
						</c:if>
						<td class="tableLeftUp">
							<div style="position : relative;">
								<img style="opacity : ${visibility}"  id="productMainImage" class="card-img-top" src="${root }/resources/upload/${productImgList[0] }" alt="제품이미지">
								<div style="position:absolute;top:45%;left:40%">
									<c:if test="${product.product_status == 1 }">
										<h5>판매 종료</h5>
									</c:if>
								</div>
							</div>
						</td>
						
						<!-- 상품정보 오른쪽 항목 -->
						<td rowspan="2" class="align-top">
							<div class="m-5">
								<h3 class="text-left"><c:out value="${product.product_name }"></c:out></h3>
								<fmt:formatNumber value="${product.product_price }" type="number" var="price"></fmt:formatNumber>
								<h5 class="text-right"><c:out value="${price }"></c:out>원</h5>					
								<fmt:formatNumber value="${product.product_quantity }" type="number" var="quantity"></fmt:formatNumber>
								<p class="text-right"><c:out value="${quantity }"></c:out>개 남음</p>
								<p class="text-right">판매자 : <c:out value="${ product.user_nickname }"></c:out></p>
								<p class="text-left">상품설명 </p>
								
								<textarea style="resize: none;" rows="15" cols="50" readonly><c:out value="${product.product_info }"></c:out></textarea>
	
							<c:if test="${product.product_status != 1 }">
								<c:if test="${product.product_seller eq authUser.user_seq}">	
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
										<c:url value="/product/finish" var="productFinish">
											<c:param name="product_seq" value="${product.product_seq }"></c:param>
							            	<c:param name="pageNum" value="${cri.pageNum }"></c:param>
							            	<c:param name="amount" value="${cri.amount }"></c:param>
							            	<c:param name="type" value="${cri.type }"></c:param>
								    		<c:param name="keyword" value="${cri.keyword }"></c:param>      
										</c:url>
										<form action="${productFinish }" method="post">
											<button class="btn_add mx-2">판매종료</button>
										</form>	
									</div>
								</c:if>
							</c:if>
							<c:if test="${product.product_status == 1 }">
								<p>판매가 종료되었습니다.</p>
							</c:if>
							
							</div>
						</td>
					</tr>
					
					<!--상품 왼쪽아래 부가정보  -->
					<tr>
						<!--이미지리스트썸네일  -->
						<td valign=top>
							<c:forEach items="${productImgList }" var="productImg" varStatus="imgNum">
								<img style="opacity : ${visibility}" class="hoveredImage"alt="" src="${root }/resources/upload/${productImg}" height="80px" width="70px">
							</c:forEach>
							<hr>
							<p>부가정보란</p>
						<fmt:setTimeZone value = "GMT+18" />
								<p>상품 등록일 : <fmt:formatDate pattern = "yyyy-MM-dd HH:mm:ss" value="${product.product_regdate }"/> </p>
								<p>상품 정보 수정일 : <fmt:formatDate pattern = "yyyy-MM-dd HH:mm:ss" value="${product.product_updatedate }"/> </p>
				
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="d-flex justify-content-center mt-2 align-middle">
								<form action="" method="get">
									
									<select>
										<c:forEach items="${ poList}" var="poLi" >
											<option class="optionClicked"> ${poLi.po_name} (${poLi.po_price} 원)  / (재고 : ${poLi.po_quantity}) </option>
										</c:forEach>
									</select>
											
									<!--이전에 쓰던거 박제(지울거) 
									<span>구매 수량</span>
									<input style="width:80px" min="1" name="order_quantity" type="number" />
									 -->
									<button class="btn_add mx-2">구매</button>
								</form>
							</div>
						</td>
					</tr>
				
				</table>	
		<br>
		<hr>
		<br>
	</div>

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