<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
* {
	margin: 0;
	padding: 0;
}

.main ul {
	padding: 0;
}

.side-bar>.frame {
	border: 1px solid #aaa;
	margin: 10px;
	padding: 10px;
	border-radius: 10px;
	height: 100%;
}

.side-bar>.frame .click {
	line-height: 50px;
	border-bottom: 1px solid #ccc;
}

.side-bar>.frame ul {
	margin: 0;
}

.sub-menu li:hover {
	background-color: #ddd;
}

.sub-menu {
	border: 2px solid #557;
	box-sizing: border-box;
	padding: 5px;
	border-radius: 10px;
}

.main-menu:nth-child(1):hover .dis-none {
	display: block;
}

.main-menu:nth-child(2):hover .dis-none {
	display: block;
}

.main-menu:nth-child(3):hover .dis-none {
	display: block;
}

.main-menu:nth-child(4):hover .dis-none {
	display: block;
}

.main-menu:nth-child(5):hover .dis-none {
	display: block;
}

.main-menu:nth-child(6):hover .dis-none {
	display: block;
}

.main-menu:nth-child(7):hover .dis-none {
	display: block;
}

.book-main .book-list {
	margin: 10px
}

.book-main {
	border: 1px solid #aaa;
	border-radius: 10px;
	margin-top: 10px
}

.book-item {
	height: 130px;
	margin-top: 15px;
}

.book-item:after {
	padding-bottom: 5px;
	border-bottom: 1px solid #ccc;
}

.book-img {
	width: 15%;
	height: 100%;
}

.book-img img {
	max-width: 80%;
	height: 100%;
}

.book-content {
	width: 85%;
	height: 100%;
	font-size: 12px;
}

.content-text {
	width: 80%;
	height: 100%;
	padding: 5px 0;
	box-sizing: border-box;
}

.content-text ul {
	margin: 0;
}

.content-text li {
	margin-top: 5px
}

.content-btn {
	width: 20%;
	height: 100%;
	padding: 10px 0;
	box-sizing: border-box;
}

.content-btn button {
	margin: 5px;
}

.title {
	font-weight: 500;
	font-size: 16px;
}

.accent {
	font-weight: bold;
	background-color: #ececec;
}

.dis-none {
	display: none;
}
</style>
<body>
	<div class="container">
		<div id="nav"></div>
		<form class="search input-group  mt-5" method="get"
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
		<div class="main cf">
			<div class="side-bar w-25 left cf">
				<div class="frame">
					<ul class="main-menu">
						<li data-num="0" class="click accent">전체</li>
					</ul>
					<ul class="main-menu">
						<li data-num="55890" class="click">건강/취미</li>
						<li class="sub-menu dis-none">
							<div>
								<ul>
									<li data-num="53521" class="click">건강정보</li>
									<li data-num="53471" class="click">건강요리</li>
									<li data-num="55890" class="click">건강/취미/레저</li>
									<li data-num="53562" class="click">건강에세이/건강정보</li>
									<li data-num="53514" class="click">다이어트</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="170" class="click">경제경영</li>
						<li class="sub-menu dis-none">
							<div>
								<ul>
									<li data-num="3057" class="click">경제학/경제일반</li>
									<li data-num="2172" class="click">기업 경영</li>
									<li data-num="2028" class="click">기업/경영자 스토리</li>
									<li data-num="261" class="click">마케팅/세일즈</li>
									<li data-num="172" class="click">재테크/투자</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="987" class="click">과학</li>
						<li class="sub-menu dis-none">
							<div>
								<ul>
									<li data-num="51002" class="click">기초과학/교양과학</li>
									<li data-num="51010" class="click">과학자의 생애</li>
									<li data-num="51013" class="click">뇌과학</li>
									<li data-num="51024" class="click">물리학</li>
									<li data-num="51272" class="click">의학</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="2551" class="click">만화</li>
						<li class="sub-menu dis-none">
							<div>
								<ul>
									<li data-num="4668" class="click">교양만화</li>
									<li data-num="36192" class="click">그래픽노블</li>
									<li data-num="3728" class="click">본격장르만화</li>
									<li data-num="3727" class="click">소년만화</li>
									<li data-num="7443" class="click">인터넷 연재 만화</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="1" class="click">소설/시/희곡</li>
						<li class="sub-menu dis-none">
							<div>
								<ul>
									<li data-num="50927" class="click">라이트 노벨</li>
									<li data-num="50940" class="click">시</li>
									<li data-num="50918" class="click">일본소설</li>
									<li data-num="50917" class="click">한국소설</li>
									<li data-num="50948" class="click">희곡</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="74" class="click">역사</li>
						<li class="sub-menu dis-none">
							<div>
								<ul>
									<li data-num="2177" class="click">문화/역사기행</li>
									<li data-num="5242" class="click">서양사</li>
									<li data-num="148" class="click">아시아사</li>
									<li data-num="169" class="click">세계사 일반</li>
								</ul>
							</div>
						</li>
					</ul>
					<ul class="main-menu">
						<li data-num="656" class="click">인문학</li>
						<li class="sub-menu dis-none">
							<div>
								<ul>
									<li data-num="51378" class="click">교양 인문학</li>
									<li data-num="51387" class="click">철학 일반</li>
									<li data-num="51395" class="click">심리학/정신분석하</li>
									<li data-num="51399" class="click">신화/종교학</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<div class="book-main right w-75">
				<div class="book-list"></div>
				<div class="pagination-box mt-3">
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
	
	$(".click").click(function() {
		APIdata.CategoryId=$(this).data("num");
		APIdata.Start=1;
		bookListCri.startPage=1;
		bookListCri.perPage=10;
		$(".click").removeClass('accent');
		$(".sub-menu").addClass('dis-none');
		$(this).parent().parent().parent('.sub-menu').removeClass('dis-none');
		$(".click").removeClass('accent');
		$(this).addClass('accent');
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
	<script type="text/javascript">
	function displayView(data) {
		let str="";
		for(book of data){
			books.push(book);
			str+=`
			<div class="book-item cf">
				<div class="book-img left">
					<a href='<c:url value="/library/bookSale/detail?isbn=\${book.isbn13}"/>'>
						<img alt="\${book.title}" src="\${book.cover}"/>
					</a>
				</div>
				<div class="book-content left">
					<div class="content-text left">
						<ul>
							<li class="title"><a href='<c:url value="/library/bookSale/detail?isbn=\${book.isbn13}"/>'>
								\${book.title} </a></li>
							<li>\${book.author} | \${book.publisher}</li>
							<li>\${book.pubDate} 평점 : <span style="color: #eb217c;"> \${book.customerReviewRank}</span></li>
							<li>판매가: \${priceToString(book.priceStandard)}</li>
						</ul>
					</div>
					<div  class="content-btn right">
						<button class="btn btn-outline-warning basket-btn " data-isbn="\${book.isbn13}">장바구니</button>
						<button class="btn btn-outline-warning purchase-btn " data-isbn="\${book.isbn13}">바로구매</button>
					</div>
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
	
	$(document).ready(function(){ $("#nav").load("/../team4/nav.html");});
	</script>
</body>