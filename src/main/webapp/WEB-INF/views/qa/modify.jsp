<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
function checkTree(chk){
    var obj = document.getElementsByName("qa_secret");
    for(var i=0; i < obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

</script>
<title>게시물 수정</title>
</head>
<body>

	<u:navbar></u:navbar>
	
			<h1>게시물 수정</h1>	

	<form id="modify-form" method="post" action="${root }/qa/modify" enctype="multipart/form-data">
	
			<label for="input3">번호</label>
	 		<input name="qa_seq" id="input3" readonly value="${board.qa_seq }">			
			<br>
			
			<label for="open">공개</label> 
			<input id="open" name="qa_secret" value="공개" type="checkbox" onclick="checkTree(this);" checked/> 
			<label for="close">비공개</label> 
			<input id="close" name="qa_secret" value="비공개" type="checkbox" onclick="checkTree(this);" />
			<br>
	
			
			질문 종류 :
			<select name="qa_category">
			<option value='<c:out value="${board.qa_category }" />'>${board.qa_category }</option>
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
					
		    <label for="input1">제목</label>
		    <input value='<c:out value="${board.qa_title }" />' name="qa_title" type="text" id="input1" placeholder="제목을 입력 하세요.">
		  		  	
		  	<br>
		  	
		    <label for="textarea1">내용</label>
		    <textarea name="qa_content" id="textarea1" rows="3" placeholder="내용을 입력 하세요."><c:out value="${board.qa_content }" /></textarea>
		    
		  	<br>		  	
		  	
		    <label for="input2">작성자</label>
		    <input readonly value='<c:out value="${board.qa_writer }" />' name="qa_writer" type="text" id="input2" placeholder="이름을 입력하세요">
		    
		    
		    <br>		  
		  	파일 업로드 : <input type="file" name="upload" /> <br>
		  	
		  	
			<input type="hidden" value="${criteria.pageNum }" name="pageNum">
			<input type="hidden" value="${criteria.amount }" name="amount">
 			<input type="hidden" value="${criteria.type }" name="type">
			<input type="hidden" value="${criteria.keyword }" name="keyword">
			
		  	<button type="submit">게시물 수정</button>
		</form>



</body>
</html>