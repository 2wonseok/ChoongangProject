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
	$(document).ready(function() {
		
		function dateString(date) {
			var d = new Date(date);
			return d.toISOString().split("T")[0];
		}
		
	});	

</script>
<title>read Page</title>
</head>
<body>
<u:navbar/>

<div class="container col-6">
<h2>게시물 보기</h2>
	<div class="form-group">		
		<label for="input1">번호</label> 
		<input type="text" class="form-control" value="${read.user_seq }"  readonly/> <br/>
	</div>
	<div class="form-group">
		<label for="input2">아이디</label> 
		<input type="text" class="form-control" value="<c:out value='${read.user_id }'/>"  readonly/><br/>
	</div>
	<div class="form-group">
		<label for="input3">이름</label> 
		<input type="text" class="form-control" value="<c:out value="${read.user_name }"/>" readonly> <br/>
	</div>
	<div class="form-group">
		<label for="input4">닉네임</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_nickname }'/>"  readonly/> <br/>
	</div>
	<div class="form-group">
		<label for="input5">우편번호</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_addresscode }'/>"  readonly/> <br/>
	</div>
	<div class="form-group">
		<label for="input6">주소</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_address }'/>"  readonly/> <br/>
	</div>
		<div class="form-group">
		<label for="input7">이메일</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_email }'/>"  readonly/> <br/>
	</div>
		<div class="form-group">
		<label for="input8">휴대폰</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_phone }'/>"  readonly/> <br/>
	</div>
		<div class="form-group">
		<label for="input9">성별</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_gender }'/>"  readonly/> <br/>
	</div>
		<div class="form-group">
		<label for="input10">생년월일</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_birth }'/>"  readonly/> <br/>
	</div>
		<div class="form-group">
		<label for="input11">등급</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_grade }'/>"  readonly/> <br/>
	</div>
		<div class="form-group">
		<label for="input12">포인트</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_point }'/>"  readonly/> <br/>
	</div>
		<div class="form-group">
		<label for="input13">가입일</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.user_regdate }'/>"  readonly/> <br/>
	</div>
	<c:url value="/user/userModify" var="modifyLink">
		<c:if test="${cri.type != null && cri.keyword != null }">
			<c:param name="type" value="${cri.type }"></c:param>
			<c:param name="keyword" value="${cri.keyword }"></c:param>
		</c:if>
		<c:param name="seq" value="${read.user_seq }"></c:param>
		<c:param name="pageNum" value="${cri.pageNum }"></c:param>
		<c:param name="amount" value="${cri.amount }"></c:param>
	</c:url>
	<a href="${modifyLink}" class="btn btn-secondary">수정</a>
</div>
</body>
</html>