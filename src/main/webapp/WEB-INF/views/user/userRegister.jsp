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
var goPopup = function(){ 
	var pop = window.open("${root}/user/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes");
	} 
	var jusoCallBack = function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo) { 
		document.getElementById("zipNo").value = zipNo; 
		document.getElementById("addr").value = roadAddrPart1 + " " + addrDetail; 
		if(addrDetail.length>30) { 
			alert('상세주소가 너무 길어 다시 입력해야 합니다.'); 
			return; 
		} 
		
		document.getElementById("addrDetail").value = addrDetail; 
	}

$(document).ready(function() {
	$("#idCheck").click(function(e) {
		var user_id = $("#input1-id").val();
		
		alert(user_id);
		e.preventDefault();
		var popup = window.open("${root}/user/idCheck?user_id="+user_id,"pop","width=570,height=420, scrollbars=yes, resizable=yes");
	});
});


</script>
<title>회원 가입</title>
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
<section id="container">
	<h3>회원가입</h3>
	<form action="${root }/user/userRegister" method="post" id="joinForm">
		  <div class="form-group">
		    <label for="input1-id">아이디</label>
		    <input type="text" class="form-control" style="width:368px;" name="user_id" id="input1-id" value="" required>
		    <button type="button" id="idCheck">중복확인</button><br>
		  </div>
		  <div class="form-group">
		    <label for="input2-name">이름</label>
		    <input type="text" class="form-control" name="user_name" id="input2-name" value="" required>
		  </div>
		  <div class="form-group">
		    <label for="input8-nickname">닉네임</label>
		    <input type="text" class="form-control" name="user_nickname" id="input8-nickname" value="" required>
		  </div>
		  <div class="form-group">
		    <label for="input3-password">패스워드</label>
		    <input type="password" class="form-control" name="user_password" id="input3-password" required>
		  </div>
		  <div class="form-group">
		    <label for="input4-confirmPassword">패스워드확인</label>
		    <input type="password" class="form-control" name="confirmPassword" id="input4-confirmPassword" required>
		  </div>
		  <div class="form-group">
		    <label for="input5-gender">성별</label> <br>
		    <span>남</span>&nbsp;<input type="radio" style="width:16px; height:16px;" name="user_gender" value="male">
		    <span>여</span>&nbsp;<input type="radio" style="width:16px; height:16px;" name="user_gender" value="famale">
		  </div>
		  <div class="form-group">
		    <label for="input6-birth">생년월일</label>
		    <input type="date" class="form-control" name="user_birth" id="input2-name" value="" required> 
		  </div>
		  <div class="form-group">
		    <label for="input7-phone">휴대폰</label>
		    <input type="text" class="form-control" style="width:368px;" name="user_phone" id="input7-phone" value="" required>
		    <button id="zip_code_btn">인증하기</button><br>
		    <label for="input8-phone">인증번호</label>
		    <input type="text" class="form-control" style="width:397px;" name="phoneConfirm" id="input8-phone" value="" required>
		    <button id="zip_code_btn">완료</button>
		  </div>
		  <div class="form-group">
		    <label for="addr">주소</label>
		    <input type="text" class="form-control" style="width:397px;" name="user_address" id="addr" required>
		    <button type="button" id="zip_code_btn" class="zip_code_btn" onclick="javascript:goPopup();">검색</button>
		  </div>
		  <div class="form-group">
		    <label for="zipNo">우편번호</label> 
		    <input type="text" class="form-control" name="user_addresscode" id="zipNo" required>
		  </div>
		  <input type="submit" value="가입완료" id="btn_add">
	</form>
</section>
</body>
</html>