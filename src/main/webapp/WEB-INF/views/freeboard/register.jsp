<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script>
$(document).ready(function (){
	$('#registerButton').click(function(){
			var freeArr = ["free_title","free_content"];
			//입력 값 널 체크
			for(var i=0;i<freeArr.length;i++){
				//alert(arr[i]);
				if($.trim($('#'+freeArr[i]).val()) == ''){
					alert('제목 또는 내용 을 모두 입력해 주세요.');
					$('#'+freeArr[i]).focus();
					return false;
				}
			}
			//전송
			$("#registerRoot").submit();
	});
});
</script>


<title>Insert title here</title>
<style>
#container1 {
	clear: both;
	posistion: relative;
	margin: 35px auto 0px;
	padding: 0 0 50px 0;
	width: 1000px;
	z-index: 1;
	
}
#registerButton {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #4a4a4a;
    padding: 0px 30px;
    margin: 0px;
    line-height: 40px;
    float: right;
    width: 120px;
	height : 40px;
	border-radius: 3px;
	text-align: center;
}

</style>
</head>
<body>
	<u:mainNav></u:mainNav>
	<div class="container">
		<section id ="container1">
				<h1>게시물 작성</h1>
				<form method="post" id="registerRoot"  action="${root}/freeboard/register">
					<div class="form-group">
						<label for="input1">제목</label> <input name="free_title" type="text"
							class="form-control" id="free_title" placeholder="제목을 입력하세요." maxlength="15" required="required">
					</div>
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea name="free_content" class="form-control" id="free_content" placeholder="내용을 입력하세요."
							rows="3" maxlength="300" required="required"></textarea>
					</div>
					<div class="form-group">
						<label for="input2">닉네임</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="anonmyous" value="y" id="anonmyous_check"><label for="anonmyous_check">&nbsp;익명</label>
						&nbsp;
						<!--유저의 grade가  관리자일때만 보여지게  -->
						<c:if test="${authUser.user_grade == 0}">
							<input type="checkbox" name="notice" value="n" id="notice_check"><label for="notice_check">&nbsp;공지사항</label> 
						</c:if>
						<input name="free_nickname" type="text" class="form-control" id="free_nickname" value="${authUser.user_nickname }" readonly>
					</div>
					<button type="submit" id="registerButton" class="btn btn-primary">등록</button>
				</form>
		</section>
	</div>
 <u:footer/> 
</body>
</html>




