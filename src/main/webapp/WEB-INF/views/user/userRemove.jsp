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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<title>회원 탈퇴</title>
</head>
<style>
#container {
    clear: both;
    position: relative;
    margin: 50px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
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
#btn_remove {
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
<body>
<u:mainNav/>
<c:choose>
	<c:when test="${authUser.user_id != null}">
	<div class="container">
		<section id="container">
		<h3>회원 탈퇴</h3>
			<form action="${root }/user/userRemove" method="post">
				<input type="hidden" name="user_id" value="${authUser.user_id }">
			 	<table class="tableBWrite">
					<tbody>
						<tr>
							<th style="width:300px;">현재 비밀번호</th>
							<td>
								<input type="password" id="user_password" name="user_password" class="form-control">
								<c:if test="${errorPw != null }">
									<small class="text-danger" id="nickCheckFail">${errorPw }</small>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
				<input type="submit" id="btn_remove" onclick="if(!confirm('탈퇴하시겠습니까?')){return false;}" value="탈퇴" >
			</form>
		</section>
	</div>	
</c:when>
<c:otherwise>
	<script>
		alert('본인만 접근 가능합니다.');
		location.href='${root}/main/mainPage';
	</script>
</c:otherwise>
</c:choose>
<u:footer/>
</body>
</html>