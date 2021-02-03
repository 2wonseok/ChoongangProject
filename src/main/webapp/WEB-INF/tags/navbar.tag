<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<<<<<<< HEAD
.header-search input[type=text] {
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
=======
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${root }/board/list">게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="${root }/freeboard/list">자유게시판 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="">판매게시판 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${root }/user/userList">회원 관리 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${root }/user/userRegister">회원 가입 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${root }/qa/list"> Q&A <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${root }/rev/register">구매 후기 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
      	<c:url value="/board/register" var="registerLink">
      		<c:param name="pageNum" value="" />
      		<c:param name="amount" value="" />
      	</c:url>
        <a class="nav-link" href="">글쓰기</a>
      </li>
    </ul>
    
    <form action="${root }/board/list" id="searchForm" class="form-inline my-2 my-lg-0">
    	<select name="type" class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref">
		    <option value="T" ${pageMaker.cri.type eq 'T' ? 'selected' : ''}>제목</option>
		    <option value="C" ${pageMaker.cri.type eq 'C' ? 'selected' : ''}>내용</option>
		    <option value="W" ${pageMaker.cri.type eq 'W' ? 'selected' : ''}>작성자</option>
	   	    <option value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : ''}>제목 or 내용</option>
		    <option value="TW" ${pageMaker.cri.type eq 'TW' ? 'selected' : ''}>제목 or 작성자</option>
		    <option value="TCW" ${pageMaker.cri.type eq 'TCW' ? 'selected' : ''}>제목 or 내용 or 작성자</option>
		</select>
    
      <input name="keyword" required="required" value="" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <input type="hidden" name="pageNum" value="1"/>
      <input type="hidden" name="amount" value="${pageMaker.cri.amount }"/>
      
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
    
  </div>
</nav>
>>>>>>> 9566e3f... 0203 23:17 dongjoo commit

</style>
<div class="container-fluid" style="background-color:#FFF;">
	<nav class="navbar navbar-expand" id="menu" style="height:100px;">
		<div class="container col-9 collapse navbar-collapse" id="navbarSupportedContent">
			<a class="navbar-brand" href="${root }/main/index">
		 	 <img src="${root }/resources/logo/logo.png" alt="noImage" style="width:90px; height:100px;"/>
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
				  <a class="nav-link" href="${root }/rev/register">구매 후기</a>
				</li>
				<li class="nav-item active">
				  <a class="nav-link" href="${root }/qa/list">Q/A</a>
				</li>	      	      
				<li class="nav-item active">
				  <a class="nav-link" href="${root }/LwsProject/pictureBoard">로그인</a>
				</li>
				<li class="nav-item active">
				  <a class="nav-link" href="${root }/user/userRegister">회원가입</a>
				</li>
				<li class="nav-item active">
				  <a class="nav-link" href="${root }/user/userList">회원관리</a>
				</li>
			</ul>
			<form role="search" action="" method="get" name="simpleSearch" novalidate="novalidate">
				<fieldset>
					<label class="visually-hidden" for="q" hidden>카탈로그 검색하기</label>
					<input class="text-input valid" type="text" id="q" name="q" value="" placeholder="search" autocomplete="off" aria-invalid="false">
					<input type="hidden" name="lang" value="ko_KR">
					<button type="submit"><i class="fas fa-search"></i></button>
				</fieldset>
			</form>
		</div>
	</nav>
</div>
