<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
	.main-box { 
    display: flex; 
    justify-content: space-around;
    align-items: flex-start;
    margin-bottom: 20px; 
}

.banner-box { 
	margin-top: 20px;
    width: 40%; 
    height: 300px; 
    position: relative;
}

.banner-box img {
    width: 100%;
    height: 300px;
    object-fit: contain;
}

.login-box { 
	margin-top: 20px;
    border:1px solid black; 
    border-radius: 10px; 
    width: 20%;
    height: 150px; 
    position: relative;
}

.profile-box{ 
	margin-top: 20px;
    border:1px solid black; 
    border-radius: 10px; 
    width: 20%;
    height: 200px; 
    position: relative;
}
    
.main-post{ display: flex; justify-content: space-around; margin-bottom: 20px;}
.notice, .hot-post { width: 45%; height: 150px; background: #f2f2f2; text-align: center; line-height: 150px; }

.book-tab { display: flex; flex-direction: column; align-items: center; border-bottom: 2px solid #f36c4f; position: relative; margin-top: 20px; }

.new-btn, .loan-btn, .hot-btn { 
	border-left: 0;
	border-top: 0;
    border-bottom: 3px solid skyblue; 
    border-right: 1px solid skyblue;
    text-align: center; 
    padding: 10px; 
    background: #d5d5d5;  
    color: inherit;
    text-decoration: none;
    position: relative;
    float: left;
    display: block;
}
.active-btn {
    background-color: aliceblue;
    padding: 15px;
    transform: translateY(-10px);
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
    filter: invert(35%) sepia(100%) saturate(7500%) hue-rotate(5deg) brightness(0%) contrast(101%);
}
</style>
<body>
<div class="main">
	<div class="main-box">
		<div id="demo" class="carousel slide banner-box" data-bs-ride="carousel">
			<div class="carousel-inner">
			   <div class="carousel-item active">
			     <img src="https://cdn.pixabay.com/photo/2023/08/21/03/34/droplets-8203505_640.jpg" alt="1" class="d-block">
			   </div>
			   <div class="carousel-item">
			     <img src="https://cdn.pixabay.com/photo/2024/03/14/08/52/pug-8632718_640.jpg" alt="2" class="d-block" >
			   </div>
			   <div class="carousel-item">
			     <img src="https://cdn.pixabay.com/photo/2023/08/18/15/02/cat-8198720_640.jpg" alt="3" class="d-block">
			   </div>
			 </div>
			 
			 <!-- Left and right controls/icons -->
			 <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
			   <span class="carousel-control-prev-icon"></span>
			 </button>
			 <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
			   <span class="carousel-control-next-icon"></span>
			 </button>
		</div>
		<c:if test="${user == null}">
			<div class="login-box text-center mt-5">
				<a href="<c:url value='/login'/>" style="top:30px;" class="btn btn-outline-success login-btn col-8 mt-2">로그인</a>
				<div style="width: 100%;" class="mt-5">
					<a href="<c:url value="/find/id"/>" style="color: gray;">아이디찾기</a>
					<span style="color: gray; opacity: 60%">|</span>
					<a href="<c:url value="/find/pw"/>" style="color: gray;">비밀번호찾기</a>
					<span style="color: gray; opacity: 60%">|</span>
					<a href="<c:url value="/signup"/>" style="color: gray;">회원가입</a>
				</div>
			</div>
		</c:if>
		<c:if test="${user != null}">
			<div class="profile-box text-center">
				[회원 정보]
				<ul>
					<li>등급</li>
					<li>닉네임</li>
					<li>게시글 개수</li>
					<li>대출 개수</li>
				</ul>
				<a href="<c:url value="logout"/>" class="btn btn-outline-success col-8">로그아웃</a>
			</div>
		</c:if>
	</div>
	<div class="main-post">
		<div class="notice">공지</div>
		<div class="hot-post">인기글</div>
	</div>
	<div class="main-book">
		<ul class="book-tap">
			<li class="new-title">
				<button class="new-btn">새로 들어온 책<span  class="badge bg-success">New</span></button>
			</li>
			<li class="popular-title">
				<button class="loan-btn">대출이 많은 책<span  class="badge bg-danger">Hot</span></button>
			</li>
			<li class="popular-title">
				<button class="hot-btn">인기 많은 책<span  class="badge bg-warning">Best</span></button>
			</li>
			<div>
				123
			</div>
		</ul>
	</div>
</div>
<!-- 대출 책 -->
<script type="text/javascript">
$(document).on("click", ".loan-btn", function(e) {
	e.preventDefault();
	
	$(".new-btn, .loan-btn, .hot-btn").removeClass("active-btn");
	
	$(this).addClass("active-btn");
});
</script>
<!-- 신규 책 -->
<script type="text/javascript">
$(document).on("click", ".new-btn", function(e) {
	e.preventDefault();
	
	$(".new-btn, .loan-btn, .hot-btn").removeClass("active-btn");
	
	$(this).addClass("active-btn");
});
</script>
<!-- 인기 책 -->
<script type="text/javascript">
$(document).on("click", ".hot-btn", function(e) {
	e.preventDefault();
	
	$(".new-btn, .loan-btn, .hot-btn").removeClass("active-btn");
	
	$(this).addClass("active-btn");
});
</script>
</body>
