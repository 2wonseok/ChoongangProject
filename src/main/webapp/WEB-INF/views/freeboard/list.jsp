<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<style>
#container {
	clear: both;
	position: relative;
	margin: 50px auto 0px;
	padding: 0 0 50px 0;
	width: 1200px;
	z-index: 1;
}
</style>
<head>


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
<script>
	var userId = "${authUser.user_id}";
	var nickname = "${authUser.user_nickname}";
</script>
<script>
	$(document).ready(
			function() {

				var result = '${result}';
				var message = '${message}';

				//checkModal(result);
				checkModal2(message);

				history.replaceState({}, null, null);

				function checkModal2(message) {
					if (message && history.state == null) {
						$("#myModal .modal-body p").html(message);
						$("#myModal").modal("show");
					}
				}

				function checkModal(result) {
					if (result === '' || history.state) {
						return;
					}

					if (parseInt(result) > 0) {
						$("#myModal .modal-body p").html(
								"게시글 " + result + "번이 등록되었습니다.");
					}
					$("#myModal").modal("show");
				}
			});
</script>
<script>
	$(document).ready(function() {
		$("#register").click(function() {
			if (userId == "") {
				alert("로그인후 이용하세요");
				location.href = "${root}/user/login";
			} else {
				location.href = "${root}/freeboard/register";
			}
		});

	});
</script>

<title>Insert title here</title>

</head>
<body>
	<u:mainNav></u:mainNav>
	<div class="container-sm">
		<div class="container">
			<div class="row">

				<section id="container">
					<table class="table table table-hover">
						<thead>
							<tr>
								<th>#번호</th>
								<th>제목</th>
								<th>닉네임</th>
								<th>작성일</th>
								<th>수정일</th>
								<th>조회수<th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="freeVO">
								<tr>
									<td>
										<c:choose>
											<c:when test="${freeVO.free_notice == 2}">
												공지
											</c:when>
											<c:otherwise>
												${freeVO.free_seq}
											</c:otherwise>
										</c:choose>
									</td>
									<td><c:url value="/freeboard/get" var="freeboardLink">

											<c:param value="${freeVO.free_seq }" name="free_seq" />
											<c:param value="${pageMaker.cri.pageNum }" name="pageNum" />
											<c:param value="${pageMaker.cri.amount }" name="amount" />
											<c:param value="${pageMaker.cri.type }" name="type" />
											<c:param value="${pageMaker.cri.keyword }" name="keyword" />

										</c:url> <a href="${freeboardLink }"> <c:out
												value="${freeVO.free_title}" /> 
												<c:if
												test="${freeVO.free_replyCnt gt 0 }">
												<span class="badge badge-info">${freeVO.free_replyCnt }</span>
												</c:if>
									</a></td>
									<td><c:out value="${freeVO.free_nickname}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd"
											value="${freeVO.free_regdate}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd"
											value="${freeVO.free_updatedate}" /></td>
									<td>${freeVO.free_readCnt}
									<td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</section>
				<button id="register">글쓰기</button>
				
				  <form action="${root }/freeboard/list" id="searchForm" class="form-inline my-2 my-lg-0">
		      <select name="type" class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref">
			    <option value="T" ${pageMaker.cri.type eq 'T' ? 'selected' : '' }>제목</option>
			    <option value="C" ${pageMaker.cri.type eq 'C' ? 'selected' : '' }>내용</option>
			    <option value="W" ${pageMaker.cri.type eq 'W' ? 'selected' : '' }>작성자</option>
			   									 <!--여기서의 작성자는 유저의 닉네임  -->
			    <option value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : '' }>제목 or 내용</option>
			    <option value="TW" ${pageMaker.cri.type eq 'TW' ? 'selected' : '' }>제목 or 작성자</option>
			    <option value="TWC" ${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }>제목 or 내용 or 작성자</option>
			  </select>
		      <input name="keyword" required value="${pageMaker.cri.keyword }" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      <input type="hidden" name="pageNum" value="1" />
		      <input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
		      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
		    </form>
			</div>
		</div>
	</div>
	<div id="myModal" class="modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">알림</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>처리가 완료되었습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<div class="container-sm mt-3">
		<div class="row justify-content-center">
			<nav aria-label="Page navigation example">
				<ul class="pagination">
					<c:if test="${pageMaker.prev }">
						<c:url value="/freeboard/list" var="prevLink">
							<c:param value="${pageMaker.startPage -1 }" name="pageNum" />
							<c:param value="${pageMaker.cri.amount }" name="amount" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
						<li class="page-item"><a class="page-link"
							href="${prevLink }">Previous</a></li>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
						<c:url value="/freeboard/list" var="pageLink">
							<c:param name="pageNum" value="${num }" />
							<c:param name="amount" value="${pageMaker.cri.amount }" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
						<li
							class="page-item ${pageMaker.cri.pageNum eq num ? 'active' : '' }">
							<a class="page-link" href="${pageLink }">${num }</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next }">
						<c:url value="/freeboard/list" var="nextLink">
							<c:param name="pageNum" value="${pageMaker.endPage +1 }" />
							<c:param name="amount" value="${pageMaker.cri.amount }" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
						<li class="page-item"><a class="page-link"
							href="${nextLink }">Next</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
<!-- 채팅창 -->
<c:if test="${authUser != null}">
<div id="_chatbox" style="display: none">
	<fieldset>
		<div id="messageWindow"></div>
		<br /> <input id="inputMessage" type="text" onkeyup="enterkey()" />
		<input type="submit" value="send" onclick="send()" />
	</fieldset>
</div>
<img class="chat" src="/resources/chat.png" />
</c:if>
<script>
	$(".chat").on({
		"click" : function() {
			if ($(this).attr("src") == "/resources/chat.png") {
				//채팅끌때 클릭할 이미지 
				$(".chat").attr("src", "/resources/chathide.png");
				$("#_chatbox").css("display", "block");
			} else if ($(this).attr("src") == "/resources/chathide.png") {
				$(".chat").attr("src", "/resources/chat.png");
				$("#_chatbox").css("display", "none");
			}
		}
	});
</script>
<script type="text/javascript">
	var textarea = document.getElementById("messageWindow");
	//서버 ip주소 입력
	var webSocket = new WebSocket('ws://localhost:8080/broadcasting');
	var inputMessage = document.getElementById('inputMessage');
	webSocket.onerror = function(event) {
		onError(event)
	};
	webSocket.onopen = function(event) {
		onOpen(event)
	};
	webSocket.onmessage = function(event) {
		onMessage(event)
	};
	function onMessage(event) {
		var message = event.data.split("|");
		var sender = message[0];
		var content = message[1];
		if (content == "") {
		} else {
			$("#messageWindow").html($("#messageWindow").html() + "<p class='chat_content'>" + sender + " : " + content + "</p>");
		}
	}
	function onOpen(event) {
		$("#messageWindow").html("<p class='chat_content'>채팅에 참여하였습니다.</p>");
	}
	function onError(event) {
		alert(event.data);
	}
	function send() {
		if (inputMessage.value == "") {
		} else {
			$("#messageWindow").html($("#messageWindow").html() + "<p class='chat_content'>나 : " + inputMessage.value + "</p>");
		}
		webSocket.send(nickname + "(" + userId + ") | " + inputMessage.value);
		inputMessage.value = "";
	}
	// 엔터키를 통해 send함
	function enterkey() {
		if (window.event.keyCode == 13) {
			send();
		}
	}
	// 채팅이 많아져 스크롤바가 넘어가더라도 자동적으로 스크롤바가 내려가게함
	window.setInterval(function() {
		var elem = document.getElementById('messageWindow');
		elem.scrollTop = elem.scrollHeight;
	}, 0);
</script>
</body>
</html>
 