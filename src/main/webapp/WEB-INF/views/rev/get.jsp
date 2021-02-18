<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
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
/*
#goodbtn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 40px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}
#hatebtn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 40px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}
#login_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
} */
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

</style>
<script>
	var appRoot = '${root}'; // 자바스크립트 코드에서 contextPath를 쓰기위해 선언.
	var rev_seq = ${RevBoard.rev_seq}; 
	var authUser = '${authUser.user_id}';
	var user_seq = '${authUser.user_seq}';
</script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<meta name="HandheldFriendly" content="true">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<script src="${root }/resources/rev_js/rev.js"></script>
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/default.css?ver=1432">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/skin/board/basic/style.css?v2">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/board.common.css?ver=1432">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/js/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/mobile.css?ver=1432">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/contents.css?ver=1432">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/plugin/featherlight/featherlight.min.css?ver=1432">
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<script>


//새 댓글 버튼 클릭 이벤트 처리
$(document).ready(function() {
		// 날짜 형식

		function dateString(date) {
			var d = new Date(date);
			return d.toISOString().split("T")[0];
			
			
		}
function showList() {
			replyService.getList(rev_seq, function(list) {
				// console.log(list);	
				
				/* var replyUL = $("#reply-ul") */
				var replyUL = $("#bo_vc");
				replyUL.empty(); // append로 계속 있어도 리스트를 넣어주니까 한번비워주는 코드
				/* for (var i = 0; i < list.length; i++) {
					var replyLI = '<li class="media" data-reply_seq="'
						+ list[i].reply_seq + '"><div class="media-body"><h5>'
						+ list[i].reply_writer + '<small class= "float-right">'
						+ dateString(list[i].reply_regdate) + "</small></h5>"
						+ list[i].reply_content + "<hr class='dashHr'></div></li>";
						
						
						replyUL.append(replyLI); 
						style="l"
					}  */
					  for (var i = 0; i < list.length; i++) {
						var replyLI = '<article data-reply_seq="' + list[i].reply_seq + '"><header style="z-index:5;line-height: 40px;">'
						+  '<span class="guest">'
						+ list[i].reply_writer
						+  '</span><span class="bo_vc_hdinfo"><i class="far fa-clock" aria-hidden="true"></i>&nbsp<small class="text-secondary">'
						+ dateString(list[i].reply_regdateKST) + '</span></small></header><div class="cmt_contents" >'
						+ list[i].reply_content
						+ '<textarea style="display:none">' 
						+  list[i].reply_content  
						+ '</textarea></div></article>'
						 
						
						replyUL.append(replyLI);
					  }
						
				}),
			function(err) {
			};
}
		

$("#new-reply-button").click(function() {
	console.log("new reply button clicked!");
	$("#new-reply-modal").modal("show");
});

//새 댓글 등록 버튼 클릭 이벤트 처리
$("#reply-submit-button").click(function() {
	
	// input에서 value 가져와서 변수에 저장
	var reply_content = $("#reply_content-input2").val();		
	var reply_writer = $("#reply_writer-input2").val();
	
	// ajax 요청을 위한 데이터 만들기
	var data = {reply_boardname: 'RevBoard', reply_boardseq: rev_seq, reply_content: reply_content,  reply_writer: reply_writer}
	
	replyService.add(data,
			function() {
			/* $("#reply-ul").empty();	이렇게 사용해도 리스트를 비워주고 
		   	showList();					새로작성한것과 기존의 리스트만 보여줌
		   	alert("댓글 등록에 성공했습니다"); */
				
		   	
		   	// 댓글 목록 가져오기 실행
				 showList(); 
				// location.reload(); 새로고침하는 자바스크립트 코드
				alert("댓글 등록에 성공하였습니다.");
				location.reload();
	},
			function() {
				alert("댓글 등록에 실패하였습니다.");
			
	});
	
	// 모달창 닫기
	$("#new-reply-modal").modal("hide");
	// 모달창 내의 input 요소들 value들 초기화
	$("#reply_content-input2").val("");
	
	
	
	
	
	
});

//reply-ul 클릭 이벤트 처리


$("#bo_vc").on("click", "article",  function() { // on메소드를 이용해서 reply-ul 안에있는 <li> 를 눌렀을때
	//console.log("reply ul clicked.....");	   // 일이 일어나도록함.
	console.log($(this).attr("data-reply_seq"));		// 여기서의 this는 click이벤트를 당한 li를 뜻함.

	// 하나의 댓글 읽어오기
	var reply_seq = $(this).attr("data-reply_seq");
	replyService.get(reply_seq, function(data) {
		console.log(reply_seq);
		console.log(data);
		console.log(data.reply_writer);
		
		//<div id="ddd">
		//<button id="reply-modify-button"type="button" class="btn btn-primary">수정</button>
		//<button id="reply-delete-button"type="button" class="btn btn-danger">삭제</button>
		//</div>
		
		var modifyMd = $("#modify-footer");
		var namei = data.reply_writer;
		var ok = '';
		if (authUser == data.reply_writer) {
			$('#reply_content-input3').attr("readonly", false);
			ok = '<div id="confirm">'
			+ '<button id="reply-modify-button" type="button" class="btn btn-primary">수정</button>'
			+ '<button id="reply-delete-button" type="button" class="btn btn-danger">삭제</button>'
			+ '</div>'
			
			modifyMd.empty();
			modifyMd.append(ok);
			
			//수정 버튼 이벤트 처리
			$("#reply-modify-button").click(function() {
				var reply_seq = $("#reply_seq-input3").val();
				var reply_content = $("#reply_content-input3").val();
				var data = {reply_seq: reply_seq, reply_content: reply_content}
				
				replyService.update(data, function() {
					alert("댓글을 수정하였습니다.");
					$("#modify-reply-modal").modal("hide");		
					showList();
				}); 
			});
			
			//삭제 버튼 이벤트 처리
			$("#reply-delete-button").click(function() {
				var reply_seq = $("#reply_seq-input3").val();
				var data = {reply_seq: reply_seq}
				
				replyService.remove(data, function() {
					alert("댓글을 삭제하였습니다.");
					$("#modify-reply-modal").modal("hide");
					showList();
				});
			});
			showList();
			
			
			
		} else {
			modifyMd.empty();
			
			$('#reply_content-input3').attr("readonly", true);
			
			ok = '<div id="confirm">'
			+ '<button id="reply-close-button" type="button" class="btn btn-primary">닫기</button>'
			+ '</div>'
			modifyMd.append(ok);
			
			$("#reply-close-button").click(function() {
				$("#modify-reply-modal").modal("hide");
			})
			
		}
		
		$("#reply_seq-input3").val(data.reply_seq);
		$("#reply_content-input3").val(data.reply_content);
		$("#reply_writer-input3").val(data.reply_writer);
		$("#reply_boardname-input3").val('RevBoard');
		$("#modify-reply-modal").modal("show");
	});
	
});

//수정 버튼 이벤트 처리
$("#reply-modify-button").click(function() {
	var reply_seq = $("#reply_seq-input3").val();
	var reply_content = $("#reply_content-input3").val();
	var data = {reply_seq: reply_seq, reply_content: reply_content}
	
	replyService.update(data, function() {
		alert("댓글을 수정하였습니다.");
		$("#modify-reply-modal").modal("hide");		
		showList();
	}); 
});
//삭제 버튼 이벤트 처리
$("#reply-delete-button").click(function() {
	var reply_seq = $("#reply_seq-input3").val();
	var data = {reply_seq: reply_seq}
	
	replyService.remove(data, function() {
		alert("댓글을 삭제하였습니다.");
		$("#modify-reply-modal").modal("hide");
		showList();
	});
});
showList();
});
</script>
<script>
	
	
	 $(document).ready(function() {
	
	$('#goodbtn').click(function(){
		   
		  $.ajax({
			  method: "get",
		      url: "/rev/like", 
		      dataType: "json",
		      data: {rev_seq: rev_seq, user_seq: user_seq},
		 	  success: function(res) {
		 		 console.log(res);
		 		  if (res == 0) {
		 			  /* alert("좋아요를 누르셨습니다."); */
			 		  alert("좋아요를 누르셨습니다.");
			 		  location.reload(); 
		 		  } else if (res == 1) {
		 			 alert("좋아요를 취소하셨습니다.");
		 			location.reload();
		 			
		 		  }
		 	  }, error: function(error) {
		 		  alert("실패");
		 		  /* alert("좋아요를 이미 누르셨습니다."); */
		 	  }
		  });
		    /* .done(function(data) {	
		    	  alert("성공");
		          
		          	if (data == 0) {
		        	  alert("좋아요를 누르셨습니다!");
		          	} else if (data == 1) {
		          		alert("좋아요를 취소하셨습니다.");
		          	} 
		          })
		       .fail(function(xhr, status, er){
		    	  alert(rev_seq);
		    	  alert(user_seq);
		    	  console.log(xhr);
		    	  alert("좋아요를 이미 누르셨습니다!");
			     }) */
	}); 
	 });

	 $(document).ready(function() {
			
			$('#hatebtn').click(function(){
				   
				  $.ajax({
					  method: "get",
				      url: "/rev/hate",
				      dataType: "json",
				      data: {rev_seq: rev_seq, user_seq: user_seq}, 
				      success: function(res){	
				    	  
				          if (res == 0) {
				        	  alert("싫어요를 누르셨습니다");
				        	  location.reload();
				          } else if (res == 1) {
				        	  alert("싫어요를 취소하셨습니다");
				        	  location.reload();
				          }
				      },
				      error:function(error){
				    	  alert("실패");
				      }
				      
				  });
				});		
			});
	 
	 $(document).ready(function() {
		 
		 $('#login_add').click(function(){
			var a = confirm("로그인시 이용가능합니다. 로그인 하시겠습니까?");
			if (a == true) {
				location = '${root}/user/login';
			} else if (a == false) {
			 //alert("로그인시 이용가능 합니다.");	 
			}
		 });
		 $('#login_add2').click(function(){
			var a = confirm("로그인시 이용가능합니다. 로그인 하시겠습니까?");
			if (a == true) {
				location = '${root}/user/login';
			} else if (a == false) {
			 //alert("로그인시 이용가능 합니다.");	 
			}
		 });
	 });
	 $(document).ready(function() {
		 
	 	$('#new-reply-button1').click(function(){
	 		var b = confirm("로그인시 이용가능합니다. 로그인 하시겠습니까?");
	 		if (b == true) {
	 		location = '${root}/user/login';
	 		} else if (b == false) {
	 		// 현재페이지
	 		}
	 	});
	 });
</script>

<title>Insert title here</title>
</head>
<body>
<u:mainNav></u:mainNav>
	
	<div class="container-md">
		<div class="row">
			<div class="col-12 col-lg-8 offset-lg-3">
	
	<article id="bo_v" style="width:100%">
    <header>
        <h4 id="bo_v_title">
                        <span class="bo_v_tit">
            ${RevBoard.rev_title }</span>
        </h4>
    </header>

    <section id="bo_v_info">
        <h2>페이지 정보</h2>
        <span class="sound_only" >작성자</span><strong><span class="sv_member">${RevBoard.rev_writer }</span></strong>
        <span>&nbsp&nbsp&nbsp</span>
        <span class="sound_only" >카테고리</span><strong><i class="fas fa-info-circle" aria-hidden="false"></i>&nbsp&nbsp<c:if test="${RevBoard.rev_category eq 1}">모자</c:if><c:if test="${RevBoard.rev_category eq 2}">신발</c:if><c:if test="${RevBoard.rev_category eq 3}">상의</c:if><c:if test="${RevBoard.rev_category eq 4}">하의</c:if><c:if test="${RevBoard.rev_category eq 5}">전자 기기</c:if><c:if test="${RevBoard.rev_category eq 6}">식품</c:if></strong>
        <span>&nbsp&nbsp&nbsp</span>
        <span class="sound_only">댓글</span><strong><i class="fas fa-comment-alt" aria-hidden="false"></i>&nbsp&nbsp${RevBoard.rev_replyCnt }</strong>
        <span>&nbsp&nbsp&nbsp</span>
        <span class="sound_only">조회</span><strong><i class="fa fa-eye" aria-hidden="true"></i>&nbsp&nbsp${RevBoard.rev_readCnt}</strong>
        <span>&nbsp&nbsp&nbsp</span>
        <c:if test="${RevBoard.rev_updatedate == null }">
        <!-- <strong class="if_date"><span class="sound_only">작성일</span> -->
        <i class="far fa-calendar-alt"></i>&nbsp&nbsp<small class="text-secondary"><fmt:formatDate value='${RevBoard.rev_regdate}' pattern='yyyy년 MM월 dd일 h시 m분'/></small>
        <!-- </strong> -->
        </c:if>
        <c:if test="${RevBoard.rev_updatedate != null }">
        <i class="far fa-calendar-alt"></i>&nbsp&nbsp<small class="text-secondary"><fmt:formatDate value='${RevBoard.rev_updatedate}' pattern='yyyy년 MM월 dd일 h시 m분'/></small>
        </c:if>
    </section>

    <section id="bo_v_atc">
        <h2 id="bo_v_atc_title">본문</h2>
       

        <!-- 본문 내용 시작 { -->
        <div id="bo_v_con">
        <c:if test="${RevBoard.rev_filename != null}">
         <div class="form-group" >
					 <input readonly hidden
						value="${RevBoard.rev_filename }" type="text" class="form-control" id="input3" />						
						<c:forEach items="${RevfileNameList }" var="revImg" varStatus="imgNum">
						<img class="hoveredImage" onerror="this.src='${root }/resources/noimage.jpg'" alt="" src="${root }/resources/upload/${revImg}" height="280px" width="260px">
						</c:forEach>
						
		</div>
        </c:if>
        <hr class="dashHr" style="border:none;">
        <pre>${RevBoard.rev_content }</pre>
        
        <hr class="one">
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
		<div id="bo_v_share" >
		<c:if test="${authUser != null }">
		<button id="goodbtn" class="btn btn_b03" style="border: 0;outline: 0;"><i class="fas fa-thumbs-up" aria-hidden="false"></i>&nbsp&nbsp${RevBoard.rev_good }</button>
		<button id="hatebtn" class="btn btn_b03" style="border: 0;outline: 0;"><i class="fas fa-thumbs-down" aria-hidden="false"></i>&nbsp&nbsp${RevBoard.rev_hate }</button>
		</c:if>
		<c:if test="${authUser == null }">
		<a id="login_add" class="btn btn_b03" style="border: 0;outline: 0;"><i class="fas fa-thumbs-up" aria-hidden="false"></i></a>
		<a id="login_add2" class="btn btn_b03" style="border: 0;outline: 0;"><i class="fas fa-thumbs-down" aria-hidden="false"></i></a>
		</c:if>
		<c:if test="${ sessionScope.authUser.user_id eq RevBoard.rev_writer || authUser.user_grade == 0}">
		<a id="btn_add" class="btn btn_b03" style="border: 0;outline: 0;" href="${modifyLink }">글수정</a>
		</c:if>
		<a id="btn_add" class="btn btn_b03" style="border: 0;outline: 0;" href="${listLink }">목록으로</a>
       </div>
       </div>
                <!-- } 본문 내용 끝 -->
    </section>

    
		
        <!--  추천 비추천 시작 { -->
                <!-- }  추천 비추천 끝 -->
		
		
                
<div class="bo_v_snswr">

	</div>
	
	</article>
	</div>
	</div>
	</div>
	<%-- <div class="container-sm">
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
				<div class="form-group" >
					<label for="input3">파일이름</label> <input readonly
						value="${RevBoard.rev_filename }" type="text" class="form-control" id="input3" />						
						<c:forEach items="${RevfileNameList }" var="revImg" varStatus="imgNum">
						<img class="hoveredImage" onerror="this.src='${root }/resources/noimage.jpg'" alt="" src="${root }/resources/upload/${revImg}" height="280px" width="260px">
						</c:forEach>
						
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
							value="<fmt:formatDate value='${RevBoard.rev_regdate}' pattern='yyyy년 MM월 dd일 h시 m분'/>" class="form-control"
							id="input9"  readonly/>
						
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
		<c:if test="${authUser != null }">
		<button id="hatebtn" class="btn btn-secondary">싫어요!</button>
		<button id="goodbtn" class="btn btn-secondary">좋아요!</button>
		</c:if>
		<c:if test="${authUser == null }">
		<a id="login_add" class="btn btn-secondary">좋아요,싫어요</a>
		</c:if>
		<c:if test="${ sessionScope.authUser.user_id eq RevBoard.rev_writer || authUser.user_grade == 0}">
		<a id="btn_add" class="btn btn-secondary"  href="${modifyLink }">글수정</a>
		</c:if>
		<a id="btn_add" class="btn btn-secondary"  href="${listLink }">목록으로</a>
			</div>
			
		</div>
		
		
	</div> --%>
	<div class="container-sm mt-3">
	<div class="row">
			<div class="col-12 col-lg-8 offset-lg-3">
			
	<hr class="dashHr">
	<div style="float: left;width: 87%;" class="cmt_btn"><i class="fas fa-comment-alt" aria-hidden="false"></i> 댓글목록 <i class="fa fa-chevron-up" aria-hidden="true"></i><i class="fa fa-chevron-down" aria-hidden="true"></i> </div>
	<div style="float: left;width: 13%;"><c:if test="${authUser != null }">
						<button class="btn btn-secondary" id="new-reply-button">댓글 쓰기</button>
						</c:if>
						<c:if test="${authUser == null }">
						<button class="btn btn-secondary" id="new-reply-button1">댓글 쓰기</button>
						</c:if></div>
	
	<hr class="dashHr" style="border: none;">
	<section id="bo_vc">
    <h2>댓글목록</h2>
    
    

    
        
</section>
<footer>
			<div id="footdiv">
				<div class="container" style="margin-left:-141px;">
					사업자명 : BCD쇼핑몰 ㅣ 사업자 번호 : 123-45-78901 ㅣ 개인정보관리책임자 : 이원석
					주소 : 서울특별시 마포구 신촌로 176 5층 501호ㅣ 전화 : 0507-1409-1711안내ㅣ 메일 : lws3793@naver.com
				</div>
			</div>
		</footer>
</div>
</div>
</div>

	<%-- <div class="container-sm mt-3">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<span>
						댓글 목록
						</span>
						<c:if test="${authUser != null }">
						<button class="btn btn-info" id="new-reply-button">댓글 쓰기</button>
						</c:if>
						<c:if test="${authUser == null }">
						<button class="btn btn-info" id="new-reply-button1">댓글 쓰기</button>
						</c:if>
					</div>
					
					<div class="card-body">
						
						<ul class="list-unstyled" id="reply-ul">
							
							<!-- 하나의 댓글이 하나의 li -->
							<!-- <li class="media" data-rno="21"> data-rno는 나중에 쓰기위해 만든 attribute임
							
								<div class="media-body">
								
									<h5>user00 <small>2021/01/29</small></h5>
									
									댓글 본문...........
									
									<hr>
								</div>
							
							</li> -->
						</ul>
						
					</div>
					
				</div>
				
			</div>
		</div>
	</div> --%>
	
	<%-- modal 새 댓글 form --%>
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
					<div class="form-group" >
						<label for="reply_content-input2" class="col-form-label" >
							댓글
						</label>
						<input type="text" class="form-control" id ="reply_content-input2" >
					</div>
					<div class="form-group">
						<label for="reply_writer-input2" class="col-form-label" id="reply-writer">
							작성자
						</label>
						<input type="text" class="form-control" id="reply_writer-input2" value="${authUser.user_id}" readonly>
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button id="reply-submit-button"type="button" class="btn btn-primary">등록</button>
				</div>
				
			</div>
		</div>
	</div>
	<%-- modal 수정 form --%>
	<div class="modal fade" id="modify-reply-modal">
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
					<input id="reply_seq-input3" type="hidden" />
					<div class="form-group">
						<label for="reply_content-input3" class="col-form-label">
							댓글
						</label>
						<input type="text" class="form-control" id ="reply_content-input3">
					</div>
					<div class="form-group">
						<label for="reply_writer-input3" class="col-form-label">
							작성자
						</label>
						<input type="text" class="form-control" id="reply_writer-input3" readonly>
					</div>
					<input id="reply_boardname-input3" type="hidden" />
				</div>
				
				<div class="modal-footer" id="modify-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<!-- <div id="ddd">
					<button id="reply-modify-button"type="button" class="btn btn-primary">수정</button>
					<button id="reply-delete-button"type="button" class="btn btn-danger">삭제</button>
					</div> -->
					
				</div>
				
			</div>
		</div>
	</div>
	
</body>
</html>