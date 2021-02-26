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
<script>
var goPopup = function(){ 
	var pop = window.open("${root}/user/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes");
	} 
	var jusoCallBack = function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo) { 
		document.getElementById("zipNo").value = zipNo; 
		document.getElementById("addr").value = roadAddrPart1 + " " + addrDetail; 
		if(addrDetail.length>30) { 
			alert('상세주소가 너무 길어 다시 입력해야 합니다.'); 
			return; 
		} 
		
		document.getElementById("addrDetail").value = addrDetail; 
	}
	
$(document).ready(function() {
	
	var user_phone = $("#phoneNum").val();
	
	var phone = user_phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		$('#userPhone').text(phone);
	
	$("#remove_btn").click(function(e) {
		e.preventDefault();
		$("#myModal .modal-body p").html("삭제하시겠습니까?");
		$("#myModal").modal("show");
		
		$("#yes").click(function() {
			$("#modify-form").attr("action", "${root}/user/userDelete");
			$("#modify-form").submit();
		});
	});
	
	$("#modify_btn").click(function(e) {
		e.preventDefault();
		$("#myModal .modal-body p").html("수정하시겠습니까?");
		$("#myModal").modal("show");
		
		$("#yes").click(function() {
			$("#modify-form").attr("action", "${root}/user/userModify");
			$("#modify-form").submit();
		});	
	});
	
	$("#alert-success").hide(); 
	$("#alert-danger").hide();
	$("#nickCheckSuccess").hide(); 
	$("#nickCheckFail").hide();
	$("#nickYes").hide();
	
	$("input").keyup(function() { 
		var pwd1=$("#changePw").val(); 
		var pwd2=$("#changeConfirmPw").val(); 
		
		if(pwd1 != "" || pwd2 != "") { 
			if(pwd1 == pwd2) { 
				$("#alert-success").show(); 
				$("#alert-danger").hide(); 
				$("#btn_add").removeAttr("disabled"); 
			} else { 
				$("#alert-success").hide(); 
				$("#alert-danger").show(); 
				$("#btn_add").attr("disabled", "disabled"); 
			} 
		} 
	});
	
	$("#user_nickname").keyup(function() {
		$("#btn_add").attr("disabled", "disabled");
		$("#nickCheck").click(function() {
			var user_nickname = $("#user_nickname").val();
			
			$.ajax({
			    type: "GET",
			    url: "${root}/user/duplicateCheck",
			    dataType : "json",
			    data: {
			        "user_nickname" : user_nickname
			    },
			    success: function(res) {
			    	console.log(res);
	          if(res == 0) {
							$("#nickCheckSuccess").show(); 
							$("#nickCheckFail").hide();
							$("#nickYes").show();
							
							$("#nickYes").click(function() {
								$("#user_nickname").attr("readonly", true);
								$("#nickYes").hide();
								$("#nickCheckSuccess").hide(); 
								$("#btn_add").removeAttr("disabled"); 
							})
	          } else {
							$("#nickCheckSuccess").hide(); 
							$("#nickCheckFail").show(); 
							$("#btn_add").attr("disabled", "disabled"); 
	          }
		        
			    }
			});
		});
	});
});
</script>
<title>회원 정보 수정</title>
</head>
<style>
	.container-fluid h2 {
		text-align: center;
		padding : 64px;
		color: #fff;
		letter-spacing: -6px;
		font-size: 48px;
	}
	#container {
    clear: both;
    position: relative;
    margin: 50px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
	}
	
	#btn_list {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #747474;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
    border-radius: 3px;
	}
#nickYes {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #747474;
    padding: 0px 13px;
    margin: 0 0px;
    line-height: 34px;
    float: right;
    border-radius: 3px;
    margin-right: 515px;
    margin-top: -4px;
}
	#btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin-right: 7px;
    line-height: 45px;
    float: right;
    border-radius: 3px;
	}
	.btn_check {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 25px;
    margin: 0 0px;
    margin-top: -54px;
    line-height: 45px;
    float: right;
    border-radius: 3px;
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
    border-radius: 3px;
}
</style>
<body>
<u:mainNav/>
<c:choose>
	<c:when test="${authUser.user_id eq read.user_id}">
		<div class="container">
			<section id="container">
				<h3>회원 정보 수정</h3>
				<input type="hidden" id="phoneNum" value="${read.user_phone }">
				<form id="modify-form" action="${root}/user/userModify" method="post">
				<input type="hidden" name="pageNum" value=${cri.pageNum }>
				<input type="hidden" name="amount" value=${cri.amount }>
				<c:if test="${cri.type != null && cri.keyword != null }">
					<input type="hidden" name="type" value=${cri.type }>
					<input type="hidden" name="keyword" value=${cri.keyword }>
				</c:if>
				<input type="hidden" name="user_id" value="${read.user_id }" />
					<table class="tableBWrite">
						<tr>
							<th style="width:300px;">아이디</th>
							<td>${read.user_id }</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" name="user_password" class="form-control" required/>
								<c:if test="${notMatch != null }">
									${notMatch }
								</c:if>
							</td>
						</tr>
						<tr>
							<th>변경할 비밀번호</th>
							<td>
								<input type="password" id="changePw" name="changePw" class="form-control" required/>
							</td>
						</tr>
						<tr>
							<th>변경할 비밀번호 확인</th>
							<td>
								<input type="password" id="changeConfirmPw" name="changeConfirmPw" class="form-control" required/>
								<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div> 
				 				<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>${read.user_name }</td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td>
								<input type="text" class="form-control" style="width:83%; margin-bottom:12px;" id="user_nickname" name="user_nickname" value="${read.user_nickname }"/>
								<button type="button" class="btn_check" id="nickCheck">중복확인</button>
						    <small class="text-primary" id="nickCheckSuccess">사용 가능합니다.</small>
						    <button type="button"  id="nickYes" >확인</button>
						    <small class="text-danger" id="nickCheckFail">이미 사용중인 닉네임입니다.</small>
							</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td>${read.user_birth }</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>
								<input type="text" class="form-control" style="width:87%" name="user_address" id="addr" value="${read.user_address }"/>
								<button type="button" id="zip_code_btn" class="zip_code_btn" onclick="javascript:goPopup();">검색</button>
							</td>
						</tr>
						<tr>
							<th>우편번호</th>
							<td>
								<input type="text" class="form-control" name="user_addresscode" id="zipNo" value="${read.user_addresscode }"/>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td id="userPhone"></td>
						</tr>
						<tr>
							<th>등급</th>
							<td>
								<c:choose>
									<c:when test="${read.user_grade == 0}">
										관리자
									</c:when>
									<c:otherwise>
										Lv.${read.user_grade}
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>포인트</th>
							<td><fmt:formatNumber value="${read.user_point }"></fmt:formatNumber></td>
						</tr>
						<tr>
							<th>가입일</th>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${read.user_regdate }"/></td>
						</tr>		
					</table>
				  <input type="button" value="돌아가기" onclick="location.href='${root}/user/userRead?user_id=${authUser.user_id }'" 
							id="btn_list"/> 
					<input type="submit" onclick="if(!confirm('수정하시겠습니까?')){return false;}" value="수정완료" id="btn_add" />
				</form>
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
		        <p>""</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" id="yes" class="btn btn-primary">예</button>
		        <button type="button" id="no" class="btn btn-secondary" data-dismiss="modal">아니요</button>
		      </div>
		    </div>
		  </div>
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