<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
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
#goodbtn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}
#hatebtn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
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
}
</style>
<script>
	var appRoot = '${root}'; // 자바스크립트 코드에서 contextPath를 쓰기위해 선언.
	var rev_seq = ${RevBoard.rev_seq}; 
	var authUser = '${authUser.user_id}';
	var user_seq = '${authUser.user_seq}';
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

<script src="${root }/resources/rev_js/rev.js"></script>
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
				
				var replyUL = $("#reply-ul")
				replyUL.empty(); // append로 계속 있어도 리스트를 넣어주니까 한번비워주는 코드
				for (var i = 0; i < list.length; i++) {
					var replyLI = '<li class="media" data-reply_seq="'
						+ list[i].reply_seq + '"><div class="media-body"><h5>'
						+ list[i].reply_writer + '<small class= "float-right">'
						+ dateString(list[i].reply_regdate) + "</small></h5>"
						+ list[i].reply_content + "<hr></div></li>";
						
						console.log('******' + list[i].reply_seq);
						
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


$("#reply-ul").on("click", "li",  function() { // on메소드를 이용해서 reply-ul 안에있는 <li> 를 눌렀을때
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
		      success: function(data){		    	  
		          alert(data);
		          if (data == 0) {
		        	  alert("좋아요를 누르셨습니다!"); 
		          }
		      }, error:function(error){
		    	  alert("좋아요를 이미 누르셨습니다!");
			     }
		       
		  });
		});		
	}); 

	 $(document).ready(function() {
			
			$('#hatebtn').click(function(){
				   
				  $.ajax({
					  method: "get",
				      url: "/rev/hate",
				      dataType: "json",
				      data: {rev_seq: rev_seq, user_seq: user_seq}, 
				      success: function(data){	
				    	  alert(rev_seq);
				    	  alert(user_seq);
				          if (data == 0) {
				        	  alert("싫어요를 누르셨습니다");
				          }
				      },
				      error:function(error){
				    	  alert("이미 싫어요를 누르셨습니다.");
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

	<div class="container-sm">
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
		<c:if test="${authUser != null }">
		<a id="hatebtn" class="btn btn-secondary"  href="">싫어요!</a>
		<a id="goodbtn" class="btn btn-secondary"  href="">좋아요!</a>
		</c:if>
		<c:if test="${authUser == null }">
		<a id="login_add" class="btn btn-secondary">좋아요,싫어요</a>
		</c:if>
		<c:if test="${ sessionScope.authUser.user_id eq RevBoard.rev_writer}">
		<a id="btn_add" class="btn btn-secondary"  href="${modifyLink }">글수정</a>
		</c:if>
		<a id="btn_add" class="btn btn-secondary"  href="${listLink }">목록으로</a>
	</div>
	<div class="container-sm mt-3">
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
	</div>
	
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