<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<script>
var appRoot = '${root}';
var bno = ${board.qa_bno};
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
<script src="${root }/resources/js/reply.js"></script>

<script>

// replyService.add("my reply");
/* 
replyService.add({
	bno:326, 
	reply:"new reply 댓글", 
	replyer:"tester"
	}, function(result) {
		console.log(result);
	}, function(err) {
		console.log(err);
	});

replyService.getList(
		{bno:326, page:1},
		function(data) {
			console.log(data);
		},
		function() {
			console.log("error");
		});
 */
/* 
replyService.remove(99, function(data) {
			console.log(data);
		}, function(err) {
			console.log(err);
		});
 */
/* 
replyService.update({rno:109, reply:'수정된 리플'}, 
		function(data) {
			console.log(data);
		}, function(err) {
			console.log(err);
		}
});
 */
/* 
replyService.get(109, function(data) {
	console.log(data);
});
 */

</script>

<script>
	$(document).ready(function() {
			// 날짜 형식
			function dateString(date) {
				var d = new Date(date);
				return d.toISOString().split("T")[0];
			}
			
		
			// 댓글 목록  가져오기 함수
			function showList() {			
			replyService.getList({bno: bno}, function(list) {
				//console.log(list);
				
				var replyUL = $("#reply-ul");
				replyUL.empty();				
				for (var i = 0; i < list.length; i++) {
					var replyLI = '<li class="media" data-rno="'
					+ list[i].rno + '"><div class="media-body"><h5>'
					+ list[i].replyer + '<small class="float-right">'
					+ dateString(list[i].replyDate) + "</small><h5>"
					+ list[i].reply + "<hr></div></li>";
					
					replyUL.append(replyLI);
				}
			});
		}
		
			$("#new-reply-button").click(function() {
				console.log("댓글 쓰기 클릭");
				$("#new-reply-modal").modal("show");
			});
			
			
			$("#reply-submit-button").click(function() {
				console.log("등록 버튼 클릭");
				
				// input 에서 value 가져와서 변수에 저장
				var reply = $("#reply-input").val();
				var replyer = $("#replyer-input").val();		
				// ajax 요청을 위한 데이터 만들기
				var data = {bno: bno, reply: reply, replyer: replyer}
				
				
				replyService.add(data, 
						function() {
							alert("댓글 등록에 성공 하였습니다.");
						}, 
						function() {
							alert("댓글 등록에 실패 하였습니다.");
						});	
				// 모달창 닫기
				$("#new-reply-modal").modal("hide");
				
				// 모달창 내의 input 요소들 value를 초기화
				$("#new-reply-modal input").val("");
				
				// 댓글 목록 가져오기 실행
				showList();
			});			
			
			
		// reply-ul 클릭 이벤트 처리
		$("#reply-ul").on("click", "li", function() {
			// console.log("reply ul clicked..");
			console.log($(this).attr("data-rno"));
			
			// 하나의 댓글 읽어오기
			var rno = $(this).attr("data-rno");
			replyService.get(rno, function(data) {
				$("#reply-rno").val(rno);
				$("#reply-modify-delete").val(data.reply);
				$("#replyer-modify-delete").val(data.replyer);
				$("#modify-delete-reply-modal").modal("show");
			});
		});
		
		// 수정 버튼 이벤트 처리
		$("#reply-modify-button").click(function() {
			
			var rno = $("#reply-rno").val();
			var reply = $("#reply-modify-delete").val();
			var data = {rno: rno, reply: reply};
			
			replyService.update(data, function() {
				alert("댓글을 수정 하였습니다.");
				$("#modify-delete-reply-modal").modal('hide');
				showList();
			});
			
		});
		
		// 삭제 버튼 이벤트 처리
		$("#reply-remove-button").click(function() {
			
			var rno = $("#reply-rno").val();
			
			replyService.remove(rno, function() {
				alert("댓글을 삭제 하였습니다.");
				$("#modify-delete-reply-modal").modal('hide');
				showList();
			});
			
		});
		
		
		
		//댓글 목록 가져오기 실행
		showList();
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
	<%-- 
		<form action="${pageContext.request.contextPath }/board/register">
	 --%>	

	 	<div class="form-group">
	 		<label for="input3">번호</label>
	 		<input class="form-control" id="input3" readonly value="${board.bno }">
	 	</div>
	 	
	 	<div class="form-group">
	 		<label for="input4">작성시간</label>
	 		<input class="form-control" id="input4" readonly value="${board.regdate }">
	 	</div>
	 	
	 	<div class="form-group">
	 		<label for="input5">수정시간</label>
	 		<input class="form-control" id="input5" readonly value="${board.updatedate }">
	 	</div>
	 	
			<div class="form-group">
		    <label for="input1">제목</label>
		    <input readonly value='<c:out value="${board.title }" />' type="text" class="form-control" id="input1">
		  	</div>		  	
		  	
		  	<div class="form-group">
		    <label for="textarea1">내용</label>
		    <textarea readonly class="form-control" id="textarea1" rows="3"><c:out value="${board.content }" /></textarea>
		    
		  	</div>
		  	
		  	<div class="form-group">
		    <label for="input2">작성자</label>
		    <input readonly value='<c:out value="${board.writer }" />' type="text" class="form-control" id="input2">
		  	</div>
		  	
		  	<c:url value="/board/modify" var="modifyLink">
		  		<c:param name="bno" value="${board.bno }" />
		  		<c:param name="pageNum" value="${criteria.pageNum }" />
		  		<c:param name="amount" value="${criteria.amount }" />
		  		<c:param name="type" value="${criteria.type }" />
		  		<c:param name="keyword" value="${criteria.keyword }" />
		  	</c:url>
		  	<a href="${modifyLink }" class="btn btn-secondary">수정 , 삭제</a>

		  	

			</div>
		</div>
	</div>
	<!-- 댓글 목록 -->
	<div class="container-sm mt-3">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<span>
						댓글 목록
						</span>						
						<button class="btn btn-info" id="new-reply-button">댓글 쓰기</button>
					</div>
					
					<div class="card-body">
						
						<ul class="list-unstyled" id="reply-ul">
						
							<!-- 하나의 댓글의 하나의 li -->
							<!-- 
							<li class="media" data-rno="21">
								
								<div class="media-body">
								
									<h5>user00 <small>2021/01/29</small></h5>
									
									댓글 본문..
									
									<hr>
								</div>
								
							</li>
							 -->
						</ul>
						
					</div>
				</div>
				
		</div>
	</div>
	
	</div>
	
	<!-- modal 새 댓글  form -->
	<div class="modal fade" id="new-reply-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						새 댓글
					</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="reply-input" class="col-form-label">
							댓글
						</label>
						<input type="text" class="form-control" id="reply-input">
					</div>
					<div class="form-group">
						<label for="reply-input" class="col-form-label">
							작성자
						</label>
						<input type="text" class="form-control" id="replyer-input">
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="reply-submit-button">등록</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
				
			</div>		
		</div>
	</div>
	
	<!-- modal 수정 댓글  form -->
	<div class="modal fade" id="modify-delete-reply-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						수정 / 삭제
					</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input id="reply-rno" type="hidden"/>
					<div class="form-group">
						<label for="reply-modify-delete" class="col-form-label">
							댓글
						</label>
						<input type="text" class="form-control" id="reply-modify-delete">
					</div>
					<div class="form-group">
						<label for="reply-input" class="col-form-label">
							작성자
						</label>
						<input readonly type="text" class="form-control" id="replyer-modify-delete">
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="reply-modify-button">수정</button>
					<button type="button" class="btn btn-danger" id="reply-remove-button">삭제</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
				
			</div>		
		</div>
	</div>
	
</body>
</html>