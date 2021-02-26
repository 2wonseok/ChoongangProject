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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
 <!-- Compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<!-- Compiled and minified JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script>
$(document).ready(function() {
	
	$("#alert-success").hide(); 
	$("#alert-danger").hide(); 
	
	$("input").keyup(function() {  
		var pwd1=$("#user_password").val(); 
		var pwd2=$("#confirmPassword").val(); 
		
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
	
	$("#btn_add").click(function() {
		var user_password = $("#user_password").val();
		var user_id = $("#user_id").val();
		
		$.ajax({
			type: "POST",
			url: '${root}/user/modifyPw',
			dataType: "JSON",
			data: {"user_id":user_id, "user_password": user_password},
			success : function(res) {
				console.log(res);
				if (res == 1) {
					alert('변경되었습니다.');
					window.close();
				} else {
					alert('실패했습니다.');
				}
				
			}
		});
		
	});
	
});
</script>
<title>비밀번호 변경</title>
</head>
<style>

html, body {
    height: 100%;
}

.medium-small {
    font-size: 0.9rem;
    margin: 0;
    padding: 0;
}

.login-form {
    width: 450px;
}


.login-form-text {
    text-transform: uppercase;
    letter-spacing: 2px;
    font-size: 0.8rem;
}

.login-text {
    margin-top: -6px;
    margin-left: -6px !important;
}

.margin {
    margin: 0 !important;
}

.pointer-events {
  pointer-events: auto !important;
}

.input-field >.material-icons  {
  padding-top:10px;
}

.input-field div.error{
    position: relative;
    top: -1rem;
    left: 3rem;
    font-size: 0.8rem;
    color:#FF4081;
    -webkit-transform: translateY(0%);
    -ms-transform: translateY(0%);
    -o-transform: translateY(0%);
    transform: translateY(0%);
}
.col {
    -ms-flex-preferred-size: 0;
    flex-basis: 1;
    -ms-flex-positive: 1;
    flex-grow: 1;
    max-width: 101%;
}
#btn_search {
	background-color:#fff;
	color:black;
}
#btn_close {
	background-color:#fff;
	color:black;
}
#btn_search:hover {
	background: #e0e0e0;
}
#btn_close:hover {
	background: #e0e0e0;
}
#phoneCheck {
    margin-left: 289px;
    margin-top: -36px;
}
#confirmPhone {
		margin-left: 289px;
    margin-top: -36px;
}
</style>
<body>
<div class="container">
	<h4>비밀번호 변경</h4>
	<input type="hidden" id="user_id" name="user_id" value="${param.user_id }"/>
	<div class="row margin">
	  <div class="input-field col s12">
	    <!-- <i class="mdi-social-person-outline prefix"></i> -->
	    <i class="material-icons prefix">vpn_key</i>
	    <input type="password" id="user_password" name="user_password" placeholder="패스워드" >
	  </div>
  </div>
  
  <div class="row margin">
	  <div class="input-field col s12">
	    <!-- <i class="mdi-social-person-outline prefix"></i> -->
	    <i class="material-icons prefix">vpn_key</i>
	    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="패스워드 확인" >
	  </div>
  </div>
	<div style="margin-left:51px;">
  	<small class="text-primary" id="alert-success">비밀번호가 일치합니다.</small> 
		<small class="text-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</small>
  </div>  
  
  <div class="row margin">
   	<button type="button" id="btn_add" class="btn waves-effect waves-light col s3">변경</button>&nbsp;&nbsp;
	 </div>
</div>
</body>
</html>