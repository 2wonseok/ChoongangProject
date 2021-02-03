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
	$("#remove_btn").click(function(e) {
		e.preventDefault();
		$("#myModal .modal-body p").html("삭제하시겠습니까?");
		$("#myModal").modal("show");
		
		$("#yes").click(function() {
			$("#modify-form").attr("action", "${root}/user/userDelete");
			$("#modify-form").submit();
		});
	});
	
	$("#modify_btn").click(function(e) {
		e.preventDefault();
		$("#myModal .modal-body p").html("수정하시겠습니까?");
		$("#myModal").modal("show");
		
		$("#yes").click(function() {
			$("#modify-form").attr("action", "${root}/user/userModify");
			$("#modify-form").submit();
		});	
	});
});
</script>
<title>수정페이지</title>
</head>
<body>
<u:navbar/>
<div class="container col-6">
<h2>게시물 수정</h2>
	<form id="modify-form" action="${root}/user/userModify" method="post">
		<input type="hidden" name="pageNum" value=${cri.pageNum }>
		<input type="hidden" name="amount" value=${cri.amount }>
		<c:if test="${cri.type != null && cri.keyword != null }">
			<input type="hidden" name="type" value=${cri.type }>
			<input type="hidden" name="keyword" value=${cri.keyword }>
		</c:if>
		<div class="form-group">		
			<label for="input1">번호</label> 
			<input type="text" class="form-control" id="input1" value="${read.user_seq }" name="user_seq" readonly/> <br/>
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
			<input type="text" class="form-control"  name="user_nickname" value="<c:out value='${read.user_nickname }'/>"  /> <br/>
		</div>
		<div class="form-group">
			<label for="input5">우편번호</label> 
			<input type="text" class="form-control" name="user_addresscode" value="<c:out value='${read.user_addresscode }'/>"  /> <br/>
		</div>
		<div class="form-group">
			<label for="input6">주소</label> 
			<input type="text" class="form-control"  name="user_address" value="<c:out value='${read.user_address }'/>"  /> <br/>
		</div>
			<div class="form-group">
			<label for="input7">이메일</label> 
			<input type="text" class="form-control"  name="user_email" value="<c:out value='${read.user_email }'/>"  /> <br/>
		</div>
			<div class="form-group">
			<label for="input8">휴대폰</label> 
			<input type="text" class="form-control" name="user_phone" value="<c:out value='${read.user_phone }'/>"  /> <br/>
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
		<div class="form-group">
			<label for="input14">패스워드</label> 
			<input type="text" class="form-control"  name="user_password" value="" /> <br/>
		</div>
		<button id="modify_btn" class="btn btn-success" >수정완료</button>
		<button id="remove_btn" class="btn btn-danger" >삭제</button>
		<%-- <a href="${root}/board/remove?bno=${read.bno}" id="remove_btn" class="btn btn-danger">삭제</a> --%>
	</form>
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
        <p>""</p>
      </div>
      <div class="modal-footer">
        <button type="button" id="yes" class="btn btn-primary">예</button>
        <button type="button" id="no" class="btn btn-secondary" data-dismiss="modal">아니요</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>