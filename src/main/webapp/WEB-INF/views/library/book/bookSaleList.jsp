<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
*{margin: 0; padding: 0;}
.side-bar{border: 1px solid #000; height: 1000px;}
.side-bar>.frame{ border: 1px solid #aaa; margin: 10px; padding: 10px; border-radius: 10px; height: 100%;} 
.side-bar>.frame li{line-height: 50px;} 
.side-bar>.frame ul{margin: 0;} 
.sub-menu li:hover{background-color:#ddd;}
.sub-menu{display: none; border: 2px solid #557; box-sizing: border-box; padding: 5px;}
.main-menu:nth-child(1):hover .sub-menu{display: block;}
.main-menu:nth-child(2):hover .sub-menu{display: block;}
.main-menu:nth-child(3):hover .sub-menu{display: block;}
.main-menu:nth-child(4):hover .sub-menu{display: block;}
.main-menu:nth-child(5):hover .sub-menu{display: block;}
.main-menu:nth-child(6):hover .sub-menu{display: block;}
.main-menu:nth-child(7):hover .sub-menu{display: block;}
</style>
<body>
	<div class="container mt-5">
		<form class="search input-group" method="get"
			action="<c:url value="/library/bookSale/search"/>">
			<select class="form-control" name="type">
				<option value="Keyword">제목+저자</option>
				<option value="Title">도서명</option>
				<option value="Author">저자</option>
				<option value="Publisher">출판사</option>
			</select> <input type="text" class="form-control" placeholder="도서 검색"
				name="search"> <input type="text" name="page" value="1"
				style="display: none">
			<div class="input-group-append">
				<button class="btn btn-success search-btn" type="submit">검색</button>
			</div>
		</form>
		<div class="basket">
			<p>장바구니</p>
			<div></div>
		</div>
		<div class="main">
			<div class="side-bar w-25 left cf">
				<div class="frame">
					<ul class="main-menu">
						<li data-num="55890" class="search1 click">건강/취미</li>
						<li class="sub-menu">
							<div>		
								<ul>
									<li data-num="53521" class="search1 click">건강정보</li>
									<li data-num="53471" class="search1 click">건강요리</li>
									<li data-num="55890" class="search1 click">건강/취미/레저</li>
									<li data-num="53562" class="search1 click">건강에세이/건강정보</li>
									<li data-num="53514" class="search1 click">다이어트</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="170" class="search1  click">경제경영</li>
						<li class="sub-menu">
							<div>
								<ul>
									<li data-num="3057" class="search1 click">경제학/경제일반</li>
									<li data-num="2172" class="search1 click">기업 경영</li>
									<li data-num="2028" class="search1 click">기업/경영자 스토리</li>
									<li data-num="261" class="search1 click">마케팅/세일즈</li>
									<li data-num="172" class="search1 click">재테크/투자</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="987" class="search1 click">과학</li>
						<li class="sub-menu">
							<div>
								<ul>
									<li data-num="51002" class="search1 click">기초과학/교양과학</li>
									<li data-num="51010" class="search1 click">과학자의 생애</li>
									<li data-num="51013" class="search1 click">뇌과학</li>
									<li data-num="51024" class="search1 click">물리학</li>
									<li data-num="51272" class="search1 click">의학</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="2551" class="search1 click">만화</li>
						<li class="sub-menu">
							<div>
								<ul>
									<li data-num="4668" class="search1 click">교양만화</li>
									<li data-num="36192" class="search1 click">그래픽노블</li>
									<li data-num="3728" class="search1 click">본격장르만화</li>
									<li data-num="3727" class="search1 click">소년만화</li>
									<li data-num="7443" class="search1 click">인터넷 연재 만화</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="1" class="search1 click">소설/시/희곡</li>
						<li class="sub-menu">
							<div>
								<ul>
									<li data-num="50927" class="search1 click">라이트 노벨</li>
									<li data-num="50940" class="search1 click">시</li>
									<li data-num="50918" class="search1 click">일본소설</li>
									<li data-num="50917" class="search1 click">한국소설</li>
									<li data-num="50948" class="search1 click">희곡</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="74" class="search1 click">역사</li>
						<li class="sub-menu">
							<div>
								<ul>
									<li data-num="2177" class="search1 click">문화/역사기행</li>
									<li data-num="5242" class="search1 click">서양사</li>
									<li data-num="148" class="search1 click">아시아사</li>
									<li data-num="169" class="search1 click">세계사 일반</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="656" class="search1 click">인문학</li>
						<li class="sub-menu">
							<div>
								<ul>
									<li data-num="51378" class="search1 click">교양 인문학</li>
									<li data-num="51387" class="search1 click">철학 일반</li>
									<li data-num="51395" class="search1 click">심리학/정신분석하</li>
									<li data-num="51399" class="search1 click">신화/종교학</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<div class="book-main">
				<div class="book-list"></div>
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
	let nick=${user.me_nick!=null}?"${user.me_nick}":"guest";
	let data=JSON.parse(localStorage.getItem(nick));
	if(data!=null){
		basket=data;
		console.log(basket);
	}
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
	
	$(".basket>p").click(function() {
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
	
	
	function displayBasketView() {
		let i=0;
		let str=`
			<p>장바구니(\${basket.length})</p>
			<div><ul>
			`;
			for(baskets of basket){
				str+=`
					<li>\${baskets.title} <button type="button" data-index="\${i}" class="close">&times;</button></li>
				`;
				i++;
			}
		str+=`</ul></div>`;
		$(".basket").html(str);
	}
	displayBasketView();
	
	$(document).on("click",".close",function(){
		let index=$(this).data("index");
		basket.splice(index,1);
		displayBasketView();
		let basketJson=JSON.stringify(basket);
		localStorage.setItem(nick,basketJson);
	});
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