<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u"  tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
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

<title>임시 메인 페이지</title>
</head>
<body>
<u:navbar/>
접속 아이디 : ${authUser.user_id} <br>
등급 : <c:choose>
					<c:when test="${authUser.user_grade < 1}">관리자</c:when>
					<c:when test="${authUser.user_grade > 0}">일반</c:when>
					<c:otherwise></c:otherwise>
			</c:choose>
<!--     채팅창 -->
<div id="_chatbox" style="display: none">
	<fieldset>
		<div id="messageWindow"></div>
		<br /> <input id="inputMessage" type="text" onkeyup="enterkey()" />
		<input type="submit" value="send" onclick="send()" />
	</fieldset>
</div>
<img class="chat" src="/resources/chat.png" /> 
</body>
</html>


<!-- 말풍선아이콘 클릭시 채팅창 열고 닫기 -->
<script>
	$(".chat").on({
		"click" : function() {
			if ($(this).attr("src") == "/resources/chat.png") {
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
	var webSocket = new WebSocket('ws://172.30.1.47:8080/broadcasting');
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
			if (content.match("/")) {
				if (content.match(("/" + $("#chat_id").val()))) {
					var temp = content.replace("/" + $("#chat_id").val(),
							"(귓속말) :").split(":");
					if (temp[1].trim() == "") {
					} else {
						$("#messageWindow").html(
								$("#messageWindow").html()
										+ "<p class='whisper'>"
										+ sender
										+ content.replace("/"
												+ $("#chat_id").val(),
												"(귓속말) :") + "</p>");
					}
				} else {
				}
			} else {
				if (content.match("!")) {
					$("#messageWindow")
							.html(
									$("#messageWindow").html()
											+ "<p class='chat_content'><b class='impress'>"
											+ sender + " : " + content
											+ "</b></p>");
				} else {
					$("#messageWindow").html(
							$("#messageWindow").html()
									+ "<p class='chat_content'>" + sender
									+ " : " + content + "</p>");
				}
			}
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
			$("#messageWindow").html(
					$("#messageWindow").html() + "<p class='chat_content'>나 : "
							+ inputMessage.value + "</p>");
		}
		webSocket.send($("#chat_id").val() + "|" + inputMessage.value);
		inputMessage.value = "";
	}
	//     엔터키를 통해 send함
	function enterkey() {
		if (window.event.keyCode == 13) {
			send();
		}
	}
	//     채팅이 많아져 스크롤바가 넘어가더라도 자동적으로 스크롤바가 내려가게함
	window.setInterval(function() {
		var elem = document.getElementById('messageWindow');
		elem.scrollTop = elem.scrollHeight;
	}, 0);
</script>