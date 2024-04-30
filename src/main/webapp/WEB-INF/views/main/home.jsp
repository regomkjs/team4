<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
<a href="<c:url value="/mail"/>">문자 테스트 하러 가기</a>
<P>  The time on the server is ${serverTime}. </P>


<c:if test="${user != null}">
	<input hidden value="${user.me_report_count}" class="report-count">
	<input hidden value="${user.me_block}" class="block-date">
</c:if>
<script type="text/javascript">
let count = $(".report-count").val();
let block = $(".block-date").val();
window.onload = function () {
	var referrer = document.referrer;
	if(referrer == "http://localhost:8080/team4/login"){
		if(block){
			alert("활동정지 : " + block +"\n커뮤니티 이용은 활동정지일 이후 가능합니다.");
		}
		else{
			if(count >= 5){
				alert("지금까지 처리되지 않은 신고가 " + count +"회 누적되었습니다.\n커뮤니티 이용에 주의하세요.");
			}
		}
	}
}

</script>

</body>
</html>
