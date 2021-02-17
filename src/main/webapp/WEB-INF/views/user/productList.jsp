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
<script type="text/javascript">
$(document).ready(function() {
	
	$("#payComplateTable").hide();
	
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});	
	
	function dateString(date) {
		var d = new Date(date);
		return d.toISOString().split("T")[0];
	}
	
	function showList() {
		
		var productList = $("#productList").empty();
		
		$.ajax({
			type: "GET",
			url: "${root}/user/productList2",
			dataType: "JSON",
			success : function(res) {
				console.log(res);
				
				for (var i = 0; i < res.length; i++) {
					
					var product_seq = res[i].product_seq;
					var product_name = res[i].product_name;
					var product_price = res[i].product_price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
					var product_regdate = res[i].product_regdate;
					var product_filename = res[i].product_filename;
					
					var productTbody = '<tr>'
													  +'<td><input type="checkbox" id="product_seq" name="product_seq" value="" /></td>'
													  +'<td><img alt="상품사진" src="${root }/resources/upload/'+product_filename+'">'
													  +'<a style= "color: #000;" href="${root}/product/get?product_seq='+product_seq+'">&nbsp;'+product_name+'</a></td>'
													  +'<td><p>'+product_price+'원</p></td>'
													  +'<td><p>'+dateString(product_regdate)+'</p></td>';
					
					productList.append(productTbody);
				}
				
			}
		});
		
	}
	
	$("#payComplateList").click(function() {
		$("#productTable").hide();
		$("#payComplateTable").show();
		
	});
	
	$("#defaultList").click(function() {
		$("#productTable").show();
		$("#payComplateTable").hide();
		
	});
	
	showList();
});
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
.table img {
	width: 100px;
	height: 100px;
}
.tablep p {
	display:table-cell
}
p {
	vertical-align: middle;
	padding-top: 30px;
} 

</style>
<body>
<u:mainNav/>
	<c:choose>
	<c:when test="${authUser != null }">
	<div class="container">
		<section id ="container">
		<h3><a style= "color: #000;" href="#" id="defaultList">판매 목록</a> / <a style= "color: #000;" href="#" id="payComplateList">결제완료 상품</a></h3><br>
			<table class="table table-hover" id="productTable">
				<thead>
					<tr>
						<th><input type="checkbox" id="allCheck"  value=""/>&nbsp; 전체선택</th>
						<th>상품명</th>
						<th>상품금액</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody id="productList">
				
				</tbody>
			</table>
			<table class="table table-hover" id="payComplateTable">
				<thead>
					<tr>
						<th><input type="checkbox" id="allCheck"  value=""/>&nbsp; 전체선택</th>
						<th>상품명</th>
						<th>상품금액</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody id="complateList">
				
				</tbody>
			</table>	
		</section>
	</div>
	</c:when>
	<c:otherwise>
		<script>
			alert('로그인 사용자만 이용 가능합니다.');
			location.href="${root}/main/mainPage";
		</script>
	</c:otherwise>
</c:choose>	
<u:footer/>
</body>
</html>