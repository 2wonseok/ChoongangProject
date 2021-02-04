<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
$(document).ready(function(){
	var message = '${message}';
	
	checkModal(message);
	
	history.replaceState({}, null, null);
	
	function checkModal(message) {
		if (message && history.state == null) {
			$("#myModal .modal-body p").html(message);
			$("#myModal").modal("show");
		}
	}
	
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});

});
</script>
<title>Insert title here</title>
</head>
<body>
<u:navbar/>

<div class="container">
<h1>user list page입니다.</h1>
	<form action="${root }/user/userCheckDel" method="post">
	<input type="submit" value="선택 삭제" class="btn btn-danger"/>
	<table class="table table-striped">
		<thead>
			<tr>
				<th><input type="checkbox" id="allCheck"  value="${user.user_seq }"/></th>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>성별</th>
				<th>가입일</th>
			</tr>
		</thead>
		<c:forEach items="${list }" var="user">
			<c:url value="/user/userRead" var="readLink">
				<c:if test="${cri.type != null && cri.keyword != null }">
					<c:param name="type" value="${cri.type }"></c:param>
					<c:param name="keyword" value="${cri.keyword }"></c:param>
				</c:if>	
				<c:param name="seq" value="${user.user_seq }"></c:param>
				<c:param name="pageNum" value="${cri.pageNum }"></c:param>
				<c:param name="amount" value="${cri.amount }"></c:param>
			</c:url>
			<tr>
				<td><input type="checkbox" id="seq" name="seq" value="${user.user_seq }" /></td>
				<td>${user.user_seq }</td>
				<td>
					<a href="${readLink }"><c:out value="${user.user_id }"></c:out>
					</a>
				</td>
				<td><c:out value="${user.user_name}"></c:out></td>
				<td><c:out value="${user.user_phone}"></c:out></td>
				<td><c:out value="${user.user_gender}"></c:out></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${user.user_regdate }"/></td>
			</tr>
		</c:forEach>
	</table>
	</form>
</div>
<div class="container-sm mt-3">
	<div class="row justify-content-center">
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<c:url value="/user/userList" var="preLink">
						<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
							<c:param name="type" value="${pageMaker.cri.type }"></c:param>
							<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
						</c:if>
						<c:param name="pageNum" value="${pageMaker.startPage - 1 }"></c:param>
						<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${preLink}">Previous</a></li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<c:url value="/user/userList" var="pageLink">
						<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
							<c:param name="type" value="${param.type }"></c:param>
							<c:param name="keyword" value="${param.keyword }"></c:param>
						</c:if>	
						<c:param name="pageNum" value="${num }"></c:param>
						<c:param name="amount" value="${pageMaker.cri.amount }"></c:param>
					</c:url>
					<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="${pageLink}">${num }</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next }">
					<c:url value="/user/userList" var="nextLink">
						<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
							<c:param name="type" value="${pageMaker.cri.type }"></c:param>
							<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
						</c:if>
						<c:param name="pageNum" value="${pageMaker.endPage + 1 }"></c:param>
						<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${nextLink }">Next</a></li>
				</c:if>
			</ul>
<!-- 		 	</form>  -->
		</nav>
	</div>
</div>

<div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">알림</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>크크크크크크</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>