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
<script>
	var userId = "${authUser.user_id}";
	var nickname = "${authUser.user_nickname}";
	var appRoot = "${root}";
</script>
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
<title>BCD쇼핑몰</title>
</head>
<style>
#container {
    clear: both;
    position: relative;
    margin: 35px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
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
    margin-left: 157px;
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
    margin-left: 425px;
		margin-top: 20px;
		margin-bottom: -100px;
}
.chat { 
		position:fixed; 
		width:130px; 
		display:inline-block; 
		top: 34%; /* 창에서 위에서 부터의 높이 */ 
		background-color: transparent; margin:0; 
}
#_chatbox { 
		/* overflow: scroll; */
		position:fixed; 
		width: 262px;
		display:inline-block;
		left: 5px; 
		top: 45%; /* 창에서 위에서 부터의 높이 */ 
		background-color: transparent; margin:0; 
} 
#messageWindow {
		overflow: scroll;
		width: 214px;
		height:250px; 
		margin-left: 20px; 
		position: fixed; 
		top:45%;
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
					<span><i class="fas fa-heart"></i> ${product.product_like }</span>										
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
<c:if test="${authUser != null}">
	<div id="_chatbox" style="display: none">
		<!-- <fieldset> -->
			<div id="messageWindow"></div>
				<input id="inputMessage" style="width: 180px; margin-top:258px;" type="text" onkeyup="enterkey()" />
				<input type="submit" style="float:right; margin-top: 258px; margin-right: 29px;" value="send" onclick="send()" />
		<!-- </fieldset> -->
	</div>
	<img class="chat" src="${root}/resources/chat.png" />
</c:if>
<script>
	$(".chat").on({
		"click" : function() {
			if ($(this).attr("src") == "${root}/resources/chat.png") {
				//채팅끌때 클릭할 이미지 
				$(".chat").attr("src", "${root}/resources/chathide.png");
				$("#_chatbox").css("display", "block");
			} else if ($(this).attr("src") == "${root}/resources/chathide.png") {
				$(".chat").attr("src", "${root}/resources/chat.png");
				$("#_chatbox").css("display", "none");
			}
		}
	});
</script>
<script type="text/javascript">
	var textarea = document.getElementById("messageWindow");
	//서버 ip주소 입력
	var webSocket = new WebSocket('ws://140.238.30.15:8080/${root}/broadcasting');
	var inputMessage = document.getElementById('inputMessage');
	webSocket.onerror = function(event) {
		onError(event)
	};
	webSocket.onopen = function(event) {
		onOpen(event)
	};
	webSocket.onmessage = function(event) {
		onMessage(event)
	};
	function onMessage(event) {
		var message = event.data.split("|");
		var sender = message[0];
		var content = message[1];
		if (content == "") {
		} else {
			$("#messageWindow").html($("#messageWindow").html() + "<p class='chat_content'>" + sender + " : " + content + "</p>");
		}
	}
	function onOpen(event) {
		$("#messageWindow").html("<p class='chat_content' style='width: 200px;'>채팅에 참여하였습니다.</p>");
	}
	function onError(event) {
		alert(event.data);
	}
	function send() {
		if (inputMessage.value == "") {
		} else {
			$("#messageWindow").html($("#messageWindow").html() + "<p class='chat_content'>나 : " + inputMessage.value + "</p>");
		}
		webSocket.send(nickname + "(" + userId + ") | " + inputMessage.value);
		inputMessage.value = "";
	}
	// 엔터키를 통해 send함
	function enterkey() {
		if (window.event.keyCode == 13) {
			send();
		}
	}
	// 채팅이 많아져 스크롤바가 넘어가더라도 자동적으로 스크롤바가 내려가게함
/* 	window.setInterval(function() {
		var elem = document.getElementById('messageWindow');
		elem.scrollTop = elem.scrollHeight;
	}, 0); */
</script>
</body>
</html>