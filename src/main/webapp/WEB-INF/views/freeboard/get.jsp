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
	#container {
    clear: both;
    position: relative;
    margin: 35px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
	}
	#container td {
    float: left;
    margin: 20px;
    border: 1px solid #d8d8d8;
    border-bottom: 3px solid #d8d8d8;
    background: #fff;
    width: 310px;
    min-height: 330px;
    overflow: hidden;
	}
	#btn_write {
    color: #fff;
    font-size: 15px;
    border: none;
  	background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float:right;
    margin-right:120px;
	}
	.webzineTypeView {
    clear: both;
    border-top: 3px solid #4a4a4a;
    border-bottom: 3px solid #4a4a4a;
    margin: 50px 0 20px 0;
    width:1000px;
    height: 580px;
	}
	.webzineTypeView .headWrap {
    background: #f5f5f5;
    position: relative;
    height: 60px;
    padding: 10px 30px;
    font-size: 14px;
    color: #222222;
    border-bottom: 1px solid #dedede;
    word-break: keep-all;
    word-wrap: break-word;
	}
	.webzineTypeView .bodyWrap {
		padding: 21px;
    color: #555555;
    font-size: 14px;
    line-height: 35px;
    word-break: keep-all;
    word-wrap: break-word;
	}
	.mr-t10 {
    margin-top: 10px !important;
	}
	.webzineTypeView .headWrap .category {
    color: #41a1eb;
    font-size: 14px;
	}
	.webzineTypeView .headWrap .date {
    position: absolute;
    right: 30px;
    top: 18px;
	}
	.webzineTypeView .headWrap .date p {
    float: left;
    color: #555555;
    margin-left: 30px;
    font-size: 14px;
	}
	.btn_add {
    color: #000;
    font-size: 15px;
    border: none;
    padding: 0px 10px;
    line-height: 45px;
    float: right;
}
#new-reply-button {
    cursor: pointer; 
    color: #000;
    font-size: 15px;
    border: none;
    padding: 0px 30px;
    line-height: 45px;
}
#logoffReply{
 	cursor: pointer; 
    color: #000;
    font-size: 15px;
    border: none;
    padding: 0px 30px;
    line-height: 45px;

}
	ol, ul {
	    list-style: none;
	}
	.recommView ul {
    border-top: 1px solid #dedede;
    width: 100%;
    margin-top: 15px;
    margin-bottom: 30px;
	}
	.recommView li {
    position: relative;
    padding: 20px 35px;
    margin-bottom: -40px;
	}
	.recommView li p.txt {
    font-size: 14px;
    color: #444444;
    line-height: 22px;
    margin-bottom: 20px;
    display: block;
    word-break: keep-all;
    word-wrap: break-word;
	}
	.recommView li p span {
    color: #999999;
    font-size: 13px;
    padding: 0 15px;
	}
	.recommView li p #datespan {
    color: #999999;
    font-size: 13px;
    padding: 0 15px;
    display: inline-block; 
    width: 133px; 
    white-space: nowrap; 
    overflow: hidden;
    margin-bottom: -6px;
	}
	.lws #reply_content_input {
		padding: 10px 20px;
    width: 877px;
    color: #666666;
    font-size: 15px;
    margin-top: 0;
    border: 1px solid #cccccc;
    line-height: 24px;
    height: 70px;
    box-sizing: content-box;
	}
	#btn_replyadd {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #353535;
    padding: 0px 50px;
    margin-right: -20px;
    line-height: 45px;
    float: right;
    margin-left: 10px;
    width: 180px;
    height: 80px;
    margin-top: 11px;
	}
	.recommView ul li .replyform {
    clear: both;
    color: #999999;
    font-size: 15px;
    height: 30px;
    width: 50px;
    border: 1px solid #dedede;
    padding: 3px 10px;
    background-color: white;
  }
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
				var reply_list = $("#reply_list").empty();
				
				for (var i = 0; i < list.length; i++) {
					var replyLI = '<ul>'
					 +'<li style="border-top:none;" data-reply_seq="'+list[i].reply_seq+'">'
					 +'<p class="txt">'+list[i].reply_content+'</p>'
					 +'<p><span>'+list[i].reply_nickname+'</span>'
					 +'<span id="datespan">'+dateString(list[i].reply_regdate)+'</span>'
					 +'</p>'
				     +'</li>'
					 +'</ul>';
					reply_list.append(replyLI);
					
				}
			});
		}
		//삭제 버튼 클릭시 확인
		$("#remove-btn").click(function(e) {
			e.preventDefault();
	 
	 		
			var remove = confirm('정말 삭제하시겠습니까?');
			if (remove) {
			$("#remove-form").submit();
			}
		});
		
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
			
			// 댓글 내용 체크
			if (reply_content.trim() == "") {
				alert("댓글 내용을 입력해주세요.");
				return false;
			}
			if (reply_content.trim().length > 100) {
				alert("100자 이내로 입력해주세요.")
				return false;
			}
			
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
				}
			);
			
			// 모달창 닫기
			$("#new-reply-modal").modal("hide");
			// 모달창 내의 input 요소들 value를 초기화
			$("#reply_content-input").val("");
		});
		
		// reply-ul 클릭 이벤트 처리
	 	$("#reply_list").on("click", "li", function() {
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
<section id="container">
	<div class="webzineTypeView">
		<div class="headWrap">
			<input class="form-control" type="hidden" id="input3" readonly value="${freeVO.free_seq }" />
			<p class="mr-t10">${freeVO.free_title }</p>
			<div class="date">
				<p><strong>NO : </strong>${freeVO.free_seq }</p>
				<p><strong>조회수 : </strong>${freeVO.free_readCnt }</p>
				<p><strong>작성자(닉네임) : </strong>${freeVO.free_nickname}</p>
				<p><strong>작성일</strong>
				<fmt:formatDate pattern="yyyy-MM-dd" value="${freeVO.free_regdate}" /></p>
				<p><strong>수정일</strong>
				<fmt:formatDate pattern="yyyy-MM-dd" value="${freeVO.free_updatedate}" /></p>
			</div>
		</div>
			<!-- 본문 -->
			<div class="bodyWrap">
				<p>${freeVO.free_content }</p>
			</div>
	</div>
	<c:url value="/freeboard/modify" var="modifyLink">
		<c:param name="free_seq" value="${freeVO.free_seq }"></c:param>
		<c:param name="pageNum" value="${cri.pageNum }"></c:param>
		<c:param name="amount" value="${cri.amount }"></c:param>
		<c:param name="type" value="${cri.type }"></c:param>
		<c:param name="keyword" value="${cri.keyword }"></c:param>
	</c:url>
	<!-- 유저의 정보가 있고 아이디가 writer와 userid값이 같을때 -->
		<form action="${root}/freeboard/remove" method="post" id="remove-form">
			<c:choose> 
				<c:when test="${authUser.user_id !=null }">
					<a id="new-reply-button">댓글 작성</a>
				</c:when>
				<c:otherwise>
					<a href="${root }/user/login" id="logoffReply">댓글 작성</a>
				</c:otherwise>
			</c:choose>
		<c:if test="${authUser != null && authUser.user_id == freeVO.free_writer}">
			<button class="btn_add" id="remove-btn">삭제</button>
			<input hidden="hidden" name="free_seq" value="${freeVO.free_seq}">
			<a href="${root}/freeboard/modify?free_seq=${freeVO.free_seq}" class="btn_add"> 수정 </a>
		</c:if>
			<a href="${root }/freeboard/list" class="btn_add">목록으로 </a>		
		</form>
	<!--  댓글 목록 -->
	<div class="recommView" id="reply_list"></div>
	<br>
	<br>
</section>

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
					 	<!-- null처리 -->
						<label for="reply_content-input" class="col-form-label"> 댓글 </label> <input
								type="text" class="form-control" id="reply_content-input" maxlength="100" >
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
	 <u:footer/> 
</body>
</html>




