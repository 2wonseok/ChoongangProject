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
$(document).ready(function() {
	$("#ShippingCheckDiv").hide();
	
	$("#review").click(function() {
		location.href="${root }/rev/list";
	});
	
	$("#ShippingCheckBtn").click(function() {
		$("#orderListDiv").hide();
		$("#ShippingCheckDiv").show();
	});
	
	$("#orderList").click(function() {
		$("#orderListDiv").show();
		$("#ShippingCheckDiv").hide();
	});
	
	
});
</script>
<title>주문목록 / 배송조회</title>
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
/* 여기부터 배송조회 */
.my-area-contents {
    margin: 0 0 0 30px;
    zoom: 1;
}
.my__container {
    position: relative;
    min-height: 1000px;
    font-size: 12px;
    line-height: 1.42857;
    color: #333;
    font-family: Dotum,"돋움",Helvetica,AppleSDGothicNeo,Arial,sans-serif !important;
}
.my-font--base {
    font-family: '돋움', dotum, "나눔고딕", "NanumGothic", sans-serif;
}
.my-ship-track__header {
    background: #eee;
    border: 1px solid #ddd;
    border-bottom-color: #ccc;
    box-shadow: 0 1px 1px -1px rgb(0 0 0 / 20%);
    text-align: center;
}
.my-ship-track__head-info {
    padding: 22px 10px 17px;
    color: #36434d;
    border-bottom: 1px solid #fff;
}
.my-ship-track__head-title {
    font-size: 28px;
    line-height: 32px;
    letter-spacing: -2px;
}
.my-ship-track__head-sub-title {
    margin-top: 8px;
    font-size: 18px;
    line-height: 24px;
    letter-spacing: -1px;
}
.my-ship-track__body {
    line-height: 1.42;
}
.my-mg-t--20 {
    margin-top: 20px;
}
.my-row--table {
    display: table;
    width: 100%;
    table-layout: fixed;
    display: block;
    width: auto;
    zoom: 1;
}
.my-border-b--gray-lighter {
    border-bottom: 1px solid #ddd;
}
.my-row--table>.my-col, .my-row--table>.my-col--r {
    float: none;
    display: table-cell;
}
.my-align--middle {
    vertical-align: middle;
}
.my-width--80 {
    width: 80px;
}
.my-col {
    float: left;
}
.my-ship-track__ship-man-thumb {
    position: relative;
    border-radius: 50%;
    height: 64px;
    width: 64px;
    overflow: hidden;
}
.my-ship-track__ship-man-thumb-img {
    width: 100%;
    vertical-align: top;
}
.my-row--table {
    display: table;
    width: 100%;
    table-layout: fixed;
    display: block;
    width: auto;
    zoom: 1;
}
.my-ship-track__delivery-info__customer {
    position: relative;
}
.my-pd-lr--16 {
    padding-left: 16px;
    padding-right: 16px;
}
.my-width--70 {
    width: 70px;
}
.my-mg-t--3 {
    margin-top: 3px;
}
.my-ship-track__invoice-link {
    font-weight: bold;
    text-decoration: underline;
}

.my-color--primary {
    color: #3d82f7 !important;
}
a:visited, span.MsoHyperlinkFollowed, a:link, span.MsoHyperlink {
    color: #111 !important;
    text-decoration: none !important;
}
.my-align--top {
    vertical-align: top;
}
.my-pd-t--12 {
    padding-top: 12px;
}
.my-row {
    zoom: 1;
}
.my-ship-track__delivery-info__customer:before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    width: 1px;
    background: #ddd;
}
.my-row:after {
    content: "";
    display: table;
    height: 0;
    clear: both;
}
.my-pd-l--16 {
    padding-left: 16px;
}
.my-pd-b--12 {
    padding-bottom: 12px;
}
.my-width--300 {
    width: 500px;
}
.my-ship-track__status-table {
    width: 100%;
    table-layout: fixed;
    border-collapse: collapse;
}
caption.my-screen-off {
    display: table-caption;
    position: static;
    height: 0;
    line-height: 0;
    overflow: hidden;
    font-size: 0;
}
thead {
    display: table-header-group;
    vertical-align: middle;
    border-color: inherit;
}
tr {
    display: table-row;
    vertical-align: inherit;
    border-color: inherit;
}
.my-ship-track__status-table th {
    background: #f9f9f9;
    font-weight: normal;
    padding: 12px 4px 12px 30px;
    color: #888;
    border-bottom: 1px solid #ddd;
    text-align: left;
}
.my-font--14 {
    font-size: 14px;
}
tbody {
    display: table-row-group;
    vertical-align: middle;
    border-color: inherit;
}
.my-ship-track__status-table__blank {
    height: 10px;
}
.my-ship-track__status-table {
    width: 100%;
    table-layout: fixed;
    border-collapse: collapse;
}
.my-ship-track__status-table__cell {
		padding: 12px 4px 12px 30px;
}
</style>
<body>
<u:mainNav/>
<c:choose>
	<c:when test="${authUser != null }">
		<div class="container">
			<section id ="container">
			<h3><a href="#" id="orderList">주문 목록</a></h3><br>
				<div class="DesktopOrderList__Wrapper-qxzqk9-0 kWqHSE" id="orderListDiv"> <!--  주문 목록 시작 -->
					<div class="DesktopOrderBoxRoot__Wrapper-fimazj-0 bTiPIu">
						<div class="DesktopOrderBoxHeader__Wrapper-abukv2-0 iUvJqV">
							<div class="DesktopOrderBoxHeader__OrderDate-abukv2-1 janngp">
								2021.02.13 주문
							</div>
							<div class="DesktopOrderBoxHeader__OrderDetailLink-abukv2-2 eNaUsP">
								<span class="DesktopOrderBoxHeader__OrderDetailLinkText-abukv2-3 jmCVTz">
									<a id="detail" href="#">주문 상세 보기 ></a>
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
													배송 완료 2/12(금) 도착
												</div>
											</div>
											<div class="DesktopOrderBoxGoodsProductList__Wrapper-sc-1jiyjbz-0 eEWKXq">
												<div class="DesktopOrderBoxStyle__DesktopOrderBoxProductWrapper-gnmni8-8 dytMBJ">
													<div class="DesktopOrderBoxGoodsProductNoticeMessage__Wrapper-g8964r-0 dzhZkT"></div>
													
													<div class="DesktopProductImageLayout__Wrapper-sc-9cwg9-1 dZgxvg">
														<div class="DesktopProductImageLayout__ProductInfoWrapper-sc-9cwg9-2 OtWkv">
															<div class="DesktopProductImageLayout__LeftArea-sc-9cwg9-3 aazNk">
																<a class="SquareImg__Anchor-sc-1uwk3m0-0 XoVxb DesktopProductImageLayout__ProductImage-sc-9cwg9-0 iHCTXb">
																	<img width="64" height="64" src="${root }/resources/logo/BCDLogo3.png" alt="애플 에어팟" class="SquareImg__Img-sc-1uwk3m0-1 cSfzyy">
																</a>
															</div>
															<div class="DesktopProductImageLayout__RightArea-sc-9cwg9-5 gnMgPh">
																<div class="DesktopProductImageLayout__ProductArea-sc-9cwg9-6 gJsjSt">
																	<div class="DesktopOrderBoxStyle__DesktopOrderBoxProductTextWrapper-gnmni8-9 cbBmbp"></div>
																	<div class="DesktopOrderBoxStyle__DesktopOrderBoxProductTextWrapper-gnmni8-9 DesktopOrderBoxGoodsBodyText__Paragraph-sc-8q24ha-0 cbBmbp jBDGcA">
																		<span color="#111111" class="BodyText__BodyTextM-sc-755zt3-1 DesktopOrderBoxGoodsBodyText__ProductText-sc-8q24ha-1 jgZoAn wEFvN">
																			애플 에어팟 프로 실리콘 케이스, 네이비
																		</span>
																	</div>
																	<div class="DesktopOrderBoxStyle__DesktopOrderBoxProductTextWrapper-gnmni8-9 DesktopOrderBoxGoodsBodyText__PriceAndCartWrapper-sc-8q24ha-4 cbBmbp bEFRXv">
																		<div class="DesktopOrderBoxGoodsBodyText__PriceTextWrapper-sc-8q24ha-2 hgNRNX">
																			<div class="DesktopOrderBoxGoodsItemPriceAndQuantity__Wrapper-uaa4l4-0 jrOJCy">
																				<span font-weight="normal" class="BodyText__BodyTextL-sc-755zt3-0 jbEZNk">5,000원</span>
																				<span class="TextDot__DotContainer-sc-13xhsmd-0 AbwgC">
																					<span class="TextDot__Dot-sc-13xhsmd-1 fYxTqY"></span>
																				</span>
																				<span class="BodyText__BodyTextL-sc-755zt3-0 bqCRgI">1개</span>
																			</div>
																		</div>
																		<div class="DesktopOrderBoxGoodsBodyText__AddCartButtonWrapper-sc-8q24ha-3 dhufUh">
																			<button class="RectButton__Wrapper-sc-1k9quwu-0 jluEnQ DesktopAddToCartButton__CartButton-xuyxga-0 kBhIpv">
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
												<button id="ShippingCheckBtn" class="RectButton__Wrapper-sc-1k9quwu-0 iBLteB DesktopOrderBoxStyle__DesktopOrderBoxBundleSelfServiceButton-gnmni8-7 kSkBV">
													배송조회
												</button>
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
				<div class="my-area-contents" id="ShippingCheckDiv"> <!-- 배송 조회 시작 -->
					<div id="my__container" class="my-ship-track my-font--base" data-reference="{&quot;module&quot;: &quot;pcweb&quot;, &quot;controller&quot;: &quot;shiptrack&quot;}" data-accessedring="false" data-tracking="deliveryStatus=DELIVERY_DONE&amp;isCoupang=false&amp;isCoupangGlobal=false&amp;hasExternalLink=true&amp;vendorId=A00154520&amp;vendorItemIds=70061377622">
      
     			 <div class="my-ship-track__header my-font--gothic ">
      		  <div class="my-ship-track__head-info">
              <div class="my-ship-track__head-title">
                화요일 2/16 도착 예정
              </div>
              <div class="my-ship-track__head-sub-title">
                고객님이 주문하신 상품이 배송시작 되었습니다.
              </div>
      		  </div>
     			 </div>
     			 <div class="my-ship-track__body my-mg-t--20">
           	<div class="my-row--table ">
					    <div class="my-col my-width--80 my-align--middle">
					      <div class="my-ship-track__ship-man-thumb">
          				<img src="${root }/resources/logo/BCDLogo3.png" alt="" class="my-col my-ship-track__ship-man-thumb-img">
      					</div>
  					  </div>
    			  	<div class="my-col my-width--300 my-align--middle my-ship-track__dm-info-area" data-log-type="click" data-log-id="1832" data-log-version="4" data-log-payload="{&quot;eventName&quot;: &quot;cdm_info&quot;}" data-has-log-group="shiptrack_meta_info">
        				<div class="my-row--table">
          				<div class="my-col my-width--70">택배사</div>
          				<div class="my-col"><strong>한진택배</strong></div>
        				</div>
	        			<div class="my-row--table my-mg-t--3">
	          			<div class="my-col my-width--70">전화번호</div>
	          				<div class="my-col"><strong>1588-0011</strong></div>
	        			</div>
	        			<div class="my-row--table my-mg-t--3">
	          			<div class="my-col my-width--70">송장번호</div>
	            		<div class="my-col">
	              		<a href="#" class="js_deliveryExternalLink" data-deliveryurl="http://www.hanjin.co.kr/Delivery_html/inquiry/result_waybill.jsp?wbl_num=509779374554" data-log-type="click" data-log-id="1555" data-log-version="5" data-log-payload="{&quot;eventName&quot;: &quot;delivery_external_status&quot;}" data-has-log-group="shiptrack_meta_info">
	                		<strong class="my-color--primary my-ship-track__invoice-link">509779374554</strong>
	              		</a>
	            		</div>
	       			 	</div>
	            	<div class="my-row--table my-mg-t--3">
	              	<div class="my-col my-width--70">판매자</div>
	              		<div class="my-col">
	                		<a href="#modalContactSeller" class="js_myModalShow my-color--primary" data-log-type="click" data-log-id="1567" data-log-version="5" data-log-payload="{&quot;eventName&quot;: &quot;product_inquiry&quot;}" data-has-log-group="shiptrack_meta_info">
	                  		<strong>빅컴퍼니 판매자 정보보기 &gt;</strong>
	                		</a>
	              		</div>
	            	</div>
    					</div>
    					        
  						<div class="my-ship-track__delivery-info__customer my-col my-align--top">
    						<div class="my-row my-pd-lr--16 my-pd-t--12">
      						<div class="my-col my-width--80">받는사람</div>
      						<div class="my-col">
        						<strong id="myDeliveryName"> 이원석 </strong>
      						</div>
    						</div>
    						
    						<div class="my-row--table my-mg-t--3 my-pd-lr--16" style="width:414px;">
      						<div class="my-col my-width--80">받는주소</div>
      						<div class="my-col my-width--240">
        						<strong id="myDeliveryAddress"> 서울특별시 은평구 신사동 237-40 2층 </strong>
      						</div>
      						<div class="my-col"></div>
    						</div>
    						<div class="my-row--table my-mg-t--3 my-pd-b--12 my-pd-l--16">
      						<div class="my-col my-width--80" style="width: 110px;">배송요청사항</div>
      						<div class="my-col my-width--240">
        						<strong>
            					<span id="orderDeliveryMessageNormal">대문 안쪽에 놓아주세요</span>
        						</strong>
      						</div>
      						<div class="my-col"></div>
    						</div>
  						</div>
          	</div>
          	<div class="my-ship-track__status-wrap my-mg-t--20 my-border-b--gray-lighter js_detailStatus
        			my--has-detail" data-log-type="impression" data-log-id="1547" data-log-version="5" data-has-log-group="shiptrack_meta_info" data-log-payload="{
  						&quot;eventName&quot;: &quot;detail_tracker_section&quot;,
  						&quot;trackingInfoLineCount&quot;:4,
 							&quot;isShowCallerCarrierButton&quot;:false}" data-log-checked="true">
              <table class="my-ship-track__status-table">
                <caption class="my-screen-off">배송 상태 도표</caption>
                <colgroup>
                  <col width="300">
                  <col>
                  <col width="150">
                </colgroup>
                <thead>
	                <tr>
	                  <th scope="col">시간</th>
	                  <th scope="col" style="width: 30%;">현재위치</th>
	                  <th scope="col">배송상태</th>
	                </tr>
                </thead>
                <tbody class="my-font--14">
	                <tr>
	                  <td colspan="3" class="my-ship-track__status-table__blank"></td>
	                </tr>
	                
                  <tr>
                    <td class="my-ship-track__status-table__cell">2021.01.19 06:30</td>
                    <td class="my-ship-track__status-table__cell">남서울터미널</td>
                    <td class="my-ship-track__status-table__cell">배송중(입고)</td>
                  </tr>
                
                  <tr>
                    <td class="my-ship-track__status-table__cell">2021.01.19 06:37</td>
                    <td class="my-ship-track__status-table__cell">남서울터미널</td>
                    <td class="my-ship-track__status-table__cell">배송중(출고)</td>
                  </tr>
                
                  <tr>
                    <td class="my-ship-track__status-table__cell">2021.01.19 11:47</td>
                    <td class="my-ship-track__status-table__cell">은평남(집)</td>
                    <td class="my-ship-track__status-table__cell">배달중</td>
                  </tr>
                
                  <tr>
                    <td class="my-ship-track__status-table__cell">2021.01.19 13:34</td>
                    <td class="my-ship-track__status-table__cell">은평남(집)</td>
                    <td class="my-ship-track__status-table__cell">배달완료</td>
                  </tr>
                
                </tbody>
              </table>
           		</div>
          	</div>
        	</div>
				</div> <!-- 배송 조회 종료 -->
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