<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
function checkTree(chk){
    var obj = document.getElementsByName("qa_secret");
    for(var i=0; i < obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

</script>

<title> Q&A 글쓰기</title>

</head>
<body>


<u:navbar></u:navbar>
<h2> Q&A 글쓰기</h2>
<div class="container"> 
	<form action="${root }/qa/register" method="post">
	
	<!-- type="checkbox" 로딩시 기본으로 체크 되어있도록 설정  -->
	<!-- label 태그로 글씨가 클릭 되어도 체크 되도록 설정, label for="" 와 input id 동일해야 함 -->
	<label for="open">공개</label> 
	<input id="open" name="qa_secret" value="공개" type="checkbox" onclick="checkTree(this);" checked/> 
	<label for="close">비공개</label> 
	<input id="close" name="qa_secret" value="비공개" type="checkbox" onclick="checkTree(this);" />
	
	<br>	
	
	질문 종류 :
	<select name="qa_category">
	<option value="">질문 선택</option>
    <option value="회원 가입 관련">회원 가입 관련</option>
    <option value="정보 수정 관련">정보 수정 관련</option>
    <option value="게시판 관련">게시판 관련</option>
    <option value="결제 관련">결제 관련</option>
    <option value="상품 관련">상품 관련</option>
    <option value="구매 후기 관련">구매 후기 관련</option>
    <option value="배송 관련">배송 관련</option>
    <option value="환불 관련">환불 관련</option>
    <option value="기타 문의 사항">기타 문의 사항</option>    
	</select>
		
	<br>	
	
	제목 : <br>
	<input type="text" name="qa_title" placeholder="제목을 입력 해주세요." />	
	
	<br>
	내용 : <br>
	<textarea name="qa_content" cols="30" rows="10" placeholder="질문 내용을 입력 해주세요."></textarea>
	<br>	
	
	작성자 : <input type="text" name="qa_writer" placeholder="작성자 이름을 입력 하세요." />	
	<input type="submit" value="전송">
</form> 
</div>
</body>
</html>