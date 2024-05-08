<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
						<li>${book.item[0].title}</li>
						<li>${book.item[0].author}<span>|</span>
							${book.item[0].publisher}<span>|</span>
							${book.item[0].pubDate}<span>|</span>
							원제: ${book.item[0].subInfo.originalTitle}
						</li>
					</ul>
				</div>
				<div class="book-content">
					<img alt="${book.title}" src="${book.item[0].cover}">
					<div class="book-info">
					<ul>
						<li>분류:${book.item[0].categoryName}</li>
						<li>타입:${book.item[0].mallType}</li>
						<li>ISBN:${book.item[0].isbn13}</li>
						<li>쪽수:${book.item[0].subInfo.itemPage}</li>
						<li>정가:${book.item[0].priceStandard}원</li>
						<li>
							<button class="btn btn-outline-warning basket-btn" data-isbn="${book.item[0].isbn13}">장바구니</button>
							<a class="btn btn-outline-warning purchase-btn" data-isbn="${book.item[0].isbn13}">구매</a>
						</li>
					</ul>
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
</script>