<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등급 수정</title>
</head>
<body>
<form action="<c:url value="/grade/update"/>" method="post">
	<input type="hidden" name="gr_num" value="${grade.gr_num}">
	<div class="container">
		<h2>등급 수정</h2>
		<label>등급명</label>
		<input type="text" id="name" name="gr_name" value="${grade.gr_name}">
		<br>
		<label>할인율</label>
		<input type="text" id="discount" name="gr_discount" value="${grade.gr_discount}">
		<br>
		<label>대출조건</label>
		<input type="text" id="loan" name="gr_loan_condition" value="${grade.gr_loan_condition}">
		<br>
		<label>게시글조건</label>
		<input type="text" id="post" name="gr_post_condition" value="${grade.gr_post_condition}">
		<br>
		<button type="submit" class="btn btn-primary btn-grade">등급 수정</button>
	</div>
</form>
</body>
</html>