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
		<div class="basket">
			<p>장바구니</p>
			<div>aa</div>
		</div>
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
						<li>정가:${book.item[0].priceStandard}</li>
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
	<!-- 구매,장바구니 -->
	<script type="text/javascript">
	let bookObj=${book};
	let basket=[];
	let books=bookObj.item;
	
	$(document).on("click",".basket-btn",function(){
		let cookie=getCookie("basket");
		let isbn=$(this).data("isbn");
		console.log(JSON.stringify(cookie));
		for(let i=0;i<books.length;i++){
			if(books[i].isbn13==isbn){
				basket.push(books[i]);
			}
		}
		let str=`
		<p>장바구니(\${basket.length})</p>
		<div><ul>
		`;
		for(baskets of basket){
			str+=`
				<li>\${baskets.title}</li>
			`;
		}
		str+=`</ul></div>`;
		$(".basket").html(str);
		setCookie("basket",basket, 1);
	});
	
	$(".basket").click(function() {
		let basketJson=JSON.stringify(basket);
		localStorage.setItem('basket',basketJson);
		location.href = '<c:url value="/library/book/sale" />';	
	});
	
	$(document).on("click",".purchase-btn",function(){
		let isbn=$(this).data("isbn");
		for(let i=0;i<books.length;i++){
			console.log(books[i].isbn13==isbn);//
			if(books[i].isbn13==isbn){
				basket.push(books[i]);
			}
		}
		let basketJson=JSON.stringify(basket);
		localStorage.setItem('basket',basketJson);
		location.href = '<c:url value="/library/book/sale" />';	
	});
	</script>
	
	<!-- 쿠키 -->
	<script type="text/javascript">
	function setCookie(cookie_name, value, days) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + days);
		// 설정 일수만큼 현재시간에 만료값으로 지정

	 	var cookie_value = escape(value) + ((days == null) ? '' : '; expires=' + exdate.toUTCString());
		document.cookie = cookie_name + '=' + cookie_value;
	}
	
	function getCookie(cookieName) {
		  cookieName = `${cookieName}=`;
		  let cookieData = document.cookie;

		  let cookieValue = "";
		  let start = cookieData.indexOf(cookieName);

		  if (start !== -1) {
		    start += cookieName.length;
		    let end = cookieData.indexOf(";", start);
		    if (end === -1) end = cookieData.length;
		    cookieValue = cookieData.substring(start, end);
		  }
		  
		  return unescape(cookieValue);
	}
	
	function deleteCookie(name) {      
		document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';  
	}
	</script>
</body>