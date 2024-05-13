<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
*{margin: 0; padding: 0;}
.main ul{padding: 0;}
.book-main .book-list{margin: 10px}
.book-main{border: 1px solid #aaa; border-radius: 10px; margin-top: 10px}
.book-item{height:130px; margin-top: 20px;  margin-left: 10px; margin-right: 10px;}
.book-item:after{padding-bottom:10px; border-bottom: 1px solid #ccc; }

.book-img{width: 15%; height:100%;}
.book-img img{max-width:80%; height:100%;}
.book-content{width: 85%; height:100%; font-size: 14px;}
.content-text{width:80%; height:100%;  padding: 5px 0; box-sizing: border-box;}
.content-text ul{margin: 0;}
.content-text li{margin-top: 5px}
.content-btn{width: 20%; height:100%; padding: 10px 0; box-sizing: border-box;}
.content-btn button{margin: 5px;}
.title{font-weight:500; font-size: 16px; }

</style>
<body>
	<div class="container">
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
		<div class="main w-100">
		
			<div class="book-main">
				<div class="book-list">
					
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
	<!-- 화면 출력 -->
	<script type="text/javascript">
		//bookObj
		let obj=${obj};
		let books=${obj.item};
		console.log(books);
		function displayListView() {
			let str="";
			for(book of obj.item){
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
									<li class="title">
										<a href='<c:url value="/library/bookSale/detail?isbn=\${book.isbn13}"/>'>
										\${book.title} 
										</a>
									</li>
									<li>\${book.author} | \${book.publisher}</li>
									<li>\${book.pubDate}</li>
									<li>판매가: \${priceToString(book.priceStandard)}</li>
								</ul>
							</div>
							<div  class="content-btn right">
								<button class="btn btn-outline-warning basket-btn" data-isbn="\${book.isbn13}">장바구니</button>
								<button class="btn btn-outline-warning purchase-btn" data-isbn="\${book.isbn13}">바로구매</button>
							</div>
						</div>
					</div>
				`;	
			}
			$(".book-list").html(str);
			$("input[name=search]").val(obj.query);
		}
		displayListView();
	</script>
</body>