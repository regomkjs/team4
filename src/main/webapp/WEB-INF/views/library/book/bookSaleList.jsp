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
			<div class="side-bar">
				<ul>
					<li data-num="55890" class="search1">건강/취미</li>
					<li data-num="170" class="search1">경제경영</li>
					<li data-num="987" class="search1">과학</li>
					<li data-num="2551" class="search1">만화</li>
					<li data-num="1" class="search1">소설/시/희곡</li>
					<li data-num="74" class="search1">역사</li>
				</ul>
				
			</div>
			<div class="book-main">
				<div class="book-list">
					
				</div>
				<div class="pagination-box">
					<ul class="pagination justify-content-center pagination-sm""></ul>
				</div>
			</div>
		</div>
	</div>
	<!-- 도서 리스트 출력 -->
	<script type="text/javascript">
	let APIdata={
		TTBKey:"${api}",
		QueryType:"ItemNewAll",
		SearchTarget:"Book",
		Start:1,
		Output:"JS",
		Version:20131101
	};
	let bookListCri={
		startPage:1,
		perPage:10	
	};

	let books=[];
	
	$(".search1").click(function() {
		APIdata.CategoryId=$(this).data("num");
		APIdata.Start=1;
		bookListCri.startPage=1;
		bookListCri.perPage=10;
		BookList()
	});
	
	function BookList() {
		$.ajaxPrefilter('json',function(options,orig,jqXHR){
			return 'jsonp';
		});
		$.ajax({
			url :"http://www.aladin.co.kr/ttb/api/ItemList.aspx" , 
			type : "get", 
			data: APIdata,
			dataType :"json",
			crossDomain:true,
			xhrFields: { 
		    	withCredentials: true // 클라이언트와 서버가 통신할때 쿠키와 같은 인증 정보 값을 공유하겠다는 설정
		    },
			success : function (data,testStatus,jqXHR){
				console.log(data);//
				displayView(data.item);
				displayPage(APIdata,bookListCri,data.totalResults);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	}
	
	BookList();
	
	$(document).on('click','.page-link',function(){
		APIdata.Start=$(this).data('page');
		books=[];
		if(APIdata.Start>bookListCri.perPage){
			bookListCri.startPage+=10;
			bookListCri.perPage+=10;
		}else if(APIdata.Start<bookListCri.startPage){
			bookListCri.startPage-=10;
			bookListCri.perPage-=10;
		}
		BookList();
	});
	</script>
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
	<script type="text/javascript">
	function displayView(data) {
		let str="";
		for(book of data){
			books.push(book);
			str+=`
			<div class="book-item">
				<div class="book-img">
					<a href='<c:url value="/library/bookSale/detail?isbn=\${book.isbn13}"/>'>
						<img alt="\${book.title}" src="\${book.cover}"/>
					</a>
				</div>
				<div class="book-content">
					<ul>
						<li><a href='<c:url value="/library/bookSale/detail?isbn=\${book.isbn13}"/>'>
							\${book.title} </a></li>
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
	
	function displayPage(data,cri,totalCount){
		let pm="";
		if(data.Start>10){
			pm+=`
			<li class="page-item"><a class="page-link" data-page="\${cri.startPage-1}">이전</a></li>
			`;
		}
		let endPage=Math.ceil(totalCount/10);
		if(cri.perPage>endPage){
			cri.perPage=endPage;
		}
		for(let i=cri.startPage;i<=cri.perPage;i++){
			let active = data.Start == i ? 'active' : '';
			pm+=`
			<li class="page-item \${active}"><a class="page-link" data-page="\${i}">\${i}</a></li>
			`;
			//APIdata.Start
		}
		if(cri.perPage!=endPage){
			pm+=`
			<li class="page-item"><a class="page-link" data-page="\${cri.perPage+1}">다음</a></li>
			`;
		}
		$(".pagination").html(pm);
	}
	</script>
</body>