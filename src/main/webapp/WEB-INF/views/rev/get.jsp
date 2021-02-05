<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
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
#goodbtn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}
#hatebtn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}
</style>
<script>
	var appRoot = '${root}'; // 자바스크립트 코드에서 contextPath를 쓰기위해 선언.
	var rev_seq = ${RevBoard.rev_seq};
</script>
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
<script src="${root }/resources/rev_js/rev.js">
/* $(document).ready(function() {
	$("#goodbtn").click(function() {
		revService.goodAdd({
			rev_seq,
			function(data) {
				console.log(data);
			},
			function() {
				console.log("error");
			}
			
		});
	});
}); */

</script>
<script>
	
	
	 $(document).ready(function() {
	
	$('#goodbtn').click(function(){
		   
		  $.ajax({
			  method: "get",
		      url: "/rev/like", 
		      data: {rev_seq: rev_seq}, 
		      

		      success: function(data){		    	  
		          alert("좋아요를 누르셨습니다");
		          console.log(rev_seq);
		      },
		      error:function(error){
		       
		        alert("좋아요를 실패하셨습니다.");
		      }
		  });
		});		
	}); 

	 $(document).ready(function() {
			
			$('#hatebtn').click(function(){
				   
				  $.ajax({
					  method: "get",
				      url: "/rev/hate", 
				      data: {rev_seq: rev_seq}, 
				      

				      success: function(data){		    	  
				          alert("싫어요를 누르셨습니다");
				          console.log(rev_seq);
				      },
				      error:function(error){
				       
				        alert("싫어요를 실패하셨습니다.");
				      }
				  });
				});		
			});
	 
</script>
<title>Insert title here</title>
</head>
<body>
<u:navbar></u:navbar>
	<div class="container-sm">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<h1>게시물 보기</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">


				<!-- 같은경로 라서 action="" 를 생략할수있음  -->
				<div class="form-group">
					<label for="input1">#번호</label> <input readonly
						value="${RevBoard.rev_seq }" type="text" class="form-control" id="input1" />
				</div>
				<div class="form-group">
					<label for="input2">카테고리</label> <input readonly
						value='<c:if test="${RevBoard.rev_category eq 1}">모자</c:if><c:if test="${RevBoard.rev_category eq 2}">신발</c:if><c:if test="${RevBoard.rev_category eq 3}">상의</c:if><c:if test="${RevBoard.rev_category eq 4}">하의</c:if>' type="text" class="form-control" id="input2" />
						
				</div>
				<div class="form-group">
					<label for="input3">파일이름</label> <input readonly
						value="${RevBoard.rev_filename }" type="text" class="form-control" id="input3" />
						<img alt="" src="${root }/resources/upload/${RevBoard.rev_filename}">
				</div>
				<div class="form-group">
					<label for="input4">제목</label> <input readonly
						value='<c:out value= "${RevBoard.rev_title }"/>' type="text"
						class="form-control" id="input4" placeholder="제목을 입력하세요.">
				</div>

				<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea readonly class="form-control" id="textarea1" rows="3"><c:out
							value="${RevBoard.rev_content }" /></textarea>
				</div>
				 
				<div class="form-group">
						<label for="input5">조회수</label> <input  name="rev_readcnt"
							value="${RevBoard.rev_readCnt }" type="text" class="form-control"
							id="input5" readonly/>
					</div>

				<div class="form-group">
					<label for="input6">작성자</label> <input readonly
						value="${RevBoard.rev_writer }" type="text" class="form-control"
						id="input6">
				</div>
				
				<div class="form-group">
					<label for="input7">좋아요</label> <input readonly
						value="${RevBoard.rev_good }" type="text" class="form-control" id="input7" />
				</div>
				
				<div class="form-group">
					<label for="input8">싫어요</label> <input readonly
						value="${RevBoard.rev_hate }" type="text" class="form-control" id="input8" />
				</div>
				
				<div class="form-group">
						<label for="input9">작성일</label> <input  name="rev_regdate"
							value="${RevBoard.rev_regdate }" type="text" class="form-control"
							id="input9"  readonly/>
					</div>
			</div>
			
		</div>
		<c:url value="${root }/rev/modify" var="modifyLink">
					<c:param name="rev_seq" value="${RevBoard.rev_seq }" />
					<c:param name="pageNum" value="${cri.pageNum }" />
					<c:param name="amount" value="${cri.amount }" />
					<c:param name="type" value="${cri.type }"/>
					<c:param name="keyword" value="${cri.keyword }"/>
				</c:url>
				<c:url value="${root }/rev/list" var="listLink">
					<c:param name="rev_seq" value="${RevBoard.rev_seq }" />
					<c:param name="pageNum" value="${cri.pageNum }" />
					<c:param name="amount" value="${cri.amount }" />
					<c:param name="type" value="${cri.type }"/>
					<c:param name="keyword" value="${cri.keyword }"/>
				</c:url>
		<a id="hatebtn" class="btn btn-secondary"  href="">싫어요!</a>
		<a id="goodbtn" class="btn btn-secondary"  href="">좋아요!</a>
		<c:if test="${ sessionScope.authUser.user_id eq RevBoard.rev_writer}">
		<a id="btn_add" class="btn btn-secondary"  href="${modifyLink }">글수정</a>
		</c:if>
		<a id="btn_add" class="btn btn-secondary"  href="${listLink }">목록으로</a>
	</div>
	
</body>
</html>