<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
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

<title>질문 답변 게시판</title>
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

thead {
	background: #f8f8f8;
}
#lock {
	background-color:hsl(80,10%,60%);
}
#user_color {
	background-color:hsl(80,10%,60%);
}
#admin_color {
	background-color:hsl(80,10%,60%);
}

</style>
</head>
<body>
<u:mainNav/>
<div class="container">
	<section id ="container">
		<div class="container-sm">
  			<div class="row">
			    <table class="table table-hover ">

      				<thead>
				       <tr>
				         <th id="menu_no">NO</th>
				         <th id="menu_category">종류</th>
				         <th id="menu_title">제목</th>
				         <th id="menu_nickname"><i class="far fa-user"></i></th>
				         <th id="menu_readcnt"><i class="fas fa-eye"></i></th>
				         <th id="menu_status">답변 상태</th>
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
							<div>			
								<c:choose>									

					            	<c:when test="${board.qa_secret eq '비공개'}">					            	
					            		<span id="lock" class="badge badge-secondary"> 
					            			<i class="fas fa-lock"></i> 비밀글
					            		</span>
				            	
					            		<c:if test="${not empty board.qa_updatedate}">
					            			<span class="badge badge-secondary"> 
					            				<i class="fas fa-edit"></i> 수정됨
					            			</span>
					            		</c:if>
	
						            	<c:if test="${board.qa_readcnt > 100}">
						            		<span id="star" class="badge badge-secondary"> 
						            			<i class="far fa-star"></i> 인기글
						            		</span>
						            	</c:if>            	
					            	</c:when>
            	
									<c:when test="${board.qa_secret eq '공개'}"> 
										<span class="badge badge-secondary"> 
											<i class="fas fa-unlock"></i> 공개글
										</span>

										<c:if test="${not empty board.qa_updatedate}">
						            		<span class="badge badge-secondary"> 
						            		<i class="fas fa-edit"></i> 수정됨
						            		</span>
						            	</c:if>

						            	<c:if test="${board.qa_readcnt > 100}">
						            		<span id="star" class="badge badge-secondary"> 
						            		<i class="far fa-star"></i> 인기글
						            		</span>
						            	</c:if>					            	
									</c:when>									
					            </c:choose>			
							</div>
			
								<a href="${boardLink }">         	
									<c:out value="${board.qa_title}" />
								</a>		 
							</td>            
            				<td>
					            <small id="writer" class="form-text text-dark"><i class="far fa-user"></i>${board.qa_writer} </small>                        
					 			<small id="regdate" class="form-text text-dark"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.qa_regdate}" /> </small>
            				</td>                  
            				<td>
				            	<small id="readcnt" class="form-text text-dark">${board.qa_readcnt}</small>
				            </td>
				            <td id="status">
				 				<c:if test="${board.qa_replycnt == 0 && board.qa_replycnt_admin == 0}">
				            		<span class="badge badge-secondary">${board.qa_status }</span> 
				 				</c:if>
				 		 		<c:if test="${board.qa_replycnt > 0 }">
				            		<span id="user_color" class="badge badge-secondary">유저 답변:${board.qa_replycnt }</span>  
				 				</c:if>
				 				<br>
				 				<c:if test="${board.qa_replycnt_admin > 0 }">
				            		<span id="admin_color" class="badge badge-secondary">관리자 답변:${board.qa_replycnt_admin }</span>
				 				</c:if>
				 			</td>															
          			</tr>          
        		</c:forEach>
			</tbody>
		</table>
<div>
	</div>
		<form action="${root }/qa/list" id="searchForm" class="form-inline my-2 my-lg-0">
      		<select name="type" class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref">      
				<option value="T" ${pageMaker.cri.type eq 'T' ? 'selected' : ''}>제목</option>
				<option value="C" ${pageMaker.cri.type eq 'C' ? 'selected' : ''}>내용</option>
				<option value="S" ${pageMaker.cri.type eq 'S' ? 'selected' : ''}>분류</option>
				<option value="W" ${pageMaker.cri.type eq 'W' ? 'selected' : ''}>닉네임</option>
				<option value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : ''}>제목,분류</option>
				<option value="TWC" ${pageMaker.cri.type eq 'TCSW' ? 'selected' : ''}>제목 or 내용 or 닉네임</option>
				<option value="TCSW" ${pageMaker.cri.type eq 'D' ? 'selected' : ''}>전체 검색</option>
					    	    
				</select>
				<input name="keyword" required value="${pageMaker.cri.keyword }" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
				<input type="hidden" name="pageNum" value="1" />
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    	</form>	
	</div>
	
	<div>
		<c:if test="${!empty authUser.user_id}">
   			<a href="/qa/register/" id="btn_add">글쓰기</a>
   		</c:if>
	</div> 	
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



<div class="modal fade" id="password_input">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						새 댓글
					</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="reply-input" class="col-form-label">
							댓글
						</label>
						<input type="text" class="form-control" id="reply-input">
					</div>
					<div class="form-group">
						<label for="reply-input" class="col-form-label">
							작성자
						</label>
						<input type="text" class="form-control" id="replyer-input">
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="reply-submit-button">등록</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
				
			</div>		
		</div>
	</div>

</body>
</html>