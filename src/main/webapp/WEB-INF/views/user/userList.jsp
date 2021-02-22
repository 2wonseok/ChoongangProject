<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script>
/* 	var lists = new Array();
	// 스크립트로 el 사용 방법 
	<c:forEach items="${list}" var="item">
		lists.push("${item.user_phone}");
		
	</c:forEach>
	
	for (var i = 0; i < lists.length; i++) {
		var newPhone = lists[i];
		
		var updatePhone = newPhone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		
		alert(updatePhone);
		var phoneTD = $("#phoneNum").empty();
		
		var tdPhone = '<p>'+updatePhone+'</p>';
		
		//$('#phoneNum').text(updatePhone);
		phoneTD.append(tdPhone);
		
		// 문자열 사이에 특수문자 추가
		var efgh = abcd.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	}
 */
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<script>
$(document).ready(function(){
	
	var message = '${message}';
	
	checkModal(message);
	
	history.replaceState({}, null, null);
	
	function checkModal(message) {
		if (message && history.state == null) {
			$("#myModal .modal-body p").html(message);
			$("#myModal").modal("show");
		}
	}
	
	// 전체 선택 스크립트
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
	
	// 선택 삭제 코드
	$("#btn_CheckDel").click(function(e) {
		e.preventDefault();
		var checkVal = $("input:checkbox[name='seq']:checked").val();
		
		if (!checkVal) {
			alert('체크 박스를 선택해주세요');
			return false;
		} 
		
		var result = confirm("정말 삭제하시겠습니까?");
		
		if (result) {
			$("#userCheckDel").attr("action", "${root }/user/userCheckDel");
			$("#userCheckDel").submit();
		} else {
			return false;
		}
		
	});
	
	// 문자 전송
	$("#btn_smsSubmit").click(function(e) {
		e.preventDefault();
		
		var form = document.userCheckDel;
		var checkValue = $("input:checkbox[name='seq']:checked").val();
		
		if (!checkValue) {
			alert('체크 박스를 선택해주세요');
			return false;
		} 
			form.method = "get";
			$("#userCheckDel").attr("action", "${root }/user/smsSubmit");
			$("#userCheckDel").submit();
	});
	
});

function reload() {
	window.location = window.location.pathname;
}
</script>
<title>Insert title here</title>
</head>
<style>
#container {
    clear: both;
    position: relative;
    margin: 35px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
}
.membersearchbox {
    clear: both;
    width: 1200px;
    margin: 50px auto 30px;
    /* background: #f2f5fa; */
    background: #f8f8f8;
    padding: 10px 30px;
    border: 1px solid #e7e9ee;
    text-align: center;
    color: #666666;
    font-size: 15px;
}
#searchType {
    width: 160px;
}
#searchKeyword {
    width: 350px;
}

.membersearchbox #btn_search {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 40px;
    margin: 0 0px;
    line-height: 45px;
    border-radius: 3px;
}
.membersearchbox #btn_reload {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #747474;
    padding: 0px 42px;
    margin: 0 0px;
    line-height: 45px;
    border-radius: 3px;
}
.page-item:last-child .page-link {
    border-top-right-radius: .25rem;
    border-bottom-right-radius: .25rem;
}
.page-item:first-child .page-link {
    margin-left: 0;
    border-top-left-radius: .25rem;
    border-bottom-left-radius: .25rem;
}
.page-link {
    position: relative;
    display: block;
    padding: .5rem .75rem;
    margin-left: -1px;
    line-height: 1.25;
    color: #007bff;
    background-color: #fff;
    border: 1px solid #dee2e6;
}
#btn_CheckDel {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 10px;
    margin: 0 0px;
    margin-bottom : 5px;
    line-height: 45px;
    float: left;
    width:110px;
    border-radius: 3px;
}
#btn_smsSubmit {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #747474;
    padding: 0px 10px;
    margin: 0 0px;
    margin-bottom : 5px;
    line-height: 45px;
    float: left;
    width:110px;
    margin-left: 5px;
    border-radius: 3px;
}
#zip_code_btn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 25px;
    margin: 0 0px;
    margin-top: -41px;
    line-height: 45px;
    float: right;
}
#idCheck {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 25px;
    margin: 0 0px;
    margin-top: -41px;
    line-height: 45px;
    float: right;
}
/* 페이지 네이션 css */
.pagerWrap {
    position: relative;
    text-align: center;
    margin: 0px 0;
}
.pagerWrap a {
    width: 34px;
    height: 34px;
    color: #333;
    border: 1px solid #dedede;
    text-align: center;
    line-height: 34px;
    background: #fff;
    display: inline-block;
}
.pagerWrap a.on {
    border-color: #222222;
    background: #4a4a4a;
    color: #fff;
}
.pagerWrap a:hover {
    border-color: #4a4a4a;
    color: #4a4a4a;
}
.pagerWrap a.on:hover {
    border-color: #4a4a4a;
    color: #fff;
}
</style>
<body>
<u:mainNav/>
<c:choose>
	<c:when test="${authUser.user_grade == 0}">
		<div class="container">
		<section id="container">
		<form action="${root }/user/userCheckDel" id="userCheckDel" name="userCheckDel" method="post">
			<button type="submit" id="btn_CheckDel"/>선택 삭제</button>
			<button type="submit" id="btn_smsSubmit"/>문자 전송</button>
		<table class="table table-hover">
			<thead style="background: #f8f8f8;">
				<tr>
					<th><input type="checkbox" id="allCheck"  value="${user.user_seq }"/></th>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>휴대폰</th>
					<th>등급</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody id="userList">
				<c:forEach items="${list }" var="user">
					<c:url value="/user/userRead" var="readLink">
						<c:if test="${cri.type != null && cri.keyword != null }">
							<c:param name="type" value="${cri.type }"></c:param>
							<c:param name="keyword" value="${cri.keyword }"></c:param>
						</c:if>	
						<c:param name="user_id" value="${user.user_id }"></c:param>
						<c:param name="pageNum" value="${cri.pageNum }"></c:param>
						<c:param name="amount" value="${cri.amount }"></c:param>
					</c:url>
					<tr>
						<td><input type="checkbox" id="seq" name="seq" value="${user.user_seq }" /></td>
						<td>${user.user_seq }</td>
						<td>
							<a href="${readLink }" style="color: #000; font-weight: 600; font-size: 18px; line-height: 20px;">
								<c:out value="${user.user_id }"></c:out>
							</a>
						</td>
						<td><c:out value="${user.user_name}"></c:out></td>
						<c:set var="phone" value="${user.user_phone }" />
						<td>${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}</td>
						<td>
							<c:choose>
								<c:when test="${user.user_grade == 0}">
									관리자
								</c:when>
								<c:otherwise>
									Lv.${user.user_grade}
								</c:otherwise>
							</c:choose>
						</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${user.user_regdate }"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</form>
		<div class="membersearchbox">
			<form id="searchForm" action="${root }/user/userList" method="get" >
				<div class="pagenation-container d-flex justify-content-center">
					<select name="type" required style="margin-top: 4px;" class="form-control" id="searchType">
						<option value=""
							<c:out value="${cri.type == null ? 'selected' : '' }"/>>==선택==</option>
						<option value="N"
							<c:out value="${cri.type eq 'N' ? 'selected' : '' }"/>>이름</option>
						<option value="I"
							<c:out value="${cri.type eq 'I' ? 'selected' : '' }"/>>아이디</option>
						<option value="G"
							<c:out value="${cri.type eq 'G' ? 'selected' : '' }"/>>성별</option>
						<option value="P"
							<c:out value="${cri.type eq 'P' ? 'selected' : '' }"/>>휴대폰</option>
						<option value="NI"
							<c:out value="${cri.type eq 'NI' ? 'selected' : '' }"/>>이름 or 아이디</option>
					</select>&nbsp;
					<input type="text" required name="keyword" value="${cri.keyword }" style="margin-top: 4px;" id="searchKeyword" class="form-control"  placeholder="Search" aria-label="Search"/>&nbsp;
					<input type="hidden" name="pageNum" value="1"/>
					<input type="hidden" name="amount" value="${cri.amount }"/>
					<input type="submit" value="검색" id="btn_search">&nbsp;
					<input type="button" value="초기화" id="btn_reload" onclick="reload()">	
				</div>
			</form>
		</div>
			<!--페이징 -->
			<div class="container d-flex justify-content-center">
				<div class="pagerWrap">
						<c:if test="${pageMaker.prev}">
							<c:url value="/user/userList" var="preLink">
								<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
									<c:param name="type" value="${pageMaker.cri.type }"></c:param>
									<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
								</c:if>
								<c:param name="pageNum" value="${pageMaker.startPage - 1 }"></c:param>
								<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
							</c:url>
								<a href="${preLink}">Previous</a>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<c:url value="/user/userList" var="pageLink">
								<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
									<c:param name="type" value="${param.type }"></c:param>
									<c:param name="keyword" value="${param.keyword }"></c:param>
								</c:if>	
								<c:param name="pageNum" value="${num }"></c:param>
								<c:param name="amount" value="${pageMaker.cri.amount }"></c:param>
							</c:url>
								<a class="${pageMaker.cri.pageNum == num ? 'on' : ''}" href="${pageLink}">${num }</a>
						</c:forEach>
						
						<c:if test="${pageMaker.next }">
							<c:url value="/user/userList" var="nextLink">
								<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
									<c:param name="type" value="${pageMaker.cri.type }"></c:param>
									<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
								</c:if>
								<c:param name="pageNum" value="${pageMaker.endPage + 1 }"></c:param>
								<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
							</c:url>
							<a href="${nextLink }">Next</a>
						</c:if>
				</div>
			</div>
		<%-- <div class="pagenation-container d-flex justify-content-center">
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<c:url value="/user/userList" var="preLink">
								<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
									<c:param name="type" value="${pageMaker.cri.type }"></c:param>
									<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
								</c:if>
								<c:param name="pageNum" value="${pageMaker.startPage - 1 }"></c:param>
								<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
							</c:url>
							<li class="page-item"><a class="page-link" href="${preLink}">Previous</a></li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<c:url value="/user/userList" var="pageLink">
								<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
									<c:param name="type" value="${param.type }"></c:param>
									<c:param name="keyword" value="${param.keyword }"></c:param>
								</c:if>	
								<c:param name="pageNum" value="${num }"></c:param>
								<c:param name="amount" value="${pageMaker.cri.amount }"></c:param>
							</c:url>
							<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="${pageLink}">${num }</a></li>
						</c:forEach>
						
						<c:if test="${pageMaker.next }">
							<c:url value="/user/userList" var="nextLink">
								<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
									<c:param name="type" value="${pageMaker.cri.type }"></c:param>
									<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
								</c:if>
								<c:param name="pageNum" value="${pageMaker.endPage + 1 }"></c:param>
								<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
							</c:url>
							<li class="page-item"><a class="page-link" href="${nextLink }">Next</a></li>
						</c:if>
					</ul>
				</nav>
		</div> --%>
		</section>
		</div>
		<div class="modal" id="myModal" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">알림</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <p>크크크크크크</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
		
	</c:when>
	<c:otherwise>
		<script>
			alert('관리자만 접근 가능합니다.');
			location.href='${root}/main/mainPage';
		</script>
	</c:otherwise>
</c:choose>
<u:footer/>
</body>
</html>