<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>

<style>

[type=checkbox] { 
  position: absolute;
  opacity: 0;
  width: 0;
  height: 0;  
} 

[type=checkbox] + label {
  cursor: pointer;
}
[type=checkbox]:checked + label {
  outline: 2px solid #1e263c;
  margin: 0px;
  padding : 5px;
}

#btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: center;
}
</style>
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


<u:mainNav/>
<h2> Q&A 글쓰기</h2>
<div class="container"> 
	<form action="${root }/qa/register" method="post" enctype="multipart/form-data">
	
	<!-- type="checkbox" 로딩시 기본으로 체크 되어있도록 설정  -->
	<!-- label 태그로 글씨가 클릭 되어도 체크 되도록 설정, label for="" 와 input id 동일해야 함 -->
	<input id="open" name="qa_secret" value="공개" type="checkbox" onclick="checkTree(this);" checked style='zoom:1.5;'/> 
	<label for="open">공개</label> 
	
	<input id="close" name="qa_secret" value="비공개" type="checkbox" onclick="checkTree(this);" style='zoom:1.5;'/>
	<label for="close">비공개</label> 
	
	<c:if test="${errors.noSecret }">
	<small class="form-text text-danger">
			공개 여부를 선택해주세요.
	</small>
	</c:if>	
	
	<br>	
	
	질문 종류 :
	<select name="qa_category" >
	<option value="">질문 선택</option>
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
	
	제목 : <br>
	<input type="text" name="qa_title" value="${title }"/>	
	<c:if test="${errors.noTitle }">
	<small class="form-text text-danger">
			제목을 입력 해주세요.
	</small>
	</c:if>
	
	<br>
	내용 : <br>
	<textarea name="qa_content" cols="30" rows="10" >${content }</textarea>
	<c:if test="${errors.noContent }">
	<small class="form-text text-danger">
			내용을 입력 해주세요.
	</small>
	</c:if>
	 
	<br>	
	
	작성자 : <input type="text" name="qa_writer" value="${authUser.user_nickname }"/>	
	<br>
	
	<div class ="inputArea">
	파일 업로드
	<label><input type="file" name="upload" id="image" value="${filename }"/></label>
	
	<div class="select_img"><img src="" /></div>
	 
	<script>
	  $("#image").change(function(){
	   if(this.files && this.files[0]) {
	    var reader = new FileReader;
	    reader.onload = function(data) {
	     $(".select_img img").attr("src", data.target.result).width(200);        
	    }
	    reader.readAsDataURL(this.files[0]);
	   }
	  });
 	</script>
 	
	</div>
	
	파일 업로드 : <input type="file" name="upload" value="${filename }"/>
	<input type="submit" value="전송" id="btn_add">
	
	
</form> 
</div>
</body>
</html>