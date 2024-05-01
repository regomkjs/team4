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
	let nick=${user.me_nick!=null}?"${user.me_nick}":"guest";
	let basket=[];
	let data=JSON.parse(localStorage.getItem(nick));
	if(data!=null){
		basket=data;
	}
	let books=bookObj.item;
	
	$(document).on("click",".basket-btn",function(){
		let isbn=$(this).data("isbn");
		for(let i=0;i<basket.length;i++){
			if(basket[i].isbn13==isbn){
				return;
			}
		}
		for(let i=0;i<books.length;i++){
			if(books[i].isbn13==isbn){
				basket.push(books[i]);
			}
		}
		displayBasketView();
		let basketJson=JSON.stringify(basket);
		localStorage.setItem(nick,basketJson);
	});
	
	$(".basket").click(function() {
		location.href = '<c:url value="/library/book/sale" />';	
	});
	
	$(document).on("click",".purchase-btn",function(){
		let isbn=$(this).data("isbn");
		for(let i=0;i<basket.length;i++){
			if(basket[i].isbn13==isbn){
				let basketJson=JSON.stringify(basket);
				localStorage.setItem(nick,basketJson);
				location.href = '<c:url value="/library/book/sale" />';
				return;
			}
		}
		for(let i=0;i<books.length;i++){
			if(books[i].isbn13==isbn){
				basket.push(books[i]);
			}
		}
		let basketJson=JSON.stringify(basket);
		localStorage.setItem(nick,basketJson);
		location.href = '<c:url value="/library/book/sale" />';	
	});
	
	displayBasketView()
	function displayBasketView() {
		let str=`
			<p>장바구니(\${basket.length})</p>
			<div><ul>
			`;
			for(baskets of basket){
				str+=`
					<li>\${baskets.title}<button type="button" data-index="\${i}" class="close">&times;</button></li>
				`;
			}
		str+=`</ul></div>`;
		$(".basket").html(str);
	}
	
	$(document).on("click",".close",function(){
		let index=$(this).data("index");
		basket.splice(index,1);
		displayBasketView();
		let basketJson=JSON.stringify(basket);
		localStorage.setItem(nick,basketJson);
	});
	</script>
	
	
</body>