<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- jquery validtaion -->	
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>
</head>
<body>
<div class="container col-5 p-5 mt-3 card-1" style="padding: 50px;">
	<form action="<c:url value="/login"/>" method="post">
		<h2 style="margin-bottom: 50px; font-weight: bold">로그인</h2>
		<div class="form-group" style="margin-bottom: 10px">
			<div class="form-group">
				<input type="text" class="form-control" id="id" name="id" placeholder="아이디">
			</div>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호">
		</div>
		<button class="btn btn-outline-success col-12 btn-submit" style="margin-top: 40px">로그인</button>
	</form>
</div>
</body>
</html>