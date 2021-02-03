<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-sm mb-3">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${root }/board/list">게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="">자유게시판 <span class="sr-only">(current)</span></a>
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
        <a class="nav-link" href="">Q&A <span class="sr-only">(current)</span></a>
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

</div>

