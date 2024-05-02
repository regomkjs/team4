<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
<style>
.category-list{line-height:30px; font-weight:500;}
.book-list{border: 1px solid #aaa; border-radius: 10px; margin-top: 10px}
.book{height: 140px; margin: 10px 0px; border-bottom: 1px solid #000; box-sizing: border-box;}
.book-img>img{height: 130px; width: 100px; margin-left: 20px}
.book-title{font-size: 20px;font-weight: bold;}
.book-content{box-sizing: border-box;}
.book-content>ul{padding: 20px; margin: 0;}
.book-content>ul>li{margin-top: 5px;}
.side-bar>.frame{ border: 1px solid #aaa; margin: 10px; padding: 10px; border-radius: 10px;} 

</style>
<body>
	<div class="container mt-5">
		<div class="input-group">
			<select class="form-control" name="type">
				<option value="all">전체</option>
				<option value="title">도서명</option>
				<option value="authors">저자</option>
				<option value="publisher">출판사</option>
			</select> 
			<input type="text" class="form-control" placeholder="검색" name="search">
			<div class="input-group-append">
				<button class="btn btn-success search-btn" type="button">검색</button>
			</div>
		</div>

		<div class="main mt-3">
			<div class="side-bar left w-25">
				<div class="frame">
					<c:forEach items="${upList}" var="category">
						<c:if test="${category.up_num != 100 }">
							<div class="category-list click"  data-num="${category.up_num}">
							    <i class="fa-regular fa-square-plus"></i> ${category.up_name} 
							  <div class="genre-list">
							   
							  </div>
							</div>
						</c:if>	
					</c:forEach>
				</div>
			</div>
			<div class="book-main right w-75">
				<div class="book-list">
					
				</div>
				<div class="pagination-box mt-3">
					<ul class="pagination justify-content-center pagination-sm""></ul>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		let cri={
			search:null,
			type:'all',
			page:1,
			bo_code:2	
		};
		
		$(".search-btn").click(function() {
			cri.search=$("input[name=search]").val();
			cri.type=$("select[name=type]").val();
			displayBookView(cri);
		})
		
		//카테고리에 맞는 장르를 추가함
		$(".category-list").click(function() {
			$(".category-list").addClass("click");
			$(".category-list>i").addClass("fa-square-plus");
			$(".category-list>i").removeClass("fa-square-minus");
			$(this).removeClass("click");
			
			let num=$(this).data("num");
			
			$('.category-list[data-num='+num+']>i').removeClass("fa-square-plus");
			$('.category-list[data-num='+num+']>i').addClass("fa-square-minus");
			$.ajax({
				async : true,
				url : '<c:url value="/management/manager/category" />', 
				type : 'post', 
				data : {num}, 
				success : function (data){
					let str="";
					for(un of data.list){
					str+=`
				    	<li value='\${un.un_num}' class="select-btn display-block click">[\${un.un_code}] \${un.un_name}</li>
					`;
					}
					$(".genre-list>li").removeClass("display-block");
					$(".genre-list>li").addClass("display-none");
					$('.category-list[data-num='+num+']>.genre-list').html(str);
					
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
		});
		
		$(document).on("click",".select-btn",function() {
			cri.type="code";
			cri.search=$(this).attr('value');	
			displayBookView(cri);
		});
		
	
	</script>
	<!--책 목록을 출력-->
	<script type="text/javascript">
		function displayBookView(cri){
			console.log(cri);
			$.ajax({
				async : true,
				url : '<c:url value="/management/manager/list"/>', 
				type : 'post', 
				data : JSON.stringify(cri),
				contentType : "application/json; charset=utf-8",
				dataType : "json", 
				success : function (data){
					let str="";
					for(book of data.bookList){
						str+=`
							<div class="book cf">
									<div class="book-img left">
										<img alt="\${book.bo_title}" src="\${book.bo_thumbnail}"/>
									</div>
									<div class="book-content left">
										<ul>
											<li class="book-title">
												<a href='<c:url value="/library/book/detail?num=\${book.bo_num}"/>'>
												\${book.bo_title}
												</a>
											</li>
											<li>저자: \${book.bo_au_name}</li>
											<li>출판사: \${book.bo_publisher}</li>
										</ul>
									</div>
							</div>
						`;
					}
					$(".book-main>.book-list").html(str);
					let pm = data.pm;
					let pmStr = "";
					if(pm.prev){
						pmStr += `
						<li class="page-item">
							<a class="page-link" href="javascript:void(0);" data-page="\${pm.startPage-1}">이전</a>
						</li>
						`;
					}
					for(i = pm.startPage; i<= pm.endPage; i++){
						let active = pm.cri.page == i ? "active" :"";
						pmStr += `
						<li class="page-item \${active}">
							<a class="page-link" href="javascript:void(0);" data-page="\${i}">\${i}</a>
						</li>
						`
					}
					if(pm.next){
						pmStr += `
						<li class="page-item">
							<a class="page-link" href="javascript:void(0);" data-page="\${pm.endPage+1}">다음</a>
						</li>
						`;
					}
					$(".pagination-box>ul").html(pmStr);
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
		}	
		
		$(document).on('click',".page-link",function(){
			cri.page = $(this).data('page');
			displayBookView(cri);
		});
	</script>
</body>