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
	
	$("#resultId").hide();
	$("#notFind").hide();
	
	$("#btn_search").click(function() {
		var user_name = $("#user_name").val();
		var user_phone = $("#user_phone").val();
		
		
		$.ajax({
		    type: "GET",
		    url: "${root}/user/findUserId",
		    data: {"user_name" : user_name , "user_phone" : user_phone},
		    success: function(res) {
		    	console.log(res);
		    	$("#notFind").hide();
					$("#resultId").show();
					
					resultId.append(res);
					
					if (res == null || res == "") {
						$("#resultId").hide();
				    $("#notFind").show();
					}
		    }
		});
	});
	
});
</script>
<title>아이디 찾기</title>
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
</style>
<body>
<div class="container">
<h4>아이디 찾기</h4>
	<div class="row margin">
     <div class="input-field col s12">
       <!-- <i class="mdi-social-person-outline prefix"></i> -->
       <i class="material-icons prefix">portrait</i>
       <input type="text" class="form-control" id="user_name" name="user_name" placeholder="이름" >
     </div>
  </div>
   
   <div class="row margin">
     <div class="input-field col s12">
       <!-- <i class="mdi-social-person-outline prefix"></i> -->
       <i class="material-icons prefix">phone_android</i>
       <input type="text" style="margin-bottom: 0rem;" class="form-control" id="user_phone" name="user_phone" placeholder="휴대폰 번호 '-' 제외하고 입력해주세요"/>
     </div>
   </div>
   <div style="margin-left:51px;">
   	 <small class="form-text text-primary" id="resultId">아이디 : </small>
		 <small class="form-text text-danger" id="notFind">일치하는 정보가 없습니다.</small>
   </div>
   <br>
   <div class="row margin">
   	<button type="button" id="btn_search" class="btn waves-effect waves-light col s3">search</button>&nbsp;&nbsp;
   	<button type="button" id="btn_close" class="btn waves-effect waves-light col s3" onclick="window.close()">close</button>
	 </div>
</div>
</body>
</html>