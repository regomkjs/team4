<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
<style>
.category-list{line-height:30px; font-weight:500;}

.side-bar>.frame{ border: 1px solid #aaa; margin: 10px; padding: 10px; border-radius: 10px;} 
.book-list ul{padding: 0;}
.book-main .book-list{margin: 10px}
.book-main{border: 1px solid #aaa; border-radius: 10px; margin-top: 10px}
.book-item{height:130px; margin-top: 15px;  }
.book-item:after{padding-bottom:5px; border-bottom: 1px solid #ccc; }

.book-img{width: 15%; height:100%; margin-left: 20px;}
.book-img img{ height:100%; }
.book-content{width: 60%; height:100%; font-size: 16px;}

.title{font-weight:500; font-size: 18px; }

.accent{font-weight: bold; background-color: #ececec;}
.genre-list{margin-left: 15px; display: none;}
.genre-sub-list{display: none;}
.active{display: block;}
</style>
<body>
	<div class="container cf">
		<div id="nav">
			
		</div>
		<div class="input-group mt-5">
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
					<div class="all-category click accent">
					전체
					</div>
					<c:forEach items="${upList}" var="category">
						<c:if test="${category.up_num != 100 }">
							<div class="category-list"  >
							  <div class="category-name click" data-num="${category.up_num}" data-toggle="0">
							  <i class="fa-regular fa-square-plus"></i>
							  ${category.up_name}</div>
							  <div class="genre-list">
							   
							  </div>
							</div>
						</c:if>	
					</c:forEach>
				</div>
			</div>
			<div class="book-main right w-75">
				<div class="book-list">
					<c:if test="${bookList == null }">
						<p>등록된 책이 없습니다.</p>
					</c:if>
				</div>
				<div class="pagination-box mt-3">
					<ul class="pagination justify-content-center pagination-sm""></ul>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		let cri={
			search:"",
			type:'all',
			page:1,
			bo_code:2	
		};
		
		$(".search-btn").click(function() {
			cri.search=$("input[name=search]").val();
			cri.type=$("select[name=type]").val();
			cri.page=1;
			$(".category-name").removeClass("accent");
			$(".select-btn").removeClass("accent");
			displayBookView(cri);
		})
		
		//카테고리에 맞는 장르를 추가함
		$(".category-name").click(function() {
			let res=$(this).data('toggle');
			if(res==0){
				$(this).children("i").removeClass("fa-square-plus");
				$(this).children("i").addClass("fa-square-minus");
				$(".category-name").removeClass("accent");
				$(this).addClass("accent");
				$(this).next().addClass("active");
				res=1;
			}else{
				$(this).children("i").addClass("fa-square-plus");
				$(this).children("i").removeClass("fa-square-minus");
				$(this).removeClass("accent");
				$(this).next().removeClass("active");
				res=0;
			}
			$(this).data('toggle',res);
			
			let num=$(this).data("num");
			$.ajax({
				async : true,
				url : '<c:url value="/management/manager/category" />', 
				type : 'post', 
				data : {num}, 
				success : function (data){
					let str="";
					let i=true;
					for(un of data.list){
						if(un.un_code!=0&&un.un_code%10==0){
							str+=`</div></div>`;
							i=true;
						}
						if(i){
							str+=`
								<div class="genre-item">
									<div class="genre-title click" data-toggle="0">
							    		<li class="display-block"><i class="fa-regular fa-square-plus"></i> \${un.un_name}</li>
							    	</div>
							    	<div class="genre-sub-list">
							`;
							i=false;
						}	
						str+=`
							<li value='\${un.un_num}' class="select-btn display-block click">[\${un.un_code}] \${un.un_name}</li>
						`;										
					}
					str+=`</div></div>`;
					$('.category-name[data-num='+num+']').next().html(str);
					
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
		});
		
		$(document).on("click",".select-btn",function() {
			cri.type="code";
			cri.search=$(this).attr('value');
			cri.page=1;
			$(".all-category").removeClass('accent');
			$(".select-btn").removeClass('accent');
			$(this).addClass('accent');
			$(".category-name").removeClass('accent');
			$(this).parent().parent().parent().prev().addClass('accent');
			displayBookView(cri);
		});
		
		$(document).on("click",".genre-title",function(){
			let res=$(this).data('toggle');
			if(res==1){
				$(this).next().removeClass("active");
				$(this).children("li").children("i").addClass("fa-square-plus");
				$(this).children("li").children("i").removeClass("fa-square-minus");
				res=0;
			}else{
				$(this).next().addClass("active");
				$(this).children("li").children("i").removeClass("fa-square-plus");
				$(this).children("li").children("i").addClass("fa-square-minus");
				res=1;
			}
			$(this).data('toggle', res);
		});
	
	</script>
	<!--책 목록을 출력-->
	<script type="text/javascript">
		function displayBookView(cri){
			$.ajax({
				async : true,
				url : '<c:url value="/management/manager/bookList"/>', 
				type : 'post', 
				data : JSON.stringify(cri),
				contentType : "application/json; charset=utf-8",
				dataType : "json", 
				success : function (data){
					let str="";
					for(book of data.bookList){
						str+=`
							<div class="book-item cf">
									<div class="book-img left">
										<img alt="\${book.bo_title}" src="\${book.bo_thumbnail}"/>
									</div>
									<div class="book-content left">
										<ul>
											<li class="title">
												<a href='<c:url value="/library/book/detail?num=\${book.bo_num}"/>'>
												\${book.bo_title}
												</a>
											</li>
											<li>저자: \${book.bo_au_name}</li>
											<li>출판사: \${book.bo_publisher}</li>
											<li>평점 : <span style="color: #eb217c; font-size: 20px;">\${book.avgScore}</span></li>
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
		
		$(".all-category").click(function(){
			cri.search="";
			cri.type="all";
			cri.page=1;
			$(this).addClass('accent');
			$(".category-name").removeClass('accent');
			$(".select-btn").removeClass('accent');
			displayBookView(cri);
		});
		
		displayBookView(cri);
	</script>
</body>