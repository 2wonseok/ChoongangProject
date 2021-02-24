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
	 /* 남은포인트 */
	 function reaminP() {
		var useP = $("#usePoint").val();
		var authP = $("#authPoint").val();
		Number(useP);
		Number(authP);
		$('#remainPoint').val(authP - useP);
		$('.remainPoint').html(authP - useP);
	 }
	 
	$("#usePoint").on('change',function(){
		reaminP();
	});
	$("#useMaxPointBtn").on('click',function(){
		reaminP();
	});
	/* 남은포인트가 */
	

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
		
		/* 보내기전에 총금액과 사용금액이 다르면 안됨*/
		var authP = $('#requireTotalPrice').val();
		var useP = $('#usePoint').val();
		if(authP != useP){
			alert("구매 총 금액과 사용금액이 다릅니다");
			return
		}
		/*보내기전에 포인트보유가 마이너스면 안됨*/
		var remainP = $('#remainPoint').val();
		Number(remainP);
		if(remainP<0){
			alert("보유금액이부족합니다");
			return
		}
 		$('#form_order').submit();
	});
	
	
});
</script>
<title>결제페이지</title>
</head>
<style>

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

.btn_add {
   color: #fff;
   font-size: 15px;
   border: none;
   background: #1e263c;
   padding: 0px 20px;
   margin-left: 10px;
   line-height: 45px;
   float: right;
}

.send_btn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #4a4a4a;
    padding: 0px 25px;
    margin: 0 20px;
    line-height: 45px;
    border-radius: 3px;
    float: right;
}

#container {
    clear: both;
    position: relative;
    margin: 50px auto 0px;
    padding: 0 0 50px 0;
    width: 950px;
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
.table1 p{
	margin-left: 10px;
	font-size: 20px;
}

.table1 th{
	width: 200px;
	font-size: 20px;
}
#usePoint {
	height: 45px;
	font-size: 20px;
	border: none;
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
								<table class="table table-hover col-8">
									<thead>
										<tr>
											<th><input type="checkbox" id="allCheck"/>&nbsp; 전체선택</th>
											<th>상품명</th>
											<th>상품금액</th>
											<th>상품개수</th>
											<th>항목가격</th>
							
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
											<td><p><fmt:formatNumber value='${order.order_poprice * order.order_quantity }' type="number"></fmt:formatNumber>원</p></td>
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
										<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_username" value="${authUser.user_name }" hidden="hidden"/>
										<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_useraddress" value="${authUser.user_address }" hidden="hidden"/>
										<input class="inputCheckBox${status.index}" name="orderVOList[${status.index}].order_userphone" value="${authUser.user_phone }" hidden="hidden"/>
									</c:forEach>
									</tbody>
								</table>
								<table class="table col-4">
										<tr>
											<th>택배비${ orderLength}</th>
											<th>총 금액</th>
										</tr>
									<tbody>
										<tr>
											<td><p> <span id="deliveryPrice">5000</span> 원</p></td>
											<td class="d-flex"><p class="requireTotalPrice"></p><p>원</p>
												<input id="requireTotalPrice" name="requireTotalPrice" value="" hidden="hidden"/>
											</td>
										</tr>
									</tbody>
								</table>
					</div>	
					
						<!-- 배송지 수정 테이블 -->
					
					<br>	
					<h5>배송지 정보</h5>
						<table class="table1">
						<tbody>
							<tr>
								<th><p>이름</p></th>
								<td>
									<p>${authUser.user_name }</p>
								</td>
							</tr>
							<tr>
								<th><p>전화번호</p></th>
								<td>
									<p>${authUser.user_phone }</p>
								</td>
							</tr>
							<tr>
								<th><p>주소</th>
								<td>
									<p>${authUser.user_address }</p>
								</td>
							</tr>
						</tbody>
						</table>
					<br>
					<br>	
					<h5>결제 정보</h5><br>
					
						<table class="table1">
							<tbody>
								<tr>
									<th><p>총 금액</p></th>
									<td><p class="text-right"><span class="requireTotalPrice"></span></p></td>
									<td><p>원</p></td>
								</tr>
								<tr>
									<th><p>보유 포인트</p></th>
									<td>
										<p class="text-right"><fmt:formatNumber value="${authUser.user_point}" pattern="#,###" /> </p>
										<input id="authPoint" value="${authUser.user_point}" hidden="hidden">
									</td>
									<td><p>포인트</p></td>
								</tr>
								<tr>
									<th><p>사용 포인트</th>
									<td>
										<input class="text-right" id="usePoint" max="${authUser.user_point}" name="usePoint" type="number"/>
									</td>
									<td><button id="useMaxPointBtn" class="btn_add" type="button">포인트 모두 사용</button></td>
								</tr>
								<tr>
									<th><p>결제 후 포인트</th>
									<td>
										<p class="text-right"><span class="remainPoint"></span></p>
										<input hidden="hidden" class="text-right" id="remainPoint" name="remainPoint" type="number"/>
									</td>
									<td><p>포인트</p></td>
								</tr>
							</tbody>
						</table>
						
							<button id="submit_btn" class="send_btn">구매하기</button>
							
							<div class="my-5">
							</div>
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