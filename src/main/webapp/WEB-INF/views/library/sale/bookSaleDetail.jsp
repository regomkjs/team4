<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style type="text/css">
.book-author, .book-publisher, .book-pubDate, .book-originalTitle {
    margin-right: 8px;
}

.book-originalTitle {
    margin-right: 0;
}

.book-info-horizontal {
	padding: 10px; margin: 10px;
    display: flex;
    flex-wrap: wrap;
    list-style: none;
    padding: 0;
}

.book-info-horizontal li {
    margin-right: 20px;
}

.media{
	padding: 10px; margin: 10px; 
	position: relative;
  	display: flex;
  	align-items: flex-start;
  }

.text-group{ margin: 10px; padding: 10px;}

.text-group li{ font-size: 20px;}

.text-group,.content li{ font-size: 14px;}

.sales-point .toggle-button {
  cursor: pointer;
  font-weight: bold;
}

.sales-point .content {
  padding: 10px;
  border: 1px solid #ddd;
  margin-top: 5px;
}

.main{ background-color: #F7F7F7;}

.book-description{ margin: 10px; padding: 10px;}
</style>
<body>
	<div class="container ">
		<div id="nav"></div>
		<form class="search input-group mt-5" method="get" action="<c:url value="/library/bookSale/search"/>">
		  	<select  class="form-control" name="type">
		  		<option value="Keyword">제목+저자</option>
		  		<option value="Title">도서명</option>
		  		<option value="Author">저자</option>
		  		<option value="Publisher">출판사</option>
		  	</select>
		    <input type="text" class="form-control" name="search" >
		    <input type="text" name="page" value="1" style="display: none">
		    <div class="input-group-append">
		      <button class="btn btn-success search-btn" type="submit">검색</button>
		    </div>
		</form>
		<div class="main">
			<div class="book-main">
				<hr style="border: 1px solid #404040; border-radius: 10px; margin-top: 30px; margin-bottom: 35px;">
				<div class="book-content">
					<div class="media">
						<img alt="${book.title}" src="${book.item[0].cover}" style="width: 20%;">
						<div class="text-group">
							<ul>
								<li class="mt-3"><h3 style="font-weight: bold;">${book.item[0].title}</h3></li>
								<li>
									<span class="book-author">${book.item[0].author}</span>
								    <span class="book-publisher">${book.item[0].publisher}</span>
								    <span class="book-pubDate">${book.item[0].pubDate}</span>
								</li>
								<li>평점 : <span style="color: #eb217c; font-size: 24px;"> ${book.item[0].customerReviewRank}</span></li>
								<li class="sales-point">Sales Point : <span style="font-size: 24px;"><fmt:formatNumber value="${book.item[0].salesPoint}" pattern="#,###"/></span> 
									<i class="bi bi-arrow-down-square toggle-button"></i>
									<div class="content" style="display: none;">
									  	<ul>
									  		<h3 style="color: #444; text-align: center; font-size: 17px;">세일즈 포인트</h3>
									  		<li>SalesPoint는 판매량과 판매기간에 근거하여 해당 상품의 판매도를 산출한 판매지수법입니다.</li>
									  		<li>최근 판매분에 가중치를 준 판매점수. 팔릴수록 올라가고 덜 팔리면 내려갑니다.</li>
									  		<li>그래서 최근 베스트셀러는 높은 점수이며, 꾸준히 팔리는 스테디셀러들도 어느 정도 포인트를 유지합니다.</li>
									  		<li>`SalesPoint`는 매일매일 업데이트됩니다.</li>
									  	</ul>
									</div>
								</li>
								<li>정가 : ﻿<span style="font-size: 24px;"><fmt:formatNumber value="${book.item[0].priceStandard}" pattern="#,###"/>원</span></li>
								<li><a href="${book.item[0].link}">책 보러 가기</a></li>
								<li>
									<button class="btn btn-outline-warning basket-btn" data-isbn="${book.item[0].isbn13}">장바구니</button>
									<a class="btn btn-outline-danger purchase-btn" data-isbn="${book.item[0].isbn13}">구매</a>
								</li>
							</ul>
						</div>
					</div>
					<hr style="border: 1px solid #404040; border-radius: 10px; margin-top: 30px; margin-bottom: 35px;">
					<div class="book-info mt-5">
						<div class="book-info-horizontal">
							<h4>기본정보</h4>
							<ul class="ml-5">
								<li>타입 : ${book.item[0].mallType}</li>
								<li>ISBN : ${book.item[0].isbn13}</li>
								<li>쪽수 : ${book.item[0].subInfo.itemPage}</li>
							</ul>
						</div>
						<div>
							<h5 style="font-weight: bold; margin: 10px; padding: 10px;">주제분류</h5>
							<ul>
								<li>분류:${book.item[0].categoryName}</li>
							</ul>
							<hr style="border: 1px solid #404040; border-radius: 10px; margin-top: 30px; margin-bottom: 35px;">
						</div>
					</div>
				</div>
				<div class="book-description">
					<h4>책 소개</h4>
					<p>${book.item[0].description}</p>
				</div>
			</div>
		</div>
	</div>	
</body>
<script type="text/javascript">
let tmp=JSON.stringify(${book});
tmp=JSON.parse(tmp);
let books=tmp.item;
console.log(books);
$(document).ready(function(){
  $('.toggle-button').click(function(){
    $(this).toggleClass('active');
    $(this).next('.content').slideToggle(200);
  });
});
</script>