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

<u:mainNav/>
	
			<h1>게시물 수정</h1>	

	<form id="modify-form" action="${root }/qa/modify" enctype="multipart/form-data" method="post">
	
			<label for="input3">번호</label>
	 		<input name="qa_seq" readonly value="${board.qa_seq }">			
			<br>
			
			<label for="open">공개</label> 
			<input id="open" name="qa_secret" value="공개" type="checkbox" onclick="checkTree(this);" checked/> 
			<label for="close">비공개</label> 
			<input id="close" name="qa_secret" value="비공개" type="checkbox" onclick="checkTree(this);" />
			<br>
			
			<c:if test="${errors.noSecret }">
			<small class="form-text text-danger">
			공개 여부를 선택해주세요.
			</small>
			</c:if> 
			
			질문 종류 :
			<select name="qa_category">
			<option value='<c:out value="${board.qa_category }" />'>${board.qa_category }</option>
		    <option value="회원 ">회원</option>
		    <option value="게시판">게시판</option>
		    <option value="결제">결제</option>
		    <option value="상품">상품</option>
		    <option value="리뷰">리뷰</option>
		    <option value="배송">배송</option>
		    <option value="환불">환불</option>
		    <option value="업체">업체</option>		    
		    <option value="기타">기타</option>    
			</select>
			
			<c:if test="${errors.noCategory }">
			<small class="form-text text-danger">
			질문 종류를 선택 해주세요.
			</small>
			</c:if>
			
			<br>
					
		    <label for="input1">제목</label>
		    <input value='<c:out value="${board.qa_title }" />' name="qa_title" type="text" id="input1" placeholder="제목을 입력 하세요.">
			
			<c:if test="${errors.noTitle }">
			<small class="form-text text-danger">
			제목을 작성 해주세요.
			</small>
			</c:if>
		  	<br>
		  	
		    <label for="textarea1">내용</label>
		    <textarea name="qa_content" id="textarea1" rows="3" placeholder="내용을 입력 하세요."><c:out value="${board.qa_content }" /></textarea>
		    
		    <c:if test="${errors.noContent }">
			<small class="form-text text-danger">
			내용을 작성 해주세요.
			</small>
			</c:if>
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