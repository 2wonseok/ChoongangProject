<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<% 
String inputYn = request.getParameter("inputYn"); 
String roadFullAddr = request.getParameter("roadFullAddr"); 
String roadAddrPart1 = request.getParameter("roadAddrPart1"); 
String roadAddrPart2 = request.getParameter("roadAddrPart2"); 
String engAddr = request.getParameter("engAddr"); 
String jibunAddr = request.getParameter("jibunAddr"); 
String zipNo = request.getParameter("zipNo"); 
String addrDetail = request.getParameter("addrDetail"); 
%> 
</head> 
<script language="javascript"> // opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("주소입력화면 소스"도 동일하게 적용시켜야 합니다.) document.domain = "오픈API에서 입력한 URL 주소를 입력한다"; 
function init() { 
	//var url = "http://localhost:8080/"; 
	var url = location.href; 
	var confmKey = "devU01TX0FVVEgyMDIxMDIwMTIyMTkwMzExMDc2NjA="; 
	var resultType = "4"; // 도로명주소 검색결과 화면 출력내용, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명 
	var inputYn= "<%=inputYn%>";
	
	if(inputYn != "Y") { 
		document.form.confmKey.value = confmKey; 
		document.form.returnUrl.value = url; 
		document.form.resultType.value = resultType; 
		document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망 
		document.form.submit();
	} else { 
		window.close(); 
		window.opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>","<%=roadAddrPart2%>", "<%=engAddr%>", "<%=jibunAddr%>", "<%=zipNo%>" ); 
	}
} 
</script> 
<body onload="init();"> 
	<form id="form" name="form" method="post"> 
		<input type="hidden" id="confmKey" name="confmKey" value=""/> 
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/> 
		<input type="hidden" id="resultType" name="resultType" value=""/>
 </form> 
</body> 
</html>

