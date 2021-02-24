<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<%
response.setStatus(HttpServletResponse.SC_OK);
%>

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

<style>
#center {
	text-align: center;
}
#container {
    clear: both;
    position: relative;
    margin: 35px auto 0px;
    padding: 0 0 50px 0;
    width: 1000px;
    z-index: 1;
}
</style>
<title>500 error 페이지</title>
</head>
<body>
<u:mainNav/>
<div class="container">
	<section id ="container">
		<div id="center">
			<br><br><br><br><br>
				<img alt="" src="${root }/resources/logo/error_500.jpg" style="width:600px;">	
					<br><br><br><br><br><br><br><br><br>
				<img alt="" src="${root }/resources/logo/error_Cart.png" style="width:150px;">	
					<br><br><br><br><br>
		</div>
	</section>
</div>
<u:footer/>
</body>
</html>