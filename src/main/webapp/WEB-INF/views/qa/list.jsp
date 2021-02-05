<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<style>
#btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0px;
    line-height: 45px;
    float: right;
}
</style>

<style>
.titleImg{
    content:url("${root }/resources/icon/title_check.png");
    height:30px;
    width:100px;
}

.contentImg{
    content:url("${root }/resources/icon/content_check.png");
    height:30px;
    width:100px;
}
.categoryImg{
    content:url("${root }/resources/icon/category_check.png");
    height:30px;
    width:110px;
}
.nicknameImg{
    content:url("${root }/resources/icon/nickname_check.png");
    height:30px;
    width:110px;
}
.titlecontentImg{
    content:url("${root }/resources/icon/titlecontent_check.png");
    height:30px;
    width:150px;
}
.allImg{
    content:url("${root }/resources/icon/all_check.png");
    height:30px;
    width:100px;
}
</style>

<style>
[type=checkbox] { 
  position: absolute;
  opacity: 0;
  width: 0;
  height: 0;  
} 

[type=checkbox] + label {
  cursor: pointer;
}
[type=checkbox]:checked + label {
  outline: 2px solid #1e263c;
  margin: 8px;

}
</style>
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

<script>
function checkTree(chk){
    var obj = document.getElementsByName("type");
    for(var i=0; i < obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

</script>

<title>Insert title here</title>
</head>
<body>


<u:navbar></u:navbar>
	
	
	
<div class="container">

             
    
<form action="${root }/qa/list" class="form-inline my-2 my-lg-0">


	
<div class="container-fluid">
	<div class="row">
		<input id="title" value="T" ${pageMaker.cri.type eq 'T' ? 'selected' : ''} name="type" type="checkbox" onclick="checkTree(this);"/>
		<label class="titleImg" for="title"></label> 

		<input id="content" value="C" ${pageMaker.cri.type eq 'C' ? 'selected' : ''} name="type" type="checkbox" onclick="checkTree(this);"/>
		<label class="contentImg" for="content"></label> 		 
		
		<input id="category" value="S" ${pageMaker.cri.type eq 'S' ? 'selected' : ''} name="type" type="checkbox" onclick="checkTree(this);"/>
		<label class="categoryImg" for="category"></label> 		
		
		<input id="nickname" value="W" ${pageMaker.cri.type eq 'W' ? 'selected' : ''} name="type" type="checkbox" onclick="checkTree(this);"/>	
		<label class="nicknameImg" for="nickname"></label> 		
		
		<input id="titlecontent" value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : ''} name="type" type="checkbox" onclick="checkTree(this);"/>	
		<label class="titlecontentImg" for="titlecontent"></label> 		
		
		<input id="all" value="TCSW" ${pageMaker.cri.type eq 'TCSW' ? 'selected' : ''} name="type" type="checkbox" onclick="checkTree(this);"/>
		<label class="allImg" for="all"></label> 
	</div>
</div>
	
<div class="container-fluid">
	<div class="row">
	  <input type="search" name="keyword" class="questions-header__form__search col" required value="${pageMaker.cri.keyword }" class="form-control" placeholder="궁금한 것을 검색해보세요.">
      <input type="hidden" name="pageNum" value="1" />
      <input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
      </div>
</div>
<div class="container-fluid">
	<div class="row">
	</div>
</div>
<%-- 	
      <select name="type" class="custom-select my-1 mr-sm-2">
	  <option value="T" ${pageMaker.cri.type eq 'T' ? 'selected' : ''}>제목</option>
	  <option value="C" ${pageMaker.cri.type eq 'C' ? 'selected' : ''}>내용</option>
	  <option value="S" ${pageMaker.cri.type eq 'S' ? 'selected' : ''}>종류</option>
	  <option value="W" ${pageMaker.cri.type eq 'W' ? 'selected' : ''}>닉네임</option>
	  
	  <option value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : ''}>제목 & 내용</option>
	  <option value="TCSW" ${pageMaker.cri.type eq 'TCSW' ? 'selected' : ''}>전체 검색</option>

	    	    
	  </select>
	   --%>
	</form>
</div>








<div class="container-sm">
  <div class="row">

    <!-- .table.table-striped.table-hover>thread+today -->
    <table class="table table-striped table-hover">
      <thead>
        <tr>
          <th>NO</th>
          <th>종류</th>
          <th>제목</th>
          <th>닉네임</th>
          <th><i class="far fa-calendar-alt"> 작성일</i></th>
          <th><i class="fas fa-eye"></i></th>
          <th>답변 상태</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${list }" var="board">
          <tr>
            <td>${board.qa_seq} </td>
            <td>${board.qa_category} </td>  
            
            <td>
            <c:url value="/qa/get" var="boardLink">
            	<c:param value="${board.qa_seq }" name="qa_seq" />
            	<c:param value="${pageMaker.cri.pageNum }" name="pageNum" />
            	<c:param value="${pageMaker.cri.amount }" name="amount" />
            	<c:param value="${pageMaker.cri.type }" name="type"	/>
            	<c:param value="${pageMaker.cri.keyword }" name="keyword" />
            </c:url>
            
            <a href="${boardLink }">
            	<c:choose>
            	<c:when test="${board.qa_secret eq '비공개'}"> <i class="fas fa-lock"></i> </c:when>
				<c:when test="${board.qa_secret eq '공개'}"> <i class="fas fa-lock-open"></i> </c:when>
            	</c:choose>
            	
	            <c:out value="${board.qa_title}" />
<%-- 	            <c:if test="${board.replyCnt gt 0 }">
	            	<span class="badge badge-info">${board.replyCnt }</span>	            
	            	</c:if> --%>
            </a>
            </td>     
            
            
                           
            <td>${board.qa_writer} </td>               
            <td><fmt:formatDate pattern="yyyy-MM-dd" 
            value="${board.qa_regdate}" /> </td>            
            <td>${board.qa_readcnt} </td>                  
            <td>${board.qa_status} </td>  
          </tr>
          
        </c:forEach>
        
        
      </tbody>

    </table>
	<c:if test="${!empty authUser.user_id}">
   		<a href="/qa/register/" id="btn_add">글쓰기</a>
   	</c:if>
  </div>


</div>











<div class="container-sm mt-3">
	<div class="row justify-content-center">
		<nav aria-label="Page navigation example">
		  <ul class="pagination">
		  
		  	<c:if test="${pageMaker.prev }" >
		  	<c:url value="/qa/list" var="prevLink">
		  		<c:param value="${pageMaker.startPage - 1 }" name="pageNum" />
		  		<c:param value="${pageMaker.cri.amount }" name="amount" />
		  		<c:param name="type" value="${pageMaker.cri.type }"/>
		  		<c:param name="keyword" value="${pageMaker.cri.keyword }"/>	
		  	</c:url>
		  			  	
		    <li class="page-item"><a class="page-link" href="${prevLink }" id="btn_add">이전</a></li>
		  	</c:if>
		  	
		  	<c:forEach var="num" begin="${pageMaker.startPage }" 
		  						end="${pageMaker.endPage }">
		  		<c:url value="/qa/list" var="pageLink" >
		  			<c:param name="pageNum" value="${num }" />
		  			<c:param name="pageNum" value="${pageMaker.cri.amount }" />	
		  			<c:param name="type" value="${pageMaker.cri.type }"/>
		  			<c:param name="keyword" value="${pageMaker.cri.keyword }"/>		  				  			
		  		</c:url>
		  						
		    <li class="${pageMaker.cri.pageNum eq num ? 'page-item active' : 'page-item' }">
			<a class="page-link" href="${pageLink }" id="btn_add">${num }</a></li>
		  	</c:forEach>
		  	
		  	
		    <c:if test="${pageMaker.next }">
		  	<c:url value="/qa/list" var="nextLink">
		  		<c:param value="${pageMaker.endPage + 1 }" name="pageNum" />
		  		<c:param value="${pageMaker.cri.amount }" name="amount" />
		  		<c:param name="type" value="${pageMaker.cri.type }"/>
		  		<c:param name="keyword" value="${pageMaker.cri.keyword }"/>	
		  	</c:url>
		    
		    <li class="page-item"><a class="page-link" href="${nextLink }" id="btn_add">다음</a></li>
		    </c:if>
		    
  		</ul>
		</nav>
	
	</div>
</div>

</body>
</html>