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
  <link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/default.css?ver=1155">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/skin/board/qna/style.css?v2">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/board.common.css?ver=1155">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/js/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/mobile.css?ver=1155">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/contents.css?ver=1155">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/plugin/featherlight/featherlight.min.css?ver=1155">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script>
	$(document).ready(
			function() {

				var result = '${result}';
				var message = '${message}';

				// checkModal(result);
				checkModal2(message);

				history.replaceState({}, null, null);

				function checkModal2(message) {

					if (message && history.state == null) {
						$("#myModal .modal-body p").html(message);
						$("#myModal").modal("show");
					}
				}

				
			});
</script>
<title>구매후기 글등록</title>
<style type="text/css">
#footdiv {
    width: 1000px;
    padding: 0 30px 30px 30px;
    text-align: center;
    color: gray;
    white-space: pre-line;
    
  	bottom:0;
  	margin-bottom: -143px;
}
#container1 {
	clear: both;
	posistion: relative;
	margin: 35px auto 0px;
	padding: 0 0 50px 0;
	width: 1000px;
	z-index: 1;
}
</style>
</head>
<body>
<u:mainNav></u:mainNav>
<c:choose>
	<c:when test="${authUser != null}">
		<div class="container">
			<section id="container1">
				<h3>게시글 쓰기</h3><br>
				<form action="${root }/rev/register" method="POST" enctype="multipart/form-data"style="width:100%">
    
			    <c:if test="${errors.noCategory }">
					<small class="form-text text-muted">
							카테고리를 입력하세요
					</small>
				</c:if>
	<%-- <input type="text" name="rev_category" class="form-group" value="${category }"/> --%> 
	
				<div class="bo_w_tit write_div">
        			<label for="wr_subject" class="sound_only">카테고리<strong>필수</strong></label>
        				<div id="autosave_wrapper write_div " style="margin-bottom:8px;">
				            <select name="rev_category" class="form-control" style="width:160px;" required>
								<option value="">카테고리 선택</option>
								<option value="1">모자</option>
								<option value="2">신발</option>
								<option value="3">상의</option>
								<option value="4">하의</option>
								<option value="5">전자 기기</option>
								<option value="6">식품</option>
							</select>
         				</div>
        
    			</div>
    	<div class="bo_w_tit write_div">
        	<label for="wr_subject" class="sound_only">제목<strong>필수</strong></label>
        	<div id="autosave_wrapper write_div" style="margin-bottom:8px;">
            	<input type="text" name="rev_title" value="${title }" maxlength="50" id="wr_subject" required="" class="frm_input full_input required" size="50"  placeholder="제목">
            </div>
    	</div>

    	<div class="write_div" >
        	<label for="wr_content" class="sound_only">내용<strong>필수</strong></label>
        	<div class="wr_content " style="margin-bottom:8px;">
                 <span class="sound_only">웹에디터 시작</span>
			<textarea id="wr_content" name="rev_content" class="frm_input full_input required" value="" maxlength="65536" style="width:100%;height:300px" placeholder="내용을 입력해 주세요." required></textarea>
			<span class="sound_only">웹 에디터 끝</span>                    </div>
        	<input type="text" name="rev_writer" class="form-group" value="${authUser.user_id }" hidden/>
    	</div>

		<div class="bo_w_info"><b>관련 파일</b>
     		<div class = "inputArea">
				<label for="revImg"></label>
	
 							<!--이미지첨부시작  -->
					<div class = "input_wrap" >
						<input type="file"  class="form-control" name="upload" id="input_imgs" multiple="multiple" accept="image/*"/>
					</div>	
					<div class="imgs_wrap">
						<img id="img"/>
							<script>
							  
							  $("#input_imgs").on("change", handleImgFileSelect);

							  //이미지셀렉트
							  function handleImgFileSelect(e){
									//이미지 정보를 초기화
									$(".imgs_wrap").empty();
									
									var files = e.target.files;
									var filesArr = Array.prototype.slice.call(files);
								
									filesArr.forEach(function(f){
										if(!f.type.match("image.*")){
											
											// 이전에 쓰던 모달창 복붙한거로나오게
											var message = "그림파일형석만 허용됩니다";
											function checkModal(message){
												if (message && history.state == null) {
													$("#myModal .modal-body p").html(message)
													$("#myModal").modal("show");
												}
											}
											checkModal(message);
											
											return;
										}
										
										var reader = new FileReader();
										reader.onload = function(e){
											
											 var html = "<div><img width=\"200\" src=\""+e.target.result+"\"></div>";
											$(".imgs_wrap").append(html);
										
										}
										reader.readAsDataURL(f);
									});
							 }
						 	</script>
						<!--이미지첨부끝 -->
					</div>
 			</div>     
      </div>          
   

        
    

    <div class="btn_confirm write_div">
        <input type="submit" value="작성완료" id="btn_submit" accesskey="s" class="btn_submit btn-secondary" style="border: thin;">
        <footer>
			<div id="footdiv">
			
				<div class="container" style="width:100%;">
					사업자명 : BCD쇼핑몰 ㅣ 사업자 번호 : 123-45-78901 ㅣ 개인정보관리책임자 : 이원석
					주소 : 서울특별시 마포구 신촌로 176 5층 501호ㅣ 전화 : 0507-1409-1711안내ㅣ 메일 : lws3793@naver.com
				</div>
			</div>
		</footer> 
    </div> 
    </form>
</section>
</div>
 </c:when>
 <c:otherwise>
 	<script>
			alert('로그인 한 사람만 접근 가능합니다.');
			location.href='${root}/rev/list';
		</script>
 </c:otherwise>
 </c:choose>
</body>
</html>