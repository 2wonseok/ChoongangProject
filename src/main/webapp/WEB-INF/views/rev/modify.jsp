<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<style>
	#btn_add {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
    }
    
    #remove-btn {
    color: #fff;
    font-size: 15px;
    border: none;
    background: #1e263c;
    padding: 0px 50px;
    margin: 0 0px;
    line-height: 45px;
    float: right;
    }
    #footdiv {
    width: 1000px;
    padding: 0 30px 30px 30px;
    text-align: center;
    color: gray;
    white-space: pre-line;
  	bottom:0;
	}
	
}
</style>

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
	 $(document).ready(function() {
		$("#remove-btn").click(function(e) {
			e.preventDefault();
	 
			// #modify-form 의 action attr 값을 바꿔야함.
	 		
			$("#modify-form").attr("action", '${root }/rev/remove');
			var remove = confirm('정말 삭제하시겠습니까?');
			if (remove) {
			$("#modify-form").submit();
			}
		});
	}); 
	
	 $(document).ready(function() {
			$("#btn_add").click(function(e) {
				e.preventDefault();
				
				var modify = confirm('정말 수정하시겠습니까?');
				if (modify) {
					$("#modify-form").submit();
				}
			})
			 });
	
</script>
<title>구매후기글 수정</title>
</head>
<body>
<u:mainNav></u:mainNav>
<c:choose>
	<c:when test="${authUser.user_grade == 0 || authUser.user_id eq RevBoard.rev_writer}">
	<div class="container mt-5" style="width: 1000px">
	<h3>게시글 수정</h3><br>
	<c:url value="${root }/rev/modify" var="modifyLink">
					<c:param name="rev_seq" value="${RevBoard.rev_seq }" />
					<c:param name="pageNum" value="${cri.pageNum }" />
					<c:param name="amount" value="${cri.amount }" />
					<c:param name="type" value="${cri.type }"/>
					<c:param name="keyword" value="${cri.keyword }"/>
				</c:url>
			
	<form id="modify-form" action="${modifyLink}" method="post" enctype="multipart/form-data">
    <c:if test="${errors.noCategory }">
	<small class="form-text text-muted">
			카테고리를 입력하세요
	</small>
	</c:if>
	<%-- <input type="text" name="rev_category" class="form-group" value="${category }"/> --%> 
	
	<div class="bo_w_tit write_div">
        <label for="wr_subject" class="sound_only">카테고리<strong>필수</strong></label>
        
        <div id="autosave_wrapper write_div" style="margin-bottom:8px;">
            <select name="rev_category" class="form-control" style="width:160px;" required>
				<option value="${RevBoard.rev_category }">카테고리 선택</option>
				<option value="1">모자</option>
				<option value="2">신발</option>
				<option value="3">상의</option>
				<option value="4">하의</option>
				<option value="5">전자 기기</option>
				<option value="6">식품</option>
			</select>
         </div>
        
    </div>
    <div class="bo_w_tit write_div" style="margin-bottom:8px;">
        <label for="wr_subject" class="sound_only">제목<strong>필수</strong></label>
        
        <div id="autosave_wrapper write_div">
            <input type="text" name="rev_title" value="<c:out value="${RevBoard.rev_title }" />" maxlength="50" id="wr_subject" required="" class="frm_input full_input required" size="50" maxlength="255" placeholder="제목">
                    </div>
        
    </div>

    <div class="write_div">
        <label for="wr_content" class="sound_only">내용<strong>필수</strong></label>
        <div class="wr_content ">
                        <span class="sound_only">웹에디터 시작</span>
<textarea id="wr_content" name="rev_content" class="rm_input full_input required" required maxlength="65536" style="width:100%;height:300px" placeholder="내용을 입력해 주세요."><c:out value="${RevBoard.rev_content }" /></textarea>
<span class="sound_only">웹 에디터 끝</span>                    </div>
        <input type="text" name="rev_writer" class="form-group" value="${authUser.user_id }" hidden/>
    </div>

	<div class="bo_w_info"><b>관련 파일</b></div>
     <div class = "inputArea">
	<label for="revImg"></label>
	 <div class="select_img"><img src="" /></div>
	 
 	
							<div class = "input_wrap">
								
						
							<!--이미지첨부시작  -->
							<label for="input3">파일이름</label>
							<input type="text" value="${preFileNames }" name ="preFileNames" hidden="hidden">							
							<div class = "input_wrap">
								 <input type="file" name="upload" id="input_imgs" multiple="multiple" accept="image/*"/>
							</div>
							<div class="imgs_wrap">
								<c:forEach items="${fileNamesList }" var="product_img">	
									<div>
										<img width="500" src="${root }/resources/upload/${product_img }"/>
									</div>
								</c:forEach>
							</div>
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
											
											 var html = "<div><img width=\"150\" src=\""+e.target.result+"\"></div>";
											$(".imgs_wrap").append(html);
										
										}
										reader.readAsDataURL(f);
									});
							 }
						 	</script>
						 	
					</div>
        
                
                <input type="hidden" value="${RevBoard.rev_seq }" name="rev_seq">
                <input type="hidden" value="${cri.pageNum }" name="pageNum" /> 
				<input type="hidden" value="${cri.amount }" name="amount" /> 
				<input type="hidden" value="${cri.type }" name="type" /> 
				<input type="hidden" value="${cri.keyword }" name="keyword" />
					
    				<c:if test="${ sessionScope.authUser.user_id eq RevBoard.rev_writer || authUser.user_grade == 0}">
						<button id="remove-btn" type="submit" class="btn btn-danger">글 삭제</button>
						<button id="btn_add" type="submit" class="btn btn-primary">글 수정</button> 
					</c:if>
   					
					
		
   		
    </div>
    </form>
</div>
    <footer>
    	<div class="container">
    		<section id="container1">
    		
			<div id="footdiv">
			
				<<!-- div class="container1" style="margin-left:100px;width:100%;"> -->
					사업자명 : BCD쇼핑몰 ㅣ 사업자 번호 : 123-45-78901 ㅣ 개인정보관리책임자 : 이원석
					주소 : 서울특별시 마포구 신촌로 176 5층 501호ㅣ 전화 : 0507-1409-1711안내ㅣ 메일 : lws3793@naver.com
				<!-- </div> -->
			</div>
			</section>
    	</div>
		</footer> 
    </c:when>
    <c:otherwise>
    		<script type="text/javascript">
    			alert('관리자나 작성자만 접근가능합니다');
    			location.href='${root}/rev/list';
    		</script>
    </c:otherwise>
    </c:choose>		
</body>
</html>