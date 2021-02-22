<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
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
	
	/* 일단 넘어온 것들을 모두 체크해두기 */
	$("input[type=checkbox]").prop("checked", true);
	
	/* 맨위 모두클릭버튼기능 */
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});	
 	
	/*포인트모두사용버튼  */
	$('#useMaxPointBtn').click(function () {
 		var totalP = $('#requireTotalPrice').val();
 		$('#usePoint').val(totalP);
	});

	/* 체크된것들로 가격총합을 바꿔서 넣어주는 함수 */
	function updateTotalPrice() {
		var totalPrice = 0;
		$('input:checkbox[name="checkbox"]:checked').each(function(){
			var index = $(this).data("index");
			var popriceName = "orderVOList["+index+"].order_poprice";
			var poquantityName = "orderVOList["+index+"].order_quantity";
			var poprice = $('input[name="'+ popriceName + '"]').val();
			var poquantity = $('input[name="'+poquantityName+'"]').val();
			var sectorPrice = poprice * poquantity;
			totalPrice += sectorPrice;
		});
			var deliveryPrice = Number( $('#deliveryPrice').html() );
			if(totalPrice != 0 ){
				totalPrice += deliveryPrice;
			}
			
		$('#requireTotalPrice').val(totalPrice);
		$('.requireTotalPrice').each(function(){
			$(this).html(totalPrice);
		});
	};
	/* 일단 첫 로딩시 총가격 실행 */
	updateTotalPrice();
	/* 체크박스누를때마다 체크박스된것들로 총합 바꾸기 */
	$('input:checkbox[name="checkbox"]').click(function () {
		updateTotalPrice();
	});
	
	/*전송버튼 누를때 체크된것들만 보내기  */
 	$('#submit_btn').click(function (e) {
		e.preventDefault();
		
		/*check안된 input들을 disabled해서 못보내게함  */
		$('input:checkbox[name="checkbox"]:not(:checked)').each(function(){
			var className = $(this).val();
			$('.'+className).attr("disabled", true);
		});
		
		/* 못보내면 name에 리스트번호가 꼬이니 OrderVO안의 list의 인덱스번호를 다시구성 해줘야함*/
		var num = 0;
		$('input:checkbox[name="checkbox"]:checked').each(function(){
			var className = $(this).val();
			$('.'+className).each(function(){
				var inputName = $(this).attr("name");
				var first = inputName.indexOf("[");
				var last = inputName.indexOf("]");
				var beforeIndex = inputName.substring(first+1,last);
				var newInputName = inputName.replace(beforeIndex, num);
				$(this).attr("name", newInputName);
				
				console.log(newInputName);
			});
			num++;
		});

 		$('#form_order').submit();
	});
	
	
});
</script>
<title>결제페이지</title>
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
			
			<form id="form_order" action="${root }/product/order" method="post">
			
			<h3>결제 페이지</h3><br>
			
			<h5>주문상품 정보</h5><br>
				
			<div class="d-flex">
				<!-- 상품 뿌려주는 테이블 -->
				<table class="table table-hover">
					<thead>
						<tr>
							<th><input type="checkbox" id="allCheck"/>&nbsp; 전체선택</th>
							<th>상품명</th>
							<th>상품금액</th>
							<th>상품개수</th>
						</tr>
					</thead>
					<tbody>
					
					<c:forEach items="${orderList }" var="order" varStatus="status" >
						<tr>
							<td><p><input type="checkbox" id="inputCheckBox${status.index}" name="checkbox" data-index="${status.index}" value="inputCheckBox${status.index}" /></p></td>
							<td>
								<img alt="상품사진" src="${root }/resources/upload/${order.order_filename}">
								<a href="${root}/product/get?product_seq=${order.order_productseq}" style="color: #000; font-weight: 600; font-size: 18px; line-height: 20px;">
									<c:out value="${order.order_poname }"></c:out>
								</a>
							</td>
							<td><p>${order.order_quantity } 개</p></td>
							<td><p><fmt:formatNumber value='${order.order_poprice }' type="number"></fmt:formatNumber>원</p></td>
						</tr>
						<!--판매에서 넘어왔을 시에 처리할것  -->
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_seq" value="${order.order_seq }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_status" value="1" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_productseq" value="${order.order_productseq }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_filename" value="${order.order_filename }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_poseq" value="${order.order_poseq }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_poname" value="${order.order_poname }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_poprice" value="${order.order_poprice }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_quantity" value="${order.order_quantity }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_userseq" value="${order.order_userseq }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_username" value="${order.order_username }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_useraddress" value="${order.order_useraddress }" hidden="hidden"/>
						<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_userphone" value="${order.order_userphone }" hidden="hidden"/>
					</c:forEach>
					</tbody>
				</table>
				<table class="table col-2">
						<tr>
							<th>택배비</th>
							<th>총 금액</th>
						</tr>
					<tbody>
						<tr>
							<td><p> <span id="deliveryPrice">5000</span> 원</p></td>
							<td><p class="requireTotalPrice"></p>원
								<input id="requireTotalPrice" name="requireTotalPrice" value="" hidden="hidden"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>	
				
				<!-- 배송지 수정 테이블 -->
			<h5>배송지 정보(일단authUser에서 가져오는데 이걸로 결정되면 order를 1로 바꾸는곳에 주소를 이거로 모두 통일해줘야함)</h5><br>
				<table>
				<tbody>
					<tr>
						<th>이름</th>
						<td>${authUser.user_name }</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${authUser.user_phone }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${authUser.user_address }</td>
					</tr>
				</tbody>
				</table>
			<br>
			<br>	
			<h5>결제 정보</h5><br>
			<div class="d-flex">
				<p>총 가격</p>
				<p class="requireTotalPrice"></p>
			</div>
			<p>보유 포인트 : ${authUser.user_point}</p>
			<div>사용 포인트 : <input id="usePoint" name="usePoint" type="number"/>
				<button id="useMaxPointBtn" type="button">포인트 모두 사용</button>
			</div>
				<button id="submit_btn">구매하기</button>
			</form>

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