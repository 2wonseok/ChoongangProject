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
		
		// 비밀번호 일치 확인
		$("input").keyup(function() { 
			var pwd1=$("#input3-password").val(); 
			var pwd2=$("#input4-confirmPassword").val(); 
			
			if ($(this).val().length < 4 ) {
				$("#passwordLengthFail").show();
			} else {
				$("#passwordLengthFail").hide();
			}
			
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
		alert('인증번호 발송 완료!');
		
		$.ajax({
		    type: "GET",
		    url: "${root}/user/sendSMS",
		    data: {
		        "user_phone" : user_phone
		    }
		});
	});
		
	//인증번호 확인
	$('#zip_code_btns').click(function() {
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
	$("#idCheck").click(function() {
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
		if ($(this).val().length < 4 ) {
			$("#idLengthFail").show();
			$("#idCheck").attr("disabled", "disabled");
		} else {
			$("#idLengthFail").hide();
			$("#idCheck").removeAttr("disabled");
		}
		
  	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
  });	
	
	$('#user_nickname').on("blur keyup", function() {
		if ($(this).val().length < 4 ) {
			$("#nicknameLengthFail").show();
			$("#nickCheck").attr("disabled", "disabled");
		} else {
			$("#nicknameLengthFail").hide();
			$("#nickCheck").removeAttr("disabled");
		}
		
  });	
	// 글자 수 제한 닉네임
  $('#user_nickname').blur(function() {
  	
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
.btn_check {
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
	<h3>회원가입</h3><br>
	<form action="${root }/user/userRegister" method="post" id="joinForm">
		  <div class="form-group">
		    <label for="input1-id">아이디</label>
		    <input type="text" class="form-control" placeholder="중복 확인을 눌러주세요"  maxlength="21" style="width:77%;" name="user_id" id="user_id" 
		    	value="" required>
		    <small class="text-danger" id="idLengthFail">영문 숫자 최소 4글자 이상 입력해주세요.</small>
		    <button type="button" class="btn_check" id="idCheck">중복확인</button>
		    <small class="text-dark" id="idCheckSuccess">사용 가능합니다.</small>
		    <button type="button" id="idYes">확인</button>
		    <small class="text-danger" id="idCheckFail">이미 사용중인 아이디입니다.</small>
		  </div>
		  <div class="form-group">
		    <label for="input2-name">이름</label>
		    <input type="text" class="form-control" name="user_name" id="input2-name" value="" required>
		  </div>
		  <div class="form-group">
		    <label for="input8-nickname">닉네임</label>
		    <input type="text" class="form-control" limitbyte="24" style="width:77%;" name="user_nickname" id="user_nickname" 
		    	value="" placeholder="중복 확인을 눌러주세요" required>
		    <small class="text-danger" id="nicknameLengthFail">최소 4글자 이상 입력해주세요.</small>
		    <button type="button" class="btn_check"  id="nickCheck">중복확인</button>
		    <small class="text-dark" id="nickCheckSuccess">사용 가능합니다.</small>
		    <button type="button" id="nickYes">확인</button>
		    <small class="text-danger" id="nickCheckFail">이미 사용중인 닉네임입니다.</small>
		  </div>
		  <div class="form-group">
		    <label for="input3-password">패스워드</label>
		    <input type="password" class="form-control" name="user_password" id="input3-password" required>
		    <small class="text-danger" id="passwordLengthFail">최소 4글자 이상 입력해주세요.</small>
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
		    <input type="text" class="form-control" style="width:77%;" name="user_phone" 
		    	id="user_phone" value="" placeholder="'-' 제외하고 입력"  required>
		    <button type="button" id="zip_code_btn">인증하기</button><br>
		    <label for="input8-phone">인증번호</label>
		    <input type="text" class="form-control" style="width:83%;" name="phoneConfirm" 
		    	id="phoneConfirm"  placeholder="인증번호를 입력해주세요." required>
		    <button type="button" id="zip_code_btns" >완료</button>
		    <div class="alert alert-success" id="phone-success">인증되었습니다.</div> 
		 		<div class="alert alert-danger" id="phone-danger">인증 번호가 일치하지 않습니다.</div>
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