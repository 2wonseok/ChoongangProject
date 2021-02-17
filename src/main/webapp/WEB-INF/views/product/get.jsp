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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<!-- <script src="https://kit.fontawesome.com/a076d05399.js"></script> -->


<script>

var root = '${root }';
var productSeq = '${product.product_seq}';
var userSeq = '${authUser.user_seq}';

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
	
	/*토탈가격 구하는 함수*/
	function totalp() {
		var sum = 0;
		$(".po_groupprice").each(function(){
			sum += Number($(this).val());
		});
		$(".total_price").val(sum);
	}
	
	 /* 옵션 클릭시 추가하기 */
	$("#optionSelectBox").on('change',function(){
		/* 선택된 옵션 val을 가져옴=productOption_seq */
		var poSeq = $(this).val();
		var po_name = $(this).find("option:selected").data("name");
		var po_price = $(this).find("option:selected").data("price");
		
		/* 이전 optionContainerNumber가 있는가 선택 */
		var exist = $('input[name="order_poseq"][value='+poSeq+']').length;
		if (exist == 0) {
			$("#optionBox").append(
				'<div id="optionContainer"'+poSeq+'>' +
					'<input style="width:150px;" class="border-0" type="text" name="order_poname" value="'+po_name+'" readonly/>' +
					'<input style="width:60px; text-align:right;" class="border-0 po_price" type="number" name="order_poprice" value="'+po_price+'" readonly/>'+"원"+
					'<input type="number" name="order_poseq" value="'+poSeq+'"hidden/>' +
					'<span class="mx-3"></span>' +
					'<button class="minus_btn" type="button">감소</button>'+
					'<input style="width:40px;" class="amount" type="number" min="1" value="1" name="order_quantity" />'+
					'<button class="plus_btn" type="button">증가</button>'+
					'<button class="removeOption_btn" type="button">제거</button>'+
					'<input style="width:60px; text-align:right;" class="border-0 po_groupprice" type="number" name="" value="'+po_price+'" readonly/>'+"원" +
				'</div>'
			);
			
			totalp();
		}
	});
			
	/* 클릭시 옵션제거=동적태그를 가져오려면 아래처럼생성해야함 */
	$(document).on('click',".removeOption_btn", function(){
		$(this).parent().remove();
		totalp();
	});

	/* 클릭시 수량증감(+가격도변경) */
	$(document).on('click',".plus_btn", function(){
		var amou = $(this).siblings(".amount").val();
		var amouc = parseInt(amou)+1;
		$(this).siblings(".amount").val(amouc);
		/* 가격도 수정 */
		var poPrice = $(this).siblings(".po_price").val();
		var pri = amouc * poPrice;
		$(this).siblings(".po_groupprice").val(pri);
		totalp();
	});
	$(document).on('click',".minus_btn", function(){
		var amou = $(this).siblings(".amount").val();
		if (amou > 1) {
			var amouc = parseInt(amou)-1;
			$(this).siblings(".amount").val(amouc);
			/* 가격도 수정 */
			var poPrice = $(this).siblings(".po_price").val();
			var pri = amouc * poPrice;
			$(this).siblings(".po_groupprice").val(pri);
		}
		totalp();
	});
	
	$("#order_btn").click(function(){
		if ("${authUser}" == ""){
			$("#myModal .modal-body p").html("로그인 해야합니다.");
			$("#myModal").modal("show");
			return;
		}
		
		$("#order_form").submit();
	});
	
	
	/* 하트 누르면 */
	$("#like").click(function(){
		if (userSeq =='') {
			$("#myModal .modal-body p").html("좋아요를 누르려면 로그인해야합니다")
			$("#myModal").modal("show");
			return
		}
		$.ajax({
			type: "post",
			url: root + "/product/like",
			contentType: "application/json",
			dataType: "JSON",
			data: '{"product_seq":'+productSeq+',"user_seq":'+userSeq+'}',
			success: function(data, status, xhr) {
				$("#totalLike").text(data);
			},
			error: function(){
			}
		});
	});

});
</script>

<style>
	#like {
		cursor:pointer;
	}
	
	
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
    
   	#container {
	    clear: both;
	    position: relative;
	    margin: 50px auto 0px;
	    padding: 0 0 50px 0;
	    width: 1200px;
	    z-index: 1;
	}

</style>


<title>Insert title here</title>
</head>
<body>
	
<u:mainNav/>
<div class="container">
  <section id="container">
  
	<div class="container">
					<p class="text-left">상품 카테고리 > <c:out value="${product.category_seq }"></c:out></p>
				<table>
					<colgroup>
					    <col width="20%"/>
					    <col width="30%"/>
					    <col width="50%"/>
				  	</colgroup>
					
					<tr>
						<!-- 상품정보 왼쪽위 이미지  -->
						<c:set var="visibility" value="100%"></c:set>
						<c:if test="${product.product_status == 1 }">
							<c:set var="visibility" value="30%"></c:set>
						</c:if>
						<td colspan="2" class="tableLeftUp">
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
								<p class="text-right">총 <c:out value="${quantity }"></c:out>개 남음</p>
								<p class="text-right">판매자 : <c:out value="${ product.user_nickname }"></c:out></p>
								<div class="d-flex">
									<p class="text-left">상품설명 </p>
									<div class="col-6"></div>
									<span id="like" style="font-size: 24px;"><i class="fas fa-heart"></i> <span id="totalLike">${product.product_like }</span></span>										
									<div class="mx-1"></div>
									<span style="font-size: 24px;"><i class="fas fa-eye"></i> ${product.product_readcnt }</span>
								</div>
									
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
						<td colspan="2"  valign=top>
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
						<td>
							<select id="optionSelectBox" class="mx-3">
									<option>===옵션을 선택하세요===</option>
								<c:forEach items="${ poList}" var="poLi" >
									<option value="${poLi.productOption_seq }" data-name="${poLi.po_name}" data-price="${poLi.po_price}"> ${poLi.po_name} (${poLi.po_price} 원)  / (재고 : ${poLi.po_quantity}) </option>
								</c:forEach>
							</select>
						</td>
						<td colspan="2" >
							<form id="order_form" action="${root }/product/order" method="post">
								<input name="product_seq" value="${product.product_seq }" hidden="hidden"/>
								<input name="order_filename" value="${productImgList[0] }" hidden="hidden"/>
								<input name="order_productseq" value="${product.product_seq }" hidden="hidden"/>
								<input name="order_userseq" value="${authUser.user_seq }" hidden="hidden"/>
								<input name="order_username" value="${authUser.user_name }" hidden="hidden"/>
								<input name="order_useraddress" value="${authUser.user_address }" hidden="hidden"/>
								<input name="order_userphone" value="${authUser.user_phone }" hidden="hidden"/>
								<div id="optionBox">
								</div>
							</form>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="row">
								<div class="ml-3"></div>
								<form action="${root }/product/list">
					            	<input hidden="hidden" name="pageNum" value="${cri.pageNum }"/>
					            	<input hidden="hidden" name="amount" value="${cri.amount }"/>
					            	<input hidden="hidden" name="type" value="${cri.type }"/>
						    		<input hidden="hidden" name="keyword" value="${cri.keyword }"/>      
						    		<input hidden="hidden" name="array" value="${cri.array }"/>      
									<button class="btn_add mx-4"> 목록으로</button>
								</form>
								<div class="col-2"></div>
								<input class="total_price" value="0" name="order_totalprice" readonly/>
								<button class="btn_add mx-2" type="button"> 장바구니</button>
								<button id="order_btn" class="btn_add mx-2" type="button"> 구매</button>
							</div>
						</td>
					</tr>					
				
				</table>
	</div>

   </section>
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
        <button id="modalClose" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!--모달창끝-->
<u:footer/>
</body>
</html>