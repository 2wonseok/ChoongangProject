<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
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
	 $(document).ready(function() {
			$("#modify-btn").click(function(e) {
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
				e.preventDefault();
				
				var modify = confirm('정말 수정하시겠습니까?');
				if (modify) {
					$("#modify-form").submit();
				}
			})
	 });
	
	
	</script>
<title>Insert title here</title>
<style>
#container {
    clear: both;
    position: relative;
    margin: 35px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
}
#modify-btn{
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
#goList{
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
		<section id="container">
				<h1>게시물 수정</h1>
				<form id="modify-form" method="post" action="${root }/freeboard/modify">
					<div class="form-group">
						<label for="input1">제목</label> <input
							value='<c:out value="${freeVO.free_title }" />' name="free_title"
							type="text" class="form-control" maxlength="50" style =width:1000px; id="free_title" placeholder="제목을 입력 하세요." >
					</div>

					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea name="free_content" class="form-control" id="free_content"
							rows="10" maxlength="300" placeholder="내용을 입력하세요."><c:out value="${freeVO.free_content }" /></textarea>
					</div>

					<div class="form-group">
						<label for="input2">닉네임</label> <input readonly
							value='<c:out value="${freeVO.free_nickname }" />'
							name="free_nickname" type="text" class="form-control" id="input2">
					</div>
						<input type="hidden" value="${criteria.pageNum }" name="pageNum">
						<input type="hidden" value="${criteria.amount }" name="amount">
						<input type="hidden" value="${criteria.type }" name="type">
						<input type="hidden" value="${criteria.keyword }" name="keyword">
						<button id ="modify-btn"type="submit" class="btn btn-primary">수정</button>
						<a href="${root}/freeboard/list"  id="goList">목록</a>
				</form>
		</section>
	</div>
 <u:footer/>
</body>
</html>