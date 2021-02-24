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
var grade = '${authUser.user_grade}';
var img = '${getQafileNameList }';
</script>
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<script src="${root }/resources/js/qa_reply.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<style>
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
    height:100%;
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
		padding: 3px;
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
#btn_add {
    color: #000;
    font-size: 15px;
    border: none;
    padding: 0px 10px;
    line-height: 45px;
    float: right;
}
/* 댓글 작성 폼 */
	.lws {
		display: flex;
	}
	.recommWritebox {
    clear: both;
    width: 1000px;
    margin: 95px auto 40px;
    background: #f8f8f8;
    padding: 15px 30px;
    border: 1px solid #e7e9ee;
    text-align: center;
    color: #666666;
    font-size: 15px;
	}
	.recommWritebox textarea {
    padding: 10px 20px;
    width: 1030px;
    color: #666666;
    font-size: 15px;
    margin: 0;
    border: 1px solid #cccccc;
    line-height: 24px;
    height: 80px;
    box-sizing: content-box;
	}
	.replyBtn_add {
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
}
/* 댓글 리스트 폼 */
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
.modify {
		cursor: pointer;
}
.delete {
		cursor: pointer;
}
.delete_admin {
		cursor: pointer;
}
/* 기존 */
#image {
	max-width: 100%
}
#footdiv {
    width: 1000px;
    padding: 0 30px 30px 30px;
	  text-align: center;
    color: gray;
    white-space: pre-line; 
   	bottom:0;
}
</style>

<script>

$(document).ready(function() {
	
	if (img == null || img == '') {
		$('.webzineTypeView').css('height', '588px');
		$('.bodyWrap').css('padding', '21px');
	}
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
			
			var replyUL = $("#reply_list").empty();

			for (var i = 0; i < list.length; i++) {
				
				var seq = list[i].reply_seq;
				var content = list[i].reply_content;
				var writer = list[i].reply_writer;
				var regdate = list[i].reply_regdateKST;

		
				// 댓글 작성자 아이디와 로그인한 닉네임이 동일 하고, 등급이 1(일반) 인 경우
				if(writer == nickname && grade == 1) {
					replyUL.append(
							'<ul>'
							+'<li style="border-top:none;" data-seq="'+seq+'">'
							+'<p class="txt">'+content+'</p>'
							+'<p><span>'+writer+'</span>'
							+'<span id="datespan">'+moment(regdate).format('YYYY.MM.DD.HH:mm')+'</span>'
							+'<span style="color:gray;" class="modify">수정</span>'
							+'<span style="color:red;" class="delete">삭제</span>'
							+'</p>'
							+'</li>'
							+'</ul>'
					);
				} 
				// 작성자 아이디와 닉네임이 동일 하고, 등급이 0(관리자) 인 경우
				else if(writer == nickname && grade == 0) {
					replyUL.append(
							'<ul>'
							+'<li style="border-top:none;" data-seq="'+seq+'">'
							+'<p class="txt">'+content+'</p>'
							+'<p><span>'+writer+'</span>'
							+'<span id="datespan">'+moment(regdate).format('YYYY.MM.DD.HH:mm')+'</span>'
							+'<span style="color:gray;" class="modify">수정</span>'
							+'<span style="color:red;" class="delete_admin">삭제</span>'
							+'</p>'
							+'</li>'
							+'</ul>'
					);	
				} else { 
					replyUL.append(
							'<ul>'
							+'<li style="border-top:none;" data-seq="'+seq+'">'
							+'<p class="txt">'+content+'</p>'
							+'<p><span>'+writer+'</span>'
							+'<span id="datespan">'+moment(regdate).format('YYYY.MM.DD.HH:mm')+'</span>'
							+'</p>'
							+'</li>'
							+'</ul>'
					);
				} 
			};
			
		});		
	};
	
	// 댓글 쓰기 (일반)
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
	
	// 댓글 쓰기 (관리자)
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
	
	// 삭제 처리 (일반)
	// reply-list seq, content 값 불러오고 삭체 처리 처리
	$("#reply_list").on("click", ".delete", function() {		
		// 하나의 댓글 읽어오기
		var seq = $(this).parent('p').parent('li').attr('data-seq');
		var content = $(this).parent('p').parent('li').children('.txt').text();
 
 		if(confirm("삭제 하시겠습니까?") == true){
			replyService.remove(seq, function() {
				alert("댓글 삭제 완료.");
				showList();								
				});						
			} else {
				showList();		
			};
	});
	
	// 삭제 처리 (관리자)
	// reply-list seq, content 값 불러오고 삭체 처리 처리
	$("#reply_list").on("click", ".delete_admin", function() {		
		// 하나의 댓글 읽어오기
		var seq = $(this).parent('p').parent('li').attr('data-seq');
		var content = $(this).parent('p').parent('li').children('.txt').text();
		
 		if(confirm("삭제 하시겠습니까?") == true){
			replyService.remove_admin(seq, function() {
				alert("댓글 삭제 완료.");
				showList();								
				});						
			} else {
				showList();		
			};
	}); 
	
	
	
 	// 댓글 값 가져오기
	// 수정 버튼 이벤트 처리
	$("#reply_list").on("click", ".modify", function() {
		var seq = $(this).parent('p').parent('li').attr('data-seq');
		var content = $(this).parent('p').parent('li').children('.txt').text();
		
		replyService.get(seq, function() {			
			$("#reply-seq").val(seq);
			$("#reply-modify-delete").val(content);
			$("#modify-reply-modal").modal("show");
		});		
	}); 
 	
	// 수정 버튼 이벤트 처리
	$("#reply-modify-button").click(function() {
		var seq = $("#reply-seq").val();
		var reply = $("#reply-modify-delete").val();

		var data = {reply_seq: seq, reply_content: reply};
		replyService.modify(data, function() {
			alert("댓글을 수정 하였습니다.");
			$("#modify-reply-modal").modal('hide');
			showList();
		});		
	});
 	
 	
	// 댓글 목록 함수 showList() 불러오기
	showList();
});

</script>

<script>
	$(document).ready(function() {
		$("#reply_content_input").mousedown(function() {
			if (nickname == "") {
				alert("로그인 후 이용하세요.");
				location.href = "${root}/user/login";
			}
		});
	});
</script>

<title>게시물 보기</title>
</head>
<body>
<u:mainNav/>
	<section id="container">
		<div class="webzineTypeView">
			<div class="headWrap">
				<p class="mr-t10">${board.qa_title }</p>
				<div class="date">
					<p><strong>구분 : </strong>${board.qa_category }</p>
					<p><strong>조회수 : </strong>${board.qa_readcnt }</p>
					<p>
						<strong>작성자 : ${board.qa_writer } </strong>
					</p>
					<c:choose>
						<c:when test="${empty board.qa_updatedate}">
							<p>
								<strong>등록일 :</strong>
								<fmt:formatDate value='${board.qa_regdateKST}' pattern='yyyy년 MM월 dd일 h시 m분'/>
							</p>
						</c:when>
						<c:otherwise>
							<p>
								<strong>수정일 :</strong>
								<fmt:formatDate value='${board.qa_updatedateKST}' pattern='yyyy년 MM월 dd일 h시 m분'/>
							</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="bodyWrap">
				<div class="form-group" style="margin-top:5px;">
					<c:forEach items="${getQafileNameList }" var="qaImg" varStatus="imgNum">
						<img onerror="this.src='${root }/resources/noimage.jpg'" src="${root }/resources/qaboard/upload/${qaImg }" width="245px" height="245px">
					</c:forEach>
				</div>
				<p>${board.qa_content }</p>
			</div>
		</div>
		<c:url value="${root }/qa/list" var="listLink">
			<c:param name="qa_seq" value="${board.qa_seq }" />
			<c:param name="pageNum" value="${criteria.pageNum }" />
			<c:param name="amount" value="${criteria.amount }" />
			<c:param name="type" value="${criteria.type }"/>
			<c:param name="keyword" value="${criteria.keyword }"/>
		</c:url>
		<a id="btn_add" href="${listLink }">목록으로</a> 
		<!-- 보드 작성자 이름과 로그인 아이디가 같고, 등급이 1인 경우(일반)에만 활성화  -->
		<c:if test="${board.qa_writer == authUser.user_nickname && authUser.user_grade == 1 }">
			<a id="btn_add" style="margin-right: 3px;" href="${root }/qa/modify?qa_seq=${board.qa_seq }" >수정</a> 
			<a id="btn_add" style="margin-right: 3px;" href="${root }/qa/remove?qa_seq=${board.qa_seq }" >삭제</a>				
		</c:if>
		<!-- 등급이 0 , 곧 관리자 일경우만 모든 게시물 삭제 가능 하도록 활성화 -->
		<c:if test="${authUser.user_grade == 0 }">
			<a id="btn_add" style="margin-right: 3px;" href="${root }/qa/remove?qa_seq=${board.qa_seq }">삭제</a>
		</c:if>		
 		<!-- 관리자이면서 자신의 글일 경우  -->
 		<c:if test="${authUser.user_grade == 0 && board.qa_writer == authUser.user_nickname }">
			<a id="btn_add" style="margin-right: 3px;" href="${root }/qa/modify?qa_seq=${board.qa_seq }">수정</a> 
		</c:if>
	<!-- 댓글 작성 폼 -->
	<div class="recommWritebox">
		<div class="lws">
			<textarea id="reply_content_input" name="reply_content" >${reply_content }</textarea>
			<c:if test="${not empty authUser.user_nickname}">
			<!-- // 작성자 hidden 처리 -->	
				<input readonly type="hidden" type="text" name="reply_writer" value="${authUser.user_nickname }" id="reply_writer_input"/><br>
				<c:if test="${errors.reply_noContent }">
					<small class="form-text text-danger"> 댓글 내용을 입력 해주세요. </small>
				</c:if>
		
			<!-- 일반 유저 댓글 쓰기 -->
				<c:if test="${!empty authUser.user_id && authUser.user_grade == 1}">
					<button class="replyBtn_add" id="reply-submit-button">댓글작성</button> 
				</c:if>
			<!-- 관리자 댓글 쓰기 -->
				<c:if test="${!empty authUser.user_id && authUser.user_grade == 0}">
					<button class="replyBtn_add" id="reply-submit-button_admin">댓글작성</button> 
				</c:if>
			</c:if>
		</div>
	</div>
	
<!-- 
// 댓글 목록 AJAX
 -->
	<div class="recommView" id="reply_list">

	</div>
</section>	 

<div class="modal fade" id="modify-reply-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						댓글 수정
					</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input id="reply-seq" type="hidden"/>
					<div class="form-group">

						<input type="text" class="form-control" id="reply-modify-delete">
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="reply-modify-button">수정</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
				
			</div>		
		</div>
	</div>
	<div class="container-md">
	<section id="containers">
		<article id="bo_v" style="width:100%">
    <footer>
			<div id="footdiv">
				<div class="container" style="width:100%;">
				사업자명 : BCD쇼핑몰 ㅣ 사업자 번호 : 123-45-78901 ㅣ 개인정보관리책임자 : 이원석
				주소 : 서울특별시 마포구 신촌로 176 5층 501호ㅣ 전화 : 0507-1409-1711안내ㅣ 메일 : lws3793@naver.com
				</div>
			</div>
		</footer> 
	</article>
	</section>
	</div>
</body>
</html>