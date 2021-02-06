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
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<title>Insert title here</title>
</head>
<style>
	.container h4 {
		text-align: center;
		padding : 7px;
		margin-top:10px;
		letter-spacing: -6px;
		font-size: 38px;
	}
	#btn_search {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float:right;
    margin-right: 5px;
	}
		#btn_exit {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #747474;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float:right;
	}
</style>
<body>
<div class="container">
<h4>비밀번호 찾기</h4>
<form action="find" method="post">
	<input type="hidden" name="oper" value="findPw" />
	<input type="text" class="form-control" name="findId" placeholder="아이디" > <br />
	<c:if test="${errors.findErrors }">
   <small class="form-text text-primary">일치하는 정보가 없습니다.</small>
  </c:if>	
	<input type="email" class="form-control" name="findEmail" placeholder="이메일"/><br />
	생년월일 <br />
	<input type="date" class="form-control" name="findBirth" /><br />
	<input type="button" value="닫기" id="btn_exit" onclick="window.close()"/>
	<input type="submit" value="검색" id="btn_search"/>
</form>
<c:if test="${not empty findRs }">
	<small class="form-text text-primary">회원님의 패스워드는 ${findRs.password } 입니다.</small>
</c:if>
</div>
</body>
</html>