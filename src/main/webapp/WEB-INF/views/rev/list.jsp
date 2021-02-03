<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

<title>Insert title here</title>
</head>
<body>
	<div class="container-sm">
		<div class="row">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>#번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>수정일</th>
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
								<%-- <c:param value="${pageMaker.cri.pageNum }" name="pageNum" />
								<c:param value="${pageMaker.cri.amount }" name="amount" />
								<c:param name="type" value="${pageMaker.cri.type }" />
								<c:param name="keyword" value="${pageMaker.cri.keyword }" /> --%>
							</c:url>
							<td>${rev.rev_category }</td>
							<td><a href="${revLink }"> <c:out
										value="${rev.rev_title}" />
							</a></td>
							<td><c:out value="${rev.rev_writer}" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd/HH:mm"
									value="${rev.rev_regdate}" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd/HH:mm"
									value="${rev.rev_updatedate}" /></td>
									<td>${rev.rev_good }</td>
									<td>${rev.rev_hate }</td>
									<td>${rev.rev_readCnt }</td>
									
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>



</body>
</html>