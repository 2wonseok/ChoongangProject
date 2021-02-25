<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u"  tagdir="/WEB-INF/tags" %>
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

});	
</script>
<title>Insert title here</title>
</head>
<style>
#container {
    clear: both;
    position: relative;
    margin: 50px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
}
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
</style>
<body>
<u:mainNav/>
<div class="container">
<section id="container">
	<div id="login-page" class="row">
		<div class="z-depth-1 card-panel" style="margin-left: 255px;">
      <form class="login-form" action="${root }/user/login" method="post">
        <div class="row">
          <div class="input-field col s12 center">
            <!-- <img src="images/login-logo.png" alt="" class="circle responsive-img valign profile-image-login"/> -->
            <p class="center login-form-text">
            	<img alt="noImg" src="${root }/resources/logo/BCDLogo3.png" style="width:40%; height:40%;">
            </p>
          </div>
        </div>
        <div class="row margin">
          <div class="input-field col s12">
            <!-- <i class="mdi-social-person-outline prefix"></i> -->
            <i class="material-icons prefix">portrait</i>
            <input id="user_id" name="user_id" type="text" style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP6zwAAAgcBApocMXEAAAAASUVORK5CYII=&quot;); cursor: auto;"/>
            <label for="user_id" data-error="wrong" class="center-align" data-success="right">아이디</label>            
          </div>
        </div>
        <div class="row margin">
          <div class="input-field col s12">
            <!-- <i class="mdi-action-lock-outline prefix"></i> -->
            <i class="material-icons prefix">vpn_key</i>
            <input id="user_password" name="user_password" type="password" style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP6zwAAAgcBApocMXEAAAAASUVORK5CYII=&quot;);"/>
            <label for="user_password">패스워드</label>
          </div>
        </div>
	      <c:if test="${noUser != null}">
	      	<small class="text-danger">${noUser }</small>
			  </c:if>
        <div class="row">
          <div class="input-field col s12">
            <button type="submit" class="btn waves-effect waves-light col s12">Login</button>
          </div>
        </div>
        
        <div class="row">
          <div class="input-field col s6 m6 l6">
            <p class="margin medium-small"><a style="color: #666;" href="${root }/user/userRegister">Register Now!</a></p>
          </div>
          <div class="input-field col s6 m6 l6">
         		  <p class="margin right-align medium-small">
              	<a href="#" style="color: #666;;" onclick="window.open('${root}/user/findId','아이디찾기','width=500px;,height=300px;,location=no,status=no,scrollbars=no');">Forgot id ?</a>&nbsp;&nbsp;&nbsp;
             		<a href="#" style="color: #666;" onclick="window.open('${root}/user/findPw','비밀번호','width=550px;,height=420px;,location=no,status=no,scrollbars=no');">Forgot password ?</a>
              </p>
          </div>          
        </div>
      </form>
    </div>  
  </div>
</section>  
</div>  
<u:footer/>
</body>
</html>