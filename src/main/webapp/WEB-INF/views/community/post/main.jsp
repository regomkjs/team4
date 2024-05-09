<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>메인</title>
</head>
<body>
<div>
	<h1>
		커뮤니티 메인
	</h1>
	
	<ul>
		<li><a href='<c:url value="/post/list"/>'>전체 게시글</a></li>
		<c:forEach items="${categoryList}" var="category">
			<li>
				<c:url value="/post/list" var="url">
					<c:param name="ca" value="${category.ca_num}"/>
				</c:url>
				<a href='${url}'>${category.ca_name}</a>
			</li>
		</c:forEach>
	</ul>
</div>

</body>
</html>
