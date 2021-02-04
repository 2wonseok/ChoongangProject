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
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<title>로그인 페이지</title>
</head>
<style>
#container {
    clear: both;
    position: relative;
    margin: 50px auto 0px;
    padding: 0 0 50px 0;
    width: 480px;
    z-index: 1;
}
#btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}
#zip_code_btn {
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
#idCheck {
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
<u:navbar/>
<div class="container">
	<section id="container">
		<form action="${root }/user/login" method="post">
			<div class="form-group">
		    <input type="text" class="form-control" placeholder="아이디" name="user_ud" id="input1-id" value="">
		  </div>
		  <div class="form-group">
		    <input type="password" class="form-control" placeholder="비밀번호" name="user_password" id="input2-password">
		  </div>
		 	<input type="submit" value="로그인" id="btn_add" class="btn btn-block btn-lg"> <br><hr>
		 	<div class="container d-flex justify-content-center">
		 	<a href="#" onclick="window.open('find?oper=id','아이디찾기','width=500px;,height=300px;,location=no,status=no,scrollbars=no');" style="color:gray;">아이디 찾기</a><p style="color:gray;">&nbsp;|&nbsp;</p>
		 	<a href="#" onclick="window.open('find?oper=pw','비밀번호','width=500px;,height=350px;,location=no,status=no,scrollbars=no');" style="color:gray;">비밀번호 찾기</a><p style="color:gray;">&nbsp;|&nbsp;</p>
		  <a href="${root }/user/userRegister" style="color:gray;">회원가입</a>
		 	</div>
	</form>
	</section>
</div>
</body>
</html>