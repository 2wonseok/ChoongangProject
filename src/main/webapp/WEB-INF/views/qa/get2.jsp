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

</script>
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/default.css?ver=1432">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/skin/board/basic/style.css?v2">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/board.common.css?ver=1432">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/js/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/mobile.css?ver=1432">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/contents.css?ver=1432">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/plugin/featherlight/featherlight.min.css?ver=1432">
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
    background: #4a4a4a;
    padding: 0px 15px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
    border-radius: 3px;    
}


#reply-submit-button_admin {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #4a4a4a;
    padding: 0px 15px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
    border-radius: 3px;
}


#table {
    border: 1px solid white;
}
#image {
	max-width: 100%
}
#containers {
    clear: both;
    position: relative;
    margin: 35px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
}
pre {
    display: block;
    font-size: 87.5%;
    color: #212529;
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
								
				// 로그인 아이디와 닉네임이 동일 하고, 등급이 1(일반) 인 경우
				if(writer == nickname && grade == 1) {
					replyUL.append(
						'<li class="main" data-seq="'+ seq +'">'
						+ '<div>'
						+ '<i class="fab fa-replyd"></i><div class="content" value="'+ content +'">' + content +'</div>'	
						+ '<small class="float-right text-primary">'
						+ '<div class="modify">수정</div>'
						+ '<div class="delete">삭제</div>'
						+ '</small>'
						+ '</div >'
						+ '<div class="float-reft text-info"><i class="far fa-user"></i>' + writer +'</div>' 
						+ '<small class="float-reft text-info"><i class="far fa-clock"></i>'
						+ moment(regdate).format('YYYY.MM.DD.HH:mm') 
						+ '</small>'
						+ '</li>'
						+ '<hr>'				
					);			
				} 
				// 로그인 아이디와 닉네임이 동일 하고, 등급이 0(관리자) 인 경우
				else if(writer == nickname && grade == 0) {
					replyUL.append(
						'<li class="main" data-seq="'+ seq +'">'
						+ '<div>'
						+ '<i class="fab fa-replyd"></i><div class="content" value="'+ content +'">' + content +'</div>'	
						+ '<small class="float-right text-primary">'
						+ '<div class="modify_admin">수정</div>'
						+ '<div class="delete_admin">삭제</div>'
						+ '</small>'
						+ '</div>'
						+ '<div class="float-reft text-info"><i class="far fa-user"></i>' + writer +'</div>'
						+ '<small class="float-reft text-info"><i class="far fa-clock"></i>'
						+ moment(regdate).format('YYYY.MM.DD.HH:mm') 
						+ '</small>'
						+ '</li>'
						+ '<hr>'				
					);			
				} else { //로그인 되어있지 않은 유저나, 로그인 되어있지만 댓글을 작성하지 않은 유저
					replyUL.append(
							'<li class="main" data-seq="'+ seq +'">'
							+ '<div>'
							+ '<i class="fab fa-replyd"></i><div class="content" value="'+ content +'">' + content +'</div>'	
							+ '</div>'
							+ '<div class="float-reft text-info"><i class="far fa-user"></i>' + writer +'</div>'
							+ '<small class="float-reft text-info"><i class="far fa-clock"></i>'
							+ moment(regdate).format('YYYY.MM.DD.HH:mm') 
							+ '</small>'
							+ '</li>'
							+ '<hr>'
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
		var seq = $(this).parent('small').parent('div').parent('li').attr("data-seq");
		var content = $(this).parent('small').parent('div').children('div').attr("value");
 
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
		var seq = $(this).parent('small').parent('div').parent('li').attr("data-seq");
		var content = $(this).parent('small').parent('div').children('div').attr("value");

 		if(confirm("삭제 하시겠습니까?") == true){
			replyService.remove_admin(seq, function() {
				alert("댓글 삭제 완료.");
				showList();								
				});						
			} else {
				showList();		
			};
	}); 
	
	
	
/* 	// 댓글 값 가져오기
	// 수정 버튼 이벤트 처리
	$("#reply_list").on("click", ".modify", function() {
		var seq = $(this).parent('small').parent('div').parent('li').attr("data-seq");
		var content = $(this).parent('small').parent('div').children('div').attr("value");
		
		
 		var data = {reply_seq: seq, reply_content: content};		
		replyService.modify(data, function() {
			alert("댓글을 수정 하였습니다.");
			showList();
		});		
	}); */
	
	// 댓글 목록 함수 showList() 불러오기
	showList();
});

</script>
<title>게시물 보기</title>
</head>
<body>

<u:mainNav/>


	
<div class="container-md">
	<section id="containers">
		<article id="bo_v" style="width:100%">
			<header>
      	<h2><span class="bo_v_tit">${board.qa_title }</span></h2>
    	</header>
		
		<section id="bo_v_info">	
			<h2>페이지 정보</h2>
	 		<span class="sound_only" >작성자</span>
      	<strong>
        	<span class="sv_member">${board.qa_writer }</span>
        </strong>
      <span>&nbsp&nbsp&nbsp</span>
	 		
	 		<span class="sound_only" >질문 종류</span>
	 			<strong>
        	<i class="fas fa-info-circle" aria-hidden="false"></i>
        		${board.qa_category }
        </strong>
       <span>&nbsp&nbsp</span>
 			 <span class="sound_only">조회</span>
   		 	<strong>
   		  	<i class="fa fa-eye" aria-hidden="true"></i>
   					${board.qa_readcnt }
   			</strong>	
   			<c:if test="${board.qa_updatedateKST == null }">
        	<small class="text-secondary" style="float:right">
        		<fmt:formatDate value='${board.qa_regdateKST}' pattern='yyyy년 MM월 dd일 h시 m분'/>
        	</small>
        	<i class="far fa-calendar-alt" style="float:right; margin-right:8px; margin-top: 1px;"></i>
        </c:if>
        <c:if test="${board.qa_updatedateKST != null }">
        	<small class="text-secondary" style="float:right">
        		수정됨 <fmt:formatDate value='${board.qa_updatedateKST}' pattern='yyyy년 MM월 dd일 h시 m분'/>
        	</small>
        	<i class="far fa-calendar-alt" style="float:right; margin-right:8px; margin-top: 1px;"></i>
        </c:if>  	
		</section>  	
		  
		<section id="bo_v_atc">
			<h2 id="bo_v_atc_title">본문</h2>
			<div id="bo_v_con">
				<div class="form-group" >
					<c:forEach items="${getQafileNameList }" var="qaImg" varStatus="imgNum">
						<img onerror="this.src='${root }/resources/noimage.jpg'" src="${root }/resources/qaboard/upload/${qaImg }" width="245px" height="245px">
					</c:forEach>
				</div>
				<hr class="dashHr" style="border:none;">
				<pre>${board.qa_content }</pre>
				<hr class="one">
				<div id="bo_v_share" >
		 			<a class="btn btn_b03" style="border: 0;outline: 0;" href="${root }/qa/list">목록으로</a> 
		 			<!-- 보드 작성자 이름과 로그인 아이디가 같고, 등급이 1인 경우(일반)에만 활성화  -->
					<c:if test="${board.qa_writer == authUser.user_nickname && authUser.user_grade == 1 }">
						<a class="btn btn_b03" style="border: 0;outline: 0;" href="${root }/qa/modify?qa_seq=${board.qa_seq }" >수정</a> 
						<a class="btn btn_b03" style="border: 0;outline: 0;" href="${root }/qa/remove?qa_seq=${board.qa_seq }" >삭제</a>				
					</c:if>
					<!-- 등급이 0 , 곧 관리자 일경우만 모든 게시물 삭제 가능 하도록 활성화 -->
					<c:if test="${authUser.user_grade == 0 }">
						<a class="btn btn_b03" style="border: 0;outline: 0;" href="${root }/qa/remove?qa_seq=${board.qa_seq }">삭제</a>
					</c:if>		
				  	<!-- 관리자이면서 자신의 글일 경우  -->
				  	<c:if test="${authUser.user_grade == 0 && board.qa_writer == authUser.user_nickname }">
						<a class="btn btn_b03" style="border: 0;outline: 0;" href="${root }/qa/modify?qa_seq=${board.qa_seq }">수정</a> 
					</c:if>
				</div>
			</div>
		</section>		  
			
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

	   </article>
	</section>
</div>
		

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