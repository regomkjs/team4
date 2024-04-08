<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
<h1>아이디찾기</h1>
<div class="form-group">
	<label for="id">아이디</label>
	<input type="text" class="form-control" id="id" name="id">
</div>
<button class="btn btn-outline-success col-12 btn-find">비번 찾기</button>
	<a href="<c:url value="/mail"/>">메일 테스트</a>
</body>
</html>