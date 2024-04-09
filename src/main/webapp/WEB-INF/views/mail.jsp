<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문자</title>
</head>
<body>
<div class="container">
	<form action="<c:url value="/mail"/>" method="post">
		<div class="form-group">
			<input type="text" class="form-control" id="phone" name="phone" placeholder="수신번호">
		</div>
		<div class="form-group">
			<textarea class="form-control" id="content" name="content" placeholder="내용"></textarea>
		</div>
		<button type="submit">전송</button>
	</form>
</div>
</body>
</html>