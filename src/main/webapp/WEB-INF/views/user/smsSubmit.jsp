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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<script>
$(document).ready(function() {
	$("#smsSubmit").click(function(e) {
		e.preventDefault();
		var smsContent = $("#smsContent").val();
		
		if (!smsContent) {
			alert('내용을 입력해주세요.');
			return false;
		}
		
		var result = confirm("전송하시겠습니까?");
		
		if (result) {
			$("#Submit").attr("action", "${root }/user/smsSubmit");
			$("#Submit").submit();
		} else {
			return false;
		}
		
	});
	
	$('#smsContent').on('keyup', function() {
        $('#test_cnt').html("("+$(this).val().length+" / 1000)");
 
        if($(this).val().length > 1000) {
            $(this).val($(this).val().substring(0, 1000));
            $('#test_cnt').html("(1000 / 1000)");
        }
    });
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
    width: 1200px;
    z-index: 1;
}
#smsSubmit {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 10px;
    margin: 0 0px;
    margin-bottom : 3px;
    line-height: 45px;
    float: left;
    width:110px;
}
</style>
<body>
<u:mainNav/>
<c:choose>
	<c:when test="${authUser.user_grade == 0}">
<div class="container">
	<section id="container">
	<h3>문자 전송</h3>
		받는 사람: 
		<form action="${root }/user/smsSubmit" id="Submit" method="post">
			<div style="border: 1px solid; width:310px; margin-top:5px; border-radius:0.2em">
				<c:forEach items="${user }" var="users">
					<div>
						<input type="text" name="user_name" value="${users.user_name }" readonly style="width:50px; border:0;"> :&nbsp;
						<input type="text" id="user_phone" name="user_phone" value="${users.user_phone }" readonly style="width:100px; border:0;">
		 			</div>
				</c:forEach>
			</div>
			<textarea style="border: 1px solid; width:310px; margin-top:5px; border-radius:0.2em;" id="smsContent" name="smsContent" rows="10" cols="40" placeholder="메세지를 입력하세요."></textarea><br>
			<div id="test_cnt">(0 / 45)</div>
			<button type="submit" id="smsSubmit">보내기</button>
		</form>
	</section>
</div>
	</c:when>
	<c:otherwise>
		<script>
			alert('관리자만 접근 가능합니다.');
			location.href='${root}/main/mainPage';
		</script>
	</c:otherwise>
</c:choose>
<u:footer/>
</body>
</html>