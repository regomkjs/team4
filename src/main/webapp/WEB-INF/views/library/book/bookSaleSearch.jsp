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
				<div class="book-list">
				<!-- 
					<c:forEach items="${list}" var="book">
						<div class="book-item">
							<div class="book-img">
								<img alt="${book.title}" src="${book.cover}"/>
							</div>
							<div class="book-content">
								<ul>
									<li>${book.title} </li>
									<li>${book.author} | ${book.publisher}</li>
									<li>${book.pubDate}</li>
									<li>판매가: ${book.priceStandard}원</li>
								</ul>
								<button class="btn btn-outline-warning basket-btn" data-isbn="${book.isbn13}">장바구니</button>
								<a class="btn btn-outline-warning purchase-btn" data-isbn="${book.isbn13}">구매</a>
							</div>
						</div>
					</c:forEach>
					 -->
				</div>
				<div class="pagination-box">
					<ul class="pagination justify-content-center pagination-sm"">
						<c:if test="${pm.prev}">
							<c:url value="/library/bookSale/search" var="url">
								<c:param name="page" value="${pm.startPage - 1}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
							</c:url>
							<li class="page-item">
								<a class="page-link" href="${url}">이전</a>
							</li>
						</c:if>
						<c:forEach begin="${pm.startPage }" end="${pm.endPage}" var="i">
							<c:url value="/library/bookSale/search" var="url">
								<c:param name="page" value="${i}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
							</c:url>
							<li class="page-item <c:if test="${pm.cri.page == i}">active</c:if>">
								<a class="page-link" href="${url}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${pm.next}">
							<c:url value="/library/bookSale/search" var="url">
								<c:param name="page" value="${pm.endPage + 1}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
							</c:url>
							<li class="page-item">
								<a class="page-link" href="${url}">다음</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- 구매,장바구니 -->
	<script type="text/javascript">
	let bookObj=${obj};
	let basket=[];
	let books=bookObj.item;
	console.log(bookObj);//
	$(document).on("click",".basket-btn",function(){
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
	
	</script>
	<!-- 화면 출력 -->
	<script type="text/javascript">
		//bookObj
		function displayListView() {
			let str="";
			for(book of bookObj.item){
				str+=`
					<div class="book-item">
						<div class="book-img">
							<img alt="\${book.title}" src="\${book.cover}"/>
						</div>
						<div class="book-content">
							<ul>
								<li>\${book.title} </li>
								<li>\${book.author} | \${book.publisher}</li>
								<li>\${book.pubDate}</li>
								<li>판매가: \${book.priceStandard}원</li>
							</ul>
							<button class="btn btn-outline-warning basket-btn" data-isbn="\${book.isbn13}">장바구니</button>
							<a class="btn btn-outline-warning purchase-btn" data-isbn="\${book.isbn13}">구매</a>
						</div>
					</div>
				`;	
			}
			$(".book-list").html(str);
		}
		displayListView();
	</script>
</body>