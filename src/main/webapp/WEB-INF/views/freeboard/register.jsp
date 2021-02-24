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
<title>자유게시판 글 쓰기</title>
<style>
#footdiv {
    width: 1000px;
    padding: 0 30px 30px 30px;
    text-align: center;
    color: gray;
    white-space: pre-line;
  	bottom:0;
  	margin-bottom: -143px;
}
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
				<h2>자유게시판 글 쓰기</h2>
				<form method="post" id="registerRoot"  action="${root}/freeboard/register">
					<!--유저의 grade가  관리자일때만 보여지게  -->
					<c:if test="${authUser.user_grade == 0}">
						<input type="checkbox" name="notice" value="n" id="notice_check"><label for="notice_check">&nbsp;공지사항</label> 
					</c:if>
					<div class="form-group">
						 <input name="free_title" type="text"
							class="form-control" id="free_title" placeholder="제목을 입력하세요." style=width:1000px; maxlength="30" size="50">
					</div>
					<div class="form-group">
						<textarea name="free_content" class="form-control" style="width:100%;height:300px" id="free_content" placeholder="내용을 입력하세요."
							rows="10" maxlength="300" required="required"></textarea>
					</div>
					<div class="form-group">
						<label for="input2">닉네임</label>&nbsp;
						<input type="checkbox" name="anonmyous" value="y" id="anonmyous_check"><label for="anonmyous_check">&nbsp;익명</label>
						&nbsp;
						<input name="free_nickname" type="text" class="form-control" id="free_nickname" value="${authUser.user_nickname }" readonly>
					</div>
					<button type="submit" id="registerButton" class="btn btn-primary">등록</button>
				</form>
		</section>
		<footer>
			<div id="footdiv">
				<div class="container" style="width:100%;">
					사업자명 : BCD쇼핑몰 ㅣ 사업자 번호 : 123-45-78901 ㅣ 개인정보관리책임자 : 이원석
					주소 : 서울특별시 마포구 신촌로 176 5층 501호ㅣ 전화 : 0507-1409-1711안내ㅣ 메일 : lws3793@naver.com
				</div>
			</div>
		</footer>
	</div>
</body>
</html>




