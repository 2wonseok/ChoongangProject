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
#btn_add {
    color: #000;
    font-size: 15px;
    border: none;
    padding: 0px 10px;
    line-height: 45px;
    float: right;
}
.new-reply-button {
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
	var img = '${RevfileNameList }';
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<script>


//새 댓글 버튼 클릭 이벤트 처리
$(document).ready(function() {
		// 날짜 형식
		function dateString(date) {
			var d = new Date(date);
			return d.toISOString().split("T")[0];
			
			
		}
		
		if (img == null || img == '') {
			$('.webzineTypeView').css('height', '588px');
		}
		
function showList() {
			replyService.getList(rev_seq, function(list) {
				// console.log(list);	
				
				/* var replyUL = $("#reply-ul") */
				var reply_list = $("#reply_list").empty(); // append로 계속 있어도 리스트를 넣어주니까 한번비워주는 코드
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
						  
							var replyLI = '<ul>'
														+'<li style="border-top:none;" data-reply_seq="'+list[i].reply_seq+'">'
														+'<p class="txt">'+list[i].reply_content+'</p>'
														+'<p><span>'+list[i].reply_writer+'</span>'
														+'<span id="datespan">'+dateString(list[i].reply_regdateKST)+'</span>'
														+'</p>'
														+'</li>'
														+'</ul>';
														
							reply_list.append(replyLI);
						
					  }
							
							
							
							
							
/* 							'<article data-reply_seq="' + list[i].reply_seq + '"><header style="z-index:5;line-height: 40px;">'
						+  '<span class="guest">'
						+ list[i].reply_writer
						+  '</span><span class="bo_vc_hdinfo"><i class="far fa-clock" aria-hidden="true"></i>&nbsp<small class="text-secondary">'
						+ dateString(list[i].reply_regdateKST) + '</span></small></header><div class="cmt_contents" >'
						+ list[i].reply_content
						+ '<textarea style="display:none">' 
						+  list[i].reply_content  
						+ '</textarea></div></article>' */
						 
						
						
						
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
		if (reply_content == null || reply_content == "") {
			alert("내용을 꼭 적어주세요!");
		}
			
	});
	
	// 모달창 닫기
	$("#new-reply-modal").modal("hide");
	// 모달창 내의 input 요소들 value들 초기화
	$("#reply_content-input2").val("");
	
	
	
	
	
	
});

//reply-ul 클릭 이벤트 처리


$("#reply_list").on("click", "li",  function() { // on메소드를 이용해서 reply-ul 안에있는 <li> 를 눌렀을때
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
	<section id="container">
		<div class="webzineTypeView">
			<div class="headWrap">
				<p class="mr-t10">${RevBoard.rev_title }</p>
				<div class="date">
					<p>
						<strong>카테고리 : </strong>
						<c:choose>
							<c:when test="${RevBoard.rev_category eq 1}">모자</c:when>
							<c:when test="${RevBoard.rev_category eq 2}">신발</c:when>
							<c:when test="${RevBoard.rev_category eq 3}">상의</c:when>
							<c:when test="${RevBoard.rev_category eq 4}">하의</c:when>
							<c:when test="${RevBoard.rev_category eq 5}">전자 기기</c:when>
							<c:otherwise>식품</c:otherwise>
						</c:choose>
					</p>
					<p><strong>조회수 : </strong>${RevBoard.rev_readCnt}</p>
					<p><strong>댓글수 : </strong>${RevBoard.rev_replyCnt }</p>
					<p>
						<strong>작성자 : ${RevBoard.rev_writer } </strong>
					</p>
					<c:choose>
						<c:when test="${RevBoard.rev_updatedate == null }">
							<p>
								<strong>등록일 :</strong>
								<fmt:formatDate value='${RevBoard.rev_regdateKST}' pattern='yyyy년 MM월 dd일 h시 m분'/>
							</p>
						</c:when>
						<c:otherwise>
							<p>
								<strong>수정일 :</strong>
								<fmt:formatDate value='${RevBoard.rev_updatedateKST}' pattern='yyyy년 MM월 dd일 h시 m분'/>
							</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<!-- 본문 -->
			<div class="bodyWrap">
				<div class="form-group" style="margin-top:5px;">
					<input readonly hidden value="${RevBoard.rev_filename }" type="text" class="form-control" id="input3" />	
					<c:forEach items="${RevfileNameList }" var="revImg" varStatus="imgNum">
						<img onerror="this.src='${root }/resources/noimage.jpg'" alt="" src="${root }/resources/upload/${revImg}" height="280px" width="260px">
					 </c:forEach>
				</div>
				<p>${RevBoard.rev_content }</p>
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
		<div class="form-group" style="float: right;">
			<c:if test="${authUser != null }">
				<button id="goodbtn" class="btn btn_b03" style="border: 0;outline: 0;"><i class="fas fa-thumbs-up" aria-hidden="false"></i>&nbsp&nbsp${RevBoard.rev_good }</button>
				<button id="hatebtn" class="btn btn_b03" style="border: 0;outline: 0;"><i class="fas fa-thumbs-down" aria-hidden="false"></i>&nbsp&nbsp${RevBoard.rev_hate }</button>
			</c:if>
			<c:if test="${authUser == null }">
				<a id="login_add" class="btn btn_b03" style="border: 0;outline: 0;"><i class="fas fa-thumbs-up" aria-hidden="false"></i></a>
				<a id="login_add2" class="btn btn_b03" style="border: 0;outline: 0;"><i class="fas fa-thumbs-down" aria-hidden="false"></i></a>
			</c:if>
		</div>
		<a id="btn_add" href="${listLink }">목록으로</a> 
		<c:if test="${ sessionScope.authUser.user_id eq RevBoard.rev_writer || authUser.user_grade == 0}">
			<a id="btn_add" style="margin-right: 3px;" href="${modifyLink }" >수정</a> 
		</c:if>
		<c:if test="${authUser != null }">
			<a class="new-reply-button" id="new-reply-button">댓글 작성</a>
		</c:if>
		<c:if test="${authUser == null }">
			<a class="new-reply-button" id="new-reply-button1">댓글 작성</a>
		</c:if>
		<!-- 댓글 리스트 -->
		<div class="recommView" id="reply_list"></div><br><br>
	
	</section>

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

				</div>
				
			</div>
		</div>
	</div>

<u:footer/>
</body>
</html>