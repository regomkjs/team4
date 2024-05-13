<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>메인</title>
	<style type="text/css">
		.banner-box{
			display: flex;
		}
		
		.carousel-inner{
			background-color: #dcdcdc;
			margin: 0 auto;
			width: 80%;
			height: 150px;
		}	
		.carousel-item>img{
			width: 100%;
			height: 150px;
			object-fit: contain;
		}
		.carousel-item>a>img{
			width: 100%;
			height: 150px;
			object-fit: contain;
		}
		.carousel-control-prev-icon, .carousel-control-next-icon {
			filter: invert(35%) sepia(100%) saturate(7500%) hue-rotate(5deg)
				brightness(0%) contrast(101%);
		}
	</style>
	
</head>
<body>
<div>
	<!-- 카페 메인 carousel -->
	<div id="demo" class="carousel slide banner-box"
		data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<a href="<c:url value="/library/book/list"/>"><img src="<c:url value="resources/img/오픈.jpg"/>" alt="1" class="d-block"></a>
			</div>
			<div class="carousel-item">
				<img
					src="<c:url value="resources/img/토론.jpg"/>"
					alt="2" class="d-block">
			</div>
			<div class="carousel-item">
				<img
					src="<c:url value="resources/img/이벤트.jpg"/>"
					alt="3" class="d-block">
			</div>
			<div class="carousel-item">
				<img
					src="<c:url value="resources/img/main.png"/>"
					alt="4" class="d-block">
			</div>
		</div>
		<!-- Left and right controls/icons -->
		<button class="carousel-control-prev" type="button"
			data-bs-target="#demo" data-bs-slide="prev">
			<span class="carousel-control-prev-icon"></span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#demo" data-bs-slide="next">
			<span class="carousel-control-next-icon"></span>
		</button>
	</div>
	
</div>



</body>
</html>
