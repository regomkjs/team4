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
    display: flex;
    flex-wrap: wrap;
    list-style: none;
    padding: 0;
}

.book-info-horizontal li {
    margin-right: 20px;
}

.media{ position: relative;}

.text-group{ margin: 10px; padding: 10px;}

.text-group li{ font-size: 20px;}
</style>
<body>
	<div class="container mt-5">
		<form class="search input-group" method="get" action="<c:url value="/library/bookSale/search"/>">
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
				<div class="book-title">
					<ul>
						<li class="mt-3"><h3 style="font-weight: bold;">${book.item[0].title}</h3></li>
						<li>
							<span class="book-author">${book.item[0].author}</span>
						    <span class="book-publisher">${book.item[0].publisher}</span>
						    <span class="book-pubDate">${book.item[0].pubDate}</span>
					   	 	<span class="book-originalTitle">원제: ${book.item[0].subInfo.originalTitle}</span>
						</li>
					</ul>
					<hr style="border: 1px solid A2A2A2; margin-top: 30px; margin-bottom: 35px;">
				</div>
				<div class="book-content">
					<div class="media">
						<img alt="${book.title}" src="${book.item[0].cover}" style="width: 30%;">
						<div class="text-group">
							<ul>
								<li>평점 : <span style="color: #eb217c;"> ${book.item[0].customerReviewRank}</span></li>
								<li>Sales Point : ${book.item[0].salesPoint} 
									<i class="bi bi-arrow-down-square"></i>
								</li>
								<li>정가 : ﻿<fmt:formatNumber value="${book.item[0].priceStandard}" pattern="#,###"/></li>
								<li><a href="${book.item[0].link}">책 보러 가기</a></li>
								<li>
									<button class="btn btn-outline-warning basket-btn" data-isbn="${book.item[0].isbn13}">장바구니</button>
									<a class="btn btn-outline-warning purchase-btn" data-isbn="${book.item[0].isbn13}">구매</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="book-info mt-5">
						<div class="book-info-horizontal">
							<h4>기본정보</h4>
							<ul class="ml-5">
								<li>타입:${book.item[0].mallType}</li>
								<li>ISBN:${book.item[0].isbn13}</li>
								<li>쪽수:${book.item[0].subInfo.itemPage}</li>
							</ul>
						</div>
						<div>
							<h5 style="font-weight: bold;">주제분류</h5>
							<ul>
								<li>분류:${book.item[0].categoryName}</li>
							</ul>
							<hr style="border: 1px solid A2A2A2; margin-top: 30px; margin-bottom: 35px;">
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