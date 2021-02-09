<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u"  tagdir="/WEB-INF/tags" %>
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

<title>임시 메인 페이지</title>
</head>
<body>
<u:mainNav/>
<%-- <u:navbar/> --%>
접속 아이디 : ${authUser.user_id} <br>
접속 닉네임 : ${authUser.user_nickname} <br>
등급 : <c:choose>
					<c:when test="${authUser.user_grade < 1}">관리자</c:when>
					<c:when test="${authUser.user_grade > 0}">일반</c:when>
					<c:otherwise></c:otherwise>
			</c:choose> 
</body>
</html>