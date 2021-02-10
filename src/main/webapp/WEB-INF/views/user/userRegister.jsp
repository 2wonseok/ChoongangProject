<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u"  tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
 <!-- Compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<!-- Compiled and minified JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!--Import materialize.css-->
<script>
// 주소 API 관련 스크립트
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
		
		// 각 엘리먼트 오류 창 숨김
		$("#alert-success").hide(); 
		$("#alert-danger").hide(); 
		$("#phone-success").hide(); 
		$("#phone-danger").hide();
		$("#idCheckSuccess").hide(); 
		$("#idCheckFail").hide();
		$("#idYes").hide();
		$("#nickCheckSuccess").hide(); 
		$("#nickCheckFail").hide();
		$("#nickYes").hide();
		$("#idLengthFail").hide();
		$("#nicknameLengthFail").hide();
		$("#passwordLengthFail").hide();
		$("#inUse").hide();
		$("#null").hide();
		$("#noUse").hide();
		
		// 비밀번호 일치 확인
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
		
		// 휴대폰 인증 관련 AJAX 
	$("#user_phone").keyup(function() { 
		$("#btn_add").attr("disabled", "disabled"); 
	}); 	
		
	$('#zip_code_btn').click(function(){
		var user_phone = $('#user_phone').val();
		
		$.ajax({
		    type: "GET",
		    url: "${root}/user/sendSMS",
		    dataType : "json",
		    data: {
		        "user_phone" : user_phone
		    },
		    success: function(res) {
		    	console.log(res);
		    	console.log(res);
		    	if (res == 0) {
		    		$("#null").hide();
		    		$("#inUse").hide();
		    		$("#noUse").show();
		    	} else if(res == 1) {
		    		$("#noUse").hide();
		    		$("#null").hide();
		    		$("#inUse").show();
		    	} else {
		    		$("#noUse").hide();
		    		$("#inUse").hide();
		    		$("#null").show();
		    	}
		    }
		});
	});
		
	//인증번호 확인
	$('#phoneConfirmBtn').click(function() {
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
					$("#btn_add").removeAttr("disabled"); 
				} else {
					$("#phone-success").hide(); 
					$("#phone-danger").show(); 
					$("#btn_add").attr("disabled", "disabled"); 
				}
		 }
			
		});
	 
  });
		
	// ID 중복 체크 관련 스크립트
	$("#idConfirm").click(function() {
		$("#btn_add").attr("disabled", "disabled");
		var user_id = $("#user_id").val();
		
		$.ajax({
		    type: "GET",
		    url: "${root}/user/duplicateCheck",
		    dataType : "json",
		    data: {
		        "user_id" : user_id
		    },
		    success: function(res) {
		    	console.log(res);
		    	if(res == 0) {
						$("#idCheckSuccess").show(); 
						$("#idCheckFail").hide();
						$("#idYes").show();
						
						$("#idYes").click(function() {
							$("#user_id").attr("readonly", true);
							$("#idYes").hide();
							$("#idCheckSuccess").hide(); 
							$("#btn_add").removeAttr("disabled"); 
						})
		      } else {
						$("#idCheckSuccess").hide(); 
						$("#idCheckFail").show(); 
						$("#idYes").hide();
						$("#btn_add").attr("disabled", "disabled"); 
		      }
	        
		    }
		});
	});
	
	// 닉네임 중복체크 관련 로직
	$("#nickCheck").click(function() {
		$("#btn_add").attr("disabled", "disabled");
		var user_nickname = $("#user_nickname").val();
		
		$.ajax({
		    type: "GET",
		    url: "${root}/user/duplicateCheck",
		    dataType : "json",
		    data: {
		        "user_nickname" : user_nickname
		    },
		    success: function(res) {
		    	console.log(res);
		    	if(res == 0) {
						$("#nickCheckSuccess").show(); 
						$("#nickCheckFail").hide();
						$("#nickYes").show();
					
						$("#nickYes").click(function() {
							$("#user_nickname").attr("readonly", true);
							$("#nickYes").hide();
							$("#nickCheckSuccess").hide(); 
							$("#btn_add").removeAttr("disabled"); 
						})
		      } else {
							$("#nickCheckSuccess").hide(); 
							$("#nickCheckFail").show(); 
							$("#btn_add").attr("disabled", "disabled"); 
		      }
	        
		    }
		});
	});
	
//글자 수 제한 아이디
	$('#user_id').on("blur keyup", function() {
		$("#btn_add").attr("disabled", "disabled");
		if ($(this).val().length < 4 ) {
			$("#idLengthFail").show();
			$("#idConfirm").attr("disabled", "disabled");
		} else {
			$("#idLengthFail").hide();
			$("#idConfirm").removeAttr("disabled");
		}
		
  	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
  });	
  
	$('#user_password').on("blur keyup", function() {
		if ($(this).val().length < 4 ) {
			$("#passwordLengthFail").show();
		} else {
			$("#passwordLengthFail").hide();
		}
	});	
	
	$('#user_nickname').on("blur keyup", function() {
		if ($(this).val().length < 2 ) {
			$("#nicknameLengthFail").show();
			$("#nickCheck").attr("disabled", "disabled");
		} else {
			$("#nicknameLengthFail").hide();
			$("#nickCheck").removeAttr("disabled");
		}
		
  });	
	// 글자 수 제한 닉네임
  $('#user_nickname').blur(function() {
	  $("#btn_add").attr("disabled", "disabled");
    var thisObject = $(this);
    
    var limit = thisObject.attr("limitbyte"); //제한byte를 가져온다.
    var str = thisObject.val();
    var strLength = 0;
    var strTitle = "";
    var strPiece = "";
    var check = false;
            
    for (i = 0; i < str.length; i++){
        var code = str.charCodeAt(i);
        var ch = str.substr(i,1).toUpperCase();
        //체크 하는 문자를 저장
        strPiece = str.substr(i,1)
        
        code = parseInt(code);
        
        if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))) {
            strLength = strLength + 3; //UTF-8 3byte 로 계산
        } else {
            strLength = strLength + 1;
        }
        
        if(strLength>limit){ //제한 길이 확인
            check = true;
            break;
        }else{
            strTitle = strTitle+strPiece; //제한길이 보다 작으면 자른 문자를 붙여준다.
        }
        
    }
    
    if(check){
    	alert('영문, 숫자 최대 24글자 한글 최대 8글자까지 입력 가능합니다.');
    }
    
    thisObject.val(strTitle);
    
});
	
});
</script>
<title>Insert title here</title>
</head>
<style>
.row .col.s2 {
    width: 16.66666%;
    margin-left: 356px;
    /* margin-left: auto; */
    margin-top: -46px;
    /* left: auto; */
    /* right: auto; */
}
.row .col.s3 {
    width: 25%;
    margin-left: 320px;
    /* margin-left: auto; */
    margin-top: -46px;
    /* left: auto; */
    /* right: auto; */
}
.medium-small {
    font-size: 0.9rem;
    margin: 0;
    padding: 0;
}

.login-form {
    width: 450px;
    margin-left:390px;
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
#idConfirm:hover {
	background: #e0e0e0;
}
#nickConfirm:hover {
	background: #e0e0e0;
}
#zip_code_btn:hover {
	background: #e0e0e0;
}
#phoneConfirmBtn:hover {
	background: #e0e0e0;
}

.text-danger {
  margin-left: 42px;
}
.text-primary {
	margin-left: 42px;
}
</style>
<body>
<u:mainNav/>
<div class="container">
	<div id="login-page" class="row">
    <form class="login-form" action="${root }/user/userRegister" method="post" id="joinForm">
      <div class="row">
        <div class="input-field col s12 center">
          <h4>회원가입</h4>
          <p class="center">BCD 쇼핑몰에 오신걸 환영합니다.</p>
        </div>
      </div>
			<div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">portrait</i>
          <input id="user_id" name="user_id" type="text" required/>
          <button type="button" id="idConfirm" class="btn waves-effect waves-light col s3">중복확인</button>
          <label for="user_id">아이디</label>
          <small class="text-danger" id="idLengthFail">영문 숫자 최소 4글자 이상 입력해주세요.</small>
          <small class="text-primary" id="idCheckSuccess">사용 가능합니다.</small>
		    	<button type="button" id="idYes">확인</button>
          <small class="text-danger" id="idCheckFail">이미 사용중인 아이디입니다.</small>
        </div>
      </div>
      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">account_circle</i>
          <input id="user_name" name="user_name" type="text" required/>
          <label for="user_name">이름</label>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">person_outline</i>
          <input id="user_nickname" name="user_nickname" type="text" style="cursor: auto;" required />
          <button type="button" id="nickCheck" class="btn waves-effect col s3">중복확인</button>
          <label for="user_nickname">닉네임</label>
          <small class="text-danger" id="nicknameLengthFail">최소 2글자 이상 입력해주세요.</small>
          <small class="text-primary" id="nickCheckSuccess">사용 가능합니다.</small>
		  	  <button type="button" id="nickYes">확인</button>
			    <small class="text-danger" id="nickCheckFail">이미 사용중인 닉네임입니다.</small>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="user_password" id="user_password" name="user_password" type="password" required />
          <label for="user_password">패스워드</label>
          <small class="text-danger" id="passwordLengthFail">최소 4글자 이상 입력해주세요.</small>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="confirmPassword" name="confirmPassword" type="password" required/>
          <label for="confirmPassword">패스워드 확인</label>
          <small class="text-primary" id="alert-success">비밀번호가 일치합니다.</small> 
		 			<small class="text-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</small>
        </div>
      </div>
			
			<div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">perm_contact_calendar</i>
          <input id="user_birth" name="user_birth" type="date" required/>
          <label for="user_birth">생년월일</label>
        </div>
      </div>
      
			<div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">phone_android</i>
          <input id="user_phone" name="user_phone" type="text" required/>
          <button type="button" id="zip_code_btn" class="btn waves-effect waves-light col s3">인증하기</button>
          <label for="user_phone">'-' 제외하고 입력</label>
          <small class="text-primary" id="noUse">인증번호가 전송되었습니다.</small>
          <small class="text-danger" id="null">번호를 입력해주세요.</small>
          <small class="text-danger" id="inUse">이미 등록된 번호입니다.</small>
        </div>
      </div>
      
      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="phoneConfirm" name="phoneConfirm" type="text" required/>
          <button type="button" id="phoneConfirmBtn" class="btn waves-effect waves-light col s2">확인</button>
          <label for="phoneConfirm">인증번호 입력</label>
          <small class="text-success" id="phone-success">인증되었습니다.</small> 
		 			<small class="text-danger" id="phone-danger">인증 번호가 일치하지 않습니다.</small>
        </div>
      </div>
      
      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">home</i>
          <input id="addr" name="user_address" type="text" required/>
          <button type="button" id="zip_code_btn" onclick="javascript:goPopup();" class="btn waves-effect waves-light col s2">검색</button>
          <label for="user_address">주소</label>
        </div>
      </div>
      
      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">home</i>
          <input id="zipNo" name="user_addresscode" type="text" required/>
          <label for="user_addresscode">우편번호</label>
        </div>
      </div>
      
      <div class="row">
        <div class="input-field col s12">
          <button type="submit" id="btn_add" class="btn waves-effect waves-light col s12">REGISTER NOW</button>
        </div>
        
        <div class="input-field col s12">
          <p class="margin center medium-small sign-up">Already have an account? <a href="./login">Login</a></p>
        </div>
      </div>
    </form>
  </div>
</div>
</body>
</html>