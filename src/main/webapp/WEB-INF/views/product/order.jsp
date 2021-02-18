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
	
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});	

	/* 유동적인 셀병합 */
    genRowspan("rowspan");
	function genRowspan(className){
	    $("." + className).each(function() {
	        var rows = $("." + className + ":contains('" + $(this).text() + "')");
	        if (rows.length > 1) {
	            rows.eq(0).attr("rowspan", rows.length);
	            rows.not(":eq(0)").remove();
	        }
    });
	    
}
	
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
			
			<form action="${root }/product/order" method="post">
			
			
			<h3>결제 페이지</h3><br>
			
			<h5>주문상품 정보</h5><br>
				
			<div class="d-flex">
				<!-- 상품 뿌려주는 테이블 -->
				<table class="table table-hover">
					<thead>
						<tr>
							<th><input type="checkbox" id="allCheck"  value=""/>&nbsp; 전체선택</th>
							<th>상품명</th>
							<th>상품금액</th>
							<th>상품개수</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${orderList }" var="order" >
						<tr>
							<td><p><input type="checkbox" id="seq" name="seq" value="" /></p></td>
							<td><input name="order_seq" value="${order.order_seq}" type="number" hidden="hidden"/>
								<img alt="상품사진" src="${root }/resources/upload/${order.order_filename}">
								<a href="${root}/product/get?product_seq=${order.order_productseq}" style="color: #000; font-weight: 600; font-size: 18px; line-height: 20px;">
									<c:out value="${order.order_poname }"></c:out>
								</a>
							</td>
							<td><p>${order.order_quantity } 개</p></td>
							<td><p><fmt:formatNumber value='${order.order_poprice }' type="number"></fmt:formatNumber>원</p></td>
						</tr>						
					</c:forEach>
					</tbody>
				</table>
				
				<!-- 총합구하기 -->
					<c:set var = "total" value = "0" />
						<c:forEach var="orderCal" items="${orderList}" varStatus="status">     
							<c:set var= "total" value="${total + orderCal.order_poprice * orderCal.order_quantity}"/>
						</c:forEach>
				
				<table class="table col-2">
						<tr>
							<th>택배비</th>
							<th>총 금액</th>
						</tr>
					<tbody>
						<tr>
							<td><p>5000원</p></td>
							<td><p><c:out value="${total}"/></p>원</td>
						</tr>
					</tbody>
				</table>
			</div>	
				
				<!-- 배송지 수정 테이블 -->
			<h5>배송지 정보</h5><br>
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
			
			<p>보유 포인트 : ${authUser.user_point}</p>
			<div>사용 포인트 : <input name="usePoint" type="number"/></div>
				<button>구매하기</button>
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




<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
$(document).ready(function() {
	
	function dateString(date) {
		var d = new Date(date);
		return d.toISOString().split("T")[0];
	}
	
	$("#review").click(function() {
		location.href="${root }/rev/list";
	});
	
	$("#ShippingCheckBtn").click(function() {
		var order_seq = $("#order_seq").val();
		location.href="${root}/user/shippingCheck?order_seq="+order_seq;
	});
	
	$(".jBDGcA").click(function() {
		var product_seq = $("#product_seq").val();
		location.href="${root}/product/get?product_seq="+product_seq;
	});
});
</script>
<title>주문목록</title>
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
#orderList, #ShippingCheck {
	color: #000; 
	font-weight: 540; 
	font-size: 28px; 
	line-height: 20px;
}
.__next-wrap * {
    box-sizing: border-box;
}
.bTiPIu {
    width: 100%;
    border-radius: 12px;
    box-shadow: rgb(0 0 0 / 8%) 0px 2px 4px 0px, rgb(0 0 0 / 16%) 0px 0px 1px 0px;
    background-color: rgb(255, 255, 255);
    margin-bottom: 20px;
    padding: 24px 24px 16px;
}
.iUvJqV {
    height: 28px;
    display: flex;
    -webkit-box-pack: justify;
    justify-content: space-between;
}
.janngp {
    display: inline-block;
    width: 50%;
    height: 28px;
    font-size: 20px;
    font-weight: bold;
    font-stretch: normal;
    font-style: normal;
    line-height: 1.4;
    letter-spacing: -0.5px;
    color: rgb(17, 17, 17);
}
.eNaUsP a {
    text-align: right;
    font-size: 16px;
    font-weight: normal;
    font-stretch: normal;
    font-style: normal;
    line-height: 1.5;
    letter-spacing: -0.5px;
    color: rgb(52, 106, 255);
    display: inline-flex;
    vertical-align: middle;
    position: relative;
    width: auto;
    -webkit-box-pack: end;
    justify-content: flex-end;
}
.jmCVTz {
    height: 16px;
    line-height: 1;
    margin: auto;
    font-family: 나눔고딕, nanumgothic, 돋움, dotum, sans-serif;
}
.iBuZkW {
    border-radius: 8px;
    border: 1px solid rgb(238, 238, 238);
    background-color: rgb(255, 255, 255);
    margin-top: 16px;
}
.dGttDc {
    width: 540px;
    height: 100%;
    padding: 20px;
    border-right: 1px solid rgb(238, 238, 238);
    vertical-align: top;
}
.ibYFEB {
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    margin-bottom: 4px;
}
.cZPmOa {
    -webkit-box-pack: start;
    justify-content: flex-start;
    -webkit-box-align: center;
    align-items: center;
    width: 100%;
    display: flex;
    line-height: 1.5;
}
.dytMBJ:first-child {
    margin-top: 20px;
}
.dzhZkT:empty {
    display: none;
}
.dzhZkT {
    position: relative;
    top: -16px;
    display: flex;
    align-items: flex-start;
    -webkit-box-pack: center;
    justify-content: center;
    flex-direction: column;
}
.dZgxvg {
    overflow: hidden;
}
.OtWkv {
    display: flex;
    flex-direction: row;
}
.aazNk {
    width: 64px;
    position: relative;
    margin-right: 16px;
}
.__next-wrap a, .__next button {
    -webkit-touch-callout: none;
    user-select: none;
    -webkit-user-select: none;
    cursor: pointer;
    text-decoration: none;
    outline: none;
}
.iHCTXb {
    opacity: 1;
}
.XoVxb {
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    overflow: hidden;
    user-select: none;
    cursor: pointer;
    border-radius: 4px;
    display: inline-flex;
}
.gnMgPh {
    user-select: none;
    overflow: hidden;
    flex: 1 1 0%;
    display: flex;
}
.gJsjSt {
    display: flex;
    flex: 1 1 0%;
    user-select: none;
    min-width: 0px;
    flex-direction: column;
}
.cbBmbp:empty {
    display: none;
}
.cbBmbp:not(:last-child) {
    margin-bottom: 4px;
}
.cbBmbp {
    display: flex;
    line-height: 1.5;
}
.cbBmbp:not(:last-child) {
    margin-bottom: 4px;
}
.jBDGcA {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    cursor: pointer;
}
.bEFRXv {
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: justify;
    justify-content: space-between;
}  
.kBhIpv {
    min-height: 2.25rem;
    padding: 0px 12px;
}
.jluEnQ {
    display: inline-flex;
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    padding-left: 12px;
    padding-right: 12px;
    user-select: none;
    cursor: pointer;
    text-decoration: none;
    outline: none;
    appearance: none;
    height: 2.25rem;
    border-radius: 4px;
    color: rgb(17, 17, 17);
    background-color: rgb(255, 255, 255);
    border: 1px solid rgb(221, 221, 221);
    -webkit-tap-highlight-color: rgba(52, 106, 255, 0.1);
    font-size: 0.875rem;
}
.kstGdW {
    width: 174px;
    height: 100%;
    text-align: center;
}
.ebLxeX {
    display: flex;
    flex-flow: column wrap;
    height: 100%;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: justify;
    justify-content: space-between;
    padding: 20px;
}
.kSkBV {
    min-height: 2.25rem;
    font-size: 0.875rem;
    width: 160px;
    margin: 4px 0px;
}
.iBLteB {
    display: inline-flex;
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    padding-left: 12px;
    padding-right: 12px;
    user-select: none;
    cursor: pointer;
    text-decoration: none;
    outline: none;
    appearance: none;
    height: 1.75rem;
    width: 100%;
    border-radius: 4px;
    color: rgb(17, 17, 17);
    background-color: rgb(255, 255, 255);
    border: 1px solid rgb(221, 221, 221);
    -webkit-tap-highlight-color: rgba(52, 106, 255, 0.1);
    font-size: 0.75rem;
}
</style>
<body>
<u:mainNav/>
<c:choose>
	<c:when test="${authUser != null }">
		<div class="container">
			<section id ="container">
			<h3><a href="#" id="orderList">구매 페이지</a></h3><br>
 			<c:forEach items="${order}" var="orders">
 				<input type="hidden" name="product_seq" id="product_seq" value="${orders.order_productseq }">
 				<input type="hidden" name="order_seq" id="order_seq" value="${orders.order_seq }">
				<div class="DesktopOrderList__Wrapper-qxzqk9-0 kWqHSE" id="orderListDiv"> <!--  주문 목록 시작 -->
					<div class="DesktopOrderBoxRoot__Wrapper-fimazj-0 bTiPIu">
						<div class="DesktopOrderBoxHeader__Wrapper-abukv2-0 iUvJqV">
							<div class="DesktopOrderBoxHeader__OrderDate-abukv2-1 janngp">
								주문 상세  
							</div>
							<div class="DesktopOrderBoxHeader__OrderDetailLink-abukv2-2 eNaUsP">
								<span class="DesktopOrderBoxHeader__OrderDetailLinkText-abukv2-3 jmCVTz">
									<a id="detail" href="${root}/product/get?product_seq=${orders.order_productseq }">주문 상세 보기 ></a>
								</span>
							</div>
						</div>	
						<div class="DesktopOrderBoxStyle__DesktopOrderBoxBundleWrapper-gnmni8-0 iBuZkW">
							<table class="DesktopOrderBoxStyle__DesktopOrderBoxBundleTable-gnmni8-1 gPVQGK" style="width:100%">
								<colgroup><col width="600"></colgroup>
								<tbody class="DesktopOrderBoxStyle__DesktopOrderBoxBundleTableBody-gnmni8-2 eYVArJ">
									<tr>
										<td>
											상품정보
 										</td>
										<td>
											판매자
										</td>
										<td>
											배송비
										</td>
										<td>
											수량
										</td>
										<td>
											주문금액
										</td>
									</tr>
									<tr>
										<td>
										
											<a class="SquareImg__Anchor-sc-1uwk3m0-0 XoVxb DesktopProductImageLayout__ProductImage-sc-9cwg9-0 iHCTXb">
												<img width="100" height="100" src="${root }/resources/upload/${orders.order_filename}" alt="${orders.order_poname } " class="SquareImg__Img-sc-1uwk3m0-1 cSfzyy">
											</a>
											
											<span color="#111111" class="BodyText__BodyTextM-sc-755zt3-1 DesktopOrderBoxGoodsBodyText__ProductText-sc-8q24ha-1 jgZoAn wEFvN">
																		  ${orders.order_poname } 
																		</span>							
									
											<span font-weight="normal" class="BodyText__BodyTextL-sc-755zt3-0 jbEZNk"><fmt:formatNumber value='${orders.order_poprice }' type="number"></fmt:formatNumber>원</span>									
												
											
										</td>
										
										<td>
											판매자
										</td>
										<td>
											배송비
										</td>
										<td>
											수량
										</td>
										<td>
											주문금액
										</td>
										
									</tr>
								
								</tbody>
							
							</table>
						</div>
					</div>
				</div> <!-- 주문 목록 종료 -->
				</c:forEach> 
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
</html> --%>