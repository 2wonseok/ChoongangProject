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
<script>
	$(document).ready(function() {
		
		function dateString(date) {
			var d = new Date(date);
			return d.toISOString().split("T")[0];
		}
		
		$("#btn_manager").click(function(e) {
			e.preventDefault();
			
			if($('#user_grade').is(":checked") == false){
			  alert('체크 박스를 선택해주세요');
			  return false;
			}
			
			$("#gradeUpdateFrom").attr("action", "${root }/user/gradeUpdate");
			$("#gradeUpdateFrom").submit();
			
		});
		
	});	

</script>
<title>read Page</title>
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
.tableBWrite {
    clear: both;
    display: table;
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border-top: 3px solid #4a4a4a;
    margin-bottom: 20px;
}
.tableBWrite tbody th {
    background: #f5f5f5;
    position: relative;
    padding: 15px 25px;
    font-size: 17px;
    text-align: left;
    color: #222222;
    border-bottom: 1px solid #dedede;
    width: 140px;
    font-weight: normal;
}
.tableBWrite tbody td {
    border-bottom: 1px solid #dedede;
    color: #555555;
    font-size: 14px;
    padding: 17px;
    position: relative;
    vertical-align: top;
    line-height: 25px;
}

.tableOrder {
    clear: both;
    display: table;
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border-top: 3px solid #4a4a4a;
    margin-bottom: 20px;
}
.tableOrder tbody th {
    background: #f5f5f5;
    position: relative;
    padding: 15px 25px;
    font-size: 17px;
    text-align: left;
    color: #222222;
    border-bottom: 1px solid #dedede;
    width: 140px;
    font-weight: normal;
}
.tableOrder tbody td {
    border-bottom: 1px solid #dedede;
    color: #555555;
    font-size: 14px;
    padding: 17px;
    position: relative;
    vertical-align: top;
    line-height: 25px;
}

#btn_remove {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #747474;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
}
#btn_list {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
}
#btn_manager {
    color: #fff;
    font-size: 13px;
    border: none;
    background: #1e263c;
    padding: 0px 20px;
    line-height: 45px;
    margin-top: -5px;
    margin-right: -17px;
}
#userInfo, #userOrderList {
	color: #000; 
	font-weight: 540; 
	font-size: 28px; 
	line-height: 20px;
}
</style>
<body>
<u:mainNav/>
<c:choose>
	<c:when test="${authUser.user_grade == 0 || authUser.user_id eq read.user_id && authUser.user_id != null}">
		<div class="container">
			<section id="container">
				<h3>회원 정보 보기</h3>
				<table class="tableBWrite">
					<tbody>
						<tr>
							<th style="width:300px;">아이디</th>
							<td>${read.user_id }</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>${read.user_name }</td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td>${read.user_nickname }</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${read.user_address }</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>${read.user_phone }</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td>${read.user_birth }</td>
						</tr>
						<tr>
							<th>회원등급</th>
							<td>
								<div class="d-flex justify-content-between" style="margin-top: 12px;">
								<c:choose>
									<c:when test="${read.user_grade == 0}">
					 					<div class="d-flex">관리자</div>
									</c:when>
									<c:otherwise>
										<div class="d-flex">Lv.${read.user_grade }</div>
									</c:otherwise>
								</c:choose>
				 					<form action="${root }/user/gradeUpdate" id="gradeUpdateFrom" method="post">	
										<div class="d-flex">
											<input type="hidden" name="user_seq" value="${read.user_seq }">		
											<input type="hidden" name="user_id" value="${read.user_id }">		
											<input type="hidden" name="pageNum" value="${cri.pageNum }">		
											<input type="hidden" name="amount" value="${cri.amount }">		
											<input type="hidden" name="type" value="${cri.type }">		
											<input type="hidden" name="keyword" value="${cri.keyword }">
											<c:if test="${authUser.user_grade == 0 }">
												<c:choose>
													<c:when test="${read.user_grade == 0}">
														<small class="form-text text-default">일반</small>
														<input type="checkbox" class="form-control" style="width:30px; height:20px; margin-top:5px;" id="user_grade" name="user_grade" value="1"/>
													</c:when>
													<c:otherwise>
														<small class="form-text text-default">관리자</small>
														<input type="checkbox" class="form-control" style="width:30px; height:20px; margin-top:5px;" id="user_grade" name="user_grade" value="0"/>
													</c:otherwise>
												</c:choose>
												<input type="submit" onclick="if(!confirm('변경하시겠습니까?')){return false;}" value="적용" id="btn_manager">
											</c:if>
										</div>
									</form>
								</div>
							</td>
						</tr>
						<tr>
							<th>포인트</th>
							<td><fmt:formatNumber value="${read.user_point }" type="number"></fmt:formatNumber> 포인트</td>
						</tr>	
						<tr>
							<th>가입일</th>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${read.user_regdate }"/></td>
						</tr>		
					</tbody>
				</table>
				
				<div style="float:right;">
					<c:url value="/user/userModify" var="modLink">
						<c:if test="${cri.type != null && cri.keyword != null }">
							<c:param name="type" value="${cri.type }"></c:param>
							<c:param name="keyword" value="${cri.keyword }"></c:param>
						</c:if>	
						<c:param name="user_id" value="${read.user_id }"></c:param>
						<c:param name="pageNum" value="${cri.pageNum }"></c:param>
						<c:param name="amount" value="${cri.amount }"></c:param>
					</c:url>
					
					<c:url value="/user/userList" var="listLink">
						<c:if test="${cri.type != null && cri.keyword != null }">
							<c:param name="type" value="${cri.type }"></c:param>
							<c:param name="keyword" value="${cri.keyword }"></c:param>
						</c:if>	
						<c:param name="pageNum" value="${cri.pageNum }"></c:param>
						<c:param name="amount" value="${cri.amount }"></c:param>
					</c:url>
						
					<c:choose>
						<c:when test="${authUser.user_grade == 0 }">
							<input type="button" value="목록" onclick="location.href='${listLink}'" id="btn_remove">
						</c:when>
						<c:otherwise>
							<input type="button" value="돌아가기" onclick="location.href='${root}/main/index'" id="btn_remove">
						</c:otherwise>
					</c:choose>
					<c:if test="${authUser.user_id eq read.user_id }">
						<input type="button" value="수정" onclick="location.href='${modLink}'" id="btn_list">
						<input type="button" value="탈퇴" onclick="location.href='${root}/user/userRemove'" id="btn_remove">
					</c:if>
				</div>
			</section>	
		</div>

	</c:when>
	<c:otherwise>
		<script>
			alert('본인만 접근 가능합니다.');
			location.href='${root}/main/index';
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>