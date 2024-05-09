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
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="http://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<!-- Popper JS -->
<script src="http://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="http://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 썸머노트 -->
<link href="http://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="http://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<style type="text/css">
	.header-box{
		min-width: 1196px;
	}
	.footer-box{
		min-width: 1196px;
	}
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
</style>

</head>
<body>
	<div class="header-box">
	    <tiles:insertAttribute name="header"/>
	</div>
    <div style="min-height: calc(100vh - 290px); min-width: 1446px;" class="community-box-container container">
    	<div class="box-sidebar" style="min-height: calc(100vh - 290px);">
	    	<tiles:insertAttribute name="sidebar" />
    	</div>
    	<div class="box-contents" style="padding: 0 20px;">
	    	<tiles:insertAttribute name="body" />
    	</div>
    </div>
    <div class="footer-box">
    	<tiles:insertAttribute name="footer" />
    </div>
</body>
</html>
