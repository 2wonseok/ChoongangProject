<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<style type="text/css">
#btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #4a4a4a;
    padding: 0px 38px;
    margin: 3px 0px;
    line-height: 38px;
    float: right;
    border-radius: 3px;
    margin-left:414px;
}
#searchButton{
	color: #fff;
	font-size: 15px;
	background: #4a4a4a;
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
.page-item:last-child .page-link {
    border-top-right-radius: .25rem;
    border-bottom-right-radius: .25rem;
}
.page-item:first-child .page-link {
    margin-left: 0;
    border-top-left-radius: .25rem;
    border-bottom-left-radius: .25rem;
}
.page-link {
    position: relative;
    display: block;
    padding: .5rem .75rem;
    margin-left: -1px;
    line-height: 1.25;
    color: #007bff;
    background-color: #fff;
    border: 1px solid #dee2e6;
}
#searchBoxBack{
	background: #f8f8f8;
	border-top: 2px solid #E3E1E1;
	border-bottom: 1px solid #E3E1E1;
}
#replyCntimg{
	background : blue;
}
</style>
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
<script>
	var userId = "${authUser.user_id}";
	var nickname = "${authUser.user_nickname}";
</script>
<script>
	$(document).ready(
			function() {

				var result = '${result}';
				var message = '${message}';

				//checkModal(result);
				checkModal2(message);

				history.replaceState({}, null, null);

				function checkModal2(message) {
					if (message && history.state == null) {
						$("#myModal .modal-body p").html(message);
						$("#myModal").modal("show");
					}
				}

				function checkModal(result) {
					if (result === '' || history.state) {
						return;
					}

					if (parseInt(result) > 0) {
						$("#myModal .modal-body p").html(
								"게시글 " + result + "번이 등록되었습니다.");
					}
					$("#myModal").modal("show");
				}
			});
</script>
<script>
	//검색 버튼 유효성체크
	$(document).ready(function() {
		$("#searchButton").click(function(e) {
			var blank_pattern = /[\s]/g;
				if( blank_pattern.test($("#searchBox").val()) == true){
					alert('검색어를 입력해 주세요.');
					$("#searchBox").focus();//커서입력
			    		return false;
			}
		})
	})
</script>
<title>자유게시판 리스트</title>
</head>
<body>
	<u:mainNav></u:mainNav>
		<div class="container">
				<section id="container">
					<table class="table table table-hover">
						<thead>
							<tr>
								<th>NO</th>
								<th>제목</th>
								<th>닉네임</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="freeVO">
								<tr>
									<c:choose>
										<c:when test="${freeVO.free_notice == 2}">
											<td style="font-weight: bold; color: red; background-color:#F5F5F5;">공지</td>
										</c:when>
										<c:otherwise>
											<td>${freeVO.free_seq}</td>
										</c:otherwise>
									</c:choose>
									<td <c:if test="${freeVO.free_notice == 2}">style="background-color:#F5F5F5;"</c:if>>
										<c:url value="/freeboard/get" var="freeboardLink">
											<c:param value="${freeVO.free_seq }" name="free_seq" />
											<c:param value="${pageMaker.cri.pageNum }" name="pageNum" />
											<c:param value="${pageMaker.cri.amount }" name="amount" />
											<c:param value="${pageMaker.cri.type }" name="type" />
											<c:param value="${pageMaker.cri.keyword }" name="keyword" />
										</c:url> 
										<a href="${freeboardLink}" <c:choose><c:when test="${freeVO.free_notice == 2}">style="font-weight: bold; color: red;"</c:when><c:otherwise>style="color: black;"</c:otherwise></c:choose>> 
										<c:out value="${freeVO.free_title}" /> 
										<c:if test="${freeVO.free_replyCnt gt 0 }">
											<span class="badge badge-info" id="replyCntimg">${freeVO.free_replyCnt}</span>
										</c:if>
										</a>
									</td>
									<td <c:if test="${freeVO.free_notice == 2}">style="background-color:#F5F5F5;"</c:if>>
										<c:out value="${freeVO.free_nickname}" />
									</td>
									<td <c:if test="${freeVO.free_notice == 2}">style="background-color:#F5F5F5;"</c:if>>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${freeVO.free_regdate}" />
									</td>
									<td <c:if test="${freeVO.free_notice == 2}">style="background-color:#F5F5F5;"</c:if>>
										${freeVO.free_readCnt}
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
			<div id="searchBoxBack" class="row">
				<form action="${root }/freeboard/list" id="searchForm" class="form-inline my-0">
		      		<select name="type" class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref">
					   									 <!--여기서의 작성자는 유저의 닉네임 -->
					    <option value="T" ${pageMaker.cri.type eq 'T' ? 'selected' : '' }>제목</option>
					    <option value="C" ${pageMaker.cri.type eq 'C' ? 'selected' : '' }>내용</option>
					    <option value="W" ${pageMaker.cri.type eq 'W' ? 'selected' : '' }>작성자</option>
					    <option value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : '' }>제목 or 내용</option>
					    <option value="TW" ${pageMaker.cri.type eq 'TW' ? 'selected' : '' }>제목 or 작성자</option>
					    <option value="TWC" ${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }>제목 or 내용 or 작성자</option>
				  </select>
		      <input name="keyword" required value="${pageMaker.cri.keyword }" class="form-control mr-sm-2" type="search"
		       placeholder="검색어를 입력하세요" aria-label="Search" maxlength="20" id="searchbox">
		      <input type="hidden" name="pageNum" value="1" />
		      <input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
		      <button id="searchButton" class="btn my-2 my-sm-0 ml-3" type="submit" >검색</button>
		    	</form>
		    	<form action="${root }/freeboard/register">
		      <c:if test="${authUser!=null }">
				<button id="btn_add">글쓰기</button>
		      </c:if>
		    	</form>
		   </div>
	
	<div class="container-sm mt-3">
		<div class="row justify-content-center">
			<div class="pagerWrap">
					<c:if test="${pageMaker.prev }">
						<c:url value="/freeboard/list" var="prevLink">
							<c:param value="${pageMaker.startPage -1 }" name="pageNum" />
							<c:param value="${pageMaker.cri.amount }" name="amount" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
						<a href="${prevLink }" style="width:80px">Previous</a>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
						<c:url value="/freeboard/list" var="pageLink">
							<c:param name="pageNum" value="${num }" />
							<c:param name="amount" value="${pageMaker.cri.amount }" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
							<a class="${pageMaker.cri.pageNum eq num ? 'on' : '' }" href="${pageLink }">${num }</a>
					
					</c:forEach>
					<c:if test="${pageMaker.next }">
						<c:url value="/freeboard/list" var="nextLink">
							<c:param name="pageNum" value="${pageMaker.endPage +1 }" />
							<c:param name="amount" value="${pageMaker.cri.amount }" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
						<a href="${nextLink }" style="width:80px">Next</a>
					</c:if>
			</div>
		</div>
	</div>
	</section>
</div>
			<!--게시글 알림  -->
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
					<p>처리가 완료되었습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<u:footer/> 
</body>
</html>
 