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
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<title>임시 메인 페이지</title>
</head>
<style>
#footdiv {
    width: 100%;
    margin: 0 auto;
    padding: 0 30px 30px 30px;
    text-align: center;
    color: gray;
    white-space: pre-line;
    position:absolute;
  	bottom:0;
}
#map {
    width: 600px;
    height: 300px;
    position: absolute;
    margin-top: -240px;
    margin-left: 255px;
}
</style>
<body>
<u:mainNav/>
접속 아이디 : ${authUser.user_id} <br>
등급 : <c:choose>
					<c:when test="${authUser.user_grade < 1}">관리자</c:when>
					<c:when test="${authUser.user_grade > 0}">일반</c:when>
					<c:otherwise></c:otherwise>
			</c:choose>


<!-- 푸터 -->
<footer>
	<div id="footdiv">
		<div class="container">
			<div id="map"></div>
		</div>
		
            사업자명 : BCD쇼핑몰 ㅣ 사업자 번호 : 123-45-78901 ㅣ 개인정보관리책임자 : 이원석
            주소 : 서울특별시 마포구 신촌로 176 5층 501호ㅣ 전화 : 0507-1409-1711안내ㅣ 메일 : lws3793@naver.com
		
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
</body>
</html>