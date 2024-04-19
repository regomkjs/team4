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
		    <input type="text" class="form-control" placeholder="도서 검색"
		    name="search">
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
				<div class="book-list">
					${list}
				</div>
				<div class="pagination-box">
					<ul class="pagination justify-content-center pagination-sm""></ul>
				</div>
			</div>
		</div>
	</div>
	<!-- 구매,장바구니 -->
	<script type="text/javascript">
	let basket=[];
	$(document).on("click",".basket-btn",function(){
		console.log(books);//
		let isbn=$(this).data("isbn");
		for(let i=0;i<books.length;i++){
			console.log(books[i].isbn13==isbn);//
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
	
	</script>
</body>