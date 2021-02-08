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
<script>
var appRoot = '${root}';
var seq = ${board.qa_seq};
</script>
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="${root }/resources/js/qa_reply.js"></script>


<style>

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
#reply-submit-button {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}

#table {
    border: 2px solid black;
}
#image {
	max-width: 100%
}
</style>



<script>

$(document).ready(function() {
	// 날짜 형식
	function dateString(date) {
		var d = new Date(date);
		return d.toISOString().split("T")[0];
	}
	

	
	$("#reply-submit-button").click(function() {
		console.log("등록 버튼 클릭");
		
		// input 에서 value 가져와서 변수에 저장
		var reply_content = $("#reply-input").val();
		var reply_writer = $("#replyer-input").val();		
		// ajax 요청을 위한 데이터 만들기
		var data = {reply_boardseq: reply_boardseq, reply_content: reply_content, reply_writer: reply_writer}
		
		
		replyService.add(data, 
				function() {
					alert("댓글 등록에 성공");
				}, 
				function() {
					alert("댓글 등록에 실패");
				});	
		// 모달창 닫기
		$("#new-reply-modal").modal("hide");
		
		// 모달창 내의 input 요소들 value를 초기화
		$("#new-reply-modal input").val("");
		
	});			
	

});

</script>



<title>게시물 보기</title>

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
	<%-- 
		<form action="${pageContext.request.contextPath }/board/register">
	 --%>	

	 	<div class="form-group">
	 		<strong><label for="input1">번호</label></strong>
	 		<input class="form-control" readonly value="${board.qa_seq }">
	 	</div>
	 	
	 	<div class="form-group">
	 		<strong><label for="input2">질문 종류</label></strong>
	 		<input class="form-control" readonly value="${board.qa_category }">
	 	</div>
	 	
<%-- 	 	
	 	<div class="form-group">
	 		<label for="input3">작성 시간</label>
	 		<input readonly class="form-control" value="<fmt:formatDate pattern="yyyy년 MM월 dd일 h시m분" value="${board.qa_regdate}" />" />

	 	</div>
	 		 	 --%>
			<div class="form-group">
		    <strong><label for="input5">제목</label></strong>
		    <input readonly value='<c:out value="${board.qa_title }" />' type="text" class="form-control">
		  	</div>		  	
		  	
		  	 <strong><label for="input6">내용</label> <br>	</strong>	  	
		  	<div class="form-group" contentEditable="false" id="table">
		  	<c:out value="${board.qa_content }" /> <br>
		  	<img src="${root }/resources/qaboard/upload/${board.qa_filename }" id="image"> <br>
		  	
			</div>
			<small class="form-text text-primary">
	 		<fmt:formatDate pattern="- yyyy년 MM월 dd일 h시m분" value="${board.qa_regdate}" /> 에 작성 되었습니다.
	 		</small>
			<c:if test="${!empty board.qa_updatedate}">
	 		<div class="form-group">
	 		<small class="form-text text-danger">
	 		<fmt:formatDate pattern="- yyyy년 MM월 dd일 h시m분" value="${board.qa_updatedate}" /> 에 수정 되었습니다.
	 		</small>
	 		</div>
	 		</c:if>

<%-- 		  	
			<div class="form-group">
		    <label for="textarea1">내용</label>
		    <textarea readonly class="form-control" id="textarea1" rows="50" id="input6"><c:out value="${board.qa_content }" /></textarea>
		    <img src="${root }/resources/upload/${board.qa_filename }"> 
		  	</div>
 --%>
		  	
		  	<div class="form-group">
		    <label for="input6">조회수</label>
		    <input readonly value='<c:out value="${board.qa_readcnt }" />' type="text" class="form-control" id="input7">
		  	</div>
		  	
		  	<div class="form-group">
		    <label for="input6">작성자</label>
		    <input readonly value='<c:out value="${board.qa_writer }" />' type="text" class="form-control" id="input8">
		  	</div>
		  	

		  <%-- 	
		  	<c:url value="/board/modify" var="modifyLink">
		  		<c:param name="qa_seq" value="${board.qa_seq }" />
		  		<c:param name="pageNum" value="${criteria.pageNum }" />
		  		<c:param name="amount" value="${criteria.amount }" />
		  		<c:param name="type" value="${criteria.type }" />
		  		<c:param name="keyword" value="${criteria.keyword }" />
		  	</c:url>
		  	<a href="${modifyLink }" class="btn btn-secondary">수정 , 삭제</a>
 --%>
 			<!-- 보드 작성자 이름과 로그인 아이디가 같고, 등급이 1인 경우(일반)에만 활성화  -->
			<c:if test="${board.qa_writer == authUser.user_nickname && authUser.user_grade == 1 }">
				<a href="${root }/qa/modify?qa_seq=${board.qa_seq }" id="btn_add">수정</a> 
				<a href="${root }/qa/remove?qa_seq=${board.qa_seq }" id="btn_add">삭제</a>				
			</c:if>
			<!-- 등급이 0 , 곧 관리자 일경우만 모든 게시물 삭제 가능 하도록 활성화 -->
			<c:if test="${authUser.user_grade == 0 }">
					<a href="${root }/qa/remove?qa_seq=${board.qa_seq }" id="btn_add">삭제</a>
			</c:if>		
		  	<!-- 관리자이면서 자신의 글일 경우  -->
		  	<c:if test="${authUser.user_grade == 0 && board.qa_writer == authUser.user_nickname }">
					<a href="${root }/qa/modify?qa_seq=${board.qa_seq }" id="btn_add">수정</a> 
			</c:if>


				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>NO</th>
							<th>내용 (<i class="far fa-calendar-alt"></i>)</th>
							<th>닉네임</th>						

						</tr>
					</thead>
					<tbody>

						<c:forEach items="${reply_list }" var="reply">
							<tr>
								<td><Strong class="text-primary">${reply.reply_seq}</Strong></td>
								
								<td><small class="text-info">${reply.reply_content}</small>
								<div>
								<small class="form-text text-secondary">
						 		<fmt:formatDate pattern="yyyy.MM.dd. hh.mm" value="${board.qa_regdate}" />
						 		</small>
								</div>
								</td>
								<td>${reply.reply_writer}</td>
								
							</tr>

						</c:forEach>
						
						

						</tbody>
						</table>
						

					<label for="reply-input">내용</label>
					<input type="text" name="reply_content" value="${reply_content }" id="reply-input"/><br>
					<label for="replyer-input">작성자</label> 
					<input readonly type="text" name="reply_writer" value="${authUser.user_nickname }" id="replyer-input"/><br>
					<input type="hidden" type="text" name="reply_boardseq" value="${board.qa_seq }"/>		
					<c:if test="${errors.reply_noContent }">
						<small class="form-text text-danger"> 댓글 내용을 입력 해주세요. </small>
					</c:if>

					<button id="reply-submit-button">댓글쓰기</button>


					
		</div>
	</div>
</div>
</body>

</html>