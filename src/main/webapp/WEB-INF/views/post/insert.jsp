<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시글 작성</title>
</head>
<body>
<div class="container">
	<h1>
		게시글 작성
	</h1>
	<div class="container mt-3 mb-3">
		<form action='<c:url value="/post/list"/>' method="post">
			<div class="mb-3 mt-3">
				<label for="category">게시판:</label>
				<select id="category" name="po_ca_num" class="form-control">
					<c:forEach items="${categoryList}" var="category">
						<c:if test='${category.ca_name == "공지" && user.me_gr_num == 0}'>
							<option value="${category.ca_num}" <c:if test="${ca_num == category.ca_num}">selected</c:if>>${category.ca_name}</option>
						</c:if>
						<c:if test='${category.ca_name != "공지"}'>
							<option value="${category.ca_num}" <c:if test="${ca_num == category.ca_num}">selected</c:if>>${category.ca_name}</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			
			<div class="mb-3 mt-3">
				<label for="title">제목:</label>
				<input type="text" class="form-control" id="title" placeholder="제목 입력" name="po_title">
			</div>
			<div class="mb-3">
				<label for="content">내용:</label>
				<textarea rows="10" name="po_content" id="content" class="form-control"></textarea>
			</div>
			
			<button type="submit" class="btn btn-primary col-12 insert-btn">등록</button>
		</form>
	</div>
</div>

</body>
</html>
