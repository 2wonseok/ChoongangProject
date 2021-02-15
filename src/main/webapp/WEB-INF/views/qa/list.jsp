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
#container {
    clear: both;
    position: relative;
    margin: 50px auto 0px;
    padding: 0 0 50px 0;
    width: 1200px;
    z-index: 1;
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
  outline: 3px solid #1e263c;
  margin: 8px;
}
#menu {
  text-align: center;
}
#menu_no {
  text-align: center;
}
#menu_category {
  text-align: center;
}
#menu_title {
  text-align: center;
}
#menu_nickname {
  text-align: center;
}
#menu_regdate {
  text-align: center;
}
#menu_readcnt {
  text-align: center;
}
#menu_status {
  text-align: center;
}
#regdate {
  text-align: center;
}
#writer {
  text-align: center;
}
#readcnt {
  text-align: center;
}
#status {
  text-align: center;
}
#image {
  text-align: center;
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>

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


<u:mainNav/>
	
	
	
<div class="container">
	<section id ="container">

             
    
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
	</section>
</div>

<div class="container-sm">
	<section id ="container">
  <div class="row">

    <!-- .table.table-striped.table-hover>thread+today -->
    <table class="table table-striped table-hover">
      <thead>
        <tr>
          <th id="menu_no">NO</th>
          <th id="menu_category">종류</th>
          <th id="menu_title">제목</th>
          <th id="menu_nickname"><i class="far fa-user"></i></th>
<!--           <th id="menu_regdate"><i class="far fa-calendar-check"></i></th> -->
          <th id="menu_readcnt"><i class="fas fa-eye"></i></th>
          <th id="menu_status">답변 상태</th>
          <th id="menu_image">미리보기</th>
        </tr>
      </thead>
      <tbody>
      
        <c:forEach items="${list }" var="board">
          <tr>
            <td id="menu">${board.qa_seq} </td>
            <td id="menu">${board.qa_category} </td>  
            
            <td>
            
            <c:url value="/qa/get" var="boardLink">
            	<c:param value="${board.qa_seq }" name="qa_seq" />
            	<c:param value="${pageMaker.cri.pageNum }" name="pageNum" />
            	<c:param value="${pageMaker.cri.amount }" name="amount" />
            	<c:param value="${pageMaker.cri.type }" name="type"	/>
            	<c:param value="${pageMaker.cri.keyword }" name="keyword" />
            </c:url>
            
            <c:url value="/qa/get_secret" var="boardLink_secret">
            	<c:param value="${board.qa_seq }" name="qa_seq" />
            	<c:param value="${pageMaker.cri.pageNum }" name="pageNum" />
            	<c:param value="${pageMaker.cri.amount }" name="amount" />
            	<c:param value="${pageMaker.cri.type }" name="type"	/>
            	<c:param value="${pageMaker.cri.keyword }" name="keyword" />
            </c:url>
			<div>
			
			<c:choose>			
            	<c:when test="${board.qa_secret eq '비공개'}">
            	
            	<span class="badge badge-secondary"> 
            	<i class="fas fa-lock"></i> 작성자만 열람가능
            	</span>
            	
            	<c:if test="${not empty board.qa_updatedate}">
            	<span class="badge badge-secondary"> 
            		<i class="fas fa-edit"></i> 수정됨
            	</span>
            	</c:if>
            	
            	<c:if test="${board.qa_readcnt > 100}">
            	<span class="badge badge-secondary"> 
            		<i class="far fa-star"></i> 인기글
            	</span>
            	</c:if>            	
            	</c:when>
            	
				<c:when test="${board.qa_secret eq '공개'}"> 
				<span class="badge badge-secondary"> 
				<i class="fas fa-lock-open"></i> 누구나 열람가능
				</span>
				
				<c:if test="${not empty board.qa_updatedate}">
            		<span class="badge badge-secondary"> 
            		<i class="fas fa-edit"></i> 수정됨
            		</span>
            	</c:if>
            	
            	<c:if test="${board.qa_readcnt > 100}">
            		<span class="badge badge-secondary"> 
            		<i class="far fa-star"></i> 인기글
            		</span>
            	</c:if>
            	
				</c:when>
            </c:choose>
			
			</div>
			
            <a href="${boardLink }">
            	<%-- <c:choose>
            	<c:when test="${board.qa_secret eq '비공개'}"> <i class="fas fa-lock" style="color:#1e263c"></i> </c:when>
				<c:when test="${board.qa_secret eq '공개'}"> <i class="fas fa-lock-open" style="color:#1e263c"></i> </c:when>
            	</c:choose> --%>
            	<c:if test="${board.qa_secret == '공개'}">
            		<c:out value="${board.qa_title}" />
            	</c:if>
            </a>
            
            <!-- 미구현 -->
            <a href="${boardLink_secret }">
            <c:if test="${board.qa_secret == '비공개' }">
            		[비밀글] 작성자와 관리자만 열람 할수 있습니다.
            </c:if>
            </a>
           
            
            </td>   
            
            <td>
            <small id="writer" class="form-text text-dark"><i class="far fa-user"></i>${board.qa_writer} </small>                        
 			<small id="regdate" class="form-text text-dark"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.qa_regdate}" /> </small>
            </td>
                  
            <td>
            <small id="readcnt" class="form-text text-dark">
            ${board.qa_readcnt} 
            </small>
            </td>
            <td id="status">
 			<c:if test="${board.qa_replycnt == 0 && board.qa_replycnt_admin == 0}">
            	<span class="badge badge-secondary">${board.qa_status }</span> 
 			</c:if>
 		 	<c:if test="${board.qa_replycnt > 0 }">
            	<span class="badge badge-warning">유저 답변:${board.qa_replycnt }</span>  
 			</c:if>
 			<br>
 			<c:if test="${board.qa_replycnt_admin > 0 }">
            	<span class="badge badge-success">관리자 답변:${board.qa_replycnt_admin }</span>
 			</c:if>
 			</td>
 			<td>			
 				<img onerror="this.src='${root }/resources/noimage.jpg'" src="${root }/resources/qaboard/upload/${board.qa_filename }" width="60px" height="60px"> <br>
 			</td>																	
          </tr>
          
        </c:forEach>
      </tbody>
    </table>
    
    <!-- 글쓰기 -->
	<c:if test="${!empty authUser.user_id}">
   		<a href="/qa/register/" id="btn_add">글쓰기</a>
   	</c:if>
   	
  </div>
  </section>
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