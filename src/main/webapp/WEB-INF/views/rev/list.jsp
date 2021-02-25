<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#btn_add_search {
    color: #fff;
    font-size: 15px;
    background: #4a4a4a;
}
#btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #4a4a4a;
    padding: 0px 30px;
    margin: 0px;
    line-height: 40px;
    float: right;
    width: 125px;
    height: 40px;
    border-radius: 3px;
    text-align: center;
    margin-left: 406px;
    margin-top: 3px;
}
#container {
    clear: both;
    position: relative;
    margin: 35px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
}
thead {
	background: #f8f8f8;
}
/* 페이징 css */
.pagerWrap {
    position: relative;
    text-align: center;
    margin: 0px 0;
}
.pagerWrap a {
    width: 34px;
    height: 34px;
    color: #333;
    border: 1px solid #dedede;
    text-align: center;
    line-height: 34px;
    background: #fff;
    display: inline-block;
}
.pagerWrap a.on {
    border-color: #222222;
    background: #4a4a4a;
    color: #fff;
}
.pagerWrap a:hover {
    border-color: #4a4a4a;
    color: #4a4a4a;
}
.pagerWrap a.on:hover {
    border-color: #4a4a4a;
    color: #fff;
}
#foot{
	background: #f8f8f8;
	border-top: 2px solid #E3E1E1;
	border-bottom: 1px solid #E3E1E1;
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
	$(document).ready(
			function() {

				var result = '${result}';
				var message = '${message}';

				// checkModal(result);
				checkModal2(message);

				history.replaceState({}, null, null);

				function checkModal2(message) {

					if (message && history.state == null) {
						$("#myModal .modal-body p").html(message);
						$("#myModal").modal("show");
					}
				}

				
			});
</script>
<title>Insert title here</title>
</head>
<body>
<u:mainNav></u:mainNav>


			
	<div class="container">
	<section id="container">	
	
		<div class="row">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>#번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<c:if test="${rev.rev_updatedateKST == null }">
						<th>작성일</th>
						</c:if>
						<c:if test="${rev.rev_updatedateKST != null }">
						<th>수정일</th>
						</c:if>
						<th>좋아요</th>
						<th>싫어요</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="rev">
						<tr>
							<td>${rev.rev_seq}</td>
							<c:url value="/rev/get" var="revLink">
								<c:param value="${rev.rev_seq }" name="rev_seq" />
								<c:param value="${pageMaker.cri.pageNum }" name="pageNum" />
								<c:param value="${pageMaker.cri.amount }" name="amount" />
								<c:param name="type" value="${pageMaker.cri.type }" />
								<c:param name="keyword" value="${pageMaker.cri.keyword }" />
								<c:param name="rev_title" value="${rev.rev_title }" />
							</c:url>
							<td><c:if test="${rev.rev_category eq 1}">모자</c:if><c:if test="${rev.rev_category eq 2}">신발</c:if><c:if test="${rev.rev_category eq 3}">상의</c:if><c:if test="${rev.rev_category eq 4}">하의</c:if><c:if test="${rev.rev_category eq 5}">전자 기기</c:if><c:if test="${rev.rev_category eq 6}">식품</c:if></td>
							<td><a href="${revLink }" style="color: black;"> <c:out
										value="${rev.rev_title}" />
								<c:if test="${rev.rev_replyCnt gt 0 }"> <!-- gt는 > 이거랑같음 -->
								<span class="badge bg-secondar"><i class="fas fa-comment-dots"></i>${rev.rev_replyCnt }</span>
								
								</c:if>
							</a></td>
							<td><c:out value="${rev.rev_writer}" /></td>
							
							<td><fmt:formatDate value='${rev.rev_regdate}' pattern='yyyy-MM-dd'/></td>
							
									<td>${rev.rev_good }</td>
									<td>${rev.rev_hate }</td>
									<td>${rev.rev_readCnt }</td>
									
		
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="foot" class="row">
			<form action="${searchLink }" id="searchForm" class="form-inline my-2 my-lg-0 ar ">
				<select class="custom-select my-1 mr-sm-2" name="type" 
					id="inlineFormCustomSelectPref">
					<option value="T" ${pageMaker.cri.type eq 'T' ? 'selected' : '' } >제목</option>
					<option value="K" ${pageMaker.cri.type eq 'K' ? 'selected' : '' } >카테고리</option>
					<option value="C" ${pageMaker.cri.type eq 'C' ? 'selected' : '' }>내용</option>
					<option value="W" ${pageMaker.cri.type eq 'W' ? 'selected' : '' }>작성자</option>
					<option value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : '' }>제목 or 내용</option>
					<option value="TW" ${pageMaker.cri.type eq 'TW' ? 'selected' : '' }>제목 or 작성자</option>
					<option value="TWC" ${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }>제목 or 내용 or 작성자</option>
				</select> 
				<input class="form-control mr-sm-2" type="search" name="keyword" value="${pageMaker.cri.keyword }"
					placeholder="검색어 입력" aria-label="Search" required >
					<input type="hidden"  name="pageNum" value="1"/>
					<input type="hidden"  name="amount" value="${pageMaker.cri.amount }"/>
				<button class="btn my-2 my-sm-0"  id="btn_add_search" type="submit">Search</button>
			</form>
			<c:if test="${ sessionScope.authUser.user_id != null }">
				<a id="btn_add" class="btn" href="${root }/rev/register">후기 작성</a>
			</c:if>
			<c:url value="/rev/list" var="searchLink">
				<c:param name="rev_seq" value="${RevBoard.rev_seq }" />
				<c:param name="pageNum" value="${cri.pageNum }" />
				<c:param name="amount" value="${cri.amount }" />
				<c:param name="type" value="${cri.type }"/>
				<c:param name="keyword" value="${cri.keyword }"/>
			</c:url>
		</div>
	
		
	
	
		<div class="container d-flex justify-content-center mt-5">
			<div class="pagerWrap">
					<c:if test="${pageMaker.prev }">
						<c:url value="/rev/list" var="prevLink">
							<!-- 앞에 contextPath를 붙여줌 -->
							<c:param value="${pageMaker.startPage -1 }" name="pageNum" />
							<c:param value="${pageMaker.cri.amount }" name="amount" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
						<a style="width:80px" href="${prevLink}">Previous</a>
							<%-- <a class="page-link" href="${pageMaker.startPage -1 }">Previous</a> --%>
						
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
						<c:url value="/rev/list" var="pageLink">
							<c:param name="pageNum" value="${num }" />
							<c:param name="amount" value="${pageMaker.cri.amount }" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
							<a class="${pageMaker.cri.pageNum eq num ? 'on' : ''}" href="${pageLink }">${num}</a> <%-- <a class="page-link" href="${num }">${num }</a> --%>
						
						<!-- href = "${root }/board/list?pageNum=${num}&amount=${pageMaker.cri.amount }" -->
					</c:forEach>

					<c:if test="${pageMaker.next }">
						<c:url value="/rev/list" var="nextLink">
							<c:param value="${pageMaker.endPage +1 }" name="pageNum" />
							<c:param value="${pageMaker.cri.amount }" name="amount" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
						<a style="width:80px" href="${nextLink}">Next</a>
							<%-- <a class="page-link" href="${pageMaker.endPage +1 }">Next</a> --%>
					
						<!-- href="${root}/board/list?pageNum=${pageMaker.endPage +1}&amount=${pageMaker.cri.amount}
						 와 같음 -->
					</c:if>
			</div>
		</div>
	</section>
	</div>
<u:footer/>
<div id="myModal" class="modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">알림</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>성공적으로 처리 됐습니다!</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>