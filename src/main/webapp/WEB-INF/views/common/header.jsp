<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<!-- Brand/logo -->
	<a class="navbar-brand" href="<c:url value="/"/>">
		<img src="<c:url value="/resources/img/bird.jpg"/>" alt="logo" style="width:40px;">
	</a>
	
	<!-- Links -->
	<ul class="navbar-nav">
		<li class="nav-item">
			<a class="nav-link" href="<c:url value="/library"/>">도서</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="<c:url value="/post"/>">커뮤니티</a>
		</li>
		<c:if test="${user == null}" >
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/signup"/>">회원가입</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/login"/>">로그인</a>
			</li>
		</c:if>
		<c:choose>
			<c:when test="${user.me_ms_num == 1}">
				<li class="nav-item">
					<a class="nav-link" href="<c:url value="/mypage"/>">내 정보</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value="/logout"/>">로그아웃</a>
				</li>
			</c:when>
			<c:when test="${user.me_ms_num == 2}">
				<li class="nav-item">
					<a class="nav-link" href="<c:url value="/grade/list"/>">등급 관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value="/logout"/>">로그아웃</a>
				</li>
			</c:when>
		</c:choose>
	</ul>
</nav>
