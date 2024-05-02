<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<!-- Brand/logo -->
	<a class="navbar-brand" href="<c:url value="/"/>">
		<img src="data:image/png;base64,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" alt="logo" style="width:40px;"> 
		<span>책책책</span>
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
			<c:when test="${user.me_mr_num > 0}">
				<li class="dropdown">
					<a type="button" class="nav-link dropdown-toggle" data-toggle="dropdown">
				    	마이페이지
					</a>
					<div class="dropdown-menu">
					    <a class="dropdown-item" href="<c:url value="/mypage"/>">내 정보</a>
					    <a class="dropdown-item" href="<c:url value="/mypage/post"/>">내가 쓴 게시글</a>
					    <a class="dropdown-item" href="<c:url value="/mypage/comment"/>">내가 쓴 댓글</a>
					    <a class="dropdown-item" href="<c:url value="/mypage/report"/>">내가 신고한 내역</a>
					    <a class="dropdown-item" href="<c:url value="/mypage/loan"/>">내가 대출한 도서</a>
				  	</div>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value="/logout"/>">로그아웃</a>
				</li>
			</c:when>
			<c:when test="${user.me_mr_num <= 1}">
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
