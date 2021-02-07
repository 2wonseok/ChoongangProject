<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
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

<script>
	$(document).ready(function(){
		
		/*모달창함수설정(+redirect시 넘어온 메세지도 출력)  */
		var message = '${message}';
		checkModal(message);
		history.replaceState({}, null, null);
		function checkModal(message){
			if (message && history.state == null) {
				$("#myModal .modal-body p").html(message)
				$("#myModal").modal("show");
			}
		}
		
		/*모달창-전송누르기전에 항목이 비어있으면 안넘어감  */
		$("#btn_submit").click(function(e){
			e.preventDefault(); // 전송버튼 막기
			
				/*비어있으면 메세지넣고모달창호출  */
				if ($("#product_name").val() == ""){
					message = "상품이름 항목이 비어있음";
				} else
				if ($("#product_price").val() == ""){
					message = "상품가격 항목이 비어있음";
				} else
				if ($("#product_quantity").val() == ""){
					message = "상품수량 항목이 비어있음";
				} else
				if ($("#product_info").val() == ""){
					message = "상품정보 항목이 비어있음";
				} else {
					message = null; //다 차있으면 message가 null임
				}
				checkModal(message);
				
			if(message == null){
				$("#form_id").submit(); //message가 다 차있으면 전송
			}
			
		})
		
		
	});
</script>

<style>

	.btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
}

table.type05 {
  border-collapse: separate;
  border-spacing: 1px;
  text-align: left;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  margin: 20px 10px;
}
table.type05 th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
  background: #efefef;
}
table.type05 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}


</style>

<title>Insert title here</title>
</head>
<body>

	<u:navbar></u:navbar>

	<div class="container">
		<div class="row d-flex justify-content-center">
			<hr>
		
			<div class="col-md-6, col-md-offset-3">
				<div class="row">
					
					<form id="form_id" action="/product/register" method="post" enctype="multipart/form-data">
						<table class="type05">
							<tbody>
								<tr>
									<td>상품 등록</td>
								</tr>
								<tr>
									<th scope="row">상품 이름</th>
									<td><input id="product_name" name="product_name" type="text" value="${product.product_name }"></td>
								</tr>
								<tr>
									<th scope="row">상품 단위 가격</th>
									<td><input id="product_price" name="product_price" type="number" value="${product.product_price }"></td>
								</tr>
								<tr>
									<th scope="row">상품 수량</th>
									<td><input id="product_quantity" name="product_quantity" type="number" value="${product.product_quantity }"></td>
								</tr>
								<tr>
									<th scope="row">상품 판매자id</th><!--value=authUser로 넣을 예정  -->
									<td><input id="product_seller" name="product_seller" type="text" value=${authUser.user_id } style="background-color:silver;"readonly></td>
								</tr>
								<tr>
									<th scope="row">상품 카테고리 번호(카테고리테이블에서 가져와서 넣어질 예정)</th>
									<td> <input name="category_seq" type="number" value="${product.category_seq }"></td>
								</tr>
								<tr>
									<th scope="row">상품 설명</th>
									<td><textarea id="product_info" name="product_info" rows="10" cols="23">${product.product_info }</textarea></td>
								</tr>
							</tbody>
						</table>	
						
						<!--파일여러개올리는것 -->
						<c:forEach begin="1" end="3" var="number">
							<div class = "inputArea">
								 <label><input type="file" name="upload" class="productImg${number }"/></label>
							</div>						
							<div class="select_img${number }"><img src="" /></div>
						
							<script>
							  $(".productImg${number}").change(function(){
								   if(this.files /* && this.files[0] */) {
								    	var reader = new FileReader;
								    	reader.onload = function(data) {
								     					$(".select_img${number} img").attr("src", data.target.result).width(500);        
								    					}
								   		reader.readAsDataURL(this.files[0]);
								   }
								  });
						 	</script>
						</c:forEach>
						<!--파일여러개올리는거 시도중끝 -->
						
						<button id="btn_submit" class="btn_add">상품 등록하기</button>
					</form>
				</div>
				
			</div>
			
			<hr>
		</div>
	</div>
	
	
	<!--모달창시작-->
	<div id="myModal" class="modal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">알림</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <p>처리가완료되었습니다</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!--모달창끝-->
	

</body>
</html>