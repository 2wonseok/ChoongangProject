<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<style>
	#menu {
   top: 0px;
   margin-left: -100px;
   text-align: center;
   width: 100%;
   min-width: 1200px;
	}
	
	#menu a {
		color: black;
		font-weight: 600;
		width : 130px;
	}
	
	#menu a:hover {
		color: #ed1b23;;

	}
	fieldset {
    border: 0 none;
    margin: 0;
    padding: 0;
}
@media screen and (min-width: 768px)
.header-search input[type=text] {
    height: 1.75rem;
    padding: 0 8px;
}

.header-search #q {
    background-color: transparent;
    border: none;
    float: left;
    margin: 0;
    padding-left: 1rem;
    height: 2.3rem;
    width: 85%;
    width: calc(100% - 2.2rem);
    outline: 0;
    font-size: 15px;
}

</style>
<div class="container-fluid" style="background-color:#FFF;">
	<nav class="navbar navbar-expand" id="menu" style="height:100px;">
		<div class="container col-9 collapse navbar-collapse" id="navbarSupportedContent">
			<a class="navbar-brand" href="${root }/main/index">
		 	 <img src="${root }/resources/logo/BCDLogo3.png" alt="noImage" style="width:105px; height:100px;"/>
		  </a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
	    <ul class="navbar-nav" style="margin-right:auto;">
				<li class="nav-item active">
				  <a class="nav-link" href="${root }/freeboard/list">자유게시판<span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item active">
				  <a class="nav-link" href="${root }/product/list">판매게시판</a>
				</li>
				<li class="nav-item active">
				  <a class="nav-link" href="${root }/rev/list">구매 후기</a>
				</li>
				<li class="nav-item active">
				  <a class="nav-link" href="${root }/qa/list">Q/A</a>
				</li>
				<c:choose>
					<c:when test="${authUser != null}">
						<li class="nav-item active">
						  <a class="nav-link" href="${root }/user/logout">로그아웃</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item active">
						  <a class="nav-link" href="${root }/user/login">로그인</a>
						</li>
						<li class="nav-item active">
						  <a class="nav-link" href="${root }/user/userRegister">회원가입</a>
						</li>
					</c:otherwise>	
				</c:choose>	      	      
				<c:if test="${authUser.user_grade == 0 }">
					<li class="nav-item active">
						<a class="nav-link" href="${root }/user/userList">회원관리</a>
					</li>
				</c:if>
				<c:if test="${authUser.user_id != null }">
					<li class="nav-item active">
					  <a class="nav-link" href="${root }/user/userRead?user_id=${authUser.user_id}">마이페이지</a>
					</li>
				</c:if>
			</ul>
			<form role="search" action="" method="get" name="simpleSearch" novalidate="novalidate">
				<fieldset>
					<label class="visually-hidden" for="q" hidden>카탈로그 검색하기</label>
					<input class="text-input valid" type="text" id="q" name="q" value="" placeholder="search" autocomplete="off" aria-invalid="false">
					<input type="hidden" name="lang" value="ko_KR">
					<button type="submit"><i class="fas fa-search" aria-hidden="true"></i></button>
				</fieldset>
			</form>
		</div>
	</nav>
</div>
