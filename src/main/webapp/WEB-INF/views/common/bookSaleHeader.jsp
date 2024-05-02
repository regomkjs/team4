<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<!-- Brand/logo -->
	<a class="navbar-brand" href="<c:url value="/library"/>">
		<img src="<c:url value="/resources/img/bird.jpg"/>" alt="logo" style="width:40px;">
	</a>
	
	<!-- Links -->
	<ul class="navbar-nav">
		<li class="nav-item">
			<a class="nav-link" href="<c:url value="/"/>">카페</a>
		</li>
		<c:if test="${user == null}" >
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/signup"/>">회원가입</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/login"/>">로그인</a>
			</li>
		</c:if>
		<c:if test="${user != null}">
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/logout"/>">로그아웃</a>
			</li>
		</c:if>
		
		<li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
	        마이페이지
	      </a>
	      <div class="dropdown-menu">
	      	<c:if test="${user == null}" >
	      		<a class="dropdown-item" href="<c:url value="/library/order/list"/>">주문내역</a>
	      	</c:if>
	      	<c:if test='${user.me_mr_name == "마스터"}' >
	      		 <a class="dropdown-item" href="<c:url value="/library/management/order"/>">주문관리</a>
	      	</c:if>
	      </div>
    	</li>
    	<li class="nav-item">
			<div class="basket">
			<p>장바구니</p>
			<div></div>
		</div>
		</li>
	</ul>
</nav>