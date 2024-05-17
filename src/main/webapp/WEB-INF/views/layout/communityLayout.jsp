<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
<title>
<c:choose>
	<c:when test="${title != null }">${title}</c:when>
	<c:otherwise>스프링</c:otherwise>
</c:choose>
</title>

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery library -->
<script src="http://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<!-- Popper JS -->
<script src="http://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- 썸머노트 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css"
integrity="sha256-IKhQVXDfwbVELwiR0ke6dX+pJt0RSmWky3WB2pNx9Hg=" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"
integrity="sha256-5slxYrL5Ct3mhMAp/dgnb5JSnTYMtkr4dHby34N10qw=" crossorigin="anonymous"></script>

<!-- language pack -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/lang/summernote-ko-KR.min.js"
integrity="sha256-y2bkXLA0VKwUx5hwbBKnaboRThcu7YOFyuYarJbCnoQ=" crossorigin="anonymous"></script>

<style type="text/css">
	
	.community-box-container{
		display: flex;
		flex-direction: row;
	}
	.box-sidebar {
		width: 250px;
		flex-shrink: 0;
	}
	
	.box-contents {
		flex-grow: 1;
		min-width: 0;
	}
	.main-img-container{
		width: 100%;
		height: 360px;
		display: flex;
	}
	.main-img-content{
		margin: 0 auto;
	}
</style>

</head>
<body>
    <tiles:insertAttribute name="header"/>
    <div class="main-img-container">
	   	<a class="main-img-content" href="<c:url value="/"/>">
    		<img src="<c:url value="/resources/img/main.png"/>" alt="2" style="width: 720px; height: 360px;">
	    </a>
   	</div>
    <div style="min-height: calc(100vh - 290px); min-width: 1200px;" class="community-box-container container">
    	<div class="box-sidebar" style="min-height: calc(100vh - 290px);">
	    	<tiles:insertAttribute name="sidebar" />
    	</div>
    	<div class="box-contents" style="padding: 0 20px;">
	    	<tiles:insertAttribute name="body" />
    	</div>
    </div>
   	<tiles:insertAttribute name="footer" />
</body>
</html>
