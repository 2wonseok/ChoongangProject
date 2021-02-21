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
		var product_seq = $("#product_seq").val();
		alert(product_seq);
		//location.href="${root}/user/shippingCheck?order_seq="+order_seq+"&product_seq="+product_seq;
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
    width: 1000px;
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
			<h3><a href="#" id="orderList">주문 목록</a></h3><br>
 			<c:forEach items="${order}" var="orders">
 				<input type="hidden" name="product_seq" id="product_seq" value="${orders.order_productseq }">
 				<input type="hidden" name="order_seq" id="order_seq" value="${orders.order_seq }">
				<div class="DesktopOrderList__Wrapper-qxzqk9-0 kWqHSE" id="orderListDiv"> <!--  주문 목록 시작 -->
					<div class="DesktopOrderBoxRoot__Wrapper-fimazj-0 bTiPIu">
						<div class="DesktopOrderBoxHeader__Wrapper-abukv2-0 iUvJqV">
							<div class="DesktopOrderBoxHeader__OrderDate-abukv2-1 janngp">
								<fmt:formatDate pattern="yyyy-MM-dd" value="${orders.order_date }"/> 주문  
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
									<tr class="DesktopOrderBoxStyle__DesktopOrderBoxBundleRow-gnmni8-3 gOLjDE">
										<td class="DesktopOrderBoxStyle__DesktopOrderBoxBundleContentsWrapper-gnmni8-4 dGttDc">
											<div class="DesktopOrderBoxBundleHeaderLayout__Wrapper-ki5ja7-0 ibYFEB">
												<div class="DesktopOrderBoxBundleHeaderLayout__Wrapper-ki5ja7-0 ibYFEB">
													배송중 3일 뒤 도착예정
												
												</div>
											</div>
											<div class="DesktopOrderBoxGoodsProductList__Wrapper-sc-1jiyjbz-0 eEWKXq">
												<div class="DesktopOrderBoxStyle__DesktopOrderBoxProductWrapper-gnmni8-8 dytMBJ">
													<div class="DesktopOrderBoxGoodsProductNoticeMessage__Wrapper-g8964r-0 dzhZkT"></div>
													
													<div class="DesktopProductImageLayout__Wrapper-sc-9cwg9-1 dZgxvg">
														<div class="DesktopProductImageLayout__ProductInfoWrapper-sc-9cwg9-2 OtWkv">
															<div class="DesktopProductImageLayout__LeftArea-sc-9cwg9-3 aazNk">
																<a class="SquareImg__Anchor-sc-1uwk3m0-0 XoVxb DesktopProductImageLayout__ProductImage-sc-9cwg9-0 iHCTXb">
																	<img width="64" height="64" src="${root }/resources/upload/${orders.order_filename}" alt="${orders.order_poname } " class="SquareImg__Img-sc-1uwk3m0-1 cSfzyy">
																</a>
															</div>
															<div class="DesktopProductImageLayout__RightArea-sc-9cwg9-5 gnMgPh">
																<div class="DesktopProductImageLayout__ProductArea-sc-9cwg9-6 gJsjSt">
																	<div class="DesktopOrderBoxStyle__DesktopOrderBoxProductTextWrapper-gnmni8-9 cbBmbp"></div>
																	<div class="DesktopOrderBoxStyle__DesktopOrderBoxProductTextWrapper-gnmni8-9 DesktopOrderBoxGoodsBodyText__Paragraph-sc-8q24ha-0 cbBmbp jBDGcA">
																		<span color="#111111" class="BodyText__BodyTextM-sc-755zt3-1 DesktopOrderBoxGoodsBodyText__ProductText-sc-8q24ha-1 jgZoAn wEFvN">
																		  ${orders.order_poname } 
																		</span>
																	</div>
																	<div class="DesktopOrderBoxStyle__DesktopOrderBoxProductTextWrapper-gnmni8-9 DesktopOrderBoxGoodsBodyText__PriceAndCartWrapper-sc-8q24ha-4 cbBmbp bEFRXv">
																		<div class="DesktopOrderBoxGoodsBodyText__PriceTextWrapper-sc-8q24ha-2 hgNRNX">
																			<div class="DesktopOrderBoxGoodsItemPriceAndQuantity__Wrapper-uaa4l4-0 jrOJCy">
																				<span font-weight="normal" class="BodyText__BodyTextL-sc-755zt3-0 jbEZNk"><fmt:formatNumber value='${orders.order_poprice }' type="number"></fmt:formatNumber>원</span>
																				<span class="TextDot__DotContainer-sc-13xhsmd-0 AbwgC">
																					<span class="TextDot__Dot-sc-13xhsmd-1 fYxTqY"></span>
																				</span>
																				<span class="BodyText__BodyTextL-sc-755zt3-0 bqCRgI"><fmt:formatNumber value='${orders.order_quantity }' type="number"></fmt:formatNumber>개</span>
																			</div>
																		</div>
																		<div class="DesktopOrderBoxGoodsBodyText__AddCartButtonWrapper-sc-8q24ha-3 dhufUh">
																			<button id="cartBtn" class="RectButton__Wrapper-sc-1k9quwu-0 jluEnQ DesktopAddToCartButton__CartButton-xuyxga-0 kBhIpv">
																				장바구니 담기</button>
																			<div class="DesktopAddToCartButton__InfoWrapper-xuyxga-1 TTZuV"></div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</td>
										<td class="DesktopOrderBoxStyle__DesktopOrderBoxBundleSelfServiceWrapper-gnmni8-5 kstGdW">
											<div class="DesktopOrderBoxStyle__DesktopOrderBoxBundleSelfServiceInnerWrapper-gnmni8-6 ebLxeX">
												<a onclick="location.href='${root}/user/shippingCheck?order_seq=${orders.order_seq }&product_seq=${orders.order_productseq }'" 
													class="RectButton__Wrapper-sc-1k9quwu-0 iBLteB DesktopOrderBoxStyle__DesktopOrderBoxBundleSelfServiceButton-gnmni8-7 kSkBV">
													배송조회
												</a>
												<button class="RectButton__Wrapper-sc-1k9quwu-0 iBLteB DesktopOrderBoxStyle__DesktopOrderBoxBundleSelfServiceButton-gnmni8-7 kSkBV">
													교환신청
												</button>
												<button class="RectButton__Wrapper-sc-1k9quwu-0 iBLteB DesktopOrderBoxStyle__DesktopOrderBoxBundleSelfServiceButton-gnmni8-7 kSkBV">
													반품신청
												</button>
												<button id="review" class="RectButton__Wrapper-sc-1k9quwu-0 iBLteB DesktopOrderBoxStyle__DesktopOrderBoxBundleSelfServiceButton-gnmni8-7 kSkBV">
													구매후기 쓰기
												</button>
												<button class="RectButton__Wrapper-sc-1k9quwu-0 iBLteB DesktopOrderBoxStyle__DesktopOrderBoxBundleSelfServiceButton-gnmni8-7 kSkBV">
													판매자 문의하기
												</button>
											</div>
										</td>
									</tr>
								
								</tbody>
							
							</table>
						</div>
					</div>
				</div> <!-- 주문 목록 종료 -->
				</c:forEach>
				<!--페이징 -->
				<div class="container d-flex justify-content-center">
					<div class="pagerWrap">
							<c:if test="${pageMaker.prev}">
								<c:url value="/user/userOrderList" var="preLink">
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
								<c:url value="/user/userOrderList" var="pageLink">
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
								<c:url value="/user/userOrderList" var="nextLink">
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