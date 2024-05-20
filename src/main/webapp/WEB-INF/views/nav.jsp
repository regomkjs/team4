<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<style>
a{text-decoration: none; color: #000;}
a:hover{text-decoration: none; color: #000;}

.nav-box {height: 60px; background-color: #212529;}
.nav-box ul{padding: 0; margin: 0; text-align: center;}
.nav-list{width: 20%; position: relative;}
.nav-box .nav-item{display: block;  border-right: 1px solid #a5a5a5;}
.nav-list li{ background-color: #fff; z-index:50; position:absolute;
 line-height: 60px; width: 100%; background-color: #212529; color:#a5a5a5;}
.nav-list li a{color:#a5a5a5;}
.nav-option div ul li{ padding: 0 1px; display: none;}
.nav-list:hover .nav-option div ul li{display: block;}

.nav-list li:after{
  position: absolute;
  top: 100%;
  left: 20%;
  width: 60%;
  height: 3px;
  background-color:#fafafa ;
  content: '';
  opacity: 0;
  -webkit-transition: opacity 0.3s, -webkit-transform 0.3s;
  -moz-transition: opacity 0.3s, -moz-transform 0.3s;
  transition: opacity 0.3s, transform 0.3s;
  -webkit-transform: translateY(0px);
  -moz-transform: translateY(0px);
  transform: translateY(0);
}
.nav-list li:hover:after{
   opacity: 1;
  -webkit-transform: translateY(-10px);
  -moz-transform: translateY(-10px);
  transform: translateY(-10px);
}

.nav-list:nth-of-type(1) {left: 0;}
.nav-list:nth-of-type(2) {left: 20%;}
.nav-list:nth-of-type(3) {left: 40%;}
.nav-list:nth-of-type(4) {left: 60%;}
.nav-list li:nth-of-type(1){top: 0;}
.nav-list li:nth-of-type(2){top: 60px;}
.nav-list li:nth-of-type(3){top: 120px;}
.nav-list li:nth-of-type(4){top: 180px;}
</style>
<body>
<div class="nav-box">
	<ul class="nav-list">
		<li class="nav-item">도서관</li>
		<li class="nav-option">
			<div>
				<ul>
					<li><a href="<c:url value="/library/book/list"/>">도서 목록</a></li>
				</ul>
			</div>
		</li>
	</ul>
	<ul class="nav-list">
		<li class="nav-item"><a href="<c:url value="/post"/>">커뮤니티</a></li>
		<li class="nav-option">
			<div>
				<ul>
					<li><a href="<c:url value="/post/list"/>">전체 게시글</a></li>
					<li><a href="<c:url value="/post/popular?ca=-1"/>">인기 게시글</a></li>
					<li><a href="<c:url value="/post/list?ca=1"/>">공지 게시판</a></li>
				</ul>
			</div>
		</li>
	</ul>
	<ul class="nav-list">
		<li class="nav-item"><a
			href="<c:url value="/library/bookSale/list"/>">도서 판매</a></li>
		<li class="nav-option">
			<div>
				<ul>
					<li></li>
				</ul>
			</div>
		</li>
	</ul>
	<c:if test="${user.me_mr_num<2}">
		<ul class="nav-list">
			<li class="nav-item">관리자</li>
			<li class="nav-option">
				<div>
					<ul>
						<li><a href="<c:url value="/library/management/manager"/>">도서
								관리</a></li>
						<li><a
							href="<c:url value="/library/management/bookCategory"/>">도서
								카테고리 관리</a></li>
						<li><a href="<c:url value="/library/management/order"/>">주문
								관리</a></li>
						<li><a href="<c:url value="/library/management/loan"/>">대출
								관리</a></li>
					</ul>
				</div>
			</li>
		</ul>
	</c:if>
</div>
</body>