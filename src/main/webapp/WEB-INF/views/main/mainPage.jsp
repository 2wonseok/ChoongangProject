<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u"  tagdir="/WEB-INF/tags" %>
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
<script type="text/javascript">
$(document).ready(function() {
	$("#btn_plus").click(function() {
		location.href="${root}/product/list";
	})


});
</script>
<title>임시 메인 페이지</title>
</head>
<style>
#container {
    clear: both;
    position: relative;
    margin: 35px auto 0px;
    padding: 0 0 50px 0;
    width: 1200px;
    z-index: 1;
}
#footdiv {
    width: 100%;
    padding: 0 30px 30px 30px;
    text-align: center;
    color: gray;
    white-space: pre-line;
  	bottom:0;
  	margin-bottom: -100px;
}
#map {
    width: 600px;
    height: 300px;
    position: absolute;
    margin-top: -240px;
    margin-left: 255px;
}
#foothr {
		margin-bottom: 15rem;
    border: 0;
    border-top: 1px solid rgba(0,0,0,.1);
}
.card {
    width:14.1rem;
    height:30rem;
}
.img_box {
    width: 14.1rem;
    height:19.0rem;
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
#btn_plus {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #747474;
    padding: 0px 30px;
    line-height: 45px;
    border-radius: 3px;
    margin-left: 520px;
		margin-top: 20px;
		margin-bottom: -100px;
}
</style>
<body>
<u:mainNav/>
<div class="container">
	<section id="container">
		<div class="row d-flex justify-content-center">
	<!--상품 bootstrap card 시작  -->
	<c:forEach items="${list }" var="product">  
		<c:url value="/product/get" var="productLink">
			<c:param name="product_seq" value="${product.product_seq }"/>
			<c:param name="pageNum" value="${pageDTO.cri.pageNum }"/>
			<c:param name="amount" value="${pageDTO.cri.amount }"/>
			<c:param name="type" value="${pageDTO.cri.type }"/>
			<c:param name="keyword" value="${pageDTO.cri.keyword }"/>            	
			<c:param name="array" value="${pageDTO.cri.array }"/>            	
	  </c:url>
		<c:set var="visibility" value="100%"></c:set>
		<c:if test="${product.product_status == 1 }">
			<c:set var="visibility" value="30%"></c:set>
		</c:if>   
		<div class="card m-2">
			<div class="img_box">
				<a href="${productLink }" >
					<img style="opacity : ${visibility}" src="${root }/resources/upload/${product.product_filename }" alt="Card image cap">
				</a>
				<div style="position:absolute;top:45%;left:30%">
					<c:if test="${product.product_status == 1 }">
						<h5>판매 종료</h5>
					</c:if>
				</div>
			</div>
			<div class="card-body" >
				<a href="${productLink }" >
	            <fmt:formatNumber value="${product.product_price }" type="number" var="price"></fmt:formatNumber>
				<h5 class="card-title"><c:out value="${price }"></c:out>원</h5>
				<p><c:out value="${product.product_name }"></c:out></p>
				</a>
				<div>
					<span><i class="fas fa-eye"></i> ${product.product_readcnt }</span>	
					<span><i class="fas fa-heart"></i> ${product.product_readcnt }</span>										
				</div>
	            <fmt:formatNumber value="${product.product_quantity }" type="number" var="quantity"></fmt:formatNumber>
				<div class="cardLine1">총 ${quantity }개 남음</div>
					<hr>
			    <p class="card-text">판매자 : <c:out value="${ product.user_nickname}"></c:out></p>
			</div>
		</div>
	</c:forEach>
		</div>
	<button id="btn_plus" >더보기 +</button>
	</section>
</div>
<!-- 푸터 -->
<hr id="foothr">
<div class="container">
	<section id="container">
		<footer id="indexFooter">
			<div id="footdiv">
				<div id="map"></div>
				<div class="container" style="margin-left:-12px;">
								
					사업자명 : BCD쇼핑몰 ㅣ 사업자 번호 : 123-45-78901 ㅣ 개인정보관리책임자 : 이원석
					주소 : 서울특별시 마포구 신촌로 176 5층 501호ㅣ 전화 : 0507-1409-1711안내ㅣ 메일 : lws3793@naver.com
				</div>
			</div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=80e0462cf0816d5f855221ad79425d44"></script>
				<script>				
					$(document).ready(function() {
						var container = document.getElementById('map');
						var options = {
							center: new kakao.maps.LatLng(37.55644880228536, 126.94519155495574),
							level: 3
						};
				
						var map = new kakao.maps.Map(container, options);
						
						// 마커가 표시될 위치입니다 
						var markerPosition  = new kakao.maps.LatLng(37.55644880228536, 126.94519155495574); 
			
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});
		
						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map)
						
					});
				</script>
		</footer>
	</section>
</div>
</body>
</html>