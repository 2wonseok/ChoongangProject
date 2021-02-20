<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
 #btn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 40px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}
pre {
    width:100%;
    overflow:hidden;
    word-break:break-all;
    word-break:break-word;
    line-height:30px;
    white-space: pre-wrap;       /* CSS 3 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
	font-weight: bolder;
	font-size: large;
}

#footdiv {
    width: 1000px;
    padding: 0 30px 30px 30px;
    text-align: center;
    color: gray;
    white-space: pre-line;
    position:absolute;
  	bottom:0;
  	margin-bottom: -143px;
}
#reply_content-input2{
	font-size : 15px;
}
#reply_writer-input2{
	font-size :20px;
}


</style>
<script>
var appRoot = '${root}';
var free_seq = ${freeVO.free_seq};
var page = ${cri.pageNum};
var user_id = "${authUser.user_id}";
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
<script src="${root }/resources/free_js/reply.js"></script>
<script>
	$(document).ready(function() {
		// 날짜 형식
		function dateString(date) {
			var d = new Date(date);
			return d.toISOString().split("T")[0];
			
		}
		
		// 댓글 목록 가져오기 함수
		function showList() {
			// data, callback, error
			// 게시글 번호와 페이지 를 받는다
			replyService.getList({"free_seq" : free_seq, "page" : page}, function(list) {			
				var replyUL = $("#reply-ul");
				replyUL.empty();
				for (var i = 0; i < list.length; i++) {
					var replyLI = '<li class="media" data-reply_seq="' 
					+ list[i].reply_seq + '" ><div class="media-body"><h5>'
					+ list[i].reply_nickname + '<small class="float-right">' 
					+ dateString(list[i].reply_regdate) + "</small></h5>"
					+ list[i].reply_content + "<hr></div></li>";
					replyUL.append(replyLI);
				}
			});
		}
		
		// 새 댓글 버튼 클릭 이벤트 처리
		$("#new-reply-button").click(function() {
			console.log("new reply button clicked....");
			$("#new-reply-modal").modal("show");
			
		});
		
		// 새 댓글 등록 버튼 클릭 이벤트 처리
		$("#reply-submit-button").click(function() {
			
			// input에서 value 가져와서 변수에 저장
			var reply_content = $("#reply_content-input").val();
			var reply_writer = $("#reply_writer-input").val();
			
			// ajax 요청을 위한 데이터 만들기
			var data = {
				"reply_boardseq" : free_seq,
					//댓글이달린 게시글번호는 는 게시글번호   
				"reply_content" : reply_content, 
				"reply_writer" : reply_writer
			};
			
			replyService.add(data,
					function() {
						// 댓글 목록 가져오기 실행
						showList();
						alert("댓글 등록에 성공하였습니다.");
					},
					function() {
						alert("댓글 등록에 실패하였습니다.")
					});
			
			// 모달창 닫기
			$("#new-reply-modal").modal("hide");
			// 모달창 내의 input 요소들 value를 초기화
			$("#new-reply-modal input").val("");
			
			
		});
		
		// reply-ul 클릭 이벤트 처리
	 	$("#reply-ul").on("click", "li", function() {
			// console.log("reply ul clicked......");
			console.log($(this).attr("data-reply_seq"));
			
			// 하나의 댓글 읽어오기
			var reply_seq = $(this).attr("data-reply_seq");
			replyService.get(reply_seq, function(data) {
				$("#reply_seq-input2").val(reply_seq);
				$("#reply_content-input2").val(data.reply_content);
				$("#reply_writer-input2").val(data.reply_nickname);
				// 수정/삭제 hidden 처리
				if (user_id != data.reply_writer) {
					$("#reply-modify-button").hide();
					$("#reply-delete-button").hide();
				} else {
					$("#reply-modify-button").show();
					$("#reply-delete-button").show();
				}
				$("#modify-reply-modal").modal('show');
			});
		});
		
		// 수정 버튼 이벤트 처리
		$("#reply-modify-button").click(function() {
			
			var reply_seq = $("#reply_seq-input2").val();
			var reply_content = $("#reply_content-input2").val();
			var data = {"reply_seq":reply_seq , "reply_content": reply_content};
				//null처리 
			replyService.update(data, function() {
				alert("댓글을 수정하였습니다.");
				$("#modify-reply-modal").modal('hide');
				showList();
			});
		});
		
		// 삭제 버튼 이벤트 처리
		$("#reply-delete-button").click(function() {
			var reply_seq = $("#reply_seq-input2").val();
			replyService.remove(reply_seq, function() {
				alert("댓글을 삭제하였습니다.");
				$("#modify-reply-modal").modal('hide');
				showList();
			});
		});
		
		// 댓글 목록 가져오기 실행
		showList();
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<u:mainNav></u:mainNav> 
	<div class="container-sm">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<h1>게시물 보기</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">

				<div class="form-group">
					<label for="input3">번호</label> <input class="form-control"
						type="text" id="input3" readonly value="${freeVO.free_seq }" />
				</div>

				<div class="form-group">
					<label for="input1">제목</label> <input readonly
						value='<c:out value="${freeVO.free_title }" />' type="text"
						class="form-control" id="input1">
				</div>

				<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea readonly class="form-control" id="textarea1" rows="3"><c:out
							value="${freeVO.free_content }" /></textarea>
				</div>

				<div class="form-group">
					<label for="input2">닉네임</label> <input readonly
						value='<c:out value="${freeVO.free_nickname}" />' type="text"
						class="form-control" id="input2">
				</div>

				<c:url value="/freeboard/modify" var="modifyLink">
					<c:param name="free_seq" value="${freeVO.free_seq }"></c:param>
					<c:param name="pageNum" value="${cri.pageNum }"></c:param>
					<c:param name="amount" value="${cri.amount }"></c:param>
					<c:param name="type" value="${cri.type }"></c:param>
					<c:param name="keyword" value="${cri.keyword }"></c:param>
				</c:url>
				<!-- 유저의 정보가 있고 아이디가 writer와 userid값이 같을때 -->
				<c:if test="${authUser != null && authUser.user_id == freeVO.free_writer}">
				<form action="${root}/freeboard/remove" method="post">
				<a href="${root}/freeboard/modify?free_seq=${freeVO.free_seq}"
					class="btn btn-secondary"> 수정 </a>
					<input hidden="hidden" name="free_seq" value="${freeVO.free_seq}">
					<button class="btn btn-secondary">삭제</button>
				</form>
				</c:if>
			</div>
		</div>
	</div>

	<!-- 댓글 목록 container -->
	<div class="container-sm mt-3">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<span> 댓글 목록 </span>
						<c:if test="${authUser != null }">
						<button class="btn btn-info" id="new-reply-button">댓글 쓰기</button>
						</c:if>
					</div>
					<div class="card-body">
						<ul class="list-unstyled" id="reply-ul">
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%-- modal 새 댓글 form --%>
	<div class="modal fade" id="new-reply-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">새 댓글</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>			
				<div class="modal-body">
					 <div class="form-group">
						<label for="reply_content-input" class="col-form-label"> 댓글 </label> <input
								type="text" class="form-control" id="reply_content-input" maxlength="100">
								</div>	
					<div class="form-group">
						<label for="reply_writer-input" class="col-form-label"> 작성자 </label> <input
							type="text" class="form-control" value="${authUser.user_nickname}" readonly>
					</div>
					<input type="hidden" id="reply_writer-input" value="${authUser.user_id}" />
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button id="reply-submit-button" type="button"
						class="btn btn-primary">등록</button>
				</div>
			</div>
		</div>
	</div>

	<%-- modal 수정 form --%>
	
	<div class="modal fade" id="modify-reply-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title"></h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input id="reply_seq-input2" type="hidden" />
					<div class="form-group">
						<label for="reply_content-input2" class="col-form-label"> 댓글 </label>
							<c:choose>
								<c:when test="${authUser != null && authUser.user_id == freeVO.free_writer}">
						 <input type="text" class="form-control" id="reply_content-input2">
								</c:when>
								<c:otherwise>
						<input type="text" class="form-control" id="reply_content-input2" readonly>		
								</c:otherwise>
							</c:choose>
					</div>
					<div class="form-group">
						<label for="reply_writer-input2" class="col-form-label"> 작성자 </label> <input
							readonly type="text" class="form-control" id="reply_writer-input2" >
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button id="reply-modify-button" type="button"
						class="btn btn-primary">수정</button>
					<button id="reply-delete-button" type="button"
						class="btn btn-danger">삭제</button>
				</div>
			</div>
		</div>
	</div>
	 <%-- <u:footer/>  --%>
</body>
</html>




