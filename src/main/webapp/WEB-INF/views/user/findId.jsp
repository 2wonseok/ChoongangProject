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
	
	$("#resultId").hide();
	$("#notFind").hide();
	
	$("#btn_search").click(function() {
		var user_name = $("#user_name").val();
		var user_phone = $("#user_phone").val();
		
		
		$.ajax({
		    type: "GET",
		    url: "${root}/user/findInfo",
		    dataType : "json",
		    data: {"user_name" : user_name , "user_phone" : user_phone},
		    success: function(res) {
	    		
		    	$("#notFind").hide();
					$("#resultId").show();
					
					resultId.append(res.user_id);
					
		    },
		    error : function(error) {
		    	$("#resultId").hide();
		    	$("#notFind").show();
		    }
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
</style>
<body>
<div class="container">
<h4>아이디 찾기</h4><br />
	<input type="text" class="form-control" id="user_name" name="user_name" placeholder="이름" > <br />
	<input type="text" class="form-control" id="user_phone" name="user_phone" placeholder="휴대폰 번호 '-' 제외하고 입력해주세요"/><br />
	<input type="button" value="닫기" id="btn_exit" onclick="window.close()"/>
	<input type="submit" value="검색" id="btn_search"/>&nbsp;
	<small class="form-text text-primary" id="resultId">아이디 : </small>
	<small class="form-text text-danger" id="notFind">일치하는 정보가 없습니다.</small>
</div>
</body>
</html>