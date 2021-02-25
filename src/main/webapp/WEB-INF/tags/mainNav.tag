<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<style>
div.l_header {
    position: relative;
    width: 100%;
    z-index: 1000;
    font-family: "Noto Sans KR", "Helvetica Neue", "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", "돋움", dotum, sans-serif;
    font-size: 14px;
    line-height: 1.5;
    letter-spacing: 0;
}
.b_header_gnb {
    position: relative;
    background: #fff;
    z-index: 100;
}
.b_header_gnb > .inner {
    position: relative;
    width: 1240px;
    height: 120px;
    margin: 0 auto;
}
.c_gnb_logo {
    position: absolute;
    left: 83px;
    top: 25px;
    overflow: hidden;
    line-height: 400px;
    background-image: url(${root }/resources/logo/BCDLogo3.png);
   /*  background-position: -162px 0px; */
    width: 100px;
    height: 70px;
    background-size: 100% 100%;
}
.c_gnb_logo a {
    position: relative;
    display: block;
    width: 100%;
    height: 100%;
}
.c_gnb_search {
    position: absolute;
    left: 196px;
    top: 35px;
    width: 510px;
    height: 50px;
    padding: 2px 55px 0 27px;
    border-radius: 25px;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    border: 1px solid #ddd;
    background: #fafafa;
}
.skip, .hide, .sr-only {
    position: absolute;
    overflow: hidden;
    clip: rect(0 0 0 0);
    margin: -1px;
    width: 1px;
    height: 1px;
}
caption, legend {
    position: absolute;
    top: -9999px;
    left: -9999px;
    font-size: 0px;
    line-height: 0;
}
.c_gnb_search .search_text.search_text_ad {
    color: #999;
}
.c_gnb_search .search_text {
    display: block;
    width: 100%;
    height: 40px;
    line-height: 40px;
    background: none;
    border: none;
    font-size: 18px;
    font-family: "Noto Sans KR", "Helvetica Neue", "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", "돋움", dotum, sans-serif;
    letter-spacing: 0;
    color: #111;
    outline: none;
    padding: 0;
}
.c_gnb_search .search_button {
    position: absolute;
    right: 4px;
    top: 4px;
    overflow: hidden;
    line-height: 200px;
    background-color: #fafafa;
    background-image: url(${root }/resources/logo/searchbtn.png);
    width: 43px;
    height: 43px;
    background-size: 100% 100%;
    border-radius: 70%;
    border: 0;
}
.c_gnb_usermenu {
    position: absolute;
    top: 36px;
    right: -8px;
}
dl, ul, ol, menu, li {
    list-style: none;
}
.c_gnb_usermenu > ul > li:first-child {
    margin-left: 0;
}
.c_gnb_usermenu > ul > li {
    position: relative;
    float: left;
    margin: 0 0 0 25px;
    padding: 0 0 15px 0;
}
.c_gnb_usermenu > ul > li.my .menu {
    background-image: url(${root }/resources/logo/user.png);
    background-position: -190px -45px;
    width: 47px;
    height: 45px;
    background-size: 100% 100%;
    margin-top: 0px;
}
.c_gnb_usermenu > ul > li .menu {
    overflow: hidden;
    display: block;
    line-height: 200px;
}
a {
    color: #666;
    text-decoration: none;
}
.c_gnb_usermenu > ul > li.my .c_gnb_layer {
    width: 170px;
    left: 0;
    top: 55px;
}
.my:hover .c_gnb_layer {
	display: block;
}
.c_gnb_layer.active {
    display: block;
}
.c_gnb_layer {
    display: none;
    position: absolute;
    -webkit-box-shadow: 0px 6px 24px -8px rgb(0 0 0 / 12%), 0px 0px 1px 0px rgb(0 0 0 / 36%);
    box-shadow: 0px 6px 24px -8px rgb(0 0 0 / 12%), 0px 0px 1px 0px rgb(0 0 0 / 36%);
    background: #fff;
    border-radius: 4px;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    z-index: 100;
}
.c_gnb_menulist {
    padding: 10px 0px;
}
.c_gnb_menulist a {
    display: block;
    height: 35px;
    padding: 0 10px 0 25px;
    line-height: 35px;
    color: #111;
    font-size: 15px;
}
.c_gnb_usermenu > ul > li.order .menu {
    background-image: url(${root }/resources/logo/truck.png);
    background-position: -106px -72px;
    width: 53px;
    height: 45px;
    background-size: 100% 140%;
}
.c_gnb_usermenu > ul > li.cart .menu {
    background-image: url(${root }/resources/logo/cart.png);
    background-position: -90px -141px;
    width: 45px;
    height: 47px;
    background-size: 100% 99%;
}
.b_header_util {
    position: relative;
    -webkit-box-shadow: 0px -2px 12px 0px rgb(0 0 0 / 6%), 0px -1px 4px 0px rgb(0 0 0 / 18%);
    box-shadow: 0px -2px 12px 0px rgb(0 0 0 / 6%), 0px -1px 4px 0px rgb(0 0 0 / 18%);
    background: #fff;
}
.b_header_util > .inner {
    position: relative;
    width: 1240px;
    height: 66px;
    margin: 0 auto;
    z-index: 20;
}
.c_util_servicelink {
    zoom: 1;
}
.c_util_etc {
    position: absolute;
    right: 0;
    top: 0;
    height: 66px;
    padding: 22px 0 0 0;
    font-size: 15px;
    color: #111;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}
.c_util_servicelink li {
		float:left;
		margin-left: 30px;
}

.c_util_servicelink li a {
    position: relative;
    display: block;
    height: 100%;
    color: #111;
    font-size: 17px;
    line-height: 66px;
    font-family: "11StreetGothic", "Helvetica Neue", "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", "돋움", dotum, sans-serif;
    font-weight: bold;
}
.c_util_etc .login_status {
    margin-top: -2px;
}
.c_util_etc .group {
    float: left;
    line-height: 22px;
}
.c_util_etc .direct_stauts {
    position: relative;
    margin: 0 12px 0 12px;
}

</style>
<body>
<div class="l_header" role="banner">
	<div class="b_header_gnb">
		<div class="inner" id="lws">
			<h1 class="c_gnb_logo">
				<a href="${root }/main/mainPage">BCD</a>
			</h1>
			<div class="c_gnb_search" id="tSearch">
				<h2 class="skip">통합검색</h2>
				<form action="${root }/product/list" method="get">
					<fieldset>
						<legend>통합검색</legend>
						<input name="type" value="TC" hidden="hidden"/>
						<input type="text" class="search_text search_text_ad" name="keyword" placeholder="통합검색" title="통합검색">
						<button type="submit" class="search_button">검색</button>
					</fieldset>
				</form>		
			</div>	
		<div class="c_gnb_usermenu">
			<h2 class="skip">나의 메뉴</h2>
			<ul>
				<li class="my" data-log-actionid-area="header_util" data-log-actionid-label="my11st">
					<a href="${root }/user/userRead?user_id=${authUser.user_id}" class="menu" id="menu"></a>
					<div class="c_gnb_layer">
						<ul class="c_gnb_menulist">
							<li>
								<a href="#" data-log-actionid-area="header_util" data-log-actionid-label="coupon">나의 쿠폰</a>
							</li>
							<li>
								<a href="${root }/user/productList" >판매 목록</a>
							</li>
							<li>
								<a href="${root }/user/userOrderList" >주문/배송조회</a>
							</li>
							<li>
								<a href="#" >취소/반품/교환</a>
							</li>
							<li>
								<a href="${root }/qa/list" >고객센터</a>
							</li>
							<li>
								<a href="${root }/user/userRead?user_id=${authUser.user_id}">회원정보</a>
							</li>
						</ul>
					</div>
				</li>
				<li class="order">
					<a href="${root }/user/userOrderList" data-log-actionid-area="header_util" data-log-actionid-label="orderdlv_inquiry" class="menu">주문</a>
				</li>
				<li class="cart">
					<a href="${root }/user/cart" class="menu" data-log-actionid-area="header_util" data-log-actionid-label="cart">장바구니</a>
				</li>
			</ul>
		</div>
	</div>		
		<div class="b_header_util">
			<div class="inner">
				<div class="c_util_servicelink">
					<h2 class="skip">주요서비스 바로가기</h2>
					<ul>
						<li>
							<a href="${root }/main/mainPage" class="" >베스트</a>
						</li>
						<li>
							<a href="${root }/freeboard/list" class="">자유게시판</a>
						</li>
						<li>
							<a href="${root }/qa/list" class="" >Q&A</a>
						</li>
						<li>
							<a href="${root }/rev/list" class="">구매후기</a>
						</li>
						<li>
							<a href="${root }/product/list" class="">상품목록</a>
						</li>
						<c:if test="${authUser.user_grade == 0 }">
							<li>
								<a href="${root }/user/userList" class="">회원관리</a>
							</li>
						</c:if>
					</ul>
				</div>
				<div class="c_util_etc">
					<div class="group login_status">
						<c:choose>
							<c:when test="${authUser == null}">
								<a style="color: #666;" href="${root }/user/login">로그인</a>&nbsp; &nbsp; 
								<a style="color: #666;" href="${root }/user/userRegister">회원가입</a>
							</c:when>
							<c:otherwise>
								<a style="color: #666;" href="${root }/user/logout">로그아웃</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>