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
<P>  The time on the server is ${serverTime}. </P>


<c:if test="${user != null}">
	<input hidden value="${user.me_report_count}" class="report-count">
</c:if>
<script type="text/javascript">
let count = $(".report-count").val();
window.onload = function () {
	var referrer = document.referrer;
	if(referrer == "http://localhost:8080/team4/login"){
		console.log(count);
		if(count >= 5){
			alert("지금까지 처리되지 않은 신고가 " + count +"회 누적되었습니다.\n커뮤니티 이용에 주의하세요.");
		}
	}
}

</script>

</body>
</html>
