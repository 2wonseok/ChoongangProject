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
var nickname = '${authUser.user_nickname}';
var pageNum = '${param.pageNum}';
</script>
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
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


#reply-submit-button_admin {
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

/* .content {
	border:none;
	border-right:0px; 
	border-top:0px; 
	boder-left:0px; 
	boder-bottom:0px;
}   */

.line {
	display: inline;
}
</style>

<script>

$(document).ready(function() {
	
	function dateString(date) {
		var d = new Date(date);
		return d.toISOString().split("T")[0];
	};

	function showList() {
		
		var page = pageNum || 1;	

		$.ajax({
			type: "GET",
			url: "${root}/reply/pages/"+seq+"/"+page,
			dataType: "JSON",
			success: function(res) {
				
				var replyUL = $("#reply_list");
				
				replyUL.empty();
				
				for (var i = 0; i < res.length; i++) {
					
					$(".modifysuccess").attr("hidden", true);	
					var reply_seq = res[i].reply_seq;
					var reply_content = res[i].reply_content;
					var reply_writer = res[i].reply_writer;
					var reply_regdateKST = res[i].reply_regdateKST;
					
					var replyLI = '<li class="main" data-seq="'+ reply_seq +'">'
												+ '<div>'
												+ '<input type="text" name="content" readonly style="border:none;" class="content" value="'+ reply_content +'">'
												+ '<small class="float-right text-primary">'
											  + '<a class="modify">수정</a>'
												+ '<a class="delete">삭제</a>'
												+ '<a class="modifysuccess">수정 완료</a>'
												+ '</small>'
												+ '</div>'
												+ '<div>'+ reply_writer +'</div>'
												+ '<small class="float-reft text-primary">'
												+ dateString(reply_regdateKST)
												+ '</small>'
												+ '</li>'
												+ '<hr>';
												
					//$(".modifysuccess").hide();	
					replyUL.append(replyLI);
					
				}
				
				// 수정시 한개의 데이터 조회
				$(".modify").click(function() {	
					
					var rno = $(this).parent('small').parent('div').parent('li').attr("data-seq");
					
					var _idx = null;
					
					// reply_seq의 번호찾기 
					for (var i = 0; i < res.length; i++) {
						//var reply_content = $("#reply_list").find('h5')[i].children[i].value;
						if(res[i].reply_seq == rno){
							_idx = i;
						 	 break;  
						}					
					}
					
					var con = $(".content")[_idx];
					var idxModify = $(".modify")[_idx];
					var idxDelete = $(".delete")[_idx];
					var idxSuccess = $(".modifysuccess")[_idx];
					var idxStyle = $('.content')[_idx];
					console.log("인덱스 번호 : " + _idx);
					
					//alert('수정 클릭');
					
						$.ajax({
							type: "GET",
							url: "${root}/reply/"+rno,
							dataType: "JSON",
							success: function(res) {
								console.log(res);
								
								con.readOnly = false;
								idxModify.hidden = true;
								idxDelete.hidden = true;
								idxSuccess.hidden = false;
								idxStyle.style = false;
								
								// 수정 완료 버튼 눌렀을 때
								$(".modifysuccess").click(function() {
									var newContent = con.value;
									
									$.ajax({
										type: "get",
										url: "${root}/reply/modify/",
										dataType: "JSON",
										data: {reply_seq: rno, reply_content: newContent},
										success: function(res) {
											if (res == 1) {
												alert('수정이 완료되었습니다');
												showList();
											} else {
												alert('수정 실패에요');
											}
										},
										error: function() {
											alert('ajax수정 실패');
										}
										
									});
									
								});
							}
							
						});
				});
			}, 
			error: function() {
				alert('실패');
			}
		});
		
	}
	
	showList();
});

</script>
<title>게시물 보기</title>
</head>
<body>

<u:mainNav/>


	
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
		  	<img onerror="this.src='${root }/resources/noimage.jpg'" src="${root }/resources/qaboard/upload/${board.qa_filename }" id="image"> <br>
		  	
		  	
			</div>
			<small class="form-text text-primary">
	 		<fmt:formatDate pattern="- yyyy년 MM월 dd일 h시m분" value="${board.qa_regdateKST}" /> 에 작성 되었습니다.
	 		</small>
			<c:if test="${!empty board.qa_updatedate}">
	 		<div class="form-group">
	 		<small class="form-text text-danger">
	 		<fmt:formatDate pattern="- yyyy년 MM월 dd일 h시m분" value="${board.qa_updatedateKST}" /> 에 수정 되었습니다.
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
			<br><br>
<!-- 
// 댓글 목록 AJAX
 -->
 

	
<div class="card-body">
	<ul class="list-unstyled" id="reply_list"> 	

	</ul>
</div>
<c:if test="${empty authUser.user_nickname}">
	로그인시 댓글 작성 가능. (로그인 마크)
</c:if>




<c:if test="${not empty authUser.user_nickname}">
<label for="reply-input">댓글</label>
	<input class="form-control" type="text" name="reply_content" value="${reply_content }" id="reply_content_input"/><br>	

	<!-- // 작성자 hidden 처리 -->	
	<input readonly type="hidden" type="text" name="reply_writer" value="${authUser.user_nickname }" id="reply_writer_input"/><br>
	
<c:if test="${errors.reply_noContent }">
<small class="form-text text-danger"> 댓글 내용을 입력 해주세요. </small>
</c:if>

<!-- 일반 유저 댓글 쓰기 -->
<c:if test="${!empty authUser.user_id && authUser.user_grade == 1}">
<button id="reply-submit-button">댓글 쓰기</button> 
</c:if>
<!-- 관리자 댓글 쓰기 -->
<c:if test="${!empty authUser.user_id && authUser.user_grade == 0}">
<button id="reply-submit-button_admin">댓글 쓰기 (관리자)</button> 
</c:if>

</c:if>

		</div>
	</div>
</div>
</body>

</html>