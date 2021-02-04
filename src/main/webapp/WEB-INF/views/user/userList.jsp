<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
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
	
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
	
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
    margin: 50px auto 0px;
    padding: 0 0 50px 0;
    width: 1200px;
    z-index: 1;
}
.membersearchbox {
    clear: both;
    width: 1200px;
    margin: 50px auto 30px;
    background: #f2f5fa;
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
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
}
.membersearchbox #btn_reload {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #747474;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
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
    margin-bottom : 3px;
    line-height: 45px;
    float: left;
    width:110px;
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

</style>
<body>
<u:navbar/>
<div class="container">
<section id="container">
	<div class="membersearchbox">
		<form id="searchForm" action="${root }/user/userList" method="get" >
			<div class="pagenation-container d-flex justify-content-center">
				<select name="type" required class="form-control" id="searchType">
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
				<input type="text" required name="keyword" value="${cri.keyword }" id="searchKeyword" class="form-control"  placeholder="Search" aria-label="Search"/>&nbsp;
				<input type="hidden" name="pageNum" value="1"/>
				<input type="hidden" name="amount" value="${cri.amount }"/>
				<input type="submit" value="검색" id="btn_search">&nbsp;
				<input type="button" value="초기화" id="btn_reload" onclick="reload()">	
			</div>
		</form>
	<!--
		<form action="" method="get">
			<div class="pagenation-container d-flex justify-content-center">
				<select name="searchKeyword" class="form-control" id="searchKeyword">
					<option value="">검색조건</option>
					<option value="name">이름</option>
					<option value="memberid">아이디</option>
					<option value="gender" id="genderSelect">성별</option>
					<option value="phone">연락처</option>
				</select>&nbsp; 
				<input type="text" name="searchField" id="searchField" placeholder="search" class="form-control" value="">&nbsp;
				<input type="submit" value="검색" id="btn_search">&nbsp;
				<input type="button" value="초기화" id="btn_reload" onclick="reload()" class="btn-sm btn-primary">	
			</div>
		</form> -->
	</div>
<form action="${root }/user/userCheckDel" id="userCheckDel" method="post">
<button type="submit" id="btn_CheckDel"/>선택 삭제</button>
<table class="table table-hover">
	<thead>
		<tr>
			<th><input type="checkbox" id="allCheck"  value="${user.user_seq }"/></th>
			<th>번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>휴대폰</th>
			<th>성별</th>
			<th>가입일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="user">
			<c:url value="/user/userRead" var="readLink">
				<c:if test="${cri.type != null && cri.keyword != null }">
					<c:param name="type" value="${cri.type }"></c:param>
					<c:param name="keyword" value="${cri.keyword }"></c:param>
				</c:if>	
				<c:param name="seq" value="${user.user_seq }"></c:param>
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
				<td><c:out value="${user.user_phone}"></c:out></td>
				<td><c:out value="${user.user_gender}"></c:out></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${user.user_regdate }"/></td>
			</tr>
		</c:forEach>
	</tbody>
</table>	
</form>

<div class="pagenation-container d-flex justify-content-center">
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
<!-- 		 	</form>  -->
		</nav>
</div>
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
</body>
</html>