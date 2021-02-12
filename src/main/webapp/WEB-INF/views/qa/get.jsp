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
</script>
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="${root }/resources/js/qa_reply.js"></script>
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

/* .reply_content {
	border:none;
	border-right:0px; 
	border-top:0px; 
	boder-left:0px; 
	boder-bottom:0px;
}  */

.line {
	display: inline;
}
</style>

<script>

$(document).ready(function() {
	
//	reply_seq NUMBER(10) PRIMARY KEY,
//	reply_content VARCHAR2(3000) NOT NULL,
//	reply_writer VARCHAR2(30) NOT NULL,
//	reply_regdate DATE,
//	reply_updatedate DATE,
//	reply_boardname VARCHAR2(10) NOT NULL,
//	reply_boardseq NUMBER(10) NOT NULL,
//	reply_filename VARCHAR2(3000)
	
	// 날짜 형식
	
	function dateString(date) {
		var d = new Date(date);
		return d.toISOString().split("T")[0];
	};


	// 댓글 목록 가져오기
	function showList() {			
		replyService.getList({qa_seq: seq}, function(list) {
			
			var replyUL = $("#reply_list");
			replyUL.empty();		

			for (var i = 0; i < list.length; i++) {
				
				var seq = list[i].reply_seq;
				var content = list[i].reply_content;
				var writer = list[i].reply_writer;
				var regdate = list[i].reply_regdateKST;
				
				var replyLI = 
					'<li class="main" data-seq="'+ seq +'">'
					+ '<div>'
					+ '<div class="content" value="'+ content +'">' + content +'</div>'
					+ '<small class="float-right text-primary">'
					+ '<div class="modify">수정</div>'
					+ '<div class="delete">삭제</div>'
					+ '</small>'
					+ '</div>'
					+ '<div>'+ writer +'</div>'
					+ '<small class="float-reft text-primary">'
					+ moment(regdate).format('YYYY.MM.DD.HH:mm') 
					+ '</small>'
					+ '</li>'
					+ '<hr>';
				
				replyUL.append(replyLI);	

			};
			
			if(writer == ninckname) {
				var reply_add = 'ㅇㅇㅇㅇ';
				
				replyUL.append(reply_add);
			};

			
			/* // 삭제 버튼 이벤트 처리
			$(".reply_delete").click(function() {
				console.log("삭제 클릭");

				
			var reply_seq = $(this).parent('div').find('.reply_seq').val();
			console.log(reply_seq);
			
			if(confirm("삭제 하시겠습니까?") == true){
				replyService.remove(reply_seq, function() {
					alert("댓글 삭제 완료.");
					showList();								
					});						
				} else {
					showList();		
				};

			});
			
			// 수정 버튼 이벤트 처리
			$(".reply_modify").click(function() {
				console.log("수정 클릭");
				
				var reply_seq = $(this).parent('div').find('.reply_modify_seq').val();
				console.log(reply_seq);
			
				var _idx = null;
				
				
				// reply_seq의 번호찾기 
				for (var i = 0; i < list.length; i++) {
					//var reply_content = $("#reply_list").find('h5')[i].children[i].value;
					if(list[i].reply_seq == reply_seq){
						_idx = i;
					 	 break;  
					}					
				}
 				var con = $(".reply_content")[_idx];
				console.log("인덱스 번호 : " + _idx);
					
				$('.reply_content')[_idx].readOnly = false
				$('.reply_content')[_idx].style = false	
				$('.reply_delete')[_idx].hidden = true
				$('.reply_modify')[_idx].hidden = true
				$('.reply_modify_good')[_idx].hidden = false
				
				// 수정 처리
				$(".reply_modify_good").click(function() {
					
					console.log(list[i].reply_seq);
					console.log(list[i].reply_content);

					var reply_content = $(".reply_content")[_idx];
					
					var text = $(this).attr('data_text');


					console.log(reply_content);

					var data = {reply_seq: list[i].reply_seq, reply_content: reply_content_mod}; 
					
					
					replyService.modify(data, function() {
						alert("댓글을 수정 하였습니다.");
						showList();

					});
					
				});

			}); */	
			
			
		});		
	}
	
	// 일반 유저 댓글 쓰기
	$("#reply-submit-button").click(function() {
		console.log("등록 버튼 클릭");		
		// input 에서 value 가져와서 변수에 저장
		var reply_content = $("#reply_content_input").val();
		var reply_writer = $("#reply_writer_input").val();		
		// ajax 요청을 위한 데이터 만들기
		var data = {reply_boardseq: seq, reply_writer: reply_writer, reply_content: reply_content};		
		
		replyService.add(data, 
				function() {
					alert("[" + reply_content + "]" + "댓글 등록 완료");
					// 댓글 등록 성공 확인창 누른후 리스트 보여주기
					showList();
				}, 
				function() {
					alert("내용을 입력 하세요");
				});	
 		// 모달창 닫기
		$("#new-reply-modal").modal("hide");
		
		// 모달창 내의 input 요소들 value를 초기화
		$("#reply_content_input").val(""); 

	});	
	
	// 관리자 댓글 쓰기
	$("#reply-submit-button_admin").click(function() {
		console.log("등록 버튼 클릭");
		
		// input 에서 value 가져와서 변수에 저장
		var reply_content = $("#reply_content_input").val();
		var reply_writer = $("#reply_writer_input").val();		
		// ajax 요청을 위한 데이터 만들기
		var data = {reply_boardseq: seq, reply_writer: reply_writer, reply_content: reply_content};
		
		
		replyService.add_admin(data, 
				function() {
					alert("[" + reply_content + "]" + "댓글 등록 완료");
					// 댓글 등록 성공 확인창 누른후 리스트 보여주기
					showList();
				}, 
				function() {
					alert("내용을 입력 하세요");
				});	
 		// 모달창 닫기
		$("#new-reply-modal").modal("hide");
		
		// 모달창 내의 input 요소들 value를 초기화
		$("#reply_content_input").val(""); 

	});
	
	// reply-list seq, content 값 불러오고 삭체 처리 처리
	$("#reply_list").on("click", ".delete", function() {		
		// 하나의 댓글 읽어오기
		var seq = $(this).parent('small').parent('div').parent('li').attr("data-seq");
		var content = $(this).parent('small').parent('div').children('div').attr("value");
 		alert(seq); 
 		alert(content); 
 		if(confirm("삭제 하시겠습니까?") == true){
			replyService.remove(seq, function() {
				alert("댓글 삭제 완료.");
				showList();								
				});						
			} else {
				showList();		
			};
	});
	
	/* 
	'<li class="main" data-seq="'+ seq +'">'
	+ '<div>'
	+ '<div class="content">'+ content +'</div>'
	+ '<small class="float-right text-primary">'
	+ '<div class="tag">수정,삭제</div>'
	+ '</small>'
	+ '</div>'
	+ '<div>'+ writer +'</div>'
	+ '<small class="float-reft text-primary">'
	+ moment(regdate).format('YYYY.MM.DD.HH:mm') 
	+ '</small>'
	+ '</li>'
	+ '<hr>'
	 */
/* 	$(this).parent('div').find('.reply_modify_seq').val(); */
	// 댓글 목록 함수 showList() 불러오기
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