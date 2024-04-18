<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<body>
	<div class="container mt-5">
		<div class="search input-group">
		  	<select  class="form-control" name="type">
		  		<option value="all">전체</option>
		  		<option value="title">도서명</option>
		  		<option value="authors">저자</option>
		  		<option value="publisher">출판사</option>
		  	</select>
		    <input type="text" class="form-control" placeholder="Search"
		    name="search">
		    <div class="input-group-append">
		      <button class="btn btn-success list-btn" type="button">검색</button>
		    </div>
		</div>
		<div class="main">
			<div class="side-bar">
				<ul>
					<li data-num="55890" class="search1">건강/취미</li>
					<li data-num="170" class="search1">>경제경영</li>
					<li data-num="987" class="search1">>과학</li>
					<li data-num="2551" class="search1">>만화</li>
					<li data-num="1" class="search1">>소설/시/희곡</li>
					<li data-num="74" class="search1">>역사</li>
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
	<!-- 도서 검색 -->
	<script type="text/javascript">
	let APIdata={
		TTBKey:"ttbquddjcho1722001",
		QueryType:"ItemNewAll",
		SearchTarget:"Book",
		Start:1,
		Output:"JS",
		Version:20131101
	};
	let startPage=1;
	let perPage=10;
	
	$(".search1").click(function() {
		APIdata.CategoryId=$(this).data("num");
		APIdata.Start=1;
		startPage=1;
		perPage=10;
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
			success : function (data,testStatus,jqXHR){
				console.log(data);//
				let str="";
				for(book of data.item){
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
						</div>
					</div>
					`;
				}
				$(".book-list").html(str);
				let pm="";
				if(APIdata.Start>10){
					pm+=`
					<li class="page-item"><a class="page-link" data-page="\${startPage-1}">이전</a></li>
					`;
				}
				let endPage=Math.ceil(data.totalResults/10);
				if(perPage>endPage){
					perPage=endPage;
				}
				for(let i=startPage;i<=perPage;i++){
					let active = APIdata.Start == i ? 'active' : '';
					pm+=`
					<li class="page-item \${active}"><a class="page-link" data-page="\${i}">\${i}</a></li>
					`;
					//APIdata.Start
				}
				if(perPage!=endPage){
					pm+=`
					<li class="page-item"><a class="page-link" data-page="\${perPage+1}">다음</a></li>
					`;
				}
				$(".pagination").html(pm);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	}
	
	BookList();
	
	$(document).on('click','.page-link',function(){
		APIdata.Start=$(this).data('page');
		if(APIdata.Start>perPage){
			startPage+=10;
			perPage+=10;
		}else if(APIdata.Start<startPage){
			startPage-=10;
			perPage-=10;
		}
		BookList();
	});

	</script>
</body>