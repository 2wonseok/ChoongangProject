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
	
	$("#resultPw").hide();
	$("#notFind").hide();
	$("#phone-success").hide(); 
	$("#phone-danger").hide();
	$("#null").hide();
	
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
					
					location.href='${root}/user/modifyPw?user_id='+res.user_id;
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
	}); 	
	
	$('#phoneCheck').click(function(){
		var user_phone = $('#user_phone').val();
		
		$.ajax({
		    type: "GET",
		    url: "${root}/user/sendSMS",
		    dataType: "JSON",
		    data: {
		        "user_phone" : user_phone
		    },
		    success: function(res) {
		    	console.log(res);
		    	console.log(res);
		    	if (res == 2) {
						$("#null").show();
		    	}
		    }
		});
	});
	
	//인증번호 확인
	$('#confirmPhone').click(function() {
		var phoneConfirm = $('#phoneConfirm').val();		

		$.ajax ({
			type: "GET",
			url: "${root}/user/authentication",
			dataType : "json",
			data: { "phoneConfirm" : phoneConfirm},
			success: function(res) {
				if(res == 0) {
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
		 }
			
		});
	 
  });
	
	
});
</script>
<title>Insert title here</title>
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
		background-color:#fff;
		color:black;
    margin-left: 321px;
    margin-top: -36px;
}
#confirmPhone {
		background-color:#fff;
		color:black;
		margin-left: 321px;
    margin-top: -36px;
}
</style>
<body>
<div class="container">
<h4>비밀번호 찾기</h4>
	<div class="row margin">
	  <div class="input-field col s12">
	    <!-- <i class="mdi-social-person-outline prefix"></i> -->
	    <i class="material-icons prefix">portrait</i>
	    <input type="text" id="user_id" name="user_id" placeholder="아이디" >
	  </div>
  </div>
  
  <div class="row margin">
     <div class="input-field col s12">
       <!-- <i class="mdi-social-person-outline prefix"></i> -->
       <i class="material-icons prefix">phone_android</i>
       <input type="text" style="margin-bottom: 0rem;" id="user_phone" name="user_phone" placeholder="휴대폰 번호 '-' 제외"/>
     	 <button type="button" id="phoneCheck" class="btn waves-effect col s3">인증하기</button>
     </div>
   </div>
   
   <div style="margin-left:51px;">
     <small class="text-danger" id="null">번호를 입력해주세요.</small>
   </div>
   
   <div class="row margin">
     <div class="input-field col s12">
       <!-- <i class="mdi-social-person-outline prefix"></i> -->
       <i class="material-icons prefix">vpn_key</i>
       <input type="text" style="margin-bottom: 0rem;" id="phoneConfirm" name="phoneConfirm" placeholder="인증번호를 입력해주세요"/>
     	 <button type="button" id="confirmPhone" class="btn waves-effect col s3">확인</button>
     </div>
   </div>
   
   <div style="margin-left:51px;">
     <small class="text-primary" id="phone-success">인증되었습니다.</small> 
		 <small class="text-danger" id="phone-danger">인증 번호가 일치하지 않습니다.</small>
	 </div>
	 
	 <div class="row margin">
	   <div class="input-field col s12">
	     <!-- <i class="mdi-action-lock-outline prefix"></i> -->
	     <i class="material-icons prefix">perm_contact_calendar</i>
	     <input id="user_birth" name="user_birth" type="date" required/>
	     <label for="user_birth">생년월일</label>
	   </div>
   </div>
   <div style="margin-left:51px;">
   	 <small class="text-primary" id="resultPw">비밀번호 : </small>
		 <small class="text-danger" id="notFind">일치하는 정보가 없습니다.</small>
   </div>
	<br />
	<div class="row margin">
   	<button type="button" id="btn_search" class="btn waves-effect waves-light col s3">search</button>&nbsp;&nbsp;
   	<button type="button" id="btn_close" class="btn waves-effect waves-light col s3" onclick="window.close()">close</button>
	 </div>
</div>
</body>
</html>