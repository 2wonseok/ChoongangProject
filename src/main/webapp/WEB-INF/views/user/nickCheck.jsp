<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
$("#searchId").click(function(e) {
	e.preventDefault();
	var user_nickname = $("#user_nickname").val();
	
	if (!user_id) {
		alert('닉네임 입력은 필수입니다.');
		return false;
	}
	
	$("#searchIdForm").attr("action", "${root }/user/searchIdCheck");
	$("#searchIdForm").submit();
});

function setParentText() {
	var user_nickname = $("#user_nickname").val();
  opener.document.getElementById("user_nickname").value = document.getElementById("user_nickname").value
  //opener.$("#user_id").val() = document.$("#user_id").val()
  window.close(); 
}

$(document).ready(function() {
	$("#close").click(function() {
		window.close();
	});
});

</script>
<title>Insert title here</title>
</head>
<style>
.btn_class {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 25px;
    margin: 0 0px;
    margin-top: -41px;
    line-height: 45px;
    float: right;
}
</style>
<body>
<div class="container">
<h2>중복체크</h2>
	<form action="${root }/user/searchIdCheck" id="searchIdForm" method="post">
		<input type="text" class="form-control" id="user_nickname" name="user_nickname" value="${user_nickname }" style="width:455px"/> 
		<button type="submit" class="btn_class" id="searchId">검색</button>
	</form>
	<div>
		<c:if test="${checkResultNcikY != null}">
			${checkResultNcikY} <br><br>
			<button type="button" class="btn_class" style="float:left; margin-top:0px" onclick="setParentText()">사용</button>&nbsp;&nbsp;
			<button type="button" class="btn_class" id="close" style="background: #747474; float:left; margin-top:0px; margin-left:2px;">닫기</button>
		</c:if>
		<c:if test="${checkResultNcikN != null}">
			${checkResultNcikN} <br><br>
			<button type="button" class="btn_class" id="close" style="background: #747474; float:left; margin-top:0px">닫기</button>
		</c:if>
	</div>
</div>
</body>
</html>