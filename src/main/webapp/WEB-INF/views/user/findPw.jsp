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
<script>
$(document).ready(function() {
	
	$("#resultPw").hide();
	$("#notFind").hide();
	$("#phone-success").hide(); 
	$("#phone-danger").hide();
	
	$("#btn_search").click(function() {
		var user_id = $("#user_id").val();
		var user_phone = $("#user_phone").val();
		var user_birth = $("#user_birth").val();
		
		$.ajax({
		    type: "GET",
		    url: "${root}/user/findUserPw",
		    dataType : "json",
		    data: {"user_id" : user_id , "user_phone" : user_phone, "user_birth" : user_birth},
		    success: function(res) {
	    		
		    	$("#notFind").hide();
					$("#resultPw").show();
					
					resultPw.append(res.user_password);
					
		    },
		    error : function(error) {
		    	$("#resultPw").hide();
		    	$("#notFind").show();
		    }
		});
	});
	
	// 휴대폰 인증 관련 AJAX 
	$("#user_phone").keyup(function() { 
		$("#btn_search").attr("disabled", "disabled"); 
		$('#zip_code_btn').click(function(){
			var user_phone = $('#user_phone').val();
			alert('인증번호 발송 완료!');
			
			$.ajax({
			    type: "GET",
			    url: "${root}/user/sendSMS",
			    data: {
			        "user_phone" : user_phone
			    },
			    success: function(res) {
		        $('#zip_code_btns').click(function(){
		            if($.trim(res) == $('#phoneConfirm').val()) {
		            	$("#user_phone").attr("readonly", true);
									$("#phoneConfirm").attr("readonly", true);
									$("#phone-success").show(); 
									$("#phone-danger").hide();
									$("#btn_search").removeAttr("disabled"); 
		            } else {
									$("#phone-success").hide(); 
									$("#phone-danger").show(); 
									$("#btn_search").attr("disabled", "disabled"); 
		            }
		        })
			    }
			});
		});
	}); 
	
});
</script>
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
#zip_code_btns {
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
<h4>비밀번호 찾기</h4>
	<input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디" > <br />
	<input type="text" class="form-control" style="width:67%;" id="user_phone" name="user_phone" placeholder="휴대폰 번호 '-' 제외하고 입력해주세요."/>
	<button type="button" id="zip_code_btn">인증번호 발송</button><br />
	<input type="text" class="form-control" id="phoneConfirm" 
		style="width:82%" name="phoneConfirm" placeholder="인증 번호를 입력해주세요."/>
	<button type="button" id="zip_code_btns">확인</button>
  <div class="alert alert-success" id="phone-success">인증되었습니다.</div> 
	<div class="alert alert-danger" id="phone-danger">인증 번호가 일치하지 않습니다.</div>
	<br />
	생년월일 <br />
	<input type="date" class="form-control" id="user_birth" name="user_birth" /><br />
	<input type="button" value="닫기" id="btn_exit" onclick="window.close()"/>
	<input type="submit" value="검색" id="btn_search"/>
	<small class="form-text text-primary" id="resultPw">비밀번호 : </small>
	<small class="form-text text-danger" id="notFind">일치하는 정보가 없습니다.</small>
</div>
</body>
</html>