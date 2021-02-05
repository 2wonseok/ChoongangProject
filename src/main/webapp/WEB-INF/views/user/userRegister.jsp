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
		e.preventDefault();
		
		var popup = window.open("${root}/user/idCheck","pop","width=570,height=420, scrollbars=yes, resizable=yes");
		
	});
	
		$("#alert-success").hide(); 
		$("#alert-danger").hide(); 
		
		$("input").keyup(function() { 
			var pwd1=$("#input3-password").val(); 
			var pwd2=$("#input4-confirmPassword").val(); 
			
			if(pwd1 != "" || pwd2 != "") { 
				if(pwd1 == pwd2) { 
					$("#alert-success").show(); 
					$("#alert-danger").hide(); 
					$("#btn_add").removeAttr("disabled"); 
				} else { 
					$("#alert-success").hide(); 
					$("#alert-danger").show(); 
					$("#btn_add").attr("disabled", "disabled"); 
				} 
			} 
		}); 
	
		
		$("#nickCheck").click(function(e) {
			var user_nick = $("#user_nickname").val();
			e.preventDefault();
			
			var popup = window.open("${root}/user/nickCheck","pop","width=570,height=420, scrollbars=yes, resizable=yes");
			
		});
	
		$("#zip_code_btn").click(function() {
			var user_phone = $("#user_phone").val();
			location.href="${root}/user/sendSMS?user_phone="+user_phone;
			
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
    width: 500px;
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
.btn_check {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #747474;
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
	<h3>회원가입</h3><br>
	<form action="${root }/user/userRegister" method="post" id="joinForm">
		  <div class="form-group">
		    <label for="input1-id">아이디</label>
		    <input type="text" class="form-control" style="width:77%;" name="user_id" id="input1-id" 
		    	value="" placeholder="중복 확인을 눌러주세요" required readonly>
		    <button type="button" class="btn_check" id="idCheck">중복확인</button><br>
		  </div>
		  <div class="form-group">
		    <label for="input2-name">이름</label>
		    <input type="text" class="form-control" name="user_name" id="input2-name" value="" required>
		  </div>
		  <div class="form-group">
		    <label for="input8-nickname">닉네임</label>
		    <input type="text" class="form-control" style="width:77%;" name="user_nickname" id="user_nickname" 
		    	value="" placeholder="중복 확인을 눌러주세요" readonly required>
		    <button type="button" class="btn_check"  id="nickCheck">중복확인</button><br>
		  </div>
		  <div class="form-group">
		    <label for="input3-password">패스워드</label>
		    <input type="password" class="form-control" name="user_password" id="input3-password" required>
		  </div>
		  <div class="form-group">
		    <label for="input4-confirmPassword">패스워드확인</label>
		    <input type="password" class="form-control" name="confirmPassword" id="input4-confirmPassword" required>
		  	<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div> 
		 		<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
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
		    <label for="user_phone">휴대폰</label>
		    <input type="text" class="form-control" style="width:77%;" name="user_phone" id="user_phone" value="" required>
		    <button id="zip_code_btn">인증하기</button><br>
		    <label for="input8-phone">인증번호</label>
		    <input type="text" class="form-control" style="width:83%;" name="phoneConfirm" id="input8-phone" value="" required>
		    <button id="zip_code_btns" >완료</button>
		  </div>
		  <div class="form-group">
		    <label for="addr">주소</label>
		    <input type="text" class="form-control" style="width:83%;" name="user_address" id="addr" required>
		    <button type="button" id="zip_code_btn" class="zip_code_btn" onclick="javascript:goPopup();">검색</button>
		  </div>
		  <div class="form-group">
		    <label for="zipNo">우편번호</label> 
		    <input type="text" class="form-control" name="user_addresscode" id="zipNo" required>
		  </div>
		  <input type="submit" value="가입완료" id="btn_add">
	</form>
</section>
</div>
</body>
</html>