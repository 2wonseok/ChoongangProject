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
<script>
var order_date = '${getOrder.order_date}';


</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<script>
$(document).ready(function() {
	var orderDate = $("#orderDate").val();

 	var odate = new Date(orderDate); 	// 주문 날짜
	var send = new Date(odate.setDate(odate.getDate() + 3));	// 3일 뒤
		//console.log("3일뒤 : ", send);
	var sendDate = send.toISOString().split("T")[0];
		//alert(sendDate);

	$(".my-ship-track__head-title").text(sendDate+" 도착 예정");
});

</script>
<title>Insert title here</title>
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
#ShippingCheck {
	color: #000; 
	font-weight: 540; 
	font-size: 28px; 
	line-height: 20px;
}
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
	<section id="container">
	<input type="hidden" name="orderDate" id="orderDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${getOrder.order_date}"/>">
	<h3>배송조회</h3><br>
		<div class="my-area-contents" id="ShippingCheckDiv"> <!-- 배송 조회 시작 -->
			<div id="my__container" class="my-ship-track my-font--base" data-reference="{&quot;module&quot;: &quot;pcweb&quot;, &quot;controller&quot;: &quot;shiptrack&quot;}" data-accessedring="false" data-tracking="deliveryStatus=DELIVERY_DONE&amp;isCoupang=false&amp;isCoupangGlobal=false&amp;hasExternalLink=true&amp;vendorId=A00154520&amp;vendorItemIds=70061377622">
	   
	  			 <div class="my-ship-track__header my-font--gothic ">
	   		  <div class="my-ship-track__head-info">
	           <div class="my-ship-track__head-title">
	             
	           </div>
	           <div class="my-ship-track__head-sub-title">
	             고객님이 주문하신 상품이 배송준비중입니다.
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
	                		<strong>${getProduct.user_nickname } 판매자 정보보기 &gt;</strong>
	              		</a>
	            		</div>
	          	</div>
	 					</div>
	 					        
						<div class="my-ship-track__delivery-info__customer my-col my-align--top">
	 						<div class="my-row my-pd-lr--16 my-pd-t--12">
	   						<div class="my-col my-width--80">받는사람</div>
	   						<div class="my-col">
	     						<strong id="myDeliveryName">${getOrder.order_username }</strong>
	   						</div>
	 						</div>
	 						
	 						<div class="my-row--table my-mg-t--3 my-pd-lr--16" style="width:414px;">
	   						<div class="my-col my-width--80">받는주소</div>
	   						<div class="my-col my-width--240">
	     						<strong id="myDeliveryAddress">${getOrder.order_useraddress } </strong>
	   						</div>
	   						<div class="my-col"></div>
	 						</div>
	 						<div class="my-row--table my-mg-t--3 my-pd-b--12 my-pd-l--16">
	   						<div class="my-col my-width--80" style="width: 110px;">배송요청사항</div>
	   						<div class="my-col my-width--240">
	     						<strong>
	         					<span id="orderDeliveryMessageNormal">없음</span>
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
	                 <td class="my-ship-track__status-table__cell"></td>
	                 <td class="my-ship-track__status-table__cell"></td>
	                 <td class="my-ship-track__status-table__cell"></td>
	               </tr>
	             
	               <tr>
	                 <td class="my-ship-track__status-table__cell"></td>
	                 <td class="my-ship-track__status-table__cell"></td>
	                 <td class="my-ship-track__status-table__cell"></td>
	               </tr>
	             
	               <tr>
	                 <td class="my-ship-track__status-table__cell"></td>
	                 <td class="my-ship-track__status-table__cell"></td>
	                 <td class="my-ship-track__status-table__cell"></td>
	               </tr>
	             
	               <tr>
	                 <td class="my-ship-track__status-table__cell"></td>
	                 <td class="my-ship-track__status-table__cell"></td>
	                 <td class="my-ship-track__status-table__cell"></td>
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
			location.href="${root}/main/mainPage";
		</script>
	</c:otherwise>
</c:choose>
<u:footer/>
</body>
</html>