<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<!-- <script src="https://kit.fontawesome.com/a076d05399.js"></script> -->
<script src="${root }/resources/product_js/category.js"></script>

<title>Insert title here</title>

<script>
var appRoot = '${root }';
var productSeq = '${product.product_seq}';
var userSeq = '${authUser.user_seq}';
</script>

<script>
$(document).ready(function(){
	
	function readSubCategory(){
		var categoryMain = $("#categoryMainSelectBox").find("option:selected").val();
		categoryService.getCategorySubList(categoryMain, function(list) {
			var subBox = $("#categorySubSelectBox");
			var categorySub = $("#categorySub").val();
			var selected ='';
			subBox.empty();
			subBox.append(
				'<option>===소분류===</option>'
			);
			for (var i = 0; i < list.length; i++) {
				if (list[i] === categorySub){
					selected='selected';
				} else {
					selected='';
				}
				subBox.append(
					'<option value="'+list[i]+'" '+selected+'>'+list[i]+'</option>'
				);
			}
		})
	};
	
	readSubCategory();
	/* 카테고리 대분류를 선택하면 소분류를 ajax로 넘겨줘서가져옴-js파일사용 */
	$("#categoryMainSelectBox").on( 'change', function(){
		readSubCategory();
		/* var categoryMain = $(this).find("option:selected").val();
		categoryService.getCategorySubList(categoryMain, function(list) {
			var subBox = $("#categorySubSelectBox");
			subBox.empty();
				subBox.append(
					'<option>===소분류===</option>'
				);
			for (var i = 0; i < list.length; i++) {
				subBox.append(
					'<option value="'+list[i]+'" >'+list[i]+'</option>'
				);
			}
		}) */ 
	});
	
	/* 카테고리 소분류를 선택하면 대분류+소분류에 맞는 seq를 가져오고 자동으로넘어감*/
	$("#categorySubSelectBox").on( 'change', function(){
		var categoryMain = $("#categoryMainSelectBox").find("option:selected").val();
		var categorySub = $(this).find("option:selected").val();
		var data = {category_main : categoryMain, category_sub : categorySub};
		categoryService.getCategorySeq(data, function(categorySeq) {
			$("#categorySeq").val(categorySeq);
			$("#categoryMain").val(categoryMain);
			$("#categorySub").val(categorySub);
			$("#formArray").submit();
		})
	});
	
	
	
	/*모달창-메세지넘어왔을때나오게함  */
	var message = '${message}';
	checkModal(message);
	history.replaceState({}, null, null);//뒤로가기로왔을시에없앰?
	function checkModal(message){
		if (message && history.state == null) {
			$("#myModal .modal-body p").html(message)
			$("#myModal").modal("show");
		}
	}
	/* Array버튼 */
	$("#latest_btn").click(function(){
		$("#inputArray").val("latest");
		$("#formArray").submit();
	});
	$("#like_btn").click(function(){
		$("#inputArray").val("like");
		$("#formArray").submit();
	});
	$("#priceLow_btn").click(function(){
		$("#inputArray").val("priceLow");
		$("#formArray").submit();
	});
	$("#priceHign_btn").click(function(){
		$("#inputArray").val("priceHign");
		$("#formArray").submit();
	});
	$("#readcnt_btn").click(function(){
		$("#inputArray").val("readcnt");
		$("#formArray").submit();
	});

});
</script>
		

<style>
#foot {
    background: #f8f8f8;
    border-top: 2px solid #E3E1E1;
    border-bottom: 1px solid #E3E1E1;
    margin-top: 20px;
}
#btn_add_search {
    color: #fff;
    font-size: 15px;
    background: #4a4a4a;
}
	.btn_add {
	    color: #fff;
	    font-size: 15px;
	    border: none;
	    background: #4a4a4a;
	    padding: 0px 30px;
	    margin: 0 0px;
	    line-height: 45px;
	    float: right;
   	 	border-radius: 3px;
    	text-align: center;
    	margin-right: -76px;
	}
	

	.card {
	    width:14.1rem;
	    height:30rem;
	}
	
	.img_box {
	    width: 14.1rem;
	    height:19.0rem;
	    position: relative;
	}
		
	.card img {
	    width: 14.0rem;
	    height:16.0rem;
	}
	.card p{
	    text-overflow:ellipsis;
	    height:40px;
	    line-height:20px;	
	    overflow:hidden;
	    
	}
	
	.cardLine1{
	    text-overflow:ellipsis;
	    height:20px;
	    line-height:20px;	
	    overflow:hidden;
	    
	}
	
	#container {
	    clear: both;
	    position: relative;
	    margin: 35px auto 0px;
	    padding: 0 0 50px 0;
	    width: 1000px;
	    z-index: 1;
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

</head>
<body>
  
<u:mainNav/>
<div class="container">
  <section id="container">
  
  		<div class="row col-10 ml-3">
  			<c:if test="${not empty pageDTO.cri.categoryNum}">
  				<p class="text-left">상품 카테고리 > ${category.category_main } > ${category.category_sub }</p>
  			</c:if>
  		</div>
  		
  		<div class="row col-12 ml-1">
  			
	  		<form id="formArray" action="${root }/product/list">
	          	<input hidden="hidden" name="pageNum" value="${pageDTO.cri.pageNum }"/>
	          	<input hidden="hidden" name="amount" value="${pageDTO.cri.amount }"/>
	          	<input hidden="hidden" name="type" value="${pageDTO.cri.type }"/>
	   			<input hidden="hidden" name="keyword" value="${pageDTO.cri.keyword }"/>            	
	   			<input id="inputArray" hidden="hidden" name="array" value="${pageDTO.cri.array }"/>            	
				<input id="categorySeq" hidden="hidden" name="categoryNum" type="text" value="${pageDTO.cri.categoryNum }" >
	   			<input hidden="hidden" id="categoryMain" name="categoryMain" value="${pageDTO.cri.categoryMain }"/>            	
	   			<input hidden="hidden" id="categorySub" name="categorySub" value="${pageDTO.cri.categorySub }"/>            	
	        </form>
	  			<button id="latest_btn" class="btn" type="button">최신순</button>
	  			<button id="like_btn" class="btn" type="button">찜많은순</button>
	  			<button id="priceLow_btn" class="btn" type="button">가격낮은순</button>
	  			<button id="priceHign_btn" class="btn" type="button">가격높은순</button>
	  			<button id="readcnt_btn" class="btn" type="button">조회순</button>
  			
  			<div class="d-flex" style="margin-left: 184px;"> 
					<select class="custom-select my-1 mr-sm-2" id="categoryMainSelectBox">
						<option>===대분류===</option>
						<c:forEach items="${ categoryMainList}" var="categoryMain" >
							<option value="${categoryMain }" ${pageDTO.cri.categoryMain eq categoryMain ? 'selected' : '' }>${categoryMain }</option>
						</c:forEach>
					</select>
					<select class="custom-select my-1 mr-sm-2" id="categorySubSelectBox">
						<option>===소분류===</option>
					</select>
				</div>
  		</div>
  		
  		
	  <div class="row justify-content-center"> 
		
				<div class="row col-12 d-flex justify-content-center">
					<!--상품 bootstrap card 시작  -->
					<c:forEach items="${list }" var="product">
			
						 <c:url value="/product/get" var="productLink">
			            	<c:param name="product_seq" value="${product.product_seq }"/>
			            	<c:param name="pageNum" value="${pageDTO.cri.pageNum }"/>
			            	<c:param name="amount" value="${pageDTO.cri.amount }"/>
			            	<c:param name="type" value="${pageDTO.cri.type }"/>
				    		<c:param name="keyword" value="${pageDTO.cri.keyword }"/>            	
				    		<c:param name="array" value="${pageDTO.cri.array }"/>
				    		<c:param name="categoryNum" value="${pageDTO.cri.categoryNum }"/>
				    		<c:param name="categoryMain" value="${pageDTO.cri.categoryMain }"/>
							<c:param name="categorySub" value="${pageDTO.cri.categorySub }"/>    
				    		   	
			            </c:url>
			            <c:set var="visibility" value="100%"></c:set>
						<c:if test="${product.product_status == 1 }">
							<c:set var="visibility" value="30%"></c:set>
						</c:if>
		            
					<div class="card m-2">
							<div class="img_box">
								<a href="${productLink }" >
									<img style="opacity : ${visibility}" src="${root }/resources/upload/${product.product_filename }" alt="Card image cap">
								</a>
								<div style="position:absolute;top:45%;left:30%">
									<c:if test="${product.product_status == 1 }">
										<h5>판매 종료</h5>
									</c:if>
								</div>
							</div>
							<div class="card-body" >
								<a href="${productLink }" >
					            <fmt:formatNumber value="${product.product_price }" type="number" var="price"></fmt:formatNumber>
								<h5 class="card-title"><c:out value="${price }"></c:out>원</h5>
								<p><c:out value="${product.product_name }"></c:out></p>
								</a>
								<div>
									<span><i class="fas fa-eye"></i> ${product.product_readcnt }</span>	
									<span><i class="fas fa-heart"></i> ${product.product_like }</span>										
								</div>
					            <fmt:formatNumber value="${product.product_quantity }" type="number" var="quantity"></fmt:formatNumber>
								<div class="cardLine1">총 ${quantity }개 남음</div>
									<hr>
							    <p class="card-text">판매자 : <c:out value="${ product.user_nickname}"></c:out></p>
							</div>
						</div>
					</c:forEach>
				</div>
				<!--상품 bootstrap card 끝  -->			
	 	</div>
		
	 	
	 	<!-- 등록버튼 & 서치바 row -->
	 	<div id="foot" class="row">
		<div class="row col-10 ml-4">
		 	
			<!-- 서치  -->
				<c:url value="${root }/product/list" var="searchLink">
						<c:param name="product_seq" value="${product.product_seq }" />
						<c:param name="pageNum" value="${cri.pageNum }" />
						<c:param name="amount" value="${cri.amount }" />
						<c:param name="type" value="${cri.type }"/>
						<c:param name="keyword" value="${cri.keyword }"/>
						<c:param name="array" value="${cri.array }" />
						<c:param name="categoryNum" value="${cri.categoryNum }"/>
						<c:param name="categoryMain" value="${cri.categoryMain }"/>            	
						<c:param name="categorySub" value="${cri.categorySub }"/>            	
				</c:url>
				
				<form action="${searchLink }" id="searchForm" class="form-inline my-2 my-lg-0 ar">
					<!--카테고리옵션 옵션  -->
					<select class="custom-select my-1 mr-sm-2" name="type" 
						id="inlineFormCustomSelectPref">
						<option value="T" ${pageDTO.cri.type eq 'T' ? 'selected' : '' } >상품명</option>
						<option value="C" ${pageDTO.cri.type eq 'C' ? 'selected' : '' } >상품 설명</option>
						<option value="TC" ${pageDTO.cri.type eq 'TC' ? 'selected' : '' }>상품명 or 설명</option>
						<option value="W" ${pageDTO.cri.type eq 'W' ? 'selected' : '' } >판매자</option>
					</select> 
					<input class="form-control mr-sm-2" type="search" name="keyword" value="${pageDTO.cri.keyword }"
						placeholder="Search" aria-label="Search" required>
						<input type="hidden"  name="pageNum" value="1"/>
						<input type="hidden"  name="amount" value="${pageDTO.cri.amount }"/>
					<button class="btn" id="btn_add_search" type="submit">Search</button>
				</form>
		</div>
			
			<!-- 등록 -->
			<div class="mr-1">
				<c:if test="${not empty authUser.user_id}">
 						<div>
							<button onclick = "location.href = '${root}/product/register'" class="btn_add">상품 등록</button>
						</div>
				</c:if>
			</div>
			
		</div> 
		
		<!-- 페이징용row -->
		<div class="row d-flex justify-content-center" style="margin-top: 20px;">
			<div class="col-md-6, col-md-offset-3">
	
				<!--페이징 시작  -->
					<div class="container d-flex justify-content-center">
						<div class="pagerWrap">
								<!--이전 버튼  -->
								<c:if test="${pageDTO.prev }">
									<c:url value="/product/list" var="prevLink">
										<!--c:url은 contextRoot를 안넣어도 자동으로 만들어진다!  -->
										<c:param value="${pageDTO.startPage-1 }" name="PageNum"></c:param>
										<c:param value="${pageDTO.cri.amount }" name="amount"></c:param>
									</c:url>
									<a style="width:80px;" href="${prevLink }">Previous</a>
								</c:if>
				
								<c:forEach var="num" begin="${pageDTO.startPage }"
									end="${pageDTO.endPage }">
				
									<c:url value="/product/list" var="pageLink">
										<c:param name="pageNum" value="${num }" />
										<c:param name="amount" value="${pageDTO.cri.amount }" />
										<c:param name="type" value="${pageDTO.cri.type }" />
										<c:param name="keyword" value="${pageDTO.cri.keyword }" />
										<c:param name="array" value="${pageDTO.cri.array }" /> 
										<c:param name="categoryNum" value="${pageDTO.cri.categoryNum }" />
										<c:param name="categoryMain" value="${pageDTO.cri.categoryMain }"/>
										<c:param name="categorySub" value="${pageDTO.cri.categorySub }"/>    
									</c:url>
										<a class="${pageDTO.cri.pageNum eq num ? 'on' : '' }" href="${pageLink }">${num }</a> <%-- <a class="page-link" href="${num }">${num }</a> --%>
								</c:forEach>
				
								<!--페이징다음버튼  -->
								<c:if test="${pageDTO.next }">
									<c:url value="/product/list" var="nextLink">
										<c:param value="${pageDTO.endPage+1 }" name="PageNum"></c:param>
										<c:param value="${pageDTO.cri.amount }" name="amount"></c:param>
									</c:url>
									<a style="width:80px;" href="${nextLink }">Next</a>
								</c:if>
						</div>
					</div>
				<!-- 페이징 끝 -->
		
			</div>
		</div>


  </section>
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
<u:footer/>
</body>
</html>